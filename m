Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35113C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DD2206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGzf66Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DD2206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNUL-0004m6-TV
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRu-0002vV-Gl
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRt-0006BL-3U
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRs-00069s-B1; Thu, 15 Aug 2019 17:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905100; x=1597441100;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RK0xad4YSJuplKznItFV5mkv8dj5FjWn8Q3Ybznq0ss=;
 b=SGzf66IyLLrAV8n83/8UZ4QGhZyjT27ePmqqWcdP307wKgmrhy8v9kOy
 Ln6M8Cjz+JYf43/Ra0oUa0nw5x3BrpPkIdAm60DdCZNUgoo/97AhXZuFr
 ruduBDkZVCRbORr5afGVUl0sc0CxOzjhbhYCA0EjkcsYAxmOntitg0NfV
 DhdjkDYOlHzxmC9MZrlnOyHsY8Y9PkqES24/j9kTyb8nGLVrD5Evz8RHv
 tnQ3eAG4O3EvUX47sfqUUqcAVUPIiRWPwfpKqmK4lGZZxMvO1u1nzCBeC
 KioSj1iZr7FmnGfd5v4jwrpcZnwTNtbebOMhnDDIJbto8OJh4t8zmZMSe Q==;
IronPort-SDR: TN58v31DFQaXKaaTNkoUqBSb7GrV1taZyA95xc2x7qgRPikvHAAo6G01CQjK0fkX1Cplv2XXC/
 CG1i72mWQz8IxOnOFNa1FJRFjeh1FrHqlsvbbTduVx7wqLEztV0Z/YKXopcczEjz/0MKDlhGsf
 zhAUq0aredOY5ubkDWeHQsLeitT/CmKDpjohH1Oal6eJ+wjhFQDOlb8St+OE9/WXliW7Qpiv/M
 wKCN8hKhOzbqrkML3izN7eCRl9cmBsQERwY8RUJF9lsqFM1UJxdwqKvuL9V4kpTRaC0gTNGVBK
 vl4=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="222470284"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:13 +0800
IronPort-SDR: FlPCuhsolrNFB2prOCK56OrBxqVJzunlDtsuX/6bshyX5tVzwdcRPbtqFbQ/ALfbw5XNimaGy0
 gzmpXMClEa2mefliQ9eQNtQzyO6N+kmWj1xmqkySpYdaVKShG6Q8l3wUFywibXXpuxeM/uWCNH
 D9heMvk6w4WT0vHkJWXdl9GoiOX9NihTx3jM6EHQJzIdDSeeFQ9ErNFkbPJEIW2COvjABBbiuP
 ju8LvStoJdzD+EGZYVI9DawJk7jgELtin03qW4s9H1MgMGn10pXyM+p32tI6iMFxq/YClVGbrz
 GbNbRIBdvnhcWjUrgfeRj+Ri
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:35:44 -0700
IronPort-SDR: 991yTsAxfYCSb5YkG8gZlCGoJ+wWfEN3ha6n6bgffXmAtguOWPOHdirrwGKnIlWTCZ6oMR26r+
 kr6qcEkqrUDNOvbzAw4D0feyAp25BPy/Jf20au5/iEC/84GGur887XMWfJKjF+f3Vskk7kDmL6
 3s/6DDfK5WLhnKP1klZiNpB5GbN5IOqFpUh1EFQWqEyI1OkGHPtOt6tF0O5BFR1yH4w91mJ3zb
 YdbGVjMfIaP5vlu9Z8aGBu8kZ/Is80dBKuy6rFP7z3qCKi1L2aqwbfIIJtTArMubJ1KSiMc71C
 k1A=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2019 14:38:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:34:45 -0700
Message-Id: <cover.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v3 0/7]  RISC-V: Hypervisor prep work part 2
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The first three patches are ones that I have pulled out of my original
Hypervisor series at an attempt to reduce the number of patches in the
series.

These three patches all make sense without the Hypervisor series so can
be merged seperatley and will reduce the review burden of the next
version of the patches.

The fource patch is a prep patch for the new v0.4 Hypervisor spec.

The fifth patch is unreleated to Hypervisor that I'm just slipping in
here because it seems easier then sending it by itself.

The final two patches are issues I discovered while adding the v0.4
Hypervisor extension.

v3:
 - Change names of all GP registers
 - Add two more patches
v2:
 - Small corrections based on feedback
 - Remove the CSR permission check patch



Alistair Francis (6):
  target/riscv: Don't set write permissions on dirty PTEs
  riscv: plic: Remove unused interrupt functions
  target/riscv: Create function to test if FP is enabled
  target/riscv: Update the Hypervisor CSRs to v0.4
  target/riscv: Fix mstatus dirty mask
  target/riscv: Convert mip to target_ulong

Atish Patra (1):
  target/riscv: Use both register name and ABI name

 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 target/riscv/cpu.c             | 19 ++++++++++--------
 target/riscv/cpu.h             |  8 ++++++--
 target/riscv/cpu_bits.h        | 35 +++++++++++++++++-----------------
 target/riscv/cpu_helper.c      | 16 ++++++++++++----
 target/riscv/csr.c             | 22 +++++++++++----------
 7 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.22.0


