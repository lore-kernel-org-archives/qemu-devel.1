Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F81C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0930C206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGsmlU6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0930C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR8m-0006rc-1v
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxQ-0005Sg-CZ; Thu, 28 May 2020 18:25:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxN-0008AD-L0; Thu, 28 May 2020 18:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704697; x=1622240697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eTDNgqGnduUaARXdpYrJlPRsQmtdi54c1YGYJojQbCg=;
 b=SGsmlU6xN/q//Lr6+bRl5pBEatnFqwzCArvf7ytG4AtLFQPavLRKdQye
 Ll3qXH0QjWWzLrTJq248nWSRFxqJouhQB5P+HA/Twtmr0ob67b/OL6Mwr
 zYQYddK/0Vc959IqtshVw9U1KM4LCA+F9553IjWxwidW+GH6ah6ge3p/V
 WDWbKwyNJy184xJbMbT5qf/2TrpIkIUgpSde8M0RN5JvVeQDgkqgIQ+gi
 R42ryun3guS71M2mhigqTLBxEuVtPB6YY/y7WhXjdFDCa6/B1FI4AhWLt
 GfvyrTyeP2XHtGbl1QfO4RwEfezf2eg2RSY4nG6mhnXpChw9M+8d0GtbD g==;
IronPort-SDR: eImOvrdJj2MdTb+JaRfYS3qlEtVBN0i+fIa1FgUPbf+5/gfoj1wG2P4iH3ARtsAefy3Jorn/Rp
 b7syw5a9L2D5WPxoqUxeYVEWdjJAjCxOo1tFtPZRen7EZza1gTiejF/WEZsa+zPHJvJNYNDPLz
 BKze2TiVIPccKdCWxmcxHu4NLjFjLaUnABtKCUSNmpwXc3/TlgG6IOrr699xw6RyTod86wUBgb
 vxRHMlseQ335JYvGmNX+8k2/R4uLHFz/Ky562QQ7t4w5wGwsw6hzT3U80lDjMukt3lXxxLnYXy
 iVk=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="247810988"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:24:52 +0800
IronPort-SDR: R6V5KDBObRN3/EsiaZ9KnaVk+IgtYzGhpBX4hH1ZrZMWDQczxduMkt0L83PA04fVPQseqJaBN7
 I3/ZOQ+LnwInpZ1tRrFFB+bMGKHjBVhBg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:14:08 -0700
IronPort-SDR: ttZi74bTETIr8rvr2ibn30S+zW8Ywm4VXedrLKdmwVOoDtsaitIQdOoJTjzCGqDG8Otc7MpSju
 ysD/C8vCJqcw==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 May 2020 15:24:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 4/4] docs: deprecated: Update the -bios documentation
Date: Thu, 28 May 2020 15:16:16 -0700
Message-Id: <dec5eeaaaea2f9ea5776a3a31d41fd8ec246a06c.1590704110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704110.git.alistair.francis@wdc.com>
References: <cover.1590704110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:24:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the -bios deprecation documentation to describe the new
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/deprecated.rst | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 38865daafc..8c445d4062 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -138,25 +138,23 @@ the backing storage specified with ``-mem-path`` can actually provide
 the guest RAM configured with ``-m`` and QEMU will fail to start up if
 RAM allocation is unsuccessful.
 
-RISC-V ``-bios`` (since 4.1)
+RISC-V ``-bios`` (since 5.1)
 ''''''''''''''''''''''''''''
 
 QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
-RISC-V virt machine and sifive_u machine.
-
-QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
-default will change in a future QEMU release, so please prepare now. All users
-of the virt or sifive_u machine must change their command line usage.
-
-QEMU 4.1 has three options, please migrate to one of these three:
- 1. ``-bios none`` - This is the current default behavior if no -bios option
-      is included. QEMU will not automatically load any firmware. It is up
+RISC-V virt machine and sifive_u machine. QEMU 4.1 had no changes to the
+default behaviour to avoid breakages.
+
+QEMU 5.1 changes the default behaviour from ``-bios none`` to ``-bios default``.
+
+QEMU 5.1 has three options:
+ 1. ``-bios default`` - This is the current default behavior if no -bios option
+      is included. This option will load the default OpenSBI firmware automatically.
+      The firmware is included with the QEMU release and no user interaction is
+      required. All a user needs to do is specify the kernel they want to boot
+      with the -kernel option
+ 2. ``-bios none`` - QEMU will not automatically load any firmware. It is up
       to the user to load all the images they need.
- 2. ``-bios default`` - In a future QEMU release this will become the default
-      behaviour if no -bios option is specified. This option will load the
-      default OpenSBI firmware automatically. The firmware is included with
-      the QEMU release and no user interaction is required. All a user needs
-      to do is specify the kernel they want to boot with the -kernel option
  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
 
 ``-tb-size`` option (since 5.0)
-- 
2.26.2


