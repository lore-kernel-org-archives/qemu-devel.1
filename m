Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EDC2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnYmgQL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EDC2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36225 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwJb-0000ef-TI
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:35:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBx-00032Y-6k
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBw-0001TW-A7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBw-0001TH-4p
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id u17so2409906pfn.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OghAJHs3fOQNasKs983B96RGcVieroO+wnBU19gV5SI=;
	b=PnYmgQL03LGX3nHHWTGEAqZm2Xjw1H5oyBj7ORW+hayqyWHNHTwW9m2vDfd7Xtu4dy
	SEZ/rMJxkfvAHLVfDpkm0gsYmS4gShE4gAY+ZBIcbC/CjlO7KhaFh5FVRufxP60GkxCW
	jE4bNMyBUDNbAUpLtQlzN+TvAFrf9w/qPI3kdKbdZfW1Xd/DagbF/00gY/jCTu7UawNl
	FqS9iuXtD3XamC4lLO1utId4vn5OgnGL0T4WHZS13E0A7b9UljUP2+syyS95bqYZenVR
	lIfsOvAvwf2IXXIW+PHw2XCLpOjrctvku1R2MHlDQcipDep5GYGiXszyqnKleibyE9YS
	maDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OghAJHs3fOQNasKs983B96RGcVieroO+wnBU19gV5SI=;
	b=EQTSE7yXHb06q10+TZrrWw1NNQ/nVyAI/2EhSxwp+LmBCWm+udj4tZj+50zdswAxrj
	xa8NDC5Hh5Dy2if3nzeeQ9GFq7B8zox4Nhmn77myX9FiGBBCW2sLI+CmEif/sD4gBXol
	j5lEnZZ+IJk7b/XDzfoJ7RqecfK3rUxOIMsEWWHkqOOpMSY7JByhrsoyX4lO5p7kxvCx
	k4v0dvngiczpFbir3wf2HdAhaXVRze27LwGWfRVJ8mJqjdeZmKKVAYL0KemWeu99I2/j
	i0GVeCm6pAfK2/O1FVgPubV26KfgAuNsIyjF3c/RbqK8VR6z/jjN0FhibS1x8tjXSyU+
	pEUg==
X-Gm-Message-State: APjAAAXzHiUP65H9INOS4Ss9TenVrwdOl842XvjpM2J2ueqyXeUA18IP
	PQuzgo86hsECAyI5fWjUwGiRbj7QSt8=
X-Google-Smtp-Source: APXvYqzDNwh1zlA5lu1LLAGKzQlw+HSJT4/vOTRPlQ0Xpzyva+m/aKDtMDKtDafglc0BXoG1aZ74Cg==
X-Received: by 2002:a62:5ec4:: with SMTP id
	s187mr10737284pfb.185.1557458842987; 
	Thu, 09 May 2019 20:27:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:10 -0700
Message-Id: <20190510032710.23910-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 8/8] scripts/qemu-binfmt-conf: Update for
 sparc64
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also note that we were missing the qemu_target_list entry
for plain sparc; fix that at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..9f1580a91c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Enable automatic program execution by the kernel.
 
-qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
-mips mipsel mipsn32 mipsn32el mips64 mips64el \
+qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
+ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"
 
@@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 sparc32plus_family=sparc
 
+sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
+sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+sparc64_family=sparc
+
 ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
 ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 ppc_family=ppc
-- 
2.17.1


