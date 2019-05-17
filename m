Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DEC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52762082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsKESoLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52762082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlj5-00083x-2p
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:53:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbL-0001Lx-N0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbK-0005ea-Ow
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:19 -0400
Received: from mail-yw1-xc33.google.com ([2607:f8b0:4864:20::c33]:34568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbK-0005d8-Kc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:18 -0400
Received: by mail-yw1-xc33.google.com with SMTP id n76so3367125ywd.1
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hhGYRrDTg0TV6d2VhrzIbknIoq/1n1f5yDRC8WcG6PA=;
	b=UsKESoLN7jGxG8KS7Kq3KCtUsA9sbDZ3dokQ8i/ynROsDFc/h4FwdQLYCMvFfVIDSl
	3/qQvruR10kaoWnHuRfPlxOHVPvLaGaA90yL34lwhPrKCOkgMw+/QkfNwhnyAUFj8le6
	LqN6gLDJrt3STsoGoZLlmMTdOsl2EPAhML3A/r38xso6v7L3cgckkCYu1u1VST/U+2Z3
	k7IxZLsVXJne0nwMx5rNh+rUxsrIXfYPwXzHFUU8WakH6cJfo5TykjyjGVI3N/r+hrB/
	+gyorbyGTxCziIFJbCbrhJQ8PNvedivI8erKzGa+gmLOgwOFzl8d1waS6TbmDlxIIRdh
	6FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hhGYRrDTg0TV6d2VhrzIbknIoq/1n1f5yDRC8WcG6PA=;
	b=iyD5+u23j9t32mbBd9ecgYoDlPTVzLpmEDn6AvtZ14FkuyXvSc3cwLUmbN/QeeQnkC
	WBF2glX3bqxXhqQVVLn8wo80NN+l/uSzk5YVvhRtPoWLWLaClPjotvcY0vRu32912A7j
	0qX0ngYseBuFmEDIaGYAoSHBLV3+m8cm7XRVm84PhQPIce/wW1laZqsD/tISEgIkCjMM
	bS+mmwNhsAnx+S/i1+/Sm6dNbxf3lc5O2ZDS8f5+De1P6aS0s4bAdhrcD16Qa0liYavN
	8nL88P80a5uNUzx4TDoF98oGupd/Ro+FbWuOo6qRZiYnkWb/60afUF1y7Z16zDPaG+K2
	fEMA==
X-Gm-Message-State: APjAAAV5plhG1hl5DKasDpPhWiyVo8f3HD7cmSaB61mpVIMrI74Ca8Ni
	+JQus/EODS2/IEyHRPqGc8a4HFL57LJdzQ==
X-Google-Smtp-Source: APXvYqxadDli5Gt6iPHTuf+iFlOzl76TzYdrHqeDq/Mg8j/8FalIZZ07lCMdP+Zp8lUr8bm4Iza33w==
X-Received: by 2002:a81:2f45:: with SMTP id v66mr17907151ywv.491.1558133117853;
	Fri, 17 May 2019 15:45:17 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:17 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:47 -0400
Message-Id: <20190517224450.15566-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c33
Subject: [Qemu-devel] [RISU v2 08/11] configure: add i386/x86_64
 architectures
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that i386 and x86_64 architectures are supported by RISU, we want
to detect them and build RISU for them automatically.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 configure | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 65e1819..ca2d7db 100755
--- a/configure
+++ b/configure
@@ -48,12 +48,14 @@ EOF
 }
 
 guess_arch() {
-    if check_define __m68k__ ; then
-        ARCH="m68k"
+    if check_define __aarch64__ ; then
+        ARCH="aarch64"
     elif check_define __arm__ ; then
         ARCH="arm"
-    elif check_define __aarch64__ ; then
-        ARCH="aarch64"
+    elif check_define __i386__ || check_define __x86_64__ ; then
+        ARCH="i386"
+    elif check_define __m68k__ ; then
+        ARCH="m68k"
     elif check_define __powerpc64__ ; then
         ARCH="ppc64"
     else
-- 
2.20.1


