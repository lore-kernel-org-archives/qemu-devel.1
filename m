Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DFD2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TsCpfXPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DFD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60397 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMFK-0001tw-Ac
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:40:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMCS-0008Hw-3s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMMCR-0002uP-9m
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:16 -0400
Received: from smtpbg299.qq.com ([184.105.67.99]:55364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMMCR-0002tZ-2Q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556843831;
	bh=5pl5oYHhrQHhrz2dqdwsgLGsyUpjkYXkRCk4kQ9nGqk=;
	h=From:To:Subject:Date:Message-Id;
	b=TsCpfXPVsmmxgPoxoQ0MbJEsPG7RM8yy91/ZceoU5bc5fnnYoUOd9zDCLPbrbylgR
	QGvYXPI2a1fDV8ETMvwxoUBF88GfQhGUCnDqNWEo+5MOgMoUfFAudD0rIXuqi2zMVS
	HkIyp/dd+KmRXD1r+8MrgkJ/8f6gS4o3wkKl2iBY=
X-QQ-mid: esmtp4t1556843828t1vs5fkh7
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:37:07 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: kCBpokdLy2DzowniVSWhOW+BVcq4spYJpNB4uD4gkKS3oBA1bE0d4g6tAs1I/
	+NslEM/oP8qlQ0ysz84gfyDhxCSINkHWPxRqDXwgutRGBUU9uqWLKgh+je4k9hOOu/nebqj
	zWgL7Qi5PsQM8xtEIuWqhKfR00TFNp2DdM6T4/XGwp+12GPkuBebrpJYPjuUtkycHSzwebk
	13VM2TmJmjRqJqG2exXH6Jzz8O6ZqfxmRgW+qArE8bQFmrZ6Auf/dzcTOmODWRdQqbrDMRm
	1fhwVLOCwtr20jOStGH/P1fDomEbQHwiPmaw==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 08:37:07 +0800
Message-Id: <20190503003707.10185-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503002206.9751-1-driver1998@foxmail.com>
References: <20190503002206.9751-1-driver1998@foxmail.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: 722D390903854009AD3FEF5654262B8C
X-QQ-LocalIP: 10.208.130.95
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.67.99
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
Message-ID: <20190503003707.L1sqikEeppkrfC943-znOIAipIJ_U8aIufeqPCvfIHk@z>

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


