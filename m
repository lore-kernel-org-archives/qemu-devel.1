Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D9C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8B720644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="juVaLrAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8B720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83wf-0005qn-IF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1i83js-0000gH-Qg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1i83jr-000147-AV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:36:56 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:35175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1i83jr-00012L-3N
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:36:55 -0400
Received: by mail-qt1-x844.google.com with SMTP id k10so25549580qth.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=onCgaoKrvohkJJP5JbemVdYzyZ7/SKUJctYDpFU+hFg=;
 b=juVaLrAAnfEChbMEEvgPqu7zxUgFpI+tEnCdQQ2iVuNtsw/XrkmPEFfq6VQRf06sFm
 sacKcEbE/wcbFynqBzM2FCZK+nz2ayJKuLhwVA6SgbIRZGmQhWek0IntKlOFCsU7EuhS
 qlyrNv+Vj1erBv1tQ0nRpX6HKjC5WAslfjKKwhsZVK34nrbM489bivgRtmGdfwQjc5/t
 ScFvIJ/YqxKpttQgBdKbj97c49M2McqdvhVvBb/ry8naWjuNLZRKvp+zteZOJszNLGhf
 pccvtg5DslUVx8swcb1k1fRKTdQCVGREUQnEK9fvSM/X2imJgaWQ87JzSbBKMqLTX8zU
 lKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=onCgaoKrvohkJJP5JbemVdYzyZ7/SKUJctYDpFU+hFg=;
 b=YCZ+HRD+6fWnP4fKQ+iysK6DNi6Ni9rOdgyDPEpivdEcT8ilnISuPb1QyTkqtyyP1M
 yA5/3pRx2DppEfgHABuUNZTiYW9+StpoJIfQLOY3bw5X+/vGwJRvDXbaCV94iYGoocNe
 GQY2ADU8BQO7WaXnKpvCVvFbs0urvNLJlPoajkxI8mr/LqdZUbVecH0UhyIxC1yd5huc
 NGrtiZD1UbfJtjt6pJFzmmeqmhIK943FTlPDucdbwGdRvTc9+DTyeqfgZIuRubj5hVvU
 7zgoXEwlztpfZa/Jf7LzxISkxYYXDxSEeYhy9zwy0ZeUdigUCCKY+FAw5pQIT/Of+QiC
 AN3A==
X-Gm-Message-State: APjAAAXjS3uehbTy0H9n5/hPnjqWx7tQ8HQQeszMUkZ6p0f9Eq5rCjxi
 mALrNT/DCiIEHvP2vBLb6xeDxGivudX2lN6yclF69PZIq/A=
X-Google-Smtp-Source: APXvYqxkN6/ARB2nnvU4s0yhGv8geeWK/KUDrp2q+s4ontI01j/ubqkzp2Bhjj4o5jW3vXB/uEF3cui1ZOwq1XZ+Trw=
X-Received: by 2002:ac8:1793:: with SMTP id o19mr35189454qtj.64.1568212611513; 
 Wed, 11 Sep 2019 07:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Date: Wed, 11 Sep 2019 17:36:39 +0300
Message-ID: <CAFr6bUky8Au-v6Y4yF+Ucg6H7Upc619WLR6tPzp3d6qy80+bsg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, seabios@seabios.org,
 Kevin OConnor <kevin@koconnor.net>, liran.alon@oracle.com, kraxel@redhat.com,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping

On Tue, Aug 27, 2019, 11:24 Sam Eiderman <sameid@google.com> wrote:

> v1:
>
> Non-standard logical geometries break under QEMU.
>
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will guess - SeaBIOS, for large enough disks - will
> use LBA translation, which will report 63 SPT instead.
>
> In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> report more than 16 physical heads when moved to an IDE controller, the
> ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.
>
> By supplying the logical geometies directly we are able to support such
> "exotic" disks.
>
> We will use fw_cfg to do just that.
>
> v2:
>
> Fix missing parenthesis check in
>     "hd-geo-test: Add tests for lchs override"
>
> v3:
>
> * Rename fw_cfg key to "bios-geometry".
> * Remove "extendible" interface.
> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
> * Fix last qtest commit - automatic docker tester for some reason does not
> have qemu-img set
>
> v4:
>
> * Change fw_cfg interface from mixed textual/binary to textual only
>
> v5:
>
> * Fix line > 80 chars in tests/hd-geo-test.c
>
> v6:
>
> * Small fixes for issues pointed by Max
> * (&conf->conf)->lcyls to conf->conf.lcyls and so on
> * Remove scsi_unrealize from everything other than scsi-hd
> * Add proper include to sysemu.h
> * scsi_device_unrealize() after scsi_device_purge_requests()
>
> Sam Eiderman (8):
>   block: Refactor macros - fix tabbing
>   block: Support providing LCHS from user
>   bootdevice: Add interface to gather LCHS
>   scsi: Propagate unrealize() callback to scsi-hd
>   bootdevice: Gather LCHS from all relevant devices
>   bootdevice: Refactor get_boot_devices_list
>   bootdevice: FW_CFG interface for LCHS values
>   hd-geo-test: Add tests for lchs override
>
>  bootdevice.c             | 148 ++++++++--
>  hw/block/virtio-blk.c    |   6 +
>  hw/ide/qdev.c            |   7 +-
>  hw/nvram/fw_cfg.c        |  14 +-
>  hw/scsi/scsi-bus.c       |  16 ++
>  hw/scsi/scsi-disk.c      |  12 +
>  include/hw/block/block.h |  22 +-
>  include/hw/scsi/scsi.h   |   1 +
>  include/sysemu/sysemu.h  |   4 +
>  tests/Makefile.include   |   2 +-
>  tests/hd-geo-test.c      | 582 +++++++++++++++++++++++++++++++++++++++
>  11 files changed, 773 insertions(+), 41 deletions(-)
>
> --
> 2.23.0.187.g17f5b7556c-goog
>
>
