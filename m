Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D926C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF1D206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQjJhOru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF1D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHzi9-0003gz-NR
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 21:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHzhN-0003AL-IQ; Mon, 14 Sep 2020 21:23:57 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:44194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHzhL-0005YA-TF; Mon, 14 Sep 2020 21:23:57 -0400
Received: by mail-oo1-xc43.google.com with SMTP id 4so338653ooh.11;
 Mon, 14 Sep 2020 18:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bxsujlZ8uYLEMwCUdtdyPzE4fQP4m9Ot6upgmK5mtC0=;
 b=dQjJhOruj3KReX8XTTTrMwmra2IIHOpcWNYhyCI0PTCa8mBcjFz03i6oMPgNEhk9/B
 R0chtE7wFIC64s776zbjXNALpuosyut++gPKTaNWW+6f5shhTBhD2TeFdVI3+trsnfgr
 f7Jz7kp6crd0cVs7KdrfhAhhd3zbFVrun3trD6OZptGH9vTcjG0Y+JYKh8leVwgIY+c9
 K7tb1R/iCp9FmnxeEb47fVF44vsKelFcUoxcURCERr+5Yxo2qxEa/mdjvoCXVUhCXXhP
 oDR2ouDMXO1zk0R1d+m8BS8NC0hJA/O+syhN17TzVTvSemZTlFXf4aEsLnM5iJn9tKj6
 vPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bxsujlZ8uYLEMwCUdtdyPzE4fQP4m9Ot6upgmK5mtC0=;
 b=BNAHkIG87WAq6GK+DfB2bvCp7zJSBwRP3bDM0kf9cHHamIAbslCWnnjJzXvJ+4isr3
 SURBaln5x2BHMcOI5dSkwmtegpObv+VJFq5BKRCLWTxJtDkQ/+SA5e6kAreOLy1M+Bwz
 Z35mfT5XUKpqiTql7U7i6zAXyH0sIItyVG+rNoPp+M5q8I71S76nWjAFRGCaXVO+z+EZ
 b3drLVt5tHhLKzeZ+s+DT+JbJlOvhH7yN7Ce/ovg22iCcLpxYM/UTcOjfmMWV2mOXsUZ
 RrSxr+RAPugAy7KX2hbkTy4ifApR0Pa//Jz9/cW9z1G5HOjoryrtDqI7St8D9VbsS6Rl
 IolA==
X-Gm-Message-State: AOAM53214coTEMAG2T2rWtg+M7HBS77BeVUs4i2uw36unKfAqIEVTQ0D
 fQwVCK/MT2y6PtwyxEQHaMFlZUP9Vwbs3JfR900=
X-Google-Smtp-Source: ABdhPJyjZ9p5bkgMqoAVbLo3f6yYZzmSto3i+xdW0hDAWW/KwxZHEOE+ZHS2q4NX8evcDBQRJ/vf59WJbK6/xxdvLI8=
X-Received: by 2002:a4a:d8ce:: with SMTP id c14mr12050434oov.90.1600133033598; 
 Mon, 14 Sep 2020 18:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
In-Reply-To: <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 14 Sep 2020 21:23:42 -0400
Message-ID: <CAFubqFssie0eqor4sL+v09kwam6aaoa8P7k+y0x=KHLZXs_7bA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 4:43 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> Add support for the vhost-user-blk-pci device. This node can be used by
> the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> in the following patches.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> index 5da0259..c0fd9d2 100644
> --- a/tests/qtest/libqos/virtio-blk.c
> +++ b/tests/qtest/libqos/virtio-blk.c
> @@ -30,7 +30,8 @@
>  static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
>                                      const char *interface)
>  {
> -    if (!g_strcmp0(interface, "virtio-blk")) {
> +    if (!g_strcmp0(interface, "virtio-blk") ||
> +            !g_strcmp0(interface, "vhost-user-blk")) {
>          return v_blk;
>      }
>      if (!g_strcmp0(interface, "virtio")) {
> @@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
>      qos_node_produces("virtio-blk-pci", "virtio-blk");
>
>      g_free(arg);
> +
> +    /* vhost-user-blk-pci */
> +    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
> +                                PCI_SLOT, PCI_FN);
> +    opts.extra_device_opts = arg;
> +    add_qpci_address(&opts, &addr);
> +    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
> +    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
> +    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
> +
> +    g_free(arg);
>  }
>
>  libqos_init(virtio_blk_register_nodes);
> --
> 2.7.4
>
>

