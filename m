Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D104C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069B121D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="paDEwZ8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069B121D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Bt-0002cf-I4
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44745)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3Q0qLXQYKCvYqYkcgbemmejc.amkocks-bctcjlmlels.mpe@flex--sameid.bounces.google.com>)
 id 1iD58E-0007iN-An
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3Q0qLXQYKCvYqYkcgbemmejc.amkocks-bctcjlmlels.mpe@flex--sameid.bounces.google.com>)
 id 1iD58C-0004In-32
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:50 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a]:52435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3Q0qLXQYKCvYqYkcgbemmejc.amkocks-bctcjlmlels.mpe@flex--sameid.bounces.google.com>)
 id 1iD58B-0004Fv-Er
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:48 -0400
Received: by mail-wr1-x44a.google.com with SMTP id t11so2181688wrq.19
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=orCQdixDAAyB3dFrVRAd6CXGSGxK2QT1UBzb/+co4sE=;
 b=paDEwZ8RaSHvTA1FBTXBa7E+TeNKMNtOIRkmt8+p8Y2Q/b/3WB2Epy+dDNHRAa0uqD
 +2IXaxOMVK/mpGVq6Fit9Tx1ec5KSEx98tr5ayLWHuJ341nwSV7OUAJQxY2gqZcRhIG/
 veHaVnxmz+m/uAxHBCW+4xMMz4/+cvk/bEPk5aJYxfb/H/fjWAJOAWwj5VX5Ig8s5m99
 xKBTwS+C0j50JfW/WtxshEV/R7yp9jnXJaGKrEEYPODpISkb3MKUFglk6pukznX8q8QI
 k79QvGMGGvMPwJDsqyuHLZWthCTT0Sy/wUOkCNBTiowJ9wCUmlgccdXPAJ+D6KMr3wWp
 nHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=orCQdixDAAyB3dFrVRAd6CXGSGxK2QT1UBzb/+co4sE=;
 b=W8IZ78zS3N8CuGJKOJm/YzWRpG/UqiFNMKJ1YU8CpKxRK/hdhcQJQ9X+hTE4s9EGVt
 +OqkVc7xfYSH+U/MhsTsZqkA3eOrReVRPiFJSOdcd3TM5nO6eJ8zXohFY/0ogVysDZ4w
 Ny7Bt4RrB0w8LOI52vAh7auCOV9r/LH7YrSgOpsh0YlWDVLtnPbAe1MfVCdXyt+++63S
 7ZqDje8IEA5HBTCFKXJGhZJimgTSr0PaH9mp7WxGyGidGfmqtYwxOz7cAmQacEltqmyP
 CQczyZH0xfNhtetdd27DxkxlqPhzmSIuuPQiC9XJfDTAv4nlBO5HybLBudCk53wvXv8+
 e6kw==
X-Gm-Message-State: APjAAAWub5PM3lNDsiaRZ9JYKlVEhdHnB97uk4d1RwqZujVbEvvjz3rj
 3dHZ7b3zEkOWiMS9kEcBtXRKEVVvgsm/MPcFd3Ou7HhW8+Mdz4CN0i5RvjDnS1NMe/KnB9ly28A
 Nj2AiHJxC+1meWl0/QojdjqmcSTHclTfxvORHZv5vHEVzMbEEf4xRpGmoYMnS
X-Google-Smtp-Source: APXvYqw8NZzcsJH75Y+gmcxoqFdhGm/qqceArAyZ++FNUF3eckiW0Xm6xrAFucBgHSXrqcusw5lBQ40NCmI=
X-Received: by 2002:a5d:63c6:: with SMTP id c6mr8793241wrw.117.1569409603434; 
 Wed, 25 Sep 2019 04:06:43 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:31 +0300
Message-Id: <20190925110639.100699-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 0/8] Add Qemu to SeaBIOS LCHS interface
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::44a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

v1:

Non-standard logical geometries break under QEMU.

A virtual disk which contains an operating system which depends on
logical geometries (consistent values being reported from BIOS INT13
AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
logical geometries - for example 56 SPT (sectors per track).
No matter what QEMU will guess - SeaBIOS, for large enough disks - will
use LBA translation, which will report 63 SPT instead.

In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
report more than 16 physical heads when moved to an IDE controller, the
ATA spec allows a maximum of 16 heads - this is an artifact of
virtualization.

By supplying the logical geometies directly we are able to support such
"exotic" disks.

We will use fw_cfg to do just that.

v2:

Fix missing parenthesis check in
    "hd-geo-test: Add tests for lchs override"

v3:

* Rename fw_cfg key to "bios-geometry".
* Remove "extendible" interface.
* Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
* Fix last qtest commit - automatic docker tester for some reason does not have qemu-img set

v4:

* Change fw_cfg interface from mixed textual/binary to textual only

v5:

* Fix line > 80 chars in tests/hd-geo-test.c

v6:

* Small fixes for issues pointed by Max
* (&conf->conf)->lcyls to conf->conf.lcyls and so on
* Remove scsi_unrealize from everything other than scsi-hd
* Add proper include to sysemu.h
* scsi_device_unrealize() after scsi_device_purge_requests()

v7:

* Adapted last commit (tests) to changes in qtest

Sam Eiderman (8):
  block: Refactor macros - fix tabbing
  block: Support providing LCHS from user
  bootdevice: Add interface to gather LCHS
  scsi: Propagate unrealize() callback to scsi-hd
  bootdevice: Gather LCHS from all relevant devices
  bootdevice: Refactor get_boot_devices_list
  bootdevice: FW_CFG interface for LCHS values
  hd-geo-test: Add tests for lchs override

 bootdevice.c             | 148 ++++++++--
 hw/block/virtio-blk.c    |   6 +
 hw/ide/qdev.c            |   7 +-
 hw/nvram/fw_cfg.c        |  14 +-
 hw/scsi/scsi-bus.c       |  16 ++
 hw/scsi/scsi-disk.c      |  12 +
 include/hw/block/block.h |  22 +-
 include/hw/scsi/scsi.h   |   1 +
 include/sysemu/sysemu.h  |   4 +
 tests/Makefile.include   |   2 +-
 tests/hd-geo-test.c      | 589 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 780 insertions(+), 41 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog


