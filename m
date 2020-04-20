Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC3C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE7E20A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTbbOyde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE7E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSE5-0005Il-VJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSCk-0004Pg-HI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:55:02 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSCj-00053O-3w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:55:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49130
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSCi-00051o-NC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587372900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6yXDSbJuOcHPyq1k83ZkWLDPSe76WYrY2SK1YyUnG8=;
 b=jTbbOydenW2glOe45oT2PdXkU7T2SS9WX6ITmNyVPCHRkOYZ4LYnDD1y8fWBvXt2aXupN4
 prYjeyBscaWC5dbAbkccVWh/HgVWXmMZoFbSgPx79JVS2ME5HlxelM3Yt+B7QWoVIQtxv4
 yxtsjXqzGUnIedL3seTtXfilIXE9d3Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-BiEfcXx1Piun7-ZFlE3n9g-1; Mon, 20 Apr 2020 04:54:58 -0400
X-MC-Unique: BiEfcXx1Piun7-ZFlE3n9g-1
Received: by mail-ed1-f71.google.com with SMTP id f11so3403714edc.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 01:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R4OpnA3+D26XCbYHWrNZurrixltjodrRjxWz0pfTf30=;
 b=iRXibqwKHD9eO9wDbTrEyiuckAOQGC3q303PcwkIiSo0vX3tPaehFZ39B2G04fSaAR
 TfErEgwjszw6tR7Y2V/gqmHgyxWtIbozjW7S0ByTzQ8ctEgjVXuoWgvqsq+qOkYqJ6pL
 YxdSAz7c7jb4+uRM8ntAv1UPaetj8BacncOMAG/lmJ1m2ekrdz5pxjALxGfGmRmMB3Wf
 vSlJ/qatmpJYzteKBO3oEttbeL14+46xcE3xl95R3Ch6lPTtkY02AmxhoQnfluTINVTv
 flWKQx4+DDi0kBoy710foaLpT3mntQJ7JSBMBCkgnmktKXf5OZYIfswTcV18jcxEf2qE
 jJPg==
X-Gm-Message-State: AGi0PuaPGwOEKu8BblsALIb9Sw4DLZj94D0ueeBnwTboDbrf67FJy/Dt
 JZ14GBr7b3gsbl8zNo6KxFucHnpMj10D9aie8PJe+xEsuy5OvSM+7MBN2/LJo3DLuyoO+5j/YLg
 +0S/0Wx9E2QdvBQY=
X-Received: by 2002:a05:6402:b99:: with SMTP id
 cf25mr13202929edb.372.1587372896632; 
 Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypII50Mz18oCVggvmQjrIECp/DMr4oa9AKzTZgbISQl0v3gLtPr1addYqd+HsbwjyvgbUnPknA==
X-Received: by 2002:a05:6402:b99:: with SMTP id
 cf25mr13202923edb.372.1587372896465; 
 Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b5sm20345edk.72.2020.04.20.01.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:54:55 -0700 (PDT)
Subject: Re: [PATCH 07/11] bochs-display: Fix vgamem=SIZE error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e703558d-6883-2a64-3489-85ab7146477b@redhat.com>
Date: Mon, 20 Apr 2020 10:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420083236.19309-8-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Markus Armbruster wrote:
> bochs_display_realize() rejects out-of-range vgamem.  The error
> handling is broken:
>=20
>      $ qemu-system-x86_64 -S -display none -monitor stdio
>      QEMU 4.2.93 monitor - type 'help' for more information
>      (qemu) device_add bochs-display,vgamem=3D1
>      Error: bochs-display: video memory too small
>      (qemu) device_add bochs-display,vgamem=3D1
>      RAMBlock "0000:00:04.0/bochs-display-vram" already registered, abort=
!
>      Aborted (core dumped)
>=20
> Cause: bochs_display_realize() neglects to bail out after setting the
> error.  Fix that.
>=20
> Fixes: 765c94290863eef1fc4a67819d452cc13b7854a1
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/display/bochs-display.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 70eb619ef4..e763a0a72d 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -267,16 +267,18 @@ static void bochs_display_realize(PCIDevice *dev, E=
rror **errp)
>       Object *obj =3D OBJECT(dev);
>       int ret;
>  =20
> -    s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_o=
ps, s);
> -
>       if (s->vgamem < 4 * MiB) {
>           error_setg(errp, "bochs-display: video memory too small");
> +        return;
>       }
>       if (s->vgamem > 256 * MiB) {
>           error_setg(errp, "bochs-display: video memory too big");
> +        return;
>       }
>       s->vgamem =3D pow2ceil(s->vgamem);
>  =20
> +    s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_o=
ps, s);
> +
>       memory_region_init_ram(&s->vram, obj, "bochs-display-vram", s->vgam=
em,
>                              &error_fatal);
>       memory_region_init_io(&s->vbe, obj, &bochs_display_vbe_ops, s,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


