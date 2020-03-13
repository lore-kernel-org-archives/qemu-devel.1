Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A219DC1975A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F99206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7qaVPl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F99206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52243 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYXu-0005N8-L1
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coreyw7@fb.com>) id 1jCYCt-0004ED-0j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coreyw7@fb.com>) id 1jCYCr-0002Fa-3h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:29:42 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <coreyw7@fb.com>)
 id 1jCYCq-0002C8-Sp; Thu, 12 Mar 2020 20:29:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 724FB4BE;
 Thu, 12 Mar 2020 20:29:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 12 Mar 2020 20:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=jblf/wtaZkgMARGaAfEh+OyYkRvrqOM9fxNCdw32ll0=; b=K7qaVPl5
 k5oFM4Y3h9RU8ZPeAJ2UJ7wEdReqreYUqUbmEfaXwn7pkdmgRMSCoPGD6oEuXXEU
 gFOkYKNSk2sQRvntTVAEQDdApxG2L6uzYEK3Eu20PahRcm/+PcMhOWwhCo0/h1mK
 c/1jAMG/HeB9wKAYfxeTUO6IJw0mhifdfbOWkhJmpcaq3F6kH7nRBaKClM/622iK
 YxxSUfbgsxYQ1gPfNf6zb3KDgWFqJ1lgXeaEehoSqQN2gt3pm3XVWMsofKN67UKu
 mpkpV+BpkfYOepNc0m6bOoSuvQ4UHQV5TlH1M/1RsemAnqaQ/mJRUsJyHDZIv9QV
 lXSM+Sy6R14cQg==
X-ME-Sender: <xms:8dNqXnC0BLjbpn_GmUhwJseEuedRdUNbFHSALxSOdF9Wt-GHMfMW9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddviedgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevohhrvgih
 ucghhhgrrhhtohhnuceotghorhgvhiifjeesfhgsrdgtohhmqeenucfkphepudeifedrud
 dugedrudefvddruddvkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpegtohhrvgihfiejsehfsgdrtghomh
X-ME-Proxy: <xmx:8dNqXlgT0exkDNiGhlQnhRKnN42OtYbjyngIIVmNNluak8ftR4NFZA>
 <xmx:8dNqXjMiQwOJXGS32WAN0D3QIMkTImzOtXhbwjtJifm6yMP37q9NQg>
 <xmx:8dNqXpWUQBKorrZub0JCfSxm4VoQbDfyFGBTY0zCISt6u_3BhL6t8w>
 <xmx:8tNqXrmskvOmunDa2ILiAV45ajQYbYMB3a3sPzQ52iuNJBzAWQLlw6nAz7k>
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com (unknown
 [163.114.132.128])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0E7363061363;
 Thu, 12 Mar 2020 20:29:36 -0400 (EDT)
From: Corey Wharton <coreyw7@fb.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 2/2] target/riscv: Add a sifive-e34 cpu type
Date: Thu, 12 Mar 2020 17:29:23 -0700
Message-Id: <20200313002923.30905-3-coreyw7@fb.com>
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

The sifive-e34 cpu type is the same as the sifive-e31 with the
single precision floating-point extension enabled.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..d415cd06eb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imafcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, DEFAULT_RSTVEC);
+    set_feature(env, RISCV_FEATURE_PMP);
+}
+
 #elif defined(TARGET_RISCV64)
 
 static void riscv_base64_cpu_init(Object *obj)
@@ -609,6 +618,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
     /* Depreacted */
     DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3dcdf92227..ae5a1d9dce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
+#define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-- 
2.21.1


