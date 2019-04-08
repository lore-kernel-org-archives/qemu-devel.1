Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F7C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C8320863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C8320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDa7C-0002zr-IP
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:39:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5E-00025w-2W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5D-000781-7D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDa5C-00077Y-RL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mf3yk-1gfv1T3mf4-00gXny; Mon, 08 Apr 2019 21:37:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 21:37:10 +0200
Message-Id: <20190408193711.32680-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408193711.32680-1-laurent@vivier.eu>
References: <20190408193711.32680-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dC+zbVk1UaetRWK9i37iwcYedkwqWIz/gPwo4SBAZLNP8Czct9S
	9/mV5Xd6632jruw4JCYugmX8MUTenIuJ/1pLJWkk30zOgE4s56k2FPRfI0YOsGfreJZs74b
	aDWRXv0IotOdaYCo5dAE9Mhh8gY3mCnTFzsubOaflK+GvSv5f/kzeDpBzhpsTAArxIefPql
	N1S7ubpvwA6BvWpndiEwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cx9CNRXHdug=:IDVq6SkLvYqO/ydBDspPW0
	Ak1Bk/0jEB+4yHWWvSIuJoAFyaAt8LnuGbR55rQqK7iiW1z5rqMhy+G7BZij6SasHS+qs1crI
	jtRZNiYHtBQHPXv4OIk25IltvC/CWCHZbV4NbJU5eTQAyucDakLXmNAK3ZB+gfq6uY/eXKeri
	+GIwdSg/G/+7ZqzlTcf2J6aHKZSUaVbNoRLWRVeKKF+S1GKZMAHcm7DKy6bNkaQySupiU5y2h
	2pFGBhgHj6BBf5TGOQLyyfDMD1RDl1vr2ycvMIw5760OYkCO/xo0DsiR+qbpfVBdYIshbp3sm
	cwppDOewJpva597xwPI4H0plEvkbHTOJPJi+W8U39l91LEY+heAjPuhrARbzZlkYxtPQ58sRt
	vC7sGHH7c63nrfEhNT6/GDQrGZAShNbe0iO1CHrQddFLy2zEGsDS+n74XKGw33+gcS6OOq8XE
	Fr3pY06cfl/++YK51LK4VBES5noOVy/STsuBm4Nlu6KrHXvB6bc0UtwBnXU0SXZtSF21Pi3Y5
	5XWhnFsik5jzp1jOdzwcnt8pla0v0n2luIbEKWdo7hfBQ7CZv450VsYbz+qvtCsEGhrdl6X9D
	m0NNVYJfRuhQuFqBOkZpFU4yYb4iVxyvhoBdWCCIw5WDZuTqRKR5T9TXFxH6DKYlg/viaPQ/7
	FB3omRwbV5rkLE8pErROEYm7x0wULSNYYeQagMAAs9tXFsj/H1d8XgkuW42Clk2rcId4XG0gU
	l3BtldATTa4SH3nb2RHXE4K1xwGxMd4uTq/WnI7vaJ0aVf5J66C1tSI4KII=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 1/2] linux-user: assume __NR_gettid always exists
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408193710.reP70uQomsyTv_ojjZp5DvlSe5WAHJvxuQDaMPvkym0@z>

From: Daniel P. Berrangé <berrange@redhat.com>

The gettid syscall was introduced in Linux 2.4.11. This is old enough
that we can assume it always exists and thus not bother with the
conditional backcompat logic.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190320161842.13908-2-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 208fd1813d6a..11729f382cf4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -249,15 +249,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR__llseek TARGET_NR_llseek
 #endif
 
-#ifdef __NR_gettid
 _syscall0(int, gettid)
-#else
-/* This is a replacement for the host gettid() and must return a host
-   errno. */
-static int gettid(void) {
-    return -ENOSYS;
-}
-#endif
 
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
-- 
2.20.1


