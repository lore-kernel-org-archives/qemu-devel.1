Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8FC20673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8FC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp5G-0002eP-Bd
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:52:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowv-0004E7-Tt
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowv-0006EE-0V
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowu-0006Ct-Mc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:04 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MtwEO-1ge4H12l8m-00uK7E; Thu, 23 May 2019 16:43:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:35 +0200
Message-Id: <20190523144336.13960-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cs5dL+X0+zasUeXQvoPJVHhfkw/EwMe1R2voizKI35ZRlKPrz33
	91yv08yz56F4EgYkfgadCkW+//Hf1Lj+n6l7znXrazaElkDBqPszz+q89EGpqeQDbMGHXqY
	D0Vtsi7X4y5t7k2lLJuUXnZSlEtd8OTkl/IvzC5TAj1xd0zHOkb0z5iWYEeAJHsLxsypbwV
	KiBnTwg+B5m1Mbnc7v0hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hUXmpm1N3uw=:VpozkE213P2bVP2P5vnXey
	r+tdpGI0VLHOAtyCdieEoe440MKAoaD9AuO7GTQBntGxUJN1/u9Imip9dtkKF+EsB9my6uN4+
	2oJEiZl1SZOsUofyf+EtphgcteF++sJscd3bhAbgasvLPmT+/M1T5P8yUStX2+psg5abWA6IU
	edMrvnhT9l47uZoQQgPsjOr4iMP10VVJoXUKoY1j+noPNF0VQOhlMxzqAK3fjhdUBBXfrHyEV
	BolUuyQMWg3rET5ncGuFkjVZSLyalHximClmhEVOMS5Jx0MBEeBB2csNRduJDoGdVXvLGkZPy
	gY22Vl9OCz56GJZ7PJliS5bbnzoyg/4ImNtXPqlIca+4tfZ6PuOdgjAvBGzIUeu3dluz7ww8f
	iIYd/kzygePbsG4Qa+t5bqp3hOsGntW1CNBe2wtM2GYrrS+PBoYjU+LhAzMVPWZsUfhOwSJaP
	zXMUaUnSSmOyHQr/0svRJRmvn4sJR9uUxmNV/QEqxmGls7tIPeBGBp/LRVNOoAglFBGVpT6+4
	t7TIaoMT6L/P7RmH6S3hZ2aWDK12xIfHh98hG9RKmpsZvIwp0s8aX5X+/w60r8vFKJGiL+112
	uPMqomiDQ3ppCVk3lTJvuzm+PvWzUgRcH4QDpt2PzmR+WucV11hf6ic8QKJ9JkrDyjrBG/jNt
	XIV43X6CXvN97aJI+qfOVJifao5DZrND6gCY6favGwtFq8+0Unv4ia9pbxC/GxKEZvezMv1ut
	+rg9udD7ir7ERr2Dvh5HtBGtHwYkR3zj3wvZTQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 09/10] linux-user: Align mmap_find_vma to host
 page size
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This can avoid stack allocation failures for i386 guest
on ppc64 (64k page) host.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190519201953.20161-14-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 10796b37ac7b..af41339d576b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -262,6 +262,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     abi_ulong addr;
     int wrapped, repeat;
 
+    align = MAX(align, qemu_host_page_size);
+
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;
-- 
2.20.1


