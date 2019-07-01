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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4292FC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148AC208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfWbUAvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148AC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho82-0001pG-9v
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2x-00058t-3c
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2w-0004Z7-2F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:07 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2v-0004Yr-UG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:06 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n127so4723191ywd.9
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=la6dB26y5b0Z/gZGtkxOu28DEQfqud2YPg7mE0UAogY=;
 b=SfWbUAvQxh+9OclGoIxigcGj2ytPw6O2lEt7Rd0etxlpHvulavSQkPtTg7YVMshGOr
 5AO1PoEufPX45zn3qNWmJu9QIAsBYtTcuxWphaX/AZQomhFe91Eu0Mlf5+YXctYXaNH7
 gbDlJ13bJcDRI6+7lFAkWy81VKq4cC8UQ23b0do5QlO0leYQ4LdzIXnMmqG4oTWVOy5l
 i898pRwvfEGwITW7PPArQSswojAO3DfcBQ+77WBbBofl/Vy/rE7uBwALFvHaEZFoAlw1
 XUTILcagCV323ALJRRo8UA0o7FaHkQq3svL8dBsHlYBIBlUZqV0SS0KEVg07uggmwT/v
 rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=la6dB26y5b0Z/gZGtkxOu28DEQfqud2YPg7mE0UAogY=;
 b=MyMv4KaIE7yhshP49rApD+6/eMgkmgFx33EOEtOC8IeR7yxfTPAxPiczxjiSST2jqD
 Ms9V/LZKiA8Odn3+XlYzJAv7WiN+EJ11cc21jlrZfLTJfWRc2DymSOxy8GyEdmICgHxS
 vj47hAjkcouQ36c/+ZOCbkVTlZkQjgIn1m8d6HhkKD6LBcpdf5/PAhNfdxsacX93bp5q
 wN369fqinSeS+vOBd6KM51vn7pxsfgrHLOeA5bQTgS9gsuyWFoQiRZAOiYsrRYsZXDSX
 USCuErcyAJZ5gtGK7BqdQmTWfs2AKvYH8CQk8r+aHm5BFB+kymLLdTHUW6A98+m2+hcS
 PS5A==
X-Gm-Message-State: APjAAAU2aJBlyRxNpEQXlqWHtXD3Bi+rK5X3SyAVQomUaeGc4yX9Jiri
 IFD/ERsTXEletaTU/eIpwc1u6TzA
X-Google-Smtp-Source: APXvYqwtiCJCUqUe/MXHTM3C1lAPS9qsfjd7f5Cct1P+cBwN4nvKMeEY4m/Y74udAEfl9yFXzYXb8Q==
X-Received: by 2002:a81:1d13:: with SMTP id d19mr12919229ywd.490.1561955765356; 
 Sun, 30 Jun 2019 21:36:05 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:04 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:31 -0400
Message-Id: <20190701043536.26019-10-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RISU RFC PATCH v2 09/14] x86.risu: add SSE3
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

Add SSE3 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/x86.risu b/x86.risu
index 9b63d6b..01181dd 100644
--- a/x86.risu
+++ b/x86.risu
@@ -49,6 +49,11 @@ PMOVMSKB        SSE2    00001111 11010111 !emit { data16(); modrm(mod => MOD_DIR
 MOVMSKPS        SSE     00001111 01010000 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMKSPD        SSE2    00001111 01010000 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 
+LDDQU           SSE3    00001111 11110000 !emit { repne(); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+MOVSHDUP        SSE3    00001111 00010110 !emit { rep(); modrm(); mem(size => 16, align => 16); }
+MOVSLDUP        SSE3    00001111 00010010 !emit { rep(); modrm(); mem(size => 16, align => 16); }
+MOVDDUP         SSE3    00001111 00010010 !emit { repne(); modrm(); mem(size => 8); }
+
 # Arithmetic Instructions
 PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
 PADDB           SSE2    00001111 11111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -72,6 +77,9 @@ ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size =>
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
 ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 8); }
 
+HADDPS          SSE3    00001111 01111100 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+HADDPD          SSE3    00001111 01111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
 PSUBB           SSE2    00001111 11111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
@@ -94,6 +102,12 @@ SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size =>
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
 SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 8); }
 
+HSUBPS          SSE3    00001111 01111101 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+HSUBPD          SSE3    00001111 01111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
+ADDSUBPS        SSE3    00001111 11010000 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+ADDSUBPD        SSE3    00001111 11010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
 PMULLW          SSE2    00001111 11010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
-- 
2.20.1


