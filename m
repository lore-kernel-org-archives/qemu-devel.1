Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB4C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79F2208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Lb4H5PiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79F2208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0bj-000834-Sh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kQ0YG-0006VG-5y; Tue, 06 Oct 2020 23:55:40 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kQ0YD-000341-JR; Tue, 06 Oct 2020 23:55:39 -0400
Received: by mail-qt1-x843.google.com with SMTP id s47so580349qth.4;
 Tue, 06 Oct 2020 20:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=58glUXUN0QTNVBya/nI4I789n2KDinn6WIOsGIH0uDY=;
 b=Lb4H5PiDSQZ5fVYuCRNDVNZr4UgaHLY9uvPoaaQ7RoRmC3lc56LKuigaBapJhGna64
 N4mm6Dt42M701YVs/dc32X3ak7/gfN2eA7BadxBHFEaHlr2/tkx7Hi753msCfLUdTYXB
 rSdE8+F6XLuGbeFyP7KDpHLwgNYQR2j3kjRVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=58glUXUN0QTNVBya/nI4I789n2KDinn6WIOsGIH0uDY=;
 b=rgDrioeLYHEaxU5d00nK/+uEYnStwZq3VQH2eGKyuBIvxhe0vQ5MJYHq4NY88EHl+X
 t0JCIxNlz0eLYLQ+9qgKUZT0X4QXPOc8BqBRPkmMTUVFk2LTEKJ9aE4lAeaJB6k0+fpA
 RduW6PuImAnsivC8oJrSF33cGeCG4MFXCZf30Y5e/vEJZf8cx82vzWBLuEhrZPCvtgLc
 1kIobojxR4b2OU7lkRIgdzxTP0HGLw9xjLWmJWGjSKOchLNcB7Df3tn+ua7/YF3sXVcG
 yD7Z05QPvuujj0QXeWpUz/kNQ5GWn2oqojs7adk4Hf/CZHge7R6ibvleC6DKxMhuKRl+
 gKGg==
X-Gm-Message-State: AOAM532AqWi9zO2esxnYLVlPZQFrJJXglA56Rvhts6GiXIXAXHwzspxx
 bycZntaEbVIEnkWATxNdmsG6bhOO7MPtr29DIOo=
X-Google-Smtp-Source: ABdhPJzkVsIFRm7ngRivHU27QYHjzpItaIPtSA6HmUTrNftrVi00lSVUGIQn1KJxP5Ufs6sZHVlMqP03mFCXEEbva/k=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr1468000qtr.263.1602042935353; 
 Tue, 06 Oct 2020 20:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902093107.608000-1-clg@kaod.org>
 <CACPK8XdsX1hfNTw+Eb-=u2AXc8Ww5wVwU0mRnRo=p=d_VBTA0A@mail.gmail.com>
In-Reply-To: <CACPK8XdsX1hfNTw+Eb-=u2AXc8Ww5wVwU0mRnRo=p=d_VBTA0A@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Oct 2020 03:55:22 +0000
Message-ID: <CACPK8XcaUXxtr-+sj8s8oHR1O+wqwEiZ2jyr7nJL9hh=YGFauA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] 5p80: Add SFDP support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=joel.stan@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 01:43, Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 2 Sep 2020 at 09:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > Hello,
> >
> > JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
> > provides a mean to describe the features of a serial flash device
> > using a set of internal parameter tables. Support in Linux has been
> > added some time ago and the spi-nor driver is using it more often
> > to detect the flash settings and even flash models.
> >
> > This is the initial framework for the RDSFDP command giving access to
> > a private SFDP area under the flash.
> >
> > The patches available here :
> >
> >   https://github.com/legoater/qemu/commits/aspeed-5.2
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
>
> Note that these need to be rebased on master; there are some minor confli=
cts.
>
> These patches have proved essential in debugging a recent kernel
> regression. Thanks for adding this support C=C3=A9dric.

For reference, an OpenBMC UBI based NOR image with an upstream (5.8,
5.9-rc) kernel can be used to reproduce the bug as follows:

qemu-system-arm -M witherspoon-bmc -nic user -nographic \
 -drive file=3Dobmc-phosphor-image-witherspoon.ubi.mtd,format=3Draw,if=3Dmt=
d \
 -kernel aspeed-g5-dev/arch/arm/boot/zImage \
 -dtb aspeed-g5-dev/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dtb \
 -append "console=3DttyS4,115200n8 ubi.mtd=3Dobmc-ubi,0,0,0
ubi.mtd=3Dalt-obmc-ubi,0,0,4 ro rootfstype=3Dsquashfs ubi.block=3D0,1
root=3D/dev/ubiblock0_1"

The ubi.mtd can be found here[1].

This assumes you're running qemu with this series applied, and an
upstream kernel built with aspeed_g5_defconfig:

git checkout v5.8
CROSS_COMPILE=3D"ccache arm-linux-gnueabi-" ARCH=3Darm make -j8
O=3Daspeed-g5-dev aspeed_g5_defconfig
CROSS_COMPILE=3D"ccache arm-linux-gnueabi-" ARCH=3Darm make -j8 O=3Daspeed-=
g5-dev

The fix for the Linux kernel issue is on the linux-mtd list[2].
WIthout the fix, the kernel will fail to attach the UBI volume:

[    1.453224] ubi0: default fastmap pool size: 25
[    1.453370] ubi0: default fastmap WL pool size: 12
[    1.453505] ubi0: attaching mtd3
[    1.467316] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI forma=
t
[    1.467902] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd3, error=
 -22

With the fix, the system will boot through to userspace.

Cheers,

Joel

[1] https://jenkins.openbmc.org/view/latest/job/latest-master/label=3Ddocke=
r-builder,target=3Dwitherspoon/lastSuccessfulBuild/artifact/openbmc/build/t=
mp/deploy/images/witherspoon/obmc-phosphor-image-witherspoon.ubi.mtd
[2] https://lore.kernel.org/linux-mtd/CACPK8XceL_QHCQOhfus27rei0vwfRJAFjfL6=
JkVw9pwxJj2d6Q@mail.gmail.com/



>
> Cheers,
>
> Joel
>
> >
> > Thanks,
> >
> > C.
> >
> > Changes in v2:
> >
> >  - fixed dummy value
> >  - replaced  'sfdp' table by a 'sfdp_read' handler
> >  - more SFDP tables
> >  - fixed Aspeed SMC support
> >  - introduced mx25l25635f chip model for test under Linux.
> >
> > C=C3=A9dric Le Goater (9):
> >   m25p80: Add basic support for the SFDP command
> >   m25p80: Add the n25q256a SFDP table
> >   m25p80: Add the mx25l25635e SFPD table
> >   m25p80: Add the mx25l25635f SFPD table
> >   m25p80: Add the mx66l1g45g SFDP table
> >   m25p80: Add the w25q256 SFPD table
> >   m25p80: Add the w25q512jv SFPD table
> >   arm/aspeed: Replace mx25l25635e chip model
> >   aspeed/smc: Add support for RDSFDP command
> >
> >  hw/block/m25p80_sfdp.h      |  27 ++++
> >  include/hw/ssi/aspeed_smc.h |   1 +
> >  hw/arm/aspeed.c             |   6 +-
> >  hw/block/m25p80.c           |  47 +++++-
> >  hw/block/m25p80_sfdp.c      | 296 ++++++++++++++++++++++++++++++++++++
> >  hw/ssi/aspeed_smc.c         |  21 ++-
> >  MAINTAINERS                 |   2 +-
> >  hw/block/meson.build        |   1 +
> >  hw/block/trace-events       |   1 +
> >  9 files changed, 385 insertions(+), 17 deletions(-)
> >  create mode 100644 hw/block/m25p80_sfdp.h
> >  create mode 100644 hw/block/m25p80_sfdp.c
> >
> > --
> > 2.25.4
> >

