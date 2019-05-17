Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836EA2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WEC98wOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836EA2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRl7o-0000bc-EB
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:14:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5y-0007tW-O3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5w-0007I9-MK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5u-0007Cj-5s; Fri, 17 May 2019 18:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558131170; x=1589667170;
	h=from:to:cc:subject:date:message-id:mime-version:
	content-transfer-encoding;
	bh=RPawglhrHzG/7peC8AZqsKuO5CHp1JP06eIpaNNiivo=;
	b=WEC98wOzTuX/6SZmR71TsnG6pzey8bcC0rkZRajpBKNTyVf0HKQdFYWC
	BNDnxz23oEkPS0fCBV57T1hgKgvsKNsG9U3kvQv4sdlpKkCB5oO1Et9R5
	OUuZDf2i0nywEADf8TMVVoO/BPFHKJt6oy+nhlX9zTVp+DIMW00kKC2gS
	ZfpXzYW45BgEzIHa2s527g6GSTmcgHccOzIe+usLpAnhpXWPn1jE/pqYV
	VXYY1Q0bm8SucTWM/rBi4jXFGwaQ9XcQlrEuU+MMdZPSoDFiq48dh+1oO
	R9sVNhfnd065LiCLJPD3u3UYiLteDyHr3HMSm4B8j5t+wBy0OuFY3GLn3 Q==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="109789991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 06:12:42 +0800
IronPort-SDR: Kal1SyPJNj9JAXRzHz3wzY54HC0+Cbcd3RMoajuK/SVvjbH6l5YwuuNpadPHskt+2jQDSIHuST
	+YNkVi3fWXoGROE4goNhgnhd2gn13VoInml6JYKXKAK7przaM2Sz1sfhmQhesaOXS1UNRWhhCh
	5huXYsLcq/zJwTwYLC6ZW/TM72lLmds0kpAJo3FnWEErfA+HOT5hNYWX7SjPLeam7hcmYGy3zS
	lN27/ekkGKbGxzUtMLyF1tQx3F7Gnh7ehkV6zTljGrKv12OcbMKGOrJzK//YWtU2vqY/rE7UBd
	yD4iqgHZ+QUSAN/+4WFilosZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep02.wdc.com with ESMTP; 17 May 2019 14:50:34 -0700
IronPort-SDR: rFKZFoKrdfHmgkL47DcLq5bNNFP/XZLIksWdoz39j8lxNp0xKdGDpNQzJzx245fmftdfjqJ3K2
	fKMWouC2R34k2CPHbZL4qC0Cah7yO18E7okEzR01jpRLYN3WoqE8WGOqPKT8sgWayZxXuuDC0C
	cq5R9rdVBciHb2nju/ntXY+dHbknrFmTFISufAyGoFsXfjUCHy7+7uMpOz/Mo1OcE4hkCBjmn4
	MrdCigqsLdXzPrdbNE4i5CVYXmQ5Eyqr3oPh13Kxf5u2gpkpCvI3BmBV7dKqptwt4n6XVeO8NB
	Svc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 17 May 2019 15:12:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 15:10:56 -0700
Message-Id: <cover.1558131003.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 0/4] Miscellaneous patches from the RISC-V
 fork
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be the last series bringing the patches from the RISC-V fork
into mainline QEMU.

Dayeol Lee (1):
  target/riscv: Fix PMP range boundary address bug

Michael Clark (3):
  disas/riscv: Disassemble reserved compressed encodings as illegal
  disas/riscv: Fix `rdinstreth` constraint
  target/riscv: Implement riscv_cpu_unassigned_access

 disas/riscv.c             | 53 ++++++++++++++++++++++++++-------------
 target/riscv/cpu.c        |  1 +
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 16 ++++++++++++
 target/riscv/pmp.c        |  2 +-
 5 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.21.0


