Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED572C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68E720739
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi2PWSg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68E720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtL4y-0003eF-UK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 21:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtL3y-0002QX-Es; Wed, 08 Jul 2020 21:09:22 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtL3w-0004dE-QE; Wed, 08 Jul 2020 21:09:22 -0400
Received: by mail-pj1-x1042.google.com with SMTP id cm21so339068pjb.3;
 Wed, 08 Jul 2020 18:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DMPcXBPT3sVJAnuBxLEiaF82OmeeooQVYUpuYan8c3k=;
 b=Vi2PWSg3ZO2OV/Qxan4Z5Tz8/zVG6mx2rml/U54zDkjFzysMUVX9Vt2h/f8/jqt1S9
 vz+1cgcBkoDNaWZxNqHlwPwDnMErY8w34gQ6j9jmr0aoOjyJRvGoT+nn9ugTE+9lLVZZ
 4gnoy4Z8eX2OUGkaabAAyYXyBeRCxEe2wm089NLfSPNg6fdA1afHV8vSRQSKsWUMUG1X
 T+LxqI1hdkKZu3YHs38ga/Kv9cjCGymkgyh9FDjfR+DSUeOHrbL2ZjLWbve+uCi4q6l/
 t/GMDk158ifBZqdXm99w0ItIOCHynxVRaYD4JrWQjgG9BuviNctYcIXr8OA/LjyK6ed6
 wSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DMPcXBPT3sVJAnuBxLEiaF82OmeeooQVYUpuYan8c3k=;
 b=kBynESmhQit1E+SJoMVgKDfw9F9CGVGdT8S3KF2PNDxuqaf0Cn9SaxypOsP/LcloqI
 ipyRodF2BgWmuy3bBXlqby0DYG1v7d0ven7PCYECQrY3Wk23iB//v5dGaayI4gf/cnz8
 jdNomHAVoyy9jTZOMHIK9ibswsWLZFhUO5P6yS8YhvQON6Q2ame++NuigGFDdlhjOy7y
 ZGPlnNiTGJlD9e1t3U43+9pxYQ4KCLvGF5RIT87iVMtpV8yM4haPiKGA9h6qeo3HQ/Pc
 jvVBBx9Es4bHOowtUDiIo0gP59gJ1Ifp0R8zug7MfhaYi3AcR/pNVhwpUUSICMiV00hX
 LpGg==
X-Gm-Message-State: AOAM530eaLQ7dsVa+1y5ueOq6NICDcn3UvHyZjwh7AsF/K0k58+JR32p
 XY3+dsK/0Z/0X75uZqb1EzU=
X-Google-Smtp-Source: ABdhPJwHbl/7sm6/OYM0/wmHJptwsbxmFGtE4ApODFf1PPYYb0q6jb7TZ7GpqWfC95+1eXGaq8p+Dg==
X-Received: by 2002:a17:902:c401:: with SMTP id
 k1mr30542589plk.202.1594256958565; 
 Wed, 08 Jul 2020 18:09:18 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id g3sm868071pfq.19.2020.07.08.18.09.17
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 08 Jul 2020 18:09:18 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/2] hw/riscv: Modify MROM size to end at 0x10000
Date: Wed,  8 Jul 2020 18:09:04 -0700
Message-Id: <1594256945-21744-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the size of Mask ROM for sifive_u / spike / virt machines
is set to 0x11000, which ends at an unusual address. This changes the
size to 0xf000 so that it ends at 0x10000.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index dc46f64..3413369 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -70,7 +70,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
+    [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index a187aa3..ea4be98 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -57,7 +57,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,    0x11000 },
+    [SPIKE_MROM] =     {     0x1000,     0xf000 },
     [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5ca49c5..37b8c55 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } virt_memmap[] = {
     [VIRT_DEBUG] =       {        0x0,         0x100 },
-    [VIRT_MROM] =        {     0x1000,       0x11000 },
+    [VIRT_MROM] =        {     0x1000,        0xf000 },
     [VIRT_TEST] =        {   0x100000,        0x1000 },
     [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
-- 
2.7.4


