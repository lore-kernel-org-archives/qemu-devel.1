Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8372075B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRwMaKI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8372075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9n4q-0005E9-7l
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1k9n3v-0004nU-IG
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:17:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1k9n3t-0003dV-W7
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:17:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id v15so3123398pgh.6
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8XRPxZgxcWrPRhkolFPduV39pLKjLxVh0HTpBwB7nAU=;
 b=YRwMaKI6MtXzF60uoaRZWzwXxeLiQDqLDEmnGrVRLs3zsXOqH0MNaYa3DvaOe8s6W2
 zfQHsIs6R9RL1qDFAityi2yj/0m/XlX8GEfNaveJQHdV96Rr5S+C+O5B3SeoH7RVSb0E
 /IMbUo69Jd1pCzCtftpbv18d2V9xaDWPiJvKqhr/LNrpn11jmiyoR+ahICVnLIvg+pCF
 3DJD2gBHUOwkdxARUZxqVaRkwo5/IAbwzce7ho6egdhBtKPYwiU6GHCHjpUFQBhrVLbj
 O6l1oGE9jspAJmRtFmGDAA+vQjTLHn+7VB2GxoFTVj2wQcLeTFYQm9cKC63LKC/xAR9W
 cVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8XRPxZgxcWrPRhkolFPduV39pLKjLxVh0HTpBwB7nAU=;
 b=fhd1ZwXNDpXUUlo0jcbTITvSrTyuvUm91cxNgtn98/BmN+CjL+Cg2COtNztvqIPbnv
 XJ+FM44UcsOOOqeCdm6gokAdz2fXQ9tkNKgjGxzQ3+RIMsv0wsM4M/aPQQdMh7qeZSqj
 rd1PDOEbc6jt0fJnyYD9FJVc5Jv7YmpzAFjszbNjdbuqkttTl872K3kDv3D9ws5Fd6bf
 BxC0mA2zmwSyl866FpY1zgn+/tCklGL+vlV2bPR8SVHr6rlfX0Phy6YpZUqONXbq904Q
 Jfk2sNtgbFEz/QgxFqWqmFu0JIyuPM780UHKX8wb0IS2ELWqynviN3HYp122v6QgXTR2
 zI8Q==
X-Gm-Message-State: AOAM532bt7WPqXijqoinU+HyN1oLEVTmyhhSB7z7J28xYBuzDU8Effru
 zL3qSolNn2GvZGYp5ZdZehqr1JmZCEI=
X-Google-Smtp-Source: ABdhPJxjld0OyFr+AyHGo9oHZv2LKsmDVdE9ZpIJCLkICu8A1f3SohuSFr56UGAlwBGCLUPsS1c4Dg==
X-Received: by 2002:a63:eb58:: with SMTP id b24mr486169pgk.174.1598177835764; 
 Sun, 23 Aug 2020 03:17:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net.
 [67.188.192.166])
 by smtp.gmail.com with ESMTPSA id j4sm6528617pgf.8.2020.08.23.03.17.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Aug 2020 03:17:14 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: detect mismatched ELF ABI in qemu-mips[n32][el]
Date: Sun, 23 Aug 2020 03:17:03 -0700
Message-Id: <20200823101703.18451-1-carenas@gmail.com>
X-Mailer: git-send-email 2.28.0.424.gade71fd49b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=carenas@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
 laurent@vivier.eu, macro@linux-mips.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS provides 2 ILP32 ABIs, and therefore 4 possible qemu-mips binaries
with 2 pairs using the same endianess and bitness.

This could lead to an O32 image loading in the N32 binary or vice versa
and in cryptic errors (if lucky that the CPU doesn't match the FPU used)
like :

  qemu: Unexpected FPU mode       (o32 ELF loaded to qemu-mipsn32[el])
  ELF binary's NaN mode not supported by CPU    (n32 -> qemu-mips[el])

Add an ABI check macro that could be used while checking the ELF header
that relies in the ABI2 flag to identify n32 binaries and abort instead
early with a more descriptive error :

  Invalid ELF image for this architecture

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v1:
- Use the provided definition from include/elf.h (per Laurent)
- Abort instead of warning (per Laurent, not using a custom error though)
- Expand the check to all other combinations (per Aleksandar)

 linux-user/elfload.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fe9dfe795d..69936dcd45 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -918,6 +918,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define elf_check_arch(x) ((x) == EM_MIPS || (x) == EM_NANOMIPS)
 
+#ifdef TARGET_ABI_MIPSN32
+#define elf_check_abi(x) ((x) & EF_MIPS_ABI2)
+#else
+#define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
+#endif
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1487,6 +1493,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_arch(x) ((x) == ELF_ARCH)
 #endif
 
+#ifndef elf_check_abi
+#define elf_check_abi(x) (1)
+#endif
+
 #ifndef ELF_HWCAP
 #define ELF_HWCAP 0
 #endif
@@ -1644,6 +1654,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
 static bool elf_check_ehdr(struct elfhdr *ehdr)
 {
     return (elf_check_arch(ehdr->e_machine)
+            && elf_check_abi(ehdr->e_flags)
             && ehdr->e_ehsize == sizeof(struct elfhdr)
             && ehdr->e_phentsize == sizeof(struct elf_phdr)
             && (ehdr->e_type == ET_EXEC || ehdr->e_type == ET_DYN));
-- 
2.28.0.424.gade71fd49b


