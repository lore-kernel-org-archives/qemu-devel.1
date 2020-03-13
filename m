Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32F6206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olaJTCzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32F6206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYYr-0006br-T6
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coreyw7@fb.com>) id 1jCYCp-00046W-HQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coreyw7@fb.com>) id 1jCYCn-00028J-DH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:38 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <coreyw7@fb.com>)
 id 1jCYCm-00026h-S8; Thu, 12 Mar 2020 20:29:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 36F7F5C1;
 Thu, 12 Mar 2020 20:29:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 12 Mar 2020 20:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=z5i76bGEffOQrMkoMBClRukxuQsLtxLA5shXKZlaPV4=; b=olaJTCzO
 L3W/paf7sxZmUrmwD4hGOab591dB8OVsjM9HwN5h6TsGqtBa2kv0NwoMO+8zlfDe
 ghfmpOer+Mf1GSDduBOaCwNCK4omFnBbFdRFbXvlqNCAB7/77PhjCFgbexNXqN3c
 PeqFZ12vmAL4T4l5tZ1pk4i7QIanJKgmvIOkK/1Z8FLNvDwZApUVviUbWQ2XR8dg
 72TZMIdB6K8uoa3dR96dP3h+mVIyvssY1WxmfYRKC7b8hRFkxEE9DKcAuSpuoLP9
 QJrUAHql1bFE5n7XDBA4+LS8m7C0FvcpTDVV5goDZvqoVwTq23efQx9JjJbHnHlC
 iKWoRDJLG2TwPw==
X-ME-Sender: <xms:7tNqXtn8GGI3mj3Ve9CWk4S2sjygvogulSV98_io9ubcKfIsKt3kGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddviedgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevohhrvgih
 ucghhhgrrhhtohhnuceotghorhgvhiifjeesfhgsrdgtohhmqeenucfkphepudeifedrud
 dugedrudefvddruddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpegtohhrvgihfiejsehfsgdrtghomh
X-ME-Proxy: <xmx:7tNqXhL4q1CzIpztxxOI3HttO-R-KpBk3DjhqZIg9rWWdV2ApEHSrA>
 <xmx:7tNqXpxvk5FMigX0YqBJdEhsgjjybpIxFy2L0t64_MvqyPRBofPO2Q>
 <xmx:7tNqXqvXLH_XhLCiebRc8nG6G8OktkuGobeQOnqJBm2fwGfFzWDe6A>
 <xmx:7tNqXtf_PvP3FuG3lb2CX49FWKcxx_etIMSJIYB0eoSGHKWubTO6pL_Rac8>
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com (unknown
 [163.114.132.128])
 by mail.messagingengine.com (Postfix) with ESMTPA id C9FEE3061393;
 Thu, 12 Mar 2020 20:29:33 -0400 (EDT)
From: Corey Wharton <coreyw7@fb.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 1/2] riscv: sifive_e: Support changing CPU type
Date: Thu, 12 Mar 2020 17:29:22 -0700
Message-Id: <20200313002923.30905-2-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313002923.30905-1-coreyw7@fb.com>
References: <20200313002923.30905-1-coreyw7@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.26
X-Mailman-Approved-At: Thu, 12 Mar 2020 20:50:33 -0400
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Corey Wharton <coreyw7@fb.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allows the CPU to be changed from the default via the -cpu command
line option.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
---
 hw/riscv/sifive_e.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a254cad489..b0a611adb9 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -123,7 +123,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
@@ -220,6 +220,7 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = riscv_sifive_e_init;
     mc->max_cpus = 1;
+    mc->default_cpu_type = SIFIVE_E_CPU;
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-- 
2.21.1


