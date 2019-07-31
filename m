Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BDC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED56206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED56206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmuR-0006pF-FM
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsmtp-0006P1-KN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsmto-0002N1-3e
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hsmtn-0002MX-Sd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E09AFA707;
 Wed, 31 Jul 2019 11:36:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82F6860BEC;
 Wed, 31 Jul 2019 11:36:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06DF51138619; Wed, 31 Jul 2019 13:36:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: P J P <ppandit@redhat.com>
References: <20190731091933.17363-1-ppandit@redhat.com>
Date: Wed, 31 Jul 2019 13:36:00 +0200
In-Reply-To: <20190731091933.17363-1-ppandit@redhat.com> (P. J. P.'s message
 of "Wed, 31 Jul 2019 14:49:33 +0530")
Message-ID: <87zhku5tcv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 11:36:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> writes:

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When invoking qemu-bridge-helper in 'net_bridge_run_helper',
> instead of using fixed sized buffers, use dynamically allocated
> ones initialised and returned by g_strdup_printf().

Does this fix a bug?

> If bridge name 'br_buf' is undefined, pass empty string ("") to
> g_strdup_printf() in its place, to avoid printing "(null)" string.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  net/tap.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> Update v5: add commit message about conditional 'br_buf' argument
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06397.html
>
> diff --git a/net/tap.c b/net/tap.c
> index e8aadd8d4b..fc38029f41 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -498,9 +498,9 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>      }
>      if (pid == 0) {
>          int open_max = sysconf(_SC_OPEN_MAX), i;
> -        char fd_buf[6+10];
> -        char br_buf[6+IFNAMSIZ] = {0};
> -        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
> +        char *fd_buf = NULL;

Dead initializer.

> +        char *br_buf = NULL;
> +        char *helper_cmd = NULL;

Another one.

>  
>          for (i = 3; i < open_max; i++) {
>              if (i != sv[1]) {
> @@ -508,17 +508,17 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>              }
>          }
>  
> -        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=", sv[1]);
> +        fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);

Good opportunity to change this to

           fd_buf = g_strdup_printf("--fd=%d", sv[1]);

More of the same below.

>  
>          if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
>              /* assume helper is a command */
>  
>              if (strstr(helper, "--br=") == NULL) {
> -                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
> +                br_buf = g_strdup_printf("%s%s", "--br=", bridge);
>              }
>  
> -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> -                     helper, "--use-vnet", fd_buf, br_buf);
> +            helper_cmd = g_strdup_printf("%s %s %s %s", helper,
> +                            "--use-vnet", fd_buf, br_buf ? br_buf : "");
>  
>              parg = args;
>              *parg++ = (char *)"sh";
> @@ -527,10 +527,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>              *parg++ = NULL;
>  
>              execv("/bin/sh", args);
> +            g_free(helper_cmd);
>          } else {
>              /* assume helper is just the executable path name */
>  
> -            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
> +            br_buf = g_strdup_printf("%s%s", "--br=", bridge);
>  
>              parg = args;
>              *parg++ = (char *)helper;
> @@ -541,6 +542,8 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>  
>              execv(helper, args);
>          }
> +        g_free(fd_buf);
> +        g_free(br_buf);
>          _exit(1);
>  
>      } else {

The commit does what it claims to do, and no more, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>

However, the code is still rather ugly, and I'd be tempted to use the
opportunity to clean up some more.  Untested sketch:

diff --git a/net/tap.c b/net/tap.c
index 06af8fb8ad..57bb4c552d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -402,8 +402,7 @@ static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
     int pid, status;
-    char *args[3];
-    char **parg;
+    const char *argv[3];
 
     /* try to launch network script */
     pid = fork();
@@ -413,18 +412,18 @@ static void launch_script(const char *setup_script, const char *ifname,
         return;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
+        int open_max = sysconf(_SC_OPEN_MAX);
+        int i;
 
         for (i = 3; i < open_max; i++) {
             if (i != fd) {
                 close(i);
             }
         }
-        parg = args;
-        *parg++ = (char *)setup_script;
-        *parg++ = (char *)ifname;
-        *parg = NULL;
-        execv(setup_script, args);
+        argv[0] = setup_script;
+        argv[1] = ifname;
+        argv[2] = NULL;
+        execv(setup_script, (char *const *)argv);
         _exit(1);
     } else {
         while (waitpid(pid, &status, 0) != pid) {
@@ -478,8 +477,7 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
 {
     sigset_t oldmask, mask;
     int pid, status;
-    char *args[5];
-    char **parg;
+    const char *argv[5];
     int sv[2];
 
     sigemptyset(&mask);
@@ -498,10 +496,9 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         return -1;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
-        char fd_buf[6+10];
-        char br_buf[6+IFNAMSIZ] = {0};
-        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
+        int open_max = sysconf(_SC_OPEN_MAX);
+        int i;
+        char *fd_opt, *br_opt;
 
         for (i = 3; i < open_max; i++) {
             if (i != sv[1]) {
@@ -509,39 +506,30 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
             }
         }
 
-        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=", sv[1]);
+        fd_opt = g_strdup_printf("--fd=%d", sv[1]);
+        br_opt = g_strdup_printf("--br=%s", bridge);
 
         if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
             /* assume helper is a command */
-
-            if (strstr(helper, "--br=") == NULL) {
-                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
-            }
-
-            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
-                     helper, "--use-vnet", fd_buf, br_buf);
-
-            parg = args;
-            *parg++ = (char *)"sh";
-            *parg++ = (char *)"-c";
-            *parg++ = helper_cmd;
-            *parg++ = NULL;
-
-            execv("/bin/sh", args);
+            /* FIXME strstr() is lazy and somewhat fragile */
+            bool need_br = !strstr(helper, "--br=");
+
+            argv[0] = "/bin/sh";
+            argv[1] = "-c";
+            argv[2] = g_strdup_printf("%s --use-vnet %s %s",
+                                      helper, fd_opt,
+                                      need_br ? br_opt : "");
+            argv[3] = NULL;
         } else {
             /* assume helper is just the executable path name */
-
-            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
-
-            parg = args;
-            *parg++ = (char *)helper;
-            *parg++ = (char *)"--use-vnet";
-            *parg++ = fd_buf;
-            *parg++ = br_buf;
-            *parg++ = NULL;
-
-            execv(helper, args);
+            argv[0] = helper;
+            argv[1] = "--use-vnet";
+            argv[2] = fd_opt;
+            argv[3] = br_opt;
+            argv[4] = NULL;
         }
+
+        execv(argv[0], (char *const *)argv);
         _exit(1);
 
     } else {

