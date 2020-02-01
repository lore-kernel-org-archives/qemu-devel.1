Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6868C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E73C2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pY2oMQLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E73C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhJn-0005xg-Lc
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGp-0000XE-CG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGl-00066z-7F
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:23 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGk-00066c-Va; Fri, 31 Jan 2020 20:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519298; x=1612055298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pbSoU/woXg8N+W9GThCgL88N3S8iyQ5SSPiOjg8xFOo=;
 b=pY2oMQLMEBdI6MxaHmTF99RNcEVQjvPlRO0m1UY3AdOaomnByGjipd8b
 HBPN2GTllmak/GRoCAy7mh6ycjPf+ECEgbRjP2fFB7kGh/fUO8MFseYsm
 elQDPFQ1NxDEbV+D8a90TsRWjxukVZn2cIYmCayoOFgId/Qobn3zmUI3Q
 1JN/2RE7tvySoeE2RO+fFBiSSRUDVYHw3ODqAo10bCg06BJDZYGHLyOEH
 13zfKff7XjGRl3Gf/LcAf0xJbatEkDUfJj2bi+zxi9xosj3kQoZVRybuX
 SBZ9vI3gGri9bYNERT3W4GAuZnoqFraN0maEgqMlsYT5wEVCsm3RdWFjh g==;
IronPort-SDR: oNNajBP7mdk/vnZhGuQoqIsJjf5kc5HTPpMDEFMLxqzVxuQkYOaqeoH1XKiGwo/ImjJ+aCQEOL
 8xOSiITp9OScrQ50gJ+mvREZmSDLLUfpPriwGYC/x3xbGJovZ8OAT1oS+h9tUsz0YQmJIXXapd
 Ha8qepBTUTWGNhzYfALZ7Ea7boD+bVPxwAmuwkJ9IdjoEIzw+tj3jUZQGxLj/ENSYUg+uxh7m4
 oXp0jpQ2u1JUm+9rZVsHisBcL7i6p23hYeSp83znB1pTL2EtCTXFfS9jHeqs4Rn7q+63BMq8S7
 rOA=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872398"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:17 +0800
IronPort-SDR: lXERkrBwW2BuP/uTyQe0DTMMmkW1R7s5sR7U2z1O9yE0xMLH5kOszbgMkLzbqbHFu8wvlHKd77
 16NLybhe89KszQmR45yGl0VdwgzMPNsH1mcbbH/pmEtpvIavZjZdlmOpzgPjtIUN3RJspwvs3m
 gY8Zyrcgw+f7oBrzDfFiP2ADJCnoSKxrGVCPXnrvD6fYgj8yk22u4FgnZvjeDloa71E/6QL+qp
 CaQxVdtE1CJ8vx+JawZribpowkGjZYVSIRuVP4wzV3YJZv0Vq78wB26n32p/9e4MQZ6WYKrltT
 U1JvjQJC/zbXVSo1UG/Katnf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:26 -0800
IronPort-SDR: C5SJzw+ZsZUPMJycrf2uEMHag7X9WIZJZdgf9D/+fj35IcDnbK8B5e+F2HZNjVQ55oWXkjVmbc
 mF5YsHjznYsucwckJCA5QbYQV+Iorz5PygFPwxRZqBbg+/puVr4FWk+n5DGEGVca1UJjcCTm3U
 3TFFEP8Lg5om4F0yTNLQYSPWE5XROvypEYgVWMavo2CFP06N7lxYxPBAobZM7I9JwBSYZKJ1Om
 4NsvJKNrgUfn+xb2agUWRE0UgJvAorP0X8Snj5/YAA4E87C4IediWxYEZP/grRUG8M532rgKJl
 Ksc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:18 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 02/35] target/riscv: Add the Hypervisor extension
Date: Fri, 31 Jan 2020 17:01:41 -0800
Message-Id: <c25018ab095c6184617788abbf571d976807f381.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 95de9e58a2..010125efd6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -67,6 +67,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.25.0


