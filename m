Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD8FC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8251D21927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8251D21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6T0-0007yv-Md
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jP6Rd-0006gD-B5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jP6Rc-0006C0-5Y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jP6Rb-0006BZ-TF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:28:48 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4bd0-1jQl8P3yPW-001gZg; Thu, 16 Apr 2020 17:28:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] linux-user/syscall.c: add target-to-host mapping for
 epoll_create1()
Date: Thu, 16 Apr 2020 17:28:29 +0200
Message-Id: <20200416152829.790561-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416152829.790561-1-laurent@vivier.eu>
References: <20200416152829.790561-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fYLnFkbtPDGNGlc8HnnaGqr7V8OqcMcyAf/6a2O3+objzZKJfPh
 paLLOcVvLPEOnY6Zk4Qz70+3F/ewMN7+reWmjNQdI5Er9wYoXblQ1MxR0mxL70RiqREexmG
 434GxSzB9aY0eC/9yhhyUwm1J0v0eszkIiSlzATxHi4pgufSB0sIMthG/XUYLP3ggETYoq2
 WBAwHp7oJsJ6ZiOmwr2Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8ASVaMBwM8=:kksufDm/zJFrwOKZJnuV87
 sAdoCTHLU7g628hhSJOFd+VSCHYzaMhiOdvWpqTl7B2rSaoI45IEaD1l3xD8sKMYzrWuaJbX9
 7NO/82CPmh1UTMKbu2iaYzVbFdDiBd34HJpASi7TrtwQgHGynO41VYN6bKR5T1PmsDA22BAL7
 rbjJSdDlpM4lNYYIIJkRLpnCkaSb/aRoGfVZT7xbRBNjdWthI6v7NVbUu2m5e7ODa6NULg/6k
 fhS85p67uEBStn6I2nz7rb+UPGXNNPzVXyWemPl5jHqPavs0Ue6mQ3/uZyiypyv9/LhV7aKDT
 mzvWgQjqBiDvI6OZe+f7u0a1aGI1VzQTufcu5BtFoTF1krsRxBwL5PzYv34IZPhvx4efkseDo
 doboUOhFXHFd0gBXXc3U13kzcBbCz3NGQvsyYD1ewIGSdDYZZRm3Dvpb37LG03UGU75BEco0z
 oFJB+Y0M4KRL8riifYQ630tJEWhDMXidEWEMsDRONKrH5ld0dDJSiWTqExCmqMYdVVR5L/7F5
 T624DgkMoElPl8RxrCvyDNM82gLobY1ymqISt55wc7jCxZi5YaR/g7qW5iigjqtEcMtOySdCk
 3H38LcMBdbsGuzi1nMGX+Rg7z3bhWnGI/8LeBkY+FTY8sQC4jvTnLQ6olS4BQUDJGJKW1jx9w
 yfx1nicCaYyJyG5KCPiPwralzqKGJ6eJociE+cft3b4mYX3Iy78h1SdPae7+AgCGFscv3zR96
 ZVpX1Zo3YRjM0qFTmybWnH0P9AFYozjOOZGUhkh8h9ZnM6j3V+yF55wfHbrBf0+EOFOHz+oP6
 3FI+Wt/Z7X4jS57znaJP+73eB8c+BSv3fmjUgxS1q5J/sQrV2BhSI+AfkkcbnBU5IsUHBiX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Sergei Trofimovich <slyfox@gentoo.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

Noticed by Barnabás Virágh as a python-3.7 failue on qemu-alpha.

The bug shows up on alpha as it's one of the targets where
EPOLL_CLOEXEC differs from other targets:
    sysdeps/unix/sysv/linux/alpha/bits/epoll.h: EPOLL_CLOEXEC  = 01000000
    sysdeps/unix/sysv/linux/bits/epoll.h:        EPOLL_CLOEXEC = 02000000

Bug: https://bugs.gentoo.org/717548
Reported-by: Barnabás Virágh
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200415220508.5044-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 674f70e70a56..05f03919ff07 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12012,7 +12012,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
     case TARGET_NR_epoll_create1:
-        return get_errno(epoll_create1(arg1));
+        return get_errno(epoll_create1(target_to_host_bitmask(arg1, fcntl_flags_tbl)));
 #endif
 #if defined(TARGET_NR_epoll_ctl)
     case TARGET_NR_epoll_ctl:
-- 
2.25.2


