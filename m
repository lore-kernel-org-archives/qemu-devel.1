Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A1ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737FA222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737FA222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wjg-0000Tk-SI
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRm-0006Bq-Mm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRl-0004Rz-Ne
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRl-0004Rd-Ev
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:45 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5wc7-1i290j3Jj1-007V9s; Wed, 11 Sep 2019 08:49:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:15 +0200
Message-Id: <20190911064920.1718-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Su61+BnpKiccqNuEQD+A6HqyxIOzxrWccEsaFWHENjM9CIChd6C
 a1w0VRCm+u9ubulRdzheD77DvR1dMe86Uu7EF6GTg6Mxzi472iPznSHK+1Pu8dG8WhpOHLI
 kOpSdvJMKmVqyOT9SlzT15N2gLZsPqW1rh+aVQwI4vm8V7nd2hJs2wXS0NuIM5kyU68/uYy
 +iH6Tfmo3cd5KtEO0Ywfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1yOHbFUPko0=:6FR5lkRiUee9DSqImHk4Hw
 fPv//MW6vE/U2s1MfdLTP/lzhUKUmVChtlDX9Uer+d2My0TIHNosk1xVkKs2mda59BhJNmYSw
 6K7Ew0dUhf7xDm+RgatrByO1nEViIlVjwgyAhS0c/BkouSkkWIpUHX7I5DuKkw3jm6rMdCPdp
 JoTYHHpOjh2p8Yznks0NHAOFeb/DDHr4rzGV79CPg+J96FUBmxZm8V28jM++RR5rFAMVQksrg
 xuymSp6F7XCIsQhos2PG6gfuNbmqIpbYV744LeRvo4UH9Om8Z68En624LJE/eaz7k3DmXKNZZ
 GL3+zxmu3uuKFcHgtRytN7u1v6Lk26nEoKW2PTUXz8FFP4Xj2r+8+nJSwsjWriAcuQtOfNWkq
 O8oBploh7cS7QAGl9ItA9bRYkMlmkvMbBOnPZfuCDy2fX5x+xT9QiUEoMuilQOqnNyKPD5SPS
 WtSE3hiEvkteofoxzG54XSQwITLeZfZvoDhxQtrx5g+1tOM39/E5O/PwBj85M6g/Kpb71aRlc
 WBAUASDo5pVmRDi+wn3Tau3tgIr8FvokockxLbNO+SgXYA5bhk6qz+bXR7fzbCnWcKZKlhwyg
 NGKtEsgTxpEKJYxgbiH/5NcRWDSXEOh9dgpWq+8Zh3eRk0lG+F3CMW/MzIO0M93SbaE1putDC
 YPIjyLTpBoSezqxqzBmGPts1zTDN7oP3Uj0dLhJsMa6WYITBehfdQ0sL8hG+dTHBw1Y6qRF/j
 6JBwPAtKH46QvEDQ2OlOqYyQbcW33CzVFS326+sR5voHnSPlL8q1P5lM09t2UWllapZdpY7Lb
 BzC3kGRHMA2twDsXyRLYXsaYlAtSw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL v2 10/15] linux-user: drop redundant handling of
 environment variables
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

QEMU_STRACE and QEMU_RAND_SEED are handled by the parse_args, no need to
do it again in main.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190906165736.5612-1-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 27d9a87bc83d..560d053f7249 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -706,13 +706,6 @@ int main(int argc, char **argv, char **envp)
         reserved_va = max_reserved_va & qemu_host_page_mask;
     }
 
-    if (getenv("QEMU_STRACE")) {
-        do_strace = 1;
-    }
-
-    if (seed_optarg == NULL) {
-        seed_optarg = getenv("QEMU_RAND_SEED");
-    }
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
-- 
2.21.0


