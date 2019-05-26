Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF274C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8546F20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8546F20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi6Z-0003EH-Ka
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:37:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxJ-0003S6-PK
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgA-0006D7-8N
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgA-00066k-19
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so4621786pfh.9
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=oEPA0o9vzCE8UV54ZLVF8fcoHCuDXwBFBPwkT+i/Um8=;
	b=rIaTH/5UtZSHr6ZjXbkI7vs4x24pj1t19yCj0k/NP5MwE/1a0L/ofyz65zQelq5Sjm
	uGKw5iPWwvk8f90GtNTynSLR94PzEt9iBrGzKKCeu+i6N3K5dsS9LqRHIzLZQCwm+sR8
	ZE7CRgCUb1RmDul6cheuZOLcsSUDtJoA5124EtHHE/sagpNjEXWHyoe3lyTG3pXbmB3q
	j0bainbigU0sJcdFTjvFCXr4wk30P2NbTHzRNch8ZFfZEqsnTjx1OdPmt2HI84aICcbe
	Hsb9/IRLozbkoj6Cyin5tpwTVFWzFPliPUajL9dnwjwyMEG/m1kF1CoAvGldsnUtOk9r
	4aGw==
X-Gm-Message-State: APjAAAWKq3oyOS84ux3YV1U/cUuRxaYAej32vd17W0hh4Q3mGZRtbfb4
	U7jga2ROgj47cCWkW6dULiC98w==
X-Google-Smtp-Source: APXvYqy3eFTJSMDonEer+W+3KTJesEVPkg+9Xs8gDaI0ugdqkayaCG34jr2c2mVhJZpJI8stxnrStQ==
X-Received: by 2002:a62:425b:: with SMTP id p88mr73718714pfa.26.1558833024032; 
	Sat, 25 May 2019 18:10:24 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	127sm7141603pfc.159.2019.05.25.18.10.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:22 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:35 -0700
Message-Id: <20190526010948.3923-17-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.193
Subject: [Qemu-devel] [PULL 16/29] target/riscv: Add a base 32 and 64 bit CPU
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

At the same time deprecate the ISA string CPUs.

It is dobtful anyone specifies the CPUs, but we are keeping them for the
Spike machine (which is about to be depreated) so we may as well just
mark them as deprecated.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/virt.h |  4 ++--
 qemu-deprecated.texi    |  9 +++++++++
 target/riscv/cpu.c      | 14 ++++++++++++++
 target/riscv/cpu.h      |  2 ++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 568764b57088..d01a1a85c426 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -74,9 +74,9 @@ enum {
                                FDT_PLIC_ADDR_CELLS + FDT_PLIC_INT_CELLS)
 
 #if defined(TARGET_RISCV32)
-#define VIRT_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
+#define VIRT_CPU TYPE_RISCV_CPU_BASE32
 #elif defined(TARGET_RISCV64)
-#define VIRT_CPU TYPE_RISCV_CPU_RV64GCSU_V1_10_0
+#define VIRT_CPU TYPE_RISCV_CPU_BASE64
 #endif
 
 #endif
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 90cb677849a4..fbdde3d1b4af 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -138,6 +138,15 @@ The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
 ``acl_remove'' commands are deprecated with no replacement. Authorization
 for VNC should be performed using the pluggable QAuthZ objects.
 
+@section System emulator CPUS
+
+@subsection RISC-V ISA CPUs (since 4.1)
+
+The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
+four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
+``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
+option when using the ``rv32`` or ``rv64`` CPUs.
+
 @section System emulator devices
 
 @subsection bluetooth (since 3.1)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0399e03e89c5..e29879915fe2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -115,6 +115,12 @@ static void riscv_any_cpu_init(Object *obj)
 
 #if defined(TARGET_RISCV32)
 
+static void riscv_base32_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+}
+
 static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -146,6 +152,12 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
 
 #elif defined(TARGET_RISCV64)
 
+static void riscv_base64_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+}
+
 static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -479,12 +491,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init)
 #elif defined(TARGET_RISCV64)
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3902138639e7..74e726c1c906 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -48,6 +48,8 @@
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
+#define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
+#define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
 #define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
 #define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
-- 
2.21.0


