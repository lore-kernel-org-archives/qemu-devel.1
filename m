Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAEFC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A143320820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A143320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCK48-0000nh-8u
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iCJiu-0006AQ-Fi
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iCJiq-0007Yc-Ne
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iCJio-0007XQ-PK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:29:27 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BCE6A83F4C
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:29:23 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w10so4555752wrl.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=kikYKHfL3Ck2fN5906iWkH6+cgjWSLcj4UEJt3nusl4=;
 b=lt2bZPqHCPRpS1o1puqfXbhH1AmrLcfAQHCXzVgz6/3VaMPzdlVI4FznMiLYOVLcKi
 t8mFC2UyH2/4/a6euKh6hsOx3EzUfetXcLwpdK0iQKeiCuexe7iVLQFD1kiApm8gOdVo
 /5lNcUIeIQ27lxGJ/JUCpHyJb/8KTSGs0PKDN203ucN3zm5PYlpt14Zq/9oHGZBSs9EW
 x+5LD4IIcSYhwmy4CDEcj02zyS3VZpU9XaCL42wx9iV1TOM/7DxrfU/YFN76j5RBBGHb
 iUymb3ZGC8gfzyXEG4PKHGksa4w0aJMfXywLf8eX2daoa8vrpsYd90cDiGjNs+KxeVNS
 udeQ==
X-Gm-Message-State: APjAAAWe1B9H8kofqV9wkKSEWFJ05p2ZVnpEj3Ow2AN5gVSd/MHJNNdV
 cI1atCH1mCNPYLKixdBFPKRxJILTX8gLqWNaP4BFlpeZ+gOG8Y/tpA9XASDRzK71Gb/VqkVqWPo
 8RceHnMj5JZ70nAg=
X-Received: by 2002:a1c:7ed7:: with SMTP id
 z206mr13700945wmc.124.1569227362481; 
 Mon, 23 Sep 2019 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKX0HB9ZtvLtoSuZ2BX1CVOs4/0nzjuxdglPCbtiFmBe8VaHKy/UJBrfY1PW5dU113hHXcdQ==
X-Received: by 2002:a1c:7ed7:: with SMTP id
 z206mr13700926wmc.124.1569227362235; 
 Mon, 23 Sep 2019 01:29:22 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id e6sm10312791wrp.91.2019.09.23.01.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 01:29:21 -0700 (PDT)
Date: Mon, 23 Sep 2019 10:29:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/arm/boot: Use the IEC binary prefix definitions
Message-ID: <20190923082919.y2fjn2y6t7lire3z@steredhat>
References: <20190921103405.19623-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190921103405.19623-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 21, 2019 at 12:34:04PM +0200, Philippe Mathieu-Daud=E9 wrote:
> IEC binary prefixes ease code review: the unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/arm/boot.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index bf97ef3e33..59bb2fa0d3 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c

Very appreciated!

What about fixing also this other line?

@@ -575,7 +575,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
         goto fail;
     }
=20
-    if (scells < 2 && binfo->ram_size >=3D (1ULL << 32)) {
+    if (scells < 2 && binfo->ram_size >=3D 4 * GiB) {
         /* This is user error so deserves a friendlier error message
          * than the failure of setprop_sized_cells would provide


> @@ -1095,7 +1095,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>       * we might still make a bad choice here.
>       */
>      info->initrd_start =3D info->loader_start +
> -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> +        MIN(info->ram_size / 2, 128 * MiB);
>      if (image_high_addr) {
>          info->initrd_start =3D MAX(info->initrd_start, image_high_addr=
);
>      }
> @@ -1155,13 +1155,13 @@ static void arm_setup_direct_kernel_boot(ARMCPU=
 *cpu,
>                   *
>                   * Let's play safe and prealign it to 2MB to give us s=
ome space.
>                   */
> -                align =3D 2 * 1024 * 1024;
> +                align =3D 2 * MiB;
>              } else {
>                  /*
>                   * Some 32bit kernels will trash anything in the 4K pa=
ge the
>                   * initrd ends in, so make sure the DTB isn't caught u=
p in that.
>                   */
> -                align =3D 4096;
> +                align =3D 4 * KiB;
>              }
> =20
>              /* Place the DTB after the initrd in memory with alignment=
. */
> @@ -1178,7 +1178,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>                  info->loader_start + KERNEL_ARGS_ADDR;
>              fixupcontext[FIXUP_ARGPTR_HI] =3D
>                  (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
> -            if (info->ram_size >=3D (1ULL << 32)) {
> +            if (info->ram_size >=3D 4 * GiB) {
>                  error_report("RAM size must be less than 4GB to boot"
>                               " Linux kernel using ATAGS (try passing a=
 device tree"
>                               " using -dtb)");

With or without the new line fix:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

