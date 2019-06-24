Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D6C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA7D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bfvah1n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYhS-0003MT-Dw
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe2-0001Fg-Jj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYdz-00019O-1C
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYdw-00011M-8b; Mon, 24 Jun 2019 19:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561419900; x=1592955900;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AcXq8ItUNFjLveFP5uB7gVk5soMtprJBIPBMsqiICrI=;
 b=Bfvah1n9StTPQuCPlSCK1mXae6RxZovqE2kWBQESBTpCjLQG8zjQ0qyj
 ldin4ouCOm0BIBiXkSFKPJ9p1b/vwskKg1sInpfag6CU24hqOFDkZGewt
 6DghpFOP4o7/9eKB8JTSy55X0nv9xks0CjKh6b4g7doY1aJD0KWGQSAlI
 7UvCQaz3GF94Rk/A1eimwPQ5nbR7tty6Q/t8FZUFeuPszVObJ4NGYN958
 4uorr7cgqzVYqT05YrhBErFZnPVI5OQmsCY82Qkh9Deg/yIGt4TchjrYD
 ICHbuGwYVTrDZHKpI1YngLPnH7tyhn0vOabR3aJwHFRRopKbzdyMXlN6p g==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="116313404"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:44:56 +0800
IronPort-SDR: BE+49INteURKLbE5/n0dl6IEBIiObmyX5K+1Uv6rCm49dfoOvK8FBRop6PBDf9VCQx7LloTcTJ
 2gzUnpw4y5LrLF/D7eh7ETHBlq2UbfydBgvUwvPB9bNBcRU8taEPW54ZO4QkNCDFl/nw1Oh+yM
 V6LuGcvAuy0GkXbRzgpX/eL9432q3wNOlYEPjuD63DsRAl2RhjRDSe6euiplnEZaVa/0s5E+id
 fAJt4q7rGr3Zexkm4jfCxzcIZxaLT0+9n4Q295ug5S7WMuslWWkRByg26htHct4oqSS75AAPP0
 6HaWlOcnBjPbAdXplsAmPGDe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 24 Jun 2019 16:44:08 -0700
IronPort-SDR: 9+4nsIs2qjxNbv+F+C5UmKdwd0PptYCUITh8Yxdu5XRXBpFMf86S/w8taA1dpYX0evnXPDbOy/
 FdIolrNqY01ugtAPWk+mSLflAqcltrBjH1bsp8oATmIylh28+fxgnxZh7Tn00vbJu4zo2F7V1s
 oMFKEKsEb7/UoiEWK+cQtab3y/q9VVqFHPvsBIXH+/9dLKeadlRmDM2E6gVAeA7qQhcQZqBoiJ
 /b2eAdFVf55w7WvjZwpiog3z6uJfIR/zG+6hyu7z7kQt5MCWt4GCGIZu2GrUNdKbIzdmUsfxU+
 uvc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 16:44:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 16:42:27 -0700
Message-Id: <cover.1561419713.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v2 0/4] Miscellaneous patches from the RISC-V
 fork
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

This should be the last series bringing the patches from the RISC-V fork
into mainline QEMU.

v2:
 - Add Wladimir's SOB line, after talking to them
 - Allow c.andi to have a 0 immediate

Dayeol Lee (1):
  target/riscv: Fix PMP range boundary address bug

Michael Clark (3):
  disas/riscv: Disassemble reserved compressed encodings as illegal
  disas/riscv: Fix `rdinstreth` constraint
  target/riscv: Implement riscv_cpu_unassigned_access

 disas/riscv.c             | 51 ++++++++++++++++++++++++++-------------
 target/riscv/cpu.c        |  1 +
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 16 ++++++++++++
 target/riscv/pmp.c        |  2 +-
 5 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.22.0


