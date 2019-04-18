Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEEC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 22:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5737A20693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afDZGSir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5737A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHFpP-0002ts-JC
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 18:48:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHFoZ-0002co-AE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHFoW-0002y0-AV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:30 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHFoT-0002qk-09
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:26 -0400
Received: by mail-it1-x141.google.com with SMTP id f22so5810815ita.3
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=OaT3cDmh1PRgJZ5FUTVUVPx0tyGVUKDpqE/6XeaGozQ=;
	b=afDZGSirbY2tb+Ju28I3JcDFdShxXX6j4c7LY2xhGLULghy0t3nSFPO2xdeunt72cY
	MvSrF+Z4sw7Za76KSttvMBp3NxXa6nXjMfwmiPGTeq9SM+DoQy17228gOoBvTE5C7rIy
	gklYj5WjbR6ym/HPXUc6DiUnhhRpUS7ngKeWyu5Xa42JXScwkAt43j7ap3peFdM3J2vV
	H+IQzY4V/4+uMQ2TrSTq68coGBzou+uMlS3ncxMOe33cpe9hlHc0wchL7VdOlT7IW+/A
	+eK+tBLJX+4AF/KilCn9LbtAHVL6Aw4pMbCgueysQ/6EJdMHysVznerVmsPSE5VOHluo
	MYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OaT3cDmh1PRgJZ5FUTVUVPx0tyGVUKDpqE/6XeaGozQ=;
	b=XguaV4RKi3j9Z23xkYlUzReRqeOF66zxWTNglsfaKU7SuijsfP7ZZ9Kb6gAJkBCp9B
	NmOOUZSWBORp7K1Dr10xVt/fUKqcpOvsA//SQsUmtgayxBS4oUohbnr15SFcFuVk0saM
	dh7FRVcoqjF86j0NYZi+UUayUVG1Cd1jV6yvMZiFxAQziiGUPFW1byfOjIBwKRkU/y+g
	nzdLM53hag7BZ/PQ0iVxlASxaz4HDAqb9ikjhpc+6F6dh+WwBx6qPxaj+gVpPKDK/hxP
	8lCOm2rCJID8w/2JDxuNXqvlZIw5AJopQw57Ho0EAPK4BlvEfcKrBELquRiCn+bX9blO
	H1jg==
X-Gm-Message-State: APjAAAXT9AHMM3luVP+KiM6rJb2/4U+/SnIIYCLiIRWVsTWAccqNA1V2
	ARtoGuAffI5z3b0VT3POrMA=
X-Google-Smtp-Source: APXvYqzIuKjTUAHPrgtvk3RBaDqo2xB7hkunJfTUEkTFS4Lg/XfRR+xi/72GtbQSZR33yq4wCVkF6A==
X-Received: by 2002:a24:7c9:: with SMTP id f192mr421983itf.97.1555627637615;
	Thu, 18 Apr 2019 15:47:17 -0700 (PDT)
Received: from localhost.localdomain (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	o143sm1626829ito.18.2019.04.18.15.47.15
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Thu, 18 Apr 2019 15:47:16 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 18:47:06 -0400
Message-Id: <20190418224706.14014-1-programmingkidx@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
Subject: [Qemu-devel] [PATCH] configure: Change capstone's default state to
 disabled
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418224706.k44dqj0wmq6kH5h7Q6dTg98oUP9xPVRtq_ePzfC1a5A@z>

Capstone is not necessary in order to use QEMU. Disable it by default.
This will save the user the pain of having to figure why QEMU isn't
building when this library is missing.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1c563a7027..77d7967f92 100755
--- a/configure
+++ b/configure
@@ -433,7 +433,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
 zlib="yes"
-capstone=""
+capstone="no"
 lzo=""
 snappy=""
 bzip2=""
-- 
2.14.3 (Apple Git-98)


