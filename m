Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FCC46478
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616D3208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhHNiuJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616D3208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoDa-0007n3-Gc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56772)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho39-0005Ny-9H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho31-0004bz-4t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:19 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho30-0004bs-T0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:11 -0400
Received: by mail-yb1-xb41.google.com with SMTP id j133so2923150ybj.12
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wu62dh84HsXmNp7TKwekOUApr/r+TWtqHzPxWwRzwkM=;
 b=WhHNiuJ84ByH1rZi8c90whLemiML6rrmHDJKP3DavDz3MV+nyloRuXzEfD+3BMJdZc
 f5buQcDIUts1STiHIyZX3UTBW+qiwN0bStWsWMwq86gXWLi6DOIEgyzC7LJKMADEI13B
 dgisQEeejMycgVA4IuCjA1JbtffNnnsqQxgKJBkxYq7c/v1kiic9Ma5tkoCDrxCS3n+y
 8IaZ02iEyqkPQMab7o4GbtrN6hJ47X4JcV2H6acJnm8dv5H7TAlggD4nZ5DD+2+116o6
 zIeaOCyifpxJWWMclnxPnYhXObAljs4owHrGvq6kgBUkznQQ4nv0L3IJFFKhj3hS7QP1
 0t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wu62dh84HsXmNp7TKwekOUApr/r+TWtqHzPxWwRzwkM=;
 b=SrylVINmcsZnK2pDwR4VO8uRLu/usXzIbRuHwJ0vwJujhvGhYs0Evm5keWl8c9vT4X
 w4cMdsKlCRNuUZuyHUJrgE5K46ZEgvNb9hnXBbJBgdlPkxRWlk8gjybPVK86SoSHTlEG
 m6hZUSfe3NT0u3YLiwKLTkv9oXNilpyKMh+EVCxyrIIn+18TIU4IMmntfm7b/n5OFE5T
 dNcp97hv6fl+ri1RZlnNiSjOYnE972rVj/Ql1tfwqMb0D7Io1pJyYXDGFnjme0iliIIb
 FpZKG2GlI8iF/bbe+D7GPJZlU4cKlHKZcdVlTWCERjr3aVIstAWiKopb7IxSVclMecc+
 rHcg==
X-Gm-Message-State: APjAAAXexGwBUarjfteUudtpfi14gUpAVYl+3WqyuCMpPEEOr88wHN82
 vOafoF2mrB+ShDeDB+pZV1xwniwO
X-Google-Smtp-Source: APXvYqxsRF3rps7rV4+N0yMDOwIMBxEBA8RO9Ir/m+khchMoKF/fTb0iiFP5K9KDf1Mi2vMBDUKiVQ==
X-Received: by 2002:a25:5f12:: with SMTP id t18mr2348841ybb.465.1561955768849; 
 Sun, 30 Jun 2019 21:36:08 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:35 -0400
Message-Id: <20190701043536.26019-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU RFC PATCH v2 13/14] x86.risu: add AVX
 instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add AVX instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 288 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 288 insertions(+)

diff --git a/x86.risu b/x86.risu
index 17a5082..d3115ac 100644
--- a/x86.risu
+++ b/x86.risu
@@ -17,452 +17,736 @@ MOVD            MMX     00001111 011 d 1110 !emit { modrm(mod => MOD_DIRECT, rm
 MOVD_mem        MMX     00001111 011 d 1110 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVD            SSE2    00001111 011 d 1110 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
 MOVD_mem        SSE2    00001111 011 d 1110 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); }
+VMOVD           AVX              011 d 1110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, W => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+VMOVD_mem       AVX              011 d 1110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, W => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
 MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVQ            SSE2    00001111 011 d 1110 !emit { data16(); rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
 MOVQ_mem        SSE2    00001111 011 d 1110 !emit { data16(); rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVQ           AVX              011 d 1110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, W => 1, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+VMOVQ_mem       AVX              011 d 1110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, W => 1, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVQ_mm         MMX     00001111 011 d 1111 !emit { modrm(); mem(size => 8); }
 MOVQ_xmm1       SSE2    00001111 01111110 !emit { rep(); modrm(); mem(size => 8); }
+VMOVQ_xmm1      AVX              01111110 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 MOVQ_xmm2       SSE2    00001111 11010110 !emit { data16(); modrm(); mem(size => 8); }
+VMOVQ_xmm2      AVX              11010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
+VMOVAPS         AVX              0010100 d !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
 MOVAPD          SSE2    00001111 0010100 d !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VMOVAPD         AVX              0010100 d !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
 MOVDQA          SSE2    00001111 011 d 1111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VMOVDQA         AVX              011 d 1111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
 MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
+VMOVUPS         AVX              0001000 d !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 MOVUPD          SSE2    00001111 0001000 d !emit { data16(); modrm(); mem(size => 16); }
+VMOVUPD         AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 MOVDQU          SSE2    00001111 011 d 1111 !emit { rep(); modrm(); mem(size => 16); }
+VMOVDQU         AVX              011 d 1111 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
+VMOVSS          AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F); modrm(mod => MOD_DIRECT); }
+VMOVSS_mem      AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVSD           SSE2    00001111 0001000 d !emit { repne(); modrm(); mem(size => 8); }
+VMOVSD          AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(mod => MOD_DIRECT); }
+VMOVSD_mem      AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 
 MOVQ2DQ         SSE2    00001111 11010110 !emit { rep(); modrm(mod => MOD_DIRECT); }
 MOVDQ2Q         SSE2    00001111 11010110 !emit { repne(); modrm(mod => MOD_DIRECT); }
 
 MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVLPS_ld      AVX              00010010  !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVLPS_st      AVX              00010011  !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVLPD          SSE2    00001111 0001001 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVLPD_ld      AVX              00010010  !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVLPD_st      AVX              00010011  !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVHPS          SSE     00001111 0001011 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVHPS_ld      AVX              00010110  !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVHPS_st      AVX              00010111  !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVHPD          SSE2    00001111 0001011 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVHPD_ld      AVX              00010110  !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+VMOVHPD_st      AVX              00010111  !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod => MOD_DIRECT); }
+VMOVLHPS        AVX              00010110  !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(mod => MOD_DIRECT); }
 MOVHLPS         SSE     00001111 00010010  !emit { modrm(mod => MOD_DIRECT); }
+VMOVHLPS        AVX              00010010  !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(mod => MOD_DIRECT); }
 
 PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 PMOVMSKB        SSE2    00001111 11010111 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VPMOVMSKB       AVX              11010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMSKPS        SSE     00001111 01010000 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VMOVMSKPS       AVX              01010000 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMKSPD        SSE2    00001111 01010000 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VMOVMSKPD       AVX              01010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 
 LDDQU           SSE3    00001111 11110000 !emit { repne(); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VLDDQU          AVX              11110000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
 MOVSHDUP        SSE3    00001111 00010110 !emit { rep(); modrm(); mem(size => 16, align => 16); }
+VMOVSHDUP       AVX              00010110 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 MOVSLDUP        SSE3    00001111 00010010 !emit { rep(); modrm(); mem(size => 16, align => 16); }
+VMOVSLDUP       AVX              00010010 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 MOVDDUP         SSE3    00001111 00010010 !emit { repne(); modrm(); mem(size => 8); }
+VMOVDDUP        AVX              00010010 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 # Arithmetic Instructions
 PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
 PADDB           SSE2    00001111 11111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDB          AVX              11111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
 PADDW           SSE2    00001111 11111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDW          AVX              11111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size => 8); }
 PADDD           SSE2    00001111 11111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDD          AVX              11111110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size => 8); }
 PADDQ           SSE2    00001111 11010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDQ          AVX              11010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDSB          MMX     00001111 11101100 !emit { modrm(); mem(size => 8); }
 PADDSB          SSE2    00001111 11101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDSB         AVX              11101100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDSW          MMX     00001111 11101101 !emit { modrm(); mem(size => 8); }
 PADDSW          SSE2    00001111 11101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDSW         AVX              11101101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDUSB         MMX     00001111 11011100 !emit { modrm(); mem(size => 8); }
 PADDUSB         SSE2    00001111 11011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDUSB        AVX              11011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PADDUSW         MMX     00001111 11011101 !emit { modrm(); mem(size => 8); }
 PADDUSW         SSE2    00001111 11011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPADDUSW        AVX              11011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
+VADDPS          AVX              01011000 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size => 16, align => 16) }
+VADDPD          AVX              01011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
+VADDSS          AVX              01011000 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 8); }
+VADDSD          AVX              01011000 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 PHADDW_64       SSSE3   00001111 00111000 00000001 !emit { modrm(); mem(size => 8); }
 PHADDW          SSSE3   00001111 00111000 00000001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHADDW         AVX                       00000001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PHADDD_64       SSSE3   00001111 00111000 00000010 !emit { modrm(); mem(size => 8); }
 PHADDD          SSSE3   00001111 00111000 00000010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHADDD         AVX                       00000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PHADDSW_64      SSSE3   00001111 00111000 00000011 !emit { modrm(); mem(size => 8); }
 PHADDSW         SSSE3   00001111 00111000 00000011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHADDSW        AVX                       00000011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 HADDPS          SSE3    00001111 01111100 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+VHADDPS         AVX              01111100 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
 HADDPD          SSE3    00001111 01111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VHADDPD         AVX              01111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
 PSUBB           SSE2    00001111 11111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBB          AVX              11111000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
 PSUBW           SSE2    00001111 11111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBW          AVX              11111001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBD           MMX     00001111 11111010 !emit { modrm(); mem(size => 8); }
 PSUBD           SSE2    00001111 11111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBD          AVX              11111010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBQ_64        SSE2    00001111 11111011 !emit { modrm(); mem(size => 8); }
 PSUBQ           SSE2    00001111 11111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBQ          AVX              11111011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBSB          MMX     00001111 11101000 !emit { modrm(); mem(size => 8); }
 PSUBSB          SSE2    00001111 11101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBSB         AVX              11101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBSW          MMX     00001111 11101001 !emit { modrm(); mem(size => 8); }
 PSUBSW          SSE2    00001111 11101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBSW         AVX              11101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBUSB         MMX     00001111 11011000 !emit { modrm(); mem(size => 8); }
 PSUBUSB         SSE2    00001111 11011000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBUSB        AVX              11011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSUBUSW         MMX     00001111 11011001 !emit { modrm(); mem(size => 8); }
 PSUBUSW         SSE2    00001111 11011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSUBUSW        AVX              11011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
+VSUBPS          AVX              01011100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VSUBPD          AVX              01011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
+VSUBSS          AVX              01011100 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 8); }
+VSUBSD          AVX              01011100 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 PHSUBW_64       SSSE3   00001111 00111000 00000101 !emit { modrm(); mem(size => 8); }
 PHSUBW          SSSE3   00001111 00111000 00000101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHSUBW         AVX                       00000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PHSUBD_64       SSSE3   00001111 00111000 00000110 !emit { modrm(); mem(size => 8); }
 PHSUBD          SSSE3   00001111 00111000 00000110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHSUBD         AVX                       00000110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PHSUBSW_64      SSSE3   00001111 00111000 00000111 !emit { modrm(); mem(size => 8); }
 PHSUBSW         SSSE3   00001111 00111000 00000111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHSUBSW        AVX                       00000111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 HSUBPS          SSE3    00001111 01111101 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+VHSUBPS         AVX              01111101 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
 HSUBPD          SSE3    00001111 01111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VHSUBPD         AVX              01111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 ADDSUBPS        SSE3    00001111 11010000 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+VADDSUBPS       AVX              11010000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
 ADDSUBPD        SSE3    00001111 11010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VADDSUBPD       AVX              11010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
 PMULLW          SSE2    00001111 11010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULLW         AVX              11010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMULLD          SSE4_1  00001111 00111000 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULLD         AVX                       01000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
 PMULHW          SSE2    00001111 11100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULHW         AVX              11100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
 PMULHUW         SSE2    00001111 11100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULHUW        AVX              11100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMULDQ          SSE4_1  00001111 00111000 00101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULDQ         AVX                       00101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
 PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULUDQ        AVX              11110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PMULHRSW_64     SSSE3   00001111 00111000 00001011 !emit { modrm(); mem(size => 8); }
 PMULHRSW        SSSE3   00001111 00111000 00001011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMULHRSW       AVX                       00001011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
+VMULPS          AVX              01011001 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 MULPD           SSE2    00001111 01011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VMULPD          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
+VMULSS          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MULSD           SSE2    00001111 01011001 !emit { repne(); modrm(); mem(size => 8); }
+VMULSD          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
 PMADDWD         SSE2    00001111 11110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMADDWD        AVX              11110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMADDUBSW_64    SSSE3   00001111 00111000 00000100 !emit { modrm(); mem(size => 8); }
 PMADDUBSW       SSSE3   00001111 00111000 00000100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMADDUBSW      AVX                       00000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
+VDIVPS          AVX              01011110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 DIVPD           SSE2    00001111 01011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VDIVPD          AVX              01011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
+VDIVSS          AVX              01011110 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 DIVSD           SSE2    00001111 01011110 !emit { repne(); modrm(); mem(size => 8); }
+VDIVSD          AVX              01011110 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
+VRCPPS          AVX              01010011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
+VRCPSS          AVX              01010011 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 
 SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
+VSQRTPS         AVX              01010001 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 SQRTPD          SSE2    00001111 01010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VSQRTPD         AVX              01010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
+VSQRTSS         AVX              01010001 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 SQRTSD          SSE2    00001111 01010001 !emit { repne(); modrm(); mem(size => 8); }
+VSQRTSD         AVX              01010001 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
+VRSQRTPS        AVX              01010010 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
+VRSQRTSS        AVX              01010010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 
 PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
 PMINUB          SSE2    00001111 11011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINUB         AVX              11011010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMINUW          SSE4_1  00001111 00111000 00111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINUW         AVX                       00111010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMINUD          SSE4_1  00001111 00111000 00111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINUD         AVX                       00111011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMINSB          SSE4_1  00001111 00111000 00111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINSB         AVX                       00111000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
 PMINSW          SSE2    00001111 11101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINSW         AVX              11101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMINSD          SSE4_1  00001111 00111000 00111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMINSD         AVX                       00111001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
+VMINPS          AVX              01011101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 MINPD           SSE2    00001111 01011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VMINPD          AVX              01011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
+VMINSS          AVX              01011101 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MINSD           SSE2    00001111 01011101 !emit { repne(); modrm(); mem(size => 8); }
+VMINSD          AVX              01011101 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 PHMINPOSUW      SSE4_1  00001111 00111000 01000001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPHMINPOSUW     AVX                       01000001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
 PMAXUB          SSE2    00001111 11011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXUB         AVX              11011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMAXUW          SSE4_1  00001111 00111000 00111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXUW         AVX                       00111110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMAXUD          SSE4_1  00001111 00111000 00111111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXUD         AVX                       00111111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMAXSB          SSE4_1  00001111 00111000 00111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXSB         AVX                       00111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
 PMAXSW          SSE2    00001111 11101110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXSW         AVX              11101110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PMAXSD          SSE4_1  00001111 00111000 00111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPMAXSD         AVX                       00111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
+VMAXPS          AVX              01011111 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 MAXPD           SSE2    00001111 01011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VMAXPD          AVX              01011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
+VMAXSS          AVX              01011111 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MAXSD           SSE2    00001111 01011111 !emit { repne(); modrm(); mem(size => 8); }
+VMAXSD          AVX              01011111 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 PAVGB           SSE     00001111 11100000 !emit { modrm(); mem(size => 8); }
 PAVGB           SSE2    00001111 11100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPAVGB          AVX              11100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PAVGW           SSE     00001111 11100011 !emit { modrm(); mem(size => 8); }
 PAVGW           SSE2    00001111 11100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPAVGW          AVX              11100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
 PSADBW          SSE2    00001111 11110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSADBW         AVX              11110110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 MPSADBW         SSE4_1  00001111 00111010 01000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VMPSADBW        AVX                       01000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 PABSB_64        SSSE3   00001111 00111000 00011100 !emit { modrm(); mem(size => 8); }
 PABSB           SSSE3   00001111 00111000 00011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPABSB          AVX                       00011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PABSW_64        SSSE3   00001111 00111000 00011101 !emit { modrm(); mem(size => 8); }
 PABSW           SSSE3   00001111 00111000 00011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPABSW          AVX                       00011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PABSD_64        SSSE3   00001111 00111000 00011110 !emit { modrm(); mem(size => 8); }
 PABSD           SSSE3   00001111 00111000 00011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPABSD          AVX                       00011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 PSIGNB_64       SSSE3   00001111 00111000 00001000 !emit { modrm(); mem(size => 8); }
 PSIGNB          SSSE3   00001111 00111000 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSIGNB         AVX                       00001000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PSIGNW_64       SSSE3   00001111 00111000 00001001 !emit { modrm(); mem(size => 8); }
 PSIGNW          SSSE3   00001111 00111000 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSIGNW         AVX                       00001001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PSIGND_64       SSSE3   00001111 00111000 00001010 !emit { modrm(); mem(size => 8); }
 PSIGND          SSSE3   00001111 00111000 00001010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSIGND         AVX                       00001010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 DPPS            SSE4_1  00001111 00111010 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VDPPS           AVX                       01000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 DPPD            SSE4_1  00001111 00111010 01000001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VDPPD           AVX                       01000001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 ROUNDPS         SSE4_1  00001111 00111010 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VROUNDPS        AVX                       00001000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 ROUNDPD         SSE4_1  00001111 00111010 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VROUNDPD        AVX                       00001001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 ROUNDSS         SSE4_1  00001111 00111010 00001010 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+VROUNDSS        AVX                       00001010 !emit { vex(l => 0, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 4); imm(size => 1); }
 ROUNDSD         SSE4_1  00001111 00111010 00001011 !emit { data16(); modrm(); mem(size => 8); imm(size => 1); }
+VROUNDSD        AVX                       00001011 !emit { vex(l => 0, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 8); imm(size => 1); }
 
 # AES Instructions
 AESDEC          AES     00001111 00111000 11011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VAESDEC         AES_AVX                   11011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 AESDECLAST      AES     00001111 00111000 11011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VAESDECLAST     AES_AVX                   11011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 AESENC          AES     00001111 00111000 11011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VAESENC         AES_AVX                   11011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 AESENCLAST      AES     00001111 00111000 11011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VAESENCLAST     AES_AVX                   11011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 AESIMC          AES     00001111 00111000 11011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VAESIMC         AES_AVX                   11011011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 AESKEYGENASSIST AES     00001111 00111010 11011111 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VAESKEYGENASSIST AES_AVX                  11011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 
 # PCLMULQDQ Instructions
 PCLMULQDQ       PCLMULQDQ      00001111 00111010 01000100 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPCLMULQDQ      PCLMULQDQ_AVX                    01000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 # Comparison Instructions
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
 PCMPEQB         SSE2    00001111 01110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPEQB        AVX              01110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
 PCMPEQW         SSE2    00001111 01110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPEQW        AVX              01110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPEQD         MMX     00001111 01110110 !emit { modrm(); mem(size => 8); }
 PCMPEQD         SSE2    00001111 01110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPEQD        AVX              01110110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPEQQ         SSE4_1  00001111 00111000 00101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPEQQ        AVX                       00101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
 PCMPGTB         SSE2    00001111 01100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPGTB        AVX              01100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
 PCMPGTW         SSE2    00001111 01100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPGTW        AVX              01100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
 PCMPGTD         SSE2    00001111 01100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPGTD        AVX              01100110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PCMPGTQ         SSE4_2  00001111 00111000 00110111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPCMPGTQ        AVX                       00110111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 PCMPESTRM       SSE4_2  00001111 00111010 01100000 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+VPCMPESTRM      AVX                       01100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 PCMPESTRI       SSE4_2  00001111 00111010 01100001 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+VPCMPESTRI      AVX                       01100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 PCMPISTRM       SSE4_2  00001111 00111010 01100010 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+VPCMPISTRM      AVX                       01100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 PCMPISTRI       SSE4_2  00001111 00111010 01100011 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+VPCMPISTRI      AVX                       01100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 
 PTEST           SSE4_1  00001111 00111000 00010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPTEST          AVX                       00010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+
+VTESTPS         AVX     00001110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VTESTPD         AVX     00001111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VCMPPS          AVX              11000010 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
 CMPPD           SSE2    00001111 11000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VCMPPD          AVX              11000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
 CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
+VCMPSS          AVX              11000010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); imm(size => 1); }
 CMPSD           SSE2    00001111 11000010 !emit { repne(); modrm(); mem(size => 8); imm(size => 1); }
+VCMPSD          AVX              11000010 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); imm(size => 1); }
 
 UCOMISS         SSE     00001111 00101110 !emit { modrm(); mem(size => 4); }
+VUCOMISS        AVX              00101110 !emit { vex(l => 0, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 UCOMISD         SSE2    00001111 00101110 !emit { data16(); modrm(); mem(size => 8); }
+VUCOMISD        AVX              00101110 !emit { vex(l => 0, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 COMISS          SSE     00001111 00101111 !emit { modrm(); mem(size => 4); }
+VCOMISS         AVX              00101111 !emit { vex(l => 0, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 COMISD          SSE2    00001111 00101111 !emit { data16(); modrm(); mem(size => 8); }
+VCOMISD         AVX              00101111 !emit { vex(l => 0, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 # Logical Instructions
 PAND            MMX     00001111 11011011 !emit { modrm(); mem(size => 8); }
 PAND            SSE2    00001111 11011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPAND           AVX              11011011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
+VANDPS          AVX              01010100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 ANDPD           SSE2    00001111 01010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VANDPD          AVX              01010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PANDN           MMX     00001111 11011111 !emit { modrm(); mem(size => 8); }
 PANDN           SSE2    00001111 11011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPANDN          AVX              11011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
+VANDNPS         AVX              01010101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 ANDNPD          SSE2    00001111 01010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VANDNPD         AVX              01010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 POR             MMX     00001111 11101011 !emit { modrm(); mem(size => 8); }
 POR             SSE2    00001111 11101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPOR            AVX              11101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
+VORPS           AVX              01010110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 ORPD            SSE2    00001111 01010110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VORPD           AVX              01010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PXOR            MMX     00001111 11101111 !emit { modrm(); mem(size => 8); }
 PXOR            SSE2    00001111 11101111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPXOR           AVX              11101111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
+VXORPS          AVX              01010111 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 XORPD           SSE2    00001111 01010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VXORPD          AVX              01010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 # Shift and Rotate Instructions
 PSLLW           MMX     00001111 11110001 !emit { modrm(); mem(size => 8); }
 PSLLW           SSE2    00001111 11110001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSLLW          AVX              11110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLD           MMX     00001111 11110010 !emit { modrm(); mem(size => 8); }
 PSLLD           SSE2    00001111 11110010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSLLD          AVX              11110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLQ           MMX     00001111 11110011 !emit { modrm(); mem(size => 8); }
 PSLLQ           SSE2    00001111 11110011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSLLQ          AVX              11110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
+VPSLLDQ         AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
 
 PSLLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLQ_imm      AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 
 PSRLW           MMX     00001111 11010001 !emit { modrm(); mem(size => 8); }
 PSRLW           SSE2    00001111 11010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSRLW          AVX              11010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLD           MMX     00001111 11010010 !emit { modrm(); mem(size => 8); }
 PSRLD           SSE2    00001111 11010010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSRLD          AVX              11010010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLQ           MMX     00001111 11010011 !emit { modrm(); mem(size => 8); }
 PSRLQ           SSE2    00001111 11010011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSRLQ          AVX              11010011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
+VPSRLDQ         AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
 
 PSRLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLQ_imm      AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 
 PSRAW           MMX     00001111 11100001 !emit { modrm(); mem(size => 8); }
 PSRAW           SSE2    00001111 11100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSRAW          AVX              11100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRAD           MMX     00001111 11100010 !emit { modrm(); mem(size => 8); }
 PSRAD           SSE2    00001111 11100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSRAD          AVX              11100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PSRAW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+VPSRAW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+VPSRAD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 
 PALIGNR_64      SSSE3   00001111 00111010 00001111 !emit { modrm(); mem(size => 8); imm(size => 1); }
 PALIGNR         SSSE3   00001111 00111010 00001111 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPALIGNR        AVX                       00001111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Scatter Instructions
 PACKSSWB        MMX     00001111 01100011 !emit { modrm(); mem(size => 8); }
 PACKSSWB        SSE2    00001111 01100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPACKSSWB       AVX              01100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PACKSSDW        MMX     00001111 01101011 !emit { modrm(); mem(size => 8); }
 PACKSSDW        SSE2    00001111 01101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPACKSSDW       AVX              01101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PACKUSWB        MMX     00001111 01100111 !emit { modrm(); mem(size => 8); }
 PACKUSWB        SSE2    00001111 01100111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPACKUSWB       AVX              01100111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PACKUSDW        SSE4_1  00001111 00111000 00101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPACKUSDW       AVX                       00101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 
 PUNPCKHBW       MMX     00001111 01101000 !emit { modrm(); mem(size => 8); }
 PUNPCKHBW       SSE2    00001111 01101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKHBW      AVX              01101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKHWD       MMX     00001111 01101001 !emit { modrm(); mem(size => 8); }
 PUNPCKHWD       SSE2    00001111 01101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKHWD      AVX              01101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKHDQ       MMX     00001111 01101010 !emit { modrm(); mem(size => 8); }
 PUNPCKHDQ       SSE2    00001111 01101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKHDQ      AVX              01101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKHQDQ      SSE2    00001111 01101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKHQDQ     AVX              01101101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PUNPCKLBW       MMX     00001111 01100000 !emit { modrm(); mem(size => 4); }
 PUNPCKLBW       SSE2    00001111 01100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKLBW      AVX              01100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKLWD       MMX     00001111 01100001 !emit { modrm(); mem(size => 4); }
 PUNPCKLWD       SSE2    00001111 01100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKLWD      AVX              01100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKLDQ       MMX     00001111 01100010 !emit { modrm(); mem(size => 4); }
 PUNPCKLDQ       SSE2    00001111 01100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKLDQ      AVX              01100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PUNPCKLQDQ      SSE2    00001111 01101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPUNPCKLQDQ     AVX              01101100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
+VUNPCKLPS       AVX              00010100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 UNPCKLPD        SSE2    00001111 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VUNPCKLPD       AVX              00010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
+VUNPCKHPS       AVX              00010101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
 UNPCKHPD        SSE2    00001111 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VUNPCKHPD       AVX              00010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PSHUFB_64       SSSE3   00001111 00111000 00000000 !emit { modrm(); mem(size => 8); }
 PSHUFB          SSSE3   00001111 00111000 00000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPSHUFB         AVX                       00000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
 PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
 PSHUFLW         SSE2    00001111 01110000 !emit { repne(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPSHUFLW        AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 PSHUFHW         SSE2    00001111 01110000 !emit { rep(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPSHUFHW        AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 PSHUFD          SSE2    00001111 01110000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPSHUFD         AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 
 SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VSHUFPS         AVX              11000110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
 SHUFPD          SSE2    00001111 11000110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VSHUFPD         AVX              11000110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
 
 BLENDPS         SSE4_1  00001111 00111010 00001100 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VBLENDPS        AVX                       00001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 BLENDPD         SSE4_1  00001111 00111010 00001101 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VBLENDPD        AVX                       00001101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 BLENDVPS        SSE4_1  00001111 00111000 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VBLENDVPS       AVX                       01001010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
 BLENDVPD        SSE4_1  00001111 00111000 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VBLENDVPD       AVX                       01001011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
 PBLENDVB        SSE4_1  00001111 00111000 00010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VPBLENDVB       AVX                       01001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
 PBLENDW         SSE4_1  00001111 00111010 00001110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+VPBLENDW        AVX                       00001110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 INSERTPS        SSE4_1  00001111 00111010 00100001 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+VINSERTPS       AVX                       00100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 4); imm(size => 1); }
 PINSRB          SSE4_1  00001111 00111010 00100000 !emit { data16(); modrm(); mem(size => 1); imm(size => 1); }
+VPINSRB         AVX                       00100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 1); imm(size => 1); }
 PINSRW          SSE     00001111 11000100 !emit { modrm(); mem(size => 2); imm(size => 1); }
 PINSRW          SSE2    00001111 11000100 !emit { data16(); modrm(); mem(size => 2); imm(size => 1); }
+VPINSRW         AVX              11000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, w => 0); modrm(); mem(size => 2); imm(size => 1); }
 PINSRD          SSE4_1  00001111 00111010 00100010 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+VPINSRD         AVX                       00100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 4); imm(size => 1); }
 PINSRQ          SSE4_1  00001111 00111010 00100010 !emit { data16(); rex(w => 1); modrm(); mem(size => 8); imm(size => 1); }
+VPINSRQ         AVX                       00100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1); modrm(); mem(size => 8); imm(size => 1); }
 
 EXTRACTPS       SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 EXTRACTPS_mem   SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
+VEXTRACTPS      AVX                       00010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+VEXTRACTPS_mem  AVX                       00010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
 
 PEXTRB          SSE4_1  00001111 00111010 00010100 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 PEXTRB_mem      SSE4_1  00001111 00111010 00010100 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 1); imm(size => 1); }
+VPEXTRB         AVX                       00010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+VPEXTRB_mem     AVX                       00010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 1); imm(size => 1); }
 PEXTRW          SSE4_1  00001111 00111010 00010101 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 PEXTRW_mem      SSE4_1  00001111 00111010 00010101 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 2); imm(size => 1); }
+VPEXTRW         AVX                       00010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+VPEXTRW_mem     AVX                       00010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 2); imm(size => 1); }
 PEXTRD          SSE4_1  00001111 00111010 00010110 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 PEXTRD_mem      SSE4_1  00001111 00111010 00010110 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
+VPEXTRD         AVX                       00010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+VPEXTRD_mem     AVX                       00010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
 PEXTRQ          SSE4_1  00001111 00111010 00010110 !emit { data16(); rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 PEXTRQ_mem      SSE4_1  00001111 00111010 00010110 !emit { data16(); rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); imm(size => 1); }
+VPEXTRQ         AVX                       00010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+VPEXTRQ_mem     AVX                       00010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 8); imm(size => 1); }
 
 PEXTRW_reg      SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 PEXTRW_reg      SSE2    00001111 11000101 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
+VPEXTRW_reg     AVX              11000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
+
+VPERMILPS       AVX     00001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPERMILPS_imm   AVX     00000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPERMILPD       AVX     00001101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPERMILPD_imm   AVX     00000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
 
 # Conversion Instructions
 PMOVSXBW        SSE4_1  00001111 00111000 00100000 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVSXBW       AVX                       00100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVSXBD        SSE4_1  00001111 00111000 00100001 !emit { data16(); modrm(); mem(size => 4); }
+VPMOVSXBD       AVX                       00100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVSXBQ        SSE4_1  00001111 00111000 00100010 !emit { data16(); modrm(); mem(size => 2); }
+VPMOVSXBQ       AVX                       00100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
 PMOVSXWD        SSE4_1  00001111 00111000 00100011 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVSXWD       AVX                       00100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVSXWQ        SSE4_1  00001111 00111000 00100100 !emit { data16(); modrm(); mem(size => 4); }
+VPMOVSXWQ       AVX                       00100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVSXDQ        SSE4_1  00001111 00111000 00100101 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVSXDQ       AVX                       00100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 PMOVZXBW        SSE4_1  00001111 00111000 00110000 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVZXBW       AVX                       00110000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVZXBD        SSE4_1  00001111 00111000 00110001 !emit { data16(); modrm(); mem(size => 4); }
+VPMOVZXBD       AVX                       00110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVZXBQ        SSE4_1  00001111 00111000 00110010 !emit { data16(); modrm(); mem(size => 2); }
+VPMOVZXBQ       AVX                       00110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
 PMOVZXWD        SSE4_1  00001111 00111000 00110011 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVZXWD       AVX                       00110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVZXWQ        SSE4_1  00001111 00111000 00110100 !emit { data16(); modrm(); mem(size => 4); }
+VPMOVZXWQ       AVX                       00110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVZXDQ        SSE4_1  00001111 00111000 00110101 !emit { data16(); modrm(); mem(size => 8); }
+VPMOVZXDQ       AVX                       00110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
 CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
 CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
+VCVTSI2SS       AVX              00101010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 0); modrm(); mem(size => 4); }
+VCVTSI2SS_64    AVX              00101010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 1); modrm(); mem(size => 8); }
 CVTPI2PD        SSE2    00001111 00101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTSI2SD        SSE2    00001111 00101010 !emit { repne(); modrm(); mem(size => 4); }
 CVTSI2SD_64     SSE2    00001111 00101010 !emit { repne(); rex(w => 1); modrm(); mem(size => 8); }
+VCVTSI2SD       AVX              00101010 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 0); modrm(); mem(size => 4); }
+VCVTSI2SD_64    AVX              00101010 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 1); modrm(); mem(size => 8); }
 
 CVTPS2PI        SSE     00001111 00101101 !emit { modrm(); mem(size => 8); }
 CVTSS2SI        SSE     00001111 00101101 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTSS2SI_64     SSE     00001111 00101101 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+VCVTSS2SI       AVX              00101101 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 4); }
+VCVTSS2SI_64    AVX              00101101 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 1, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTPD2PI        SSE2    00001111 00101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTSD2SI        SSE2    00001111 00101101 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
 CVTSD2SI_64     SSE2    00001111 00101101 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
+VCVTSD2SI       AVX              00101101 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 8); }
+VCVTSD2SI_64    AVX              00101101 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 1, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 8); }
 
 CVTTPS2PI       SSE     00001111 00101100 !emit { modrm(); mem(size => 8); }
 CVTTSS2SI       SSE     00001111 00101100 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTTSS2SI_64    SSE     00001111 00101100 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+VCVTTSS2SI      AVX              00101100 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 4); }
+VCVTTSS2SI_64   AVX              00101100 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F, w => 1, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 4); }
 CVTTPD2PI       SSE2    00001111 00101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTTSD2SI       SSE2    00001111 00101100 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
 CVTTSD2SI_64    SSE2    00001111 00101100 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
+VCVTTSD2SI      AVX              00101100 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 8); }
+VCVTTSD2SI_64   AVX              00101100 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F, w => 1, v => VEX_V_UNUSED); modrm(reg => ~REG_ESP); mem(size => 8); }
 
 CVTPD2DQ        SSE2    00001111 11100110 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+VCVTPD2DQ       AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTTPD2DQ       SSE2    00001111 11100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VCVTTPD2DQ      AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTDQ2PD        SSE2    00001111 11100110 !emit { rep(); modrm(); mem(size => 8); }
+VCVTDQ2PD       AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 
 CVTPS2PD        SSE2    00001111 01011010 !emit { modrm(); mem(size => 8); }
+VCVTPS2PD       AVX              01011010 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 CVTPD2PS        SSE2    00001111 01011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VCVTPD2PS       AVX              01011010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTSS2SD        SSE2    00001111 01011010 !emit { rep(); modrm(); mem(size => 4); }
+VCVTSS2SD       AVX              01011010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 CVTSD2SS        SSE2    00001111 01011010 !emit { repne(); modrm(); mem(size => 8); }
+VCVTSD2SS       AVX              01011010 !emit { vex(l => 0, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 8); }
 
 CVTDQ2PS        SSE2    00001111 01011011 !emit { modrm(); mem(size => 16, align => 16); }
+VCVTDQ2PS       AVX              01011011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTPS2DQ        SSE2    00001111 01011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+VCVTPS2DQ       AVX              01011011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTTPS2DQ       SSE2    00001111 01011011 !emit { rep(); modrm(); mem(size => 16, align => 16); }
+VCVTTPS2DQ      AVX              01011011 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
 MASKMOVDQU      SSE2    00001111 11110111 !emit { data16(); modrm(mod => MOD_DIRECT); mem(size => 16, base => REG_EDI); }
+VMASKMOVDQU     AVX              11110111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT); mem(size => 16, base => REG_EDI); }
+
+VMASKMOVPS      AVX     001011 d 0 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VMASKMOVPD      AVX     001011 d 1 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
 
 MOVNTPS         SSE     00001111 00101011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTPS        AVX              00101011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 MOVNTPD         SSE2    00001111 00101011 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTPD        AVX              00101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 
 MOVNTI          SSE2    00001111 11000011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVNTI_64       SSE2    00001111 11000011 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTDQ         SSE2    00001111 11100111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTDQ        AVX              11100111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 MOVNTDQA        SSE4_1  00001111 00111000 00101010 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTDQA       AVX                       00101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 
 PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
 PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
@@ -476,6 +760,10 @@ PAUSE           SSE2    10010000          !emit { rep(); }
 
 # State Management Instructions
 EMMS            MMX     00001111 01110111 !emit { }
+VZEROUPPER      AVX              01110111 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); }
+VZEROALL        AVX              01110111 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); }
 
 # LDMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 4); }
+# VLDMXCSR        AVX              10101110 !emit { vex(l => 0, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 4); }
 STMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 4); }
+VSTMXCSR        AVX              10101110 !emit { vex(l => 0, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 4); }
-- 
2.20.1


