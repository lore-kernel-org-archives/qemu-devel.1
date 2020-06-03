Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80258C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481DA20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXGSbqNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481DA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWHm-00028W-H2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAI-0007mi-6z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAH-00060l-5T
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201373; x=1622737373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=orsSXLrSQIMi3TMC0jSYfH0EWLV9WQAZfn7IxsH8lEI=;
 b=iXGSbqNPZYLr5Bo8FJ2nnHtSyFi1dTIg4Nh7QghToueE+A5K+QDA18/d
 4gnejhdEPvNPLODW962m11tfuaty28bX9VfCTxFkkNYH3qmEDKbKI5KYu
 in5mHNvPy5BmTUhgCVR2ZC/H+VdXsoxsT6TLv2vy+N2U9si+078z5lzzk
 R8QkzltygOkFnRPYWXhEpGDlIt3qjBPRQMAwXYH4sC5f5GrSkCL0jMuWS
 v7adAR8TiFG5p1xv1qSZCQaxAvopVoz7RJIYB483PL2yT2t2XlIq90tiz
 q2AJ/oFX4meeJdgqKI5Z9JCJt2kvhk9QaVU4fxanfoN9+f/mow58t4ZWY A==;
IronPort-SDR: GiOIdaKP4sbgOBLAvzLb/PbW3KylqiDftXzXM82Ri08/GeYST4mckclgU8vfn8dQ9RrgRRqilX
 EaDdEywoLlCAo9SUDHuL2tB1Qk64B10ZBCbqPTcowaK2Mbqswyabuomg5XMvSM8PNjCXpX5w48
 9sZuWnbDPv5Qu7xaL98oHFuJynHCssMu7tLGXPsPNl7O1d/3xwe4sYRiup/NJxDioqvIVkMMSB
 W6cppjEUmjlReYSgp77X43BO3Eq2wENrhR+zNN10FFe30POc4KapdBQr2FcyjICB7mj+wGW33m
 QE8=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451370"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:43 +0800
IronPort-SDR: SVRO/mhh2FxdYEoRiRaLpCXhwLJ+lYO35+P7HqyvwC+SR9jgIxLjpwBQVq5RVCN82H9vOdx7eg
 xdc36mgMXopyG8HQ1kT3dJEgrZaeGc87M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:47 -0700
IronPort-SDR: mOn2pcKJxsmA1xzKaajakd2WOAxotvI8qvHqEPvDzJQT4NPh1KLf2vWEPKPzVb2L6QKi9AxYkt
 YEIpUkqUwbkg==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 08/15] docs: deprecated: Update the -bios documentation
Date: Wed,  3 Jun 2020 09:13:51 -0700
Message-Id: <20200603161352.744204-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the -bios deprecation documentation to describe the new
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 docs/system/deprecated.rst | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index d177609cbc..544ece0a45 100644
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


