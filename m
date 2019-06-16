Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB2C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E242133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ormvmd0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E242133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcWC7-0007G4-7j
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3u-0001Cc-LH
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3s-0006dH-LY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3m-0006V5-T8
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so4199143pfe.11
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pTLXzvmTNkJlCECYYNnTKliz1T1gVwsPhad5qzAO5F4=;
 b=Ormvmd0j8JCD7QYZFhw8HV4M30HoyArsFJDSo8AY7dOdsj+GDqYadb7DHsOfciV5yQ
 J3n6dshTrzGeIWAM+Wqwv5twbCSj2WGCdl01FKuWfYWe9IrHW4JBUHlVKPEtMcDbcsSJ
 vg06VS596RqVGqLg7wkm8i0G75V+uLKcDFoi7wtqqXLvQLevB/dgXum+jekknxHglNUi
 nWOctMr4PbkPezjqipbDsBC5JAaNh/j+py5B0Ja1LTTBiOzVz+MzcOcYwjoNUKMtUaGQ
 eUMi/G78uUuM6PYDtX5aFlUrN29VX2OcLSRwtRIS5xS7uKttMsNIumvd3UogR5wvnrID
 keXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pTLXzvmTNkJlCECYYNnTKliz1T1gVwsPhad5qzAO5F4=;
 b=FB9LVhihqboEPdYkoz6n6tiAZECIKACxV9wgLiKucpJ2EippME8POBVXDSBlgrhrvL
 QiXF0nhy1V9a0U4F4MpCwtvTLckaWNBL40zQWih8jA1g5DcAWblSrTjEXfajZwhquZbx
 oEIiIm+OEKoGod5OlVNty2m7rLqzPwLD16FBnUjGXc6GsT95MXrzUEV/4vy3IZxYTLC2
 co4j8Meb6cGCM+t48NFV58ilEtp6QKeP2zrUFEc2sivya+NGV2y2WjNg0ooVBUAzDt+p
 Bi2mB9D7/zLu5xDKL+4ZraWYgL9pXytFHqVv9QK7+ALIIF9zIED5BNs7RML1jxmt4fXt
 PGXg==
X-Gm-Message-State: APjAAAVj6FtRrjwbKnckp0wRaXxxcnceRVKY0SjY2Rl1N59+gbTaKmpQ
 8jXEkCfJnuvwDNhrhL+Vxz3sODEE
X-Google-Smtp-Source: APXvYqxT9IBAaDQdAvCJaS9Bd8MY9mINL6Ujvo+gSYjHf79EZ8rEXkg4sJrSAc1LfdrfVObHxVWjCA==
X-Received: by 2002:a17:90a:3603:: with SMTP id
 s3mr4358605pjb.17.1560694980721; 
 Sun, 16 Jun 2019 07:23:00 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id m19sm5898783pjl.0.2019.06.16.07.22.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:23:00 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:22:57 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142257.GA71205@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 3/6] Improved comments on m68k_move_to/from
 helpers
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added more detailed comments to each case of m68k_move_to/from helpers to list
the supported CPUs for that CR as they were wrong in some cases, and
missing some cpu classes in other cases.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---
 target/m68k/helper.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index b0bb579403..5483ce9837 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -197,40 +197,47 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     switch (reg) {
-    /* MC680[1234]0 */
+    /* MC680[12346]0 */
     case M68K_CR_SFC:
         env->sfc = val & 7;
         return;
+    /* MC680[12346]0 */
     case M68K_CR_DFC:
         env->dfc = val & 7;
         return;
+    /* MC680[12346]0 */
     case M68K_CR_VBR:
         env->vbr = val;
         return;
-    /* MC680[234]0 */
+    /* MC680[2346]0 */
     case M68K_CR_CACR:
         env->cacr = val;
         m68k_switch_sp(env);
         return;
-    /* MC680[34]0 */
+    /* MC680[46]0 */
     case M68K_CR_TC:
         env->mmu.tcr = val;
         return;
+    /* MC680[4]0 */
     case M68K_CR_MMUSR:
         env->mmu.mmusr = val;
         return;
+    /* MC680[46]0 */
     case M68K_CR_SRP:
         env->mmu.srp = val;
         return;
     case M68K_CR_URP:
         env->mmu.urp = val;
         return;
+    /* MC680[46]0 */
     case M68K_CR_USP:
         env->sp[M68K_USP] = val;
         return;
+    /* MC680[234]0 */
     case M68K_CR_MSP:
         env->sp[M68K_SSP] = val;
         return;
+    /* MC680[234]0 */
     case M68K_CR_ISP:
         env->sp[M68K_ISP] = val;
         return;
@@ -238,12 +245,15 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_ITT0:
         env->mmu.ttr[M68K_ITTR0] = val;
         return;
+    /* MC68040/MC68LC040 */
     case M68K_CR_ITT1:
          env->mmu.ttr[M68K_ITTR1] = val;
         return;
+    /* MC68040/MC68LC040 */
     case M68K_CR_DTT0:
         env->mmu.ttr[M68K_DTTR0] = val;
         return;
+    /* MC68040/MC68LC040 */
     case M68K_CR_DTT1:
         env->mmu.ttr[M68K_DTTR1] = val;
         return;
@@ -257,39 +267,50 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     switch (reg) {
-    /* MC680[1234]0 */
+    /* MC680[12346]0 */
     case M68K_CR_SFC:
         return env->sfc;
+    /* MC680[12346]0 */
     case M68K_CR_DFC:
         return env->dfc;
+    /* MC680[12346]0 */
     case M68K_CR_VBR:
         return env->vbr;
-    /* MC680[234]0 */
+    /* MC680[2346]0 */
     case M68K_CR_CACR:
         return env->cacr;
-    /* MC680[34]0 */
+    /* MC680[46]0 */
     case M68K_CR_TC:
         return env->mmu.tcr;
+    /* MC680[4]0 */
     case M68K_CR_MMUSR:
         return env->mmu.mmusr;
+    /* MC680[46]0 */
     case M68K_CR_SRP:
         return env->mmu.srp;
+    /* MC680[46]0 */
     case M68K_CR_USP:
         return env->sp[M68K_USP];
+    /* MC680[234]0 */
     case M68K_CR_MSP:
         return env->sp[M68K_SSP];
+    /* MC680[234]0 */
     case M68K_CR_ISP:
         return env->sp[M68K_ISP];
     /* MC68040/MC68LC040 */
     case M68K_CR_URP:
         return env->mmu.urp;
-    case M68K_CR_ITT0:
+    /* MC68040/MC68LC040 */
+    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
         return env->mmu.ttr[M68K_ITTR0];
-    case M68K_CR_ITT1:
+    /* MC68040/MC68LC040 */
+    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
         return env->mmu.ttr[M68K_ITTR1];
-    case M68K_CR_DTT0:
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
         return env->mmu.ttr[M68K_DTTR0];
-    case M68K_CR_DTT1:
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
         return env->mmu.ttr[M68K_DTTR1];
     }
     cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
-- 
2.21.0



