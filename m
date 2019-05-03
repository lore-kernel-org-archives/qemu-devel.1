Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2987C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9992070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lUryH7sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9992070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60429 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMFv-0002RD-TN
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:40:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMDX-0000kR-Ng
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMDW-0003RX-Sb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:38:23 -0400
Received: from [103.7.29.139] (port=44834 helo=smtpbg64.qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMMDW-0003MU-CQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556843887;
	bh=5pl5oYHhrQHhrz2dqdwsgLGsyUpjkYXkRCk4kQ9nGqk=;
	h=From:To:Subject:Date:Message-Id;
	b=lUryH7sMXwI8o82H42zl0igcaSSMD6jlLi78zN6XSR0JXuYrtAB7pHBZYIQmIh4KC
	O+QfgJNFip6YA66mUhaF5VKGaBRBIEmwY99lv9Bphi0jmL5soPI0U5ogxg0dwBPByY
	Io+lpcrjniSrQpAtRVDp9wsBlRG26Egu/iGrrVzo=
X-QQ-mid: esmtp4t1556843416tyn0400j7
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:30:16 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: 6ugjij1k5i9E74SfuYtuW8YsyBDw94YlKSv0B42VXl3Fd7F0i1MRV4k9QZ7ls
	WOPRlNZLlB/7Ik3k1qlwu/ib3gelkLoK35ulkctttr47HyoA7WnvCs2+1ePD/8B6kZf4DxY
	3hTFS+dOTWY7koPAhXizhOVc/1uwu3y6mHHEqoYV3RzuJgLN6hGip5d9oA22nhYTv25oGtR
	5OQIO49cw1zJWMmEZMIKY5gERYoizdAHPPuski+iLrY5mNgOZNOm36QKn23duZvO4F1KuHe
	aPr+GqOgbp/45nfVxYfbGNyy9La0flNNWF5Q==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 08:29:30 +0800
Message-Id: <20190503002930.9991-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503002258.9799-1-driver1998@foxmail.com>
References: <20190503002258.9799-1-driver1998@foxmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb115
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 103.7.29.139
Subject: [Qemu-devel] [PATCH v3 3/4] util/cacheinfo: Use uint64_t on LLP64
 model to satisfy Windows ARM64
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
Cc: Cao Jiaxi <driver1998@foxmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503002930.4F7gd1HJLqfT_V75MXkq-LQ29fcUF3gX2GCiQGX7VUs@z>

Windows ARM64 uses LLP64 model, which breaks current assumptions.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 util/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 3cd080b83d..eebe1ce9c5 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void arch_cache_info(int *isize, int *dsize)
 {
     if (*isize == 0 || *dsize == 0) {
-        unsigned long ctr;
+        uint64_t ctr;
 
         /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
            but (at least under Linux) these are marked protected by the
-- 
2.17.1


