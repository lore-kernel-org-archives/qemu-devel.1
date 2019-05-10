Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C90C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD532175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD532175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzsM-0003S0-V1
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:23:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlT-0005nq-Pi
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlS-0001l0-Tu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlS-0001kT-KI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MPXpU-1h3dQ418gE-00Mcjx; Fri, 10 May 2019 09:16:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:53 +0200
Message-Id: <20190510071557.30126-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MmIg/GBEgOPrGam1T82sI5ZEbuQbmmLb0GqQFWMMcebxb5G8aO9
	/q/4VO1vas7qd6C+B1nH8YojBViw+puG0zMG04yyO2aFYpFN1VVLis+UtbQpZAMdJBN+y3D
	GEqqwpWl8WJPKAVh24cZYJKHWkVBctGCq9E+xm7KIfDGP/MPNE7ApYCrFu6KTMAYQO/EBSi
	Z8V9Bdpim3xwmnzfNYWgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:39ZglJTmz5A=:74csuOgxyu29sjQw6RrW86
	1fIUhodlqy6do/obfo/WyhPxxFvFXrOE8tL8zz4aybr3xsTzo4hN48CBgRZDecdGaj9guL2K2
	ARYnAcr6xzex5Flugtx91Jjyl/bwQFrpadXZFNQuq9UiBc/PJWsgb3/IeIzJJedsN/8WzgvdN
	My3tPI70wYfuA504ugbPOvlAzVyGprhk3O4ie5VFiaJ2iU9sl6Bp+bTl8n68LTZ0FxZsVlQXj
	6LlXc5eo3gR8R+frVMAsovdnOGVrClrko1W7KZ/O6vH3uv6XggK0emW3o4iOQYL9PaZsxpxzp
	+48bRRGas6zI35HKE/LQAaL74wTv5auM/jSR+xfQDmOU0Gq+1Jc69FnsdkGBrz8Xd2jD0M46H
	b6b7HbPxTRWNKmfH3S702xPz/DRbzkz1pfF7ijh3NPGtbj8gM43VBQrSHGnisw3hr5G9nXLc5
	hGZcQsBSFhB9pAOVcrD9Yol0cyqlVEpfd08n8P3BXg+jRa8lAbLamcw4sqGKSPjpUNzZ0eDXW
	hg59o/uWAgXzODRBsea4tB3Q8a8RvvtzhTRGN8r9W1+CJg2R76WA8YT8fEV0z7JrT1iMhEQl9
	Do4/eK8yAdO3zPwSkKw8XFZ/PGcSxOqcTLlL9kwqv/MVsSrSmdzTjO7YzAIGeYsK6WDrDRy46
	CWGAgZMFPGhMkC0SBj5IiQfa4iFlsdhF/BFG9UCly+dcC2xb3AJprFURg/wv2P0mUIfB6CkkE
	YZmBHdvHNOmI16xt01mSLJSe3QI9hlZSjc70unZ6iHP/OEhf37Y+/VboOUs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 3/7] linux-user: avoid string truncation
 warnings in uname field copying
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from linux-user/uname.c:20:
In function ‘strncpy’,
    inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We don't care where the NUL terminator in the original uname
field was. It suffices to copy the entire original field and
simply force a NUL terminator at the end of the new field.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190501144646.4851-1-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/uname.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad47..1c05f95387f4 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -72,9 +72,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
 
 #define COPY_UTSNAME_FIELD(dest, src) \
   do { \
-      /* __NEW_UTS_LEN doesn't include terminating null */ \
-      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
-      (dest)[__NEW_UTS_LEN] = '\0'; \
+      memcpy((dest), (src), MIN(sizeof(src), sizeof(dest))); \
+      (dest)[sizeof(dest) - 1] = '\0'; \
   } while (0)
 
 int sys_uname(struct new_utsname *buf)
-- 
2.20.1


