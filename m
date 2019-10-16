Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD9FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766072168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cujMgVZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766072168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmP6-0005Sc-6R
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35907)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3TkinXQYKCm8fNZRVQTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--sameid.bounces.google.com>)
 id 1iKmMz-0003r4-Cg
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3TkinXQYKCm8fNZRVQTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--sameid.bounces.google.com>)
 id 1iKmMy-00061Y-3C
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:41:53 -0400
Received: from mail-vk1-xa4a.google.com ([2607:f8b0:4864:20::a4a]:39615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3TkinXQYKCm8fNZRVQTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--sameid.bounces.google.com>)
 id 1iKmMx-00060w-Sj
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:41:52 -0400
Received: by mail-vk1-xa4a.google.com with SMTP id d64so9894959vke.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=tzx64PJDyLT+ij05ONTmyhJONls08nBfiV+oj1m8mIk=;
 b=cujMgVZe62pabwlIyPI05h0lXc7FrEnEs3OFzJ5xTqF5h9IDEWUDexRFJTMpzRMrH8
 L5NgFBZGwP3s1eYajclGJ75qX52FppFi6S3aPBditw4rwUPtYqEFrA7dpLz842jnnMy5
 e4JCmpb0D+PxaIifmqjvg6TPnCaEqSZdc6c/2xEDYoELpeccAsJ5tI2N60NqnSar0p90
 u2BKyt8TZl01Myuz3RZafkq/Sev/HIGCGHWp6Jgs9uMg/lbPpIvvR8emeaRnEUhhLLsH
 AkCvJNeV1rslaHNrHn7H7hDZkSLli3UQYzDYc7qbX5ARccAP36DJ/VcU6wchvdtPB3rw
 QDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=tzx64PJDyLT+ij05ONTmyhJONls08nBfiV+oj1m8mIk=;
 b=QUDzqPLSx1HURa93usqhN4sEzsweyPY7Zj0gegXK5PSwMz3qp9YOomaND7RGpteNUm
 yhltdGjoMF92+xMnmQI+7c/0rF8W5oOLy6M34zbjuc1huopTAg2Tr7jsyllIp7T1O8Tw
 9npJbFhaPjkcfREgeLPuK17Iwxh508fL7gPwEYHzXozkrbSLWo/XG+gHpPhYPINc+oDh
 tj1O+5S9KDJpSJFvIFhKieMVwneK0+TrJy+OTGZ2tV4YmcQhovtxkmfI8b5kvsA7m1VO
 tv8MLbsb00EZydlJPbzYYokEf370Lq/sTGwq0wJgGvSDWQGxKwfgbRISvZLWPeqFV8Xm
 ew/g==
X-Gm-Message-State: APjAAAV40LdLdNxG3H+YpOhfzRNTjRDQRiE/kHlQfnMUChfxhIYCaV0q
 plUVpPMUKUYKpzq/fRoXSvAxaOG+YR+osIsKYlROsjCvpmI03cnksDhVnTDKUnh02q11cmKgCns
 wdNsR9nP0etRL3XxWIZ794G9BwRmxo4tcUpV8VLYNCAaCfRd0TPBClsurVlNY
X-Google-Smtp-Source: APXvYqwTK9bQfCoQY5N12HxnGnjyhDzuTDp54Hg/Y/hmJhRW8kFd/JE90DEE5G1JXOESJZN8hEINLwHi2ro=
X-Received: by 2002:a67:ffc7:: with SMTP id w7mr3085418vsq.15.1571244110645;
 Wed, 16 Oct 2019 09:41:50 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:36 +0300
Message-Id: <20191016164145.115898-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 0/8] Add Qemu to SeaBIOS LCHS interface
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a4a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


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

v8:

* Fixed BE issue with tests by using qfw_cfg_get_file() instead of
  read_fw_cfg_file(), thanks Laszlo.
* Removed incorrect comment in 7/8.

Sam Eiderman (8):
  block: Refactor macros - fix tabbing
  block: Support providing LCHS from user
  bootdevice: Add interface to gather LCHS
  scsi: Propagate unrealize() callback to scsi-hd
  bootdevice: Gather LCHS from all relevant devices
  bootdevice: Refactor get_boot_devices_list
  bootdevice: FW_CFG interface for LCHS values
  hd-geo-test: Add tests for lchs override

 bootdevice.c             | 147 +++++++++--
 hw/block/virtio-blk.c    |   6 +
 hw/ide/qdev.c            |   7 +-
 hw/nvram/fw_cfg.c        |  14 +-
 hw/scsi/scsi-bus.c       |  16 ++
 hw/scsi/scsi-disk.c      |  12 +
 include/hw/block/block.h |  22 +-
 include/hw/scsi/scsi.h   |   1 +
 include/sysemu/sysemu.h  |   4 +
 tests/Makefile.include   |   2 +-
 tests/hd-geo-test.c      | 551 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 741 insertions(+), 41 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog


