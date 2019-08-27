Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7344C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BBC217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AgAjgUXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BBC217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Wo2-0006BD-5E
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36579)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3yehkXQYKCiAO6IAE9CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--sameid.bounces.google.com>)
 id 1i2WmS-0004Vn-Se
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3yehkXQYKCiAO6IAE9CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--sameid.bounces.google.com>)
 id 1i2WmR-0007jh-F2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:44 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:42887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3yehkXQYKCiAO6IAE9CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--sameid.bounces.google.com>)
 id 1i2WmR-0007jA-2V
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:43 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id l8so4993040ybm.9
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=oPzGYCfz6fB+LQmTo0GVew/IPrjI9h3/dbHxHOhwq/Y=;
 b=AgAjgUXGhwvJpVzQCVsyeyVV88SpqvLv1YnaY7G5S9Zmi0U/n3D5KmZjTB6GW8aN4/
 5TEFk2zPVaM5s7P3VozcbXlBJIM9dfFDh/Px5ZMcZpczNkRlwav/16mS7dW+KJ5zI2ye
 c5iFepzJQ2B6Xo+ZX6kn/ERiMV6ndWHss0xqjOVuz7LKl+wKe8aOZd0GUQlPf+XKoTy5
 pU87pgB6NtEtr4zdnhX+M2/os4QKuoF7Ef4jU0bDFMAEPJ1HnwEY2HGLFNTp/w59NUbR
 BNXSJGzcthB1l40QQJYtIMsPTQryTwagQevsZtLWVJ1Jp/R65QU1lek89a7uvVYnT2ZA
 QLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=oPzGYCfz6fB+LQmTo0GVew/IPrjI9h3/dbHxHOhwq/Y=;
 b=YJhC291Ybtj4wxavnLbaMrkNxOsC10jWJw42/EQiJ0XwBHH30IfwJQlYph2luQa5eT
 D+vPNCegU9soE+XTME+nqJAM6yjn/rFIIH7tWM68V79S/H9vukAC3xfLov9Dg4svGKWz
 ZTgFuK7BNS/e5Lb0NcEFxRSYaDfYJY4ftRJ5lEkkmMtPQTJQf77V2ajgKp/2znr2tONQ
 fxYL1NtOTUF8KkBstmPIHs+Vsp6fbr3AkCXwuqMczD+xtW4ofa1sjHNwfYx4Zrr5Jl3T
 a1WQricoyHn2TsZx26POMpUPZniPoCRnPWewinWK6QBBXV3EV52TCenHKxRNDzntwoCo
 TUBw==
X-Gm-Message-State: APjAAAWUJqiw43nzp7daiOWEQOMrO74Ii7z16w22GfswuxeL8D/fOWGG
 SmeZmVc6DscB/5+44RyVJPMQoyQ16e2VgPLOV26mDG/fsaywqOdDl2LMb81+0e+PXF2gTx17Bwh
 8VUbNcz3M7RoVskYWtC01x0iRfZxmoJadN8t50z+FXwnXkuRROm7P3BwFEoIa
X-Google-Smtp-Source: APXvYqxcnKrr8OWQgYIsiWQ7avk5ef1k4lh6igl1m+oAnkE3RtzEQdLtPk6uHmMqbWD6SJKykDuEF3cGrvE=
X-Received: by 2002:a81:7a06:: with SMTP id v6mr14651442ywc.450.1566894281951; 
 Tue, 27 Aug 2019 01:24:41 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:19 +0300
Message-Id: <20190827082427.64280-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b4a
Subject: [Qemu-devel] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
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
 kevin@koconnor.net, liran.alon@oracle.com, kraxel@redhat.com,
 sameid@google.com, karl.heubaum@oracle.com
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
 tests/hd-geo-test.c      | 582 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 773 insertions(+), 41 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog


