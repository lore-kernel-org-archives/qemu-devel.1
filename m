Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43DBCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B602064A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ko5nMFeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B602064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOKUq-0006GK-K0
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 07:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOKTw-0004dy-0H
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOKTu-0001hw-HJ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:43:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOKTu-0001hZ-7K
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572090221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOWlYIUJRUHBKHgRIVKQGSH+Q51A71I8O0LDZNACRQM=;
 b=Ko5nMFeFeU/3c/AKAajCgZ/nPzSP/yfhiGErPQdvhEIzwLLIQgAtso6GAu38vNt/Olg3g6
 xyqNkt5XlYCMN3lxxkVd2FRSpc+dDcfaYO8WS4MxsY25dhsJ+VwKD2ILfr/k5h0yfvV6ik
 eEc5sAyIpnlfQNRUvawn3gHIIoUNDr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-SphE4MFDPkOJumCWKuwsLQ-1; Sat, 26 Oct 2019 07:43:39 -0400
Received: by mail-wr1-f70.google.com with SMTP id z9so2778029wrq.11
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 04:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3kpiyek/zHlWl+6hhSia6N8ekqxektReXUTIazP7q0=;
 b=Er6FUQyGoXGrROPBnpzs1WQgYNfoI3wIyXMoSH5jWMm2ilt4yehF9swDMwjCN+P5gU
 5Ncqb3JPOtuS/vEHMC8i/ODb9PMprv/MGeQ+/XdffHzE1uJxRc9DudiAOlC9crm+4lCD
 Etp1dadlwN+7BrqVG3xO6iuvcqNWrGGD/bUczslYLoGPjlzWpTw1r0eCkJRKVN/HixAr
 HNXGG18kfyDFIrOFwYPoMrkdqQ3phvzPL3FbhOStzdVl6r0pbyxcoL0eWlDmy2UarzaF
 gaC6gIxhtU9zWbMSAxzIGH1qn07NVRwEXz/2OPEO6HyNUjMLnJKEr0WYIFQGtHXiFP2b
 HFFA==
X-Gm-Message-State: APjAAAXf+mvGRjGhIqqEfECxi2KwQ056Nwob8dOur/cYSRxQYqKXNpQq
 dyLG9JtUJfcpdODnqa/RctOKhK4eROSPXn4IXruY0Hc3CyqV150HX9OIzKTvNeYJ3yAV1clnbib
 yfxb565NIsXSNuxo=
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr7948146wmg.174.1572090218217; 
 Sat, 26 Oct 2019 04:43:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEvsAQYEANy3MM7r9q1S+NjRLSVZsLrG1/geoHWW4aCeNsNRQCgaLeTVHm1seBGmGR7PY4BQ==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr7948132wmg.174.1572090217972; 
 Sat, 26 Oct 2019 04:43:37 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id s10sm6897537wrr.5.2019.10.26.04.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 04:43:37 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] hppa: Add emulation of Artist graphics
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-6-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40b19733-f72f-17be-be30-984712523eb0@redhat.com>
Date: Sat, 26 Oct 2019 13:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022205941.23152-6-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: SphE4MFDPkOJumCWKuwsLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

On 10/22/19 10:59 PM, Sven Schnelle wrote:
> This adds emulation of Artist graphics good enough
> to get a Text console on both Linux and HP-UX. The
> X11 server from HP-UX also works.
>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/display/Kconfig       |    3 +
>   hw/display/Makefile.objs |    1 +
>   hw/display/artist.c      | 1336 ++++++++++++++++++++++++++++++++++++++
>   hw/display/trace-events  |    9 +
>   hw/hppa/Kconfig          |    1 +
>   hw/hppa/hppa_hardware.h  |    1 +
>   hw/hppa/machine.c        |   10 +
>   7 files changed, 1361 insertions(+)
>   create mode 100644 hw/display/artist.c
>=20
[...]
> +static void fill_window(ARTISTState *s, int startx, int starty,
> +                        int width, int height)
> +{
> +    uint32_t offset;
> +    uint8_t color =3D artist_get_color(s);
> +    uint8_t *buf;
> +    int x, y;
> +
> +    trace_artist_fill_window(startx, starty, width, height,
> +        s->image_bitmap_op, s->control_plane);
> +
> +    if (s->control_plane !=3D 0) {
> +        qemu_log_mask(LOG_UNIMP, "%s: CONTROL_PLANE: %08x\n", __func__,
> +            s->control_plane);
> +        return;
> +    }
> +
> +    if (s->reg_100080 =3D=3D 0x7d) {

What is checked here? Can you add a comment about it?

> +        height =3D artist_get_y(s->blockmove_size);
> +        s->vram_start +=3D height;
> +    }
> +
> +    buf =3D s->vram_buffer[ARTIST_BUFFER_AP].data;
> +
> +    for (y =3D starty; y < starty + height; y++) {
> +        offset =3D y * s->width;
> +
> +        for (x =3D startx; x < startx + width; x++) {
> +            artist_rop8(s, buf + offset + x, color);
> +        }
> +    }
> +}
> +
[...]
> +static void artist_initfn(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    ARTISTState *s =3D ARTIST(obj);
> +
> +    memory_region_init_io(&s->reg, obj, &artist_reg_ops, s, "artist.reg"=
,
> +            0x400000);

Easier to read as: 4 * MiB

> +    memory_region_init_io(&s->vram_mem, obj, &artist_vram_ops, s, "artis=
t.vram",
> +            0x800000);

And 8 * MiB.

> +    sysbus_init_mmio(sbd, &s->reg);
> +    sysbus_init_mmio(sbd, &s->vram_mem);
> +}
> +
> +static void artist_set_buffer(ARTISTState *s, uint8_t **vram, unsigned i=
nt idx,
> +                              int width, int height)
> +{
> +    struct vram_buffer *buf =3D s->vram_buffer + idx;
> +
> +    buf->data =3D *vram;
> +    buf->size =3D height * width;
> +    buf->width =3D width;
> +    buf->height =3D height;
> +    *vram =3D *vram + buf->size;
> +}
> +
> +static void artist_realizefn(DeviceState *dev, Error **errp)
> +{
> +    uint8_t *vram;
> +
> +    ARTISTState *s =3D ARTIST(dev);
> +
> +    vram =3D g_malloc0(4 * 1048576);

Here you can simply use g_malloc(4 * MiB). If you really need
to bzero the VRAM, that should be done in the reset() handler.

> +    s->vram =3D vram;
> +    artist_set_buffer(s, &vram, ARTIST_BUFFER_CMAP, 2048, 4);
> +    artist_set_buffer(s, &vram, ARTIST_BUFFER_AP, s->width, s->height);
> +    artist_set_buffer(s, &vram, ARTIST_BUFFER_CURSOR1, 64, 64);
> +    artist_set_buffer(s, &vram, ARTIST_BUFFER_CURSOR2, 64, 64);
> +    artist_set_buffer(s, &vram, ARTIST_BUFFER_ATTRIBUTE, 64, 64);

Shouldn't this be done by firmware code? If no firmware, this seems to
belong to reset() too, isn't it?

> +
> +    /*
> +     * no idea whether the cursor is fixed size or not, so assume 32x32 =
which
> +     * seems sufficient for HP-UX X11.
> +     */
> +    s->cursor_height =3D 32;
> +    s->cursor_width =3D 32;
> +
> +    s->con =3D graphic_console_init(DEVICE(dev), 0, &artist_ops, s);
> +    qemu_console_resize(s->con, s->width, s->height);
> +}
[...]


