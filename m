Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D91214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D91214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VYE-0007kT-9q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Ul5-0003RU-9J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Ul4-0005cl-2p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:55 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:13363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0Ul2-0005Uk-2Y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:54 -0400
IronPort-SDR: OmtgVFvRWFOAVEv2vW5yjFsOQvjQikRbDoEcyQcvvNfyHxnmEOE3aXEIoX4A9YlaJIMfv8wBw+
 fdSA0lMwohVFyc2gCcLDwVajC4bfD0ithz4qhJlUre6Wsxf59G5CxrqjJD5gXq9dAsfvZ+f1cR
 h34HZIpcwuHPpzPRokS5bsMPhVrsehAQlR+1OgKrG0D7xyLdRvFwjBn95CDUqcxlUx9GfbK6rk
 vKIJKhUU7cK3WUG3/RiW6zoRlkchIi07mITqAyXXtuua2jw8jXYBNk3LisQ+cGbccn5HgS4uPR
 WCQ=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="40657531"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 21 Aug 2019 09:50:50 -0800
IronPort-SDR: 7B0yq3nUz7b46Lgg1btkY3aVh3QzKIAKJXaqtrVSUIVR883e8VhUa5cXrdYQ39iPu3oAl1/cwp
 LWL4mUmjfGBO6IW1TE2ByXDVzoSjJCmveWxdz1BhWsYPaIcacvtrscMj3bU1snVqBQeAJCXXax
 Cg1+90no2zFBp6AUHNNoaq5J/zbu5XUoAj5LOvTjb03v2fb67WVSaP5GRVxKvFjw330LfHfZv1
 kVczLes9PTxvwJRiKiXpQHHxO2tdza4Dg3+VXnwasVQP1HZsmzRH+zGprynv3CelHOwn3m5g4u
 xfo=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 11:50:29 -0600
Message-ID: <20190821175029.21868-3-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821175029.21868-1-sandra@codesourcery.com>
References: <20190821175029.21868-1-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.252
Subject: [Qemu-devel] [PATCH V2 2/2] target/m68k: Fix bug in semihosted exit
 handling
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes a bug that caused semihosted exit to always return
status 0; it was incorrectly using the value of D0 (which
contains the HOSTED_EXIT request number) instead of D1.

Note that per the newlib documentation for the m68k semihosting protocol

https://www.sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/m68k/m68k-semi.txt;h=50520c15292aa7edf7eef28e09fd9202ce75b153;hb=HEAD

for the HOSTED_EXIT syscall the parameter is passed directly in the register
instead of in a parameter block pointed to by the register.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/m68k-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 8e5fbfc..f189c92 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -194,8 +194,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     args = env->dregs[1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env, env->dregs[0]);
-        exit(env->dregs[0]);
+        gdb_exit(env, env->dregs[1]);
+        exit(env->dregs[1]);
     case HOSTED_OPEN:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.8.1


