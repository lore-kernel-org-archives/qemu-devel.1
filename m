Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB339C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69CD2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzP7DIAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69CD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTued-00019j-0m
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:49:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZv-00068T-GW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZt-0003Bx-Dd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:43 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZr-00039B-FI
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:39 -0400
Received: by mail-yb1-xb35.google.com with SMTP id w127so923288yba.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0ilxUhOWtdPal8guoafu7uVUdV65rxKS1rgM4/OQmO8=;
	b=LzP7DIAH6TxVJw/RAarL1dKOcYuOiX+hKY3O1MbhUb4ASnwz6WNEtCGXyNEN3tfyHt
	0MVr/wbodOMkUHADYui3do0igVL/R1b2kcSbl1vRPQxqv1HanXPZC3j+cqbC6LnSrIsM
	P+uQyhmcqpGsuefqY8VVpEhwKpZTkAXyWF4IEOl+cBAXL2ZK8pFkj9arCQQnW48pRWH0
	vCulNdn7yeViSICbH181aG80/WL1FAVqnIyKjCVWWudYJkYZ+s5aY9OI3MRgtDoDiY6y
	7l+qZQsndh+nHMAz9kLTQaXVAlxX655tgNejOxNLZzPj6Zcaw07JVfD4V5xKtOfEsPyT
	j8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0ilxUhOWtdPal8guoafu7uVUdV65rxKS1rgM4/OQmO8=;
	b=p3i//iMUbNOTlXeDnzx6kbKosZbBosgzD9AruOG7H+NbiIGDzpN4tjpBgmK/cN+/y4
	V+v8oRiQvTs+scxigNyVK8zQQF8B+ng1gXhKGNuImYeaxR5XRrvkavWADRqcM+J6CZMh
	0UfWOnnThU/heYYtskcVH03i1C97EviXDBRokRhMQbrVzlH1V5eGzGChTn/UVd2n7FRu
	DM12n4AJzFAbuBvfJBix37MCZRwXg6xPQ+CuiMc5w1223Be5uqE+iRrNFnLRMWEg3NoF
	5z29AlMVfAAu4+1r5HBrpt9E4q6hDzR22p2sMn1yYaTeo5RQXv3Ymaf+OGQ1ggIfTR3X
	eY9Q==
X-Gm-Message-State: APjAAAWSbhmgx6oGb5DteBqf93q0+8QVmE4VElPvlpk5gO2/IAlDxuW4
	zV67wzz5cyY5a5DpML0XD5NfYeQS
X-Google-Smtp-Source: APXvYqxPBDcpajJyswcRAX4EdZ2FVVxWMb1TAzYN9CCyvlVVj+GeEOLc26DxNNRVWd7xTi7Wg6uLYA==
X-Received: by 2002:a25:b70c:: with SMTP id t12mr6654762ybj.67.1558644278596; 
	Thu, 23 May 2019 13:44:38 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:38 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:06 -0400
Message-Id: <20190523204409.21068-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b35
Subject: [Qemu-devel] [RISU v3 08/11] configure: add i386/x86_64
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


