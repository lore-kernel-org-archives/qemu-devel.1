Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A9EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7110820854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lEy5DO95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7110820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXIy-0003bX-Hy
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:16:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXGM-0001oe-Rj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXGK-0007LZ-HB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:54 -0400
Received: from [103.7.28.233] (port=48940 helo=smtpbg65.qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hLXGJ-0007Hj-0O
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556648013;
	bh=fXh84p0STXn5EKlUSN9SkaMeXFu9HW8bXx5D12nm5Fs=;
	h=From:To:Subject:Date:Message-Id;
	b=lEy5DO95RAUKNPgzeGfdSzCbkirzV8d3zamC3Flux0eLVMB96J/6XMe9FpkFAYTXR
	zt/YOli9cs7GnpjG5avQo1EMFeShNtsWIum9OXF2WtJNix/akqK6LkLRGIHBo/nTDS
	s70zKwklfEw9xHubs3OgKyOR7BLrwUbRTQzGaYuQ=
X-QQ-mid: esmtp7t1556648011t03dg8sce
Received: from localhost (unknown [183.63.119.27])
	by esmtp4.qq.com (ESMTP) with 
	id ; Wed, 01 May 2019 02:13:30 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: Me8Xob1wlXKFmfv5qapX8itN2yV4+W/QesTEzkr0GqYAn7qQvKjofD3aqltiw
	3E3JyPLdklFLtWYnXpjskd/NWE3kHr4Yu6hMX+ltiw+LZh7CSfzn6+eHCt+ffXfWUvusIgC
	MsPo+CAxp0m+ysKqnNAqMBBVGmsK25P9rHFtKaRY+9/XJ7VN7gLgH/7uBZF4lMwfkcaYTNO
	3HecW86xw/RGheMc+hDzwCzleHQpbqD7wIfowoI8WB1GoFd5McirB3qKyiaSKqXgFVYfE1m
	308cxcHa/k5dktNFv/SWyB7s7BRMPeL99E2A==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 02:13:26 +0800
Message-Id: <20190430181326.1314-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 103.7.28.233
Subject: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t instead
 of unsigned long in AArch64 arch_cache_info()
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
Message-ID: <20190430181326.yps9TpQu-QGLExJwLQ0qw8sw0Gb1oVbVRUheoE_3N2E@z>

Windows ARM64 uses LLP64 model, which breaks current assumptions.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 util/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 3cd080b83d..ce6f0dbf6a 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void arch_cache_info(int *isize, int *dsize)
 {
     if (*isize == 0 || *dsize == 0) {
-        unsigned long ctr;
+        uintptr_t ctr;
 
         /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
            but (at least under Linux) these are marked protected by the
-- 
2.17.1




