Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790EBC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE3E20863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE3E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDa8N-0003fT-Ls
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:40:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5K-000284-Fh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hDa5J-0007BW-CR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hDa5J-0007Ap-0O
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:37:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MelWf-1gf4jz1smL-00ake9; Mon, 08 Apr 2019 21:37:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 21:37:11 +0200
Message-Id: <20190408193711.32680-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408193711.32680-1-laurent@vivier.eu>
References: <20190408193711.32680-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/NmBRfLQlj6w7+pKeyyiXk1wBAY6dGCphEkiKEWySpOkeFAvUf7
	I2lAIHF4FQz2sqzN3I03tB4kVnEqZGbFyrOmOhbJAHM49k8Ln6ZDPqnHcXtsXTfZ9Omlm7w
	oUXKpY5m5wtlsYjj9GqmGS9F8L3KPPBQcXmN1PyqQLNu7bn6ulO5m5W6I94Zu7z3Izh85PB
	+N4KXSeMaQglaWsEUS0xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tMCD/o/Tj3Y=:ARUcA7nERBCaME/xP5+7DQ
	3Mr/QdyI0BxBnhosFqzr3MWsZLRIySfLauh+fg6wuVybz9XgEg7JxCu5xWyIrP4GoDOL4HU7r
	ppbRNE6Cc0IhATtbz+0qSA/j2Dx066x82MIWc8XeIOl+GdnSjS1/CoqBON0YJQ9jC8H0ZrRQQ
	ejnho8xHCUKezdhk70va+wNx/qtbKjpO+CodNoHkuVaM40lLsmPLMxD1fHDJJR0YlIxj48Z8c
	7o0D6WOqnjG3KJLqRNXFsrh+bn3MXIi2KA+HlyF/LdThmQNOX3cd9RObgrkEFlYXAan8NjNlo
	2edRY6slRPgZEASahFNhJ6q34bp1U+/s5+vnhvF2oEuSR/aBbAYUrERoqZ5+y7kBk6jFAtItb
	u+RARR1UT2Fq4TMrZFIf2KjZ6+2/7nbnQdd9EjZuKw2OM1sE1Zurss3cgCZfVRQhMZMtk1CAH
	GHOw4VxteOp/swa2QuKqakmPCyMVrfPerplmXol0jYNOX86j06arHG29SSwVA4acpntWL8FlP
	ZUAumW4MBNHTqMfrLjeSHrVKg+EdxNOZTzcrMJ7k2i53gfb5ft7eiB+tvrk3nmcPVdkfE+ATy
	yRU9f+AkcihSTAyTrjoenZ7hfQKDLvegVi3kHjeL4WUrxRuscVrpQexcYEdbA8IdXlktXduVl
	1dWDPgJORvcymFh5fOWqLHgdZvM3w/zoE49NuFMbUTf72NFOiJwWRpwq/feZUdiJWdWht/xTO
	jEodFjdLlkyaHH+rXLFKkdhxqtffQW5cdkb0BCIiHeZUhfHJ05Ry7LDUGxU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 2/2] linux-user: rename gettid() to sys_gettid()
 to avoid clash with glibc
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
Message-ID: <20190408193711.G7vWIg8A-YkWSg3WzWcX73C8D9-a4HREiFHCgVroA6g@z>

From: Daniel P. Berrangé <berrange@redhat.com>

The glibc-2.29.9000-6.fc31.x86_64 package finally includes the gettid()
function as part of unistd.h when __USE_GNU is defined. This clashes
with linux-user code which unconditionally defines this function name
itself.

/home/berrange/src/virt/qemu/linux-user/syscall.c:253:16: error: static declaration of ‘gettid’ follows non-static declaration
  253 | _syscall0(int, gettid)
      |                ^~~~~~
/home/berrange/src/virt/qemu/linux-user/syscall.c:184:13: note: in definition of macro ‘_syscall0’
  184 | static type name (void)   \
      |             ^~~~
In file included from /usr/include/unistd.h:1170,
                 from /home/berrange/src/virt/qemu/include/qemu/osdep.h:107,
                 from /home/berrange/src/virt/qemu/linux-user/syscall.c:20:
/usr/include/bits/unistd_ext.h:34:16: note: previous declaration of ‘gettid’ was here
   34 | extern __pid_t gettid (void) __THROW;
      |                ^~~~~~
  CC      aarch64-linux-user/linux-user/signal.o
make[1]: *** [/home/berrange/src/virt/qemu/rules.mak:69: linux-user/syscall.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:449: subdir-aarch64-linux-user] Error 2

While we could make our definition conditional and rely on glibc's impl,
this patch simply renames our definition to sys_gettid() which is a
common pattern in this file.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190320161842.13908-3-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11729f382cf4..96cd4bf86dd3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -249,7 +249,8 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR__llseek TARGET_NR_llseek
 #endif
 
-_syscall0(int, gettid)
+#define __NR_sys_gettid __NR_gettid
+_syscall0(int, sys_gettid)
 
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
@@ -5434,7 +5435,7 @@ static void *clone_func(void *arg)
     cpu = ENV_GET_CPU(env);
     thread_cpu = cpu;
     ts = (TaskState *)cpu->opaque;
-    info->tid = gettid();
+    info->tid = sys_gettid();
     task_settid(ts);
     if (info->child_tidptr)
         put_user_u32(info->tid, info->child_tidptr);
@@ -5579,9 +5580,9 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                mapping.  We can't repeat the spinlock hack used above because
                the child process gets its own copy of the lock.  */
             if (flags & CLONE_CHILD_SETTID)
-                put_user_u32(gettid(), child_tidptr);
+                put_user_u32(sys_gettid(), child_tidptr);
             if (flags & CLONE_PARENT_SETTID)
-                put_user_u32(gettid(), parent_tidptr);
+                put_user_u32(sys_gettid(), parent_tidptr);
             ts = (TaskState *)cpu->opaque;
             if (flags & CLONE_SETTLS)
                 cpu_set_tls (env, newtls);
@@ -10621,7 +10622,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return TARGET_PAGE_SIZE;
 #endif
     case TARGET_NR_gettid:
-        return get_errno(gettid());
+        return get_errno(sys_gettid());
 #ifdef TARGET_NR_readahead
     case TARGET_NR_readahead:
 #if TARGET_ABI_BITS == 32
-- 
2.20.1


