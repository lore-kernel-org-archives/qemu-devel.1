Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0BD2070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQhipP9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0BD2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXVp-00052v-OF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4C-000284-M8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4B-0004E5-EB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:28 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4B-0004DU-4H; Mon, 06 Jan 2020 13:25:27 -0500
Received: by mail-qk1-x741.google.com with SMTP id k6so40296404qki.5;
 Mon, 06 Jan 2020 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iIYRPlSXfjPSgphJVr9MrieAqsI8xts4nkwFUXyHtYQ=;
 b=mQhipP9oLD5WYxqXU3Jf1sX/+F2XCuz17PnDMVOQGuSYlA3ITIeH4GDfHo5O9OLRAi
 mpbP56gc+LoBIWpZpz3A+ESeexNycfiOo1O2ieYVo+FriFiqkp11MFrBAL5+WGE1mGj5
 Q6YB0MM+1pK2HWLfKBV2Q3iJzy6VpY1GL93KunDPDXcZa+zkf3BlSFtOtDp2bhk1wPz6
 gnXS4qGhYPas6OybiOE4st28V0WnQlAf1trWanaB59bweCqfsDUvEY+ZCUE9MlpdAgeS
 /aIn9BVLx75tuQsEM1IFY9+AAavV0NjSP6/smv8WV35hLxj7pltxOve41CM9MCN+3t7E
 sF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iIYRPlSXfjPSgphJVr9MrieAqsI8xts4nkwFUXyHtYQ=;
 b=dEOrwk/YTq0tG4RqGgcBXIukwJu/yYVInUkx1P1W0SCl81L+KsDlWLqTLEHsst0iL+
 QgYAH2nMtSIhfxOWus392CiIHFMdoiZPPcsxLgSJEe1cLXrMOvzrAo6rxfM3oce3vgbK
 feBaAQ2S1R61QYjP4DgaR0mjwOoVqomA6peMlj3D3mW8lhAnhSVFInjXIItQ8oK6hG9C
 n/yMvc87eC6mdxYmHc70DZty/lwS8DImrqmz342+VVyo5xywjeEINSvpF3Zm/N4YI/sn
 3F3D1K1FN9hMQ+M6LNaWaZkke7rCFzj5BkpyiAAl4higMEZabO9wSAj5+A6ewd+E5XPI
 tJ+g==
X-Gm-Message-State: APjAAAWP5MzqYJH0elyBd1l2a/v2BX6k6J8wOgipmXAfoLWwLWrhZLQQ
 qK0f+1oUpj5+WVhIWyQivhsoaWt6
X-Google-Smtp-Source: APXvYqyr26GEbIsdAlLQPqpzzUEP+eCeLvGjtbIaTl7QyANUHBEppluPjmQ1RudJ9NcQqRSQ6A7raw==
X-Received: by 2002:a37:684b:: with SMTP id d72mr85753234qkc.293.1578335126320; 
 Mon, 06 Jan 2020 10:25:26 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:25 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 19/59] block/ssh.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:23:45 -0300
Message-Id: <20200106182425.20312-20-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'out' labels for check_host_key_knownhosts() and authenticate()
functions can be removed and, instead, call 'return' with the
appropriate return value. The 'ret' integer from both functions
could also be removed.

CC: Richard W.M. Jones <rjones@redhat.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/ssh.c | 61 +++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index b4375cf7d2..e0c56d002a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -276,7 +276,6 @@ static void ssh_parse_filename(const char *filename, QDict *options,
 
 static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
 {
-    int ret;
 #ifdef HAVE_LIBSSH_0_8
     enum ssh_known_hosts_e state;
     int r;
@@ -295,7 +294,6 @@ static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
         trace_ssh_check_host_key_knownhosts();
         break;
     case SSH_KNOWN_HOSTS_CHANGED:
-        ret = -EINVAL;
         r = ssh_get_server_publickey(s->session, &pubkey);
         if (r == 0) {
             r = ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SHA256,
@@ -320,28 +318,23 @@ static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
                        "host key does not match the one in known_hosts; this "
                        "may be a possible attack");
         }
-        goto out;
+        return -EINVAL;
     case SSH_KNOWN_HOSTS_OTHER:
-        ret = -EINVAL;
         error_setg(errp,
                    "host key for this server not found, another type exists");
-        goto out;
+        return -EINVAL;
     case SSH_KNOWN_HOSTS_UNKNOWN:
-        ret = -EINVAL;
         error_setg(errp, "no host key was found in known_hosts");
-        goto out;
+        return -EINVAL;
     case SSH_KNOWN_HOSTS_NOT_FOUND:
-        ret = -ENOENT;
         error_setg(errp, "known_hosts file not found");
-        goto out;
+        return -ENOENT;
     case SSH_KNOWN_HOSTS_ERROR:
-        ret = -EINVAL;
         error_setg(errp, "error while checking the host");
-        goto out;
+        return -EINVAL;
     default:
-        ret = -EINVAL;
         error_setg(errp, "error while checking for known server (%d)", state);
-        goto out;
+        return -EINVAL;
     }
 #else /* !HAVE_LIBSSH_0_8 */
     int state;
@@ -355,40 +348,31 @@ static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
         trace_ssh_check_host_key_knownhosts();
         break;
     case SSH_SERVER_KNOWN_CHANGED:
-        ret = -EINVAL;
         error_setg(errp,
                    "host key does not match the one in known_hosts; this "
                    "may be a possible attack");
-        goto out;
+        return -EINVAL;
     case SSH_SERVER_FOUND_OTHER:
-        ret = -EINVAL;
         error_setg(errp,
                    "host key for this server not found, another type exists");
-        goto out;
+        return -EINVAL;
     case SSH_SERVER_FILE_NOT_FOUND:
-        ret = -ENOENT;
         error_setg(errp, "known_hosts file not found");
-        goto out;
+        return -ENOENT;
     case SSH_SERVER_NOT_KNOWN:
-        ret = -EINVAL;
         error_setg(errp, "no host key was found in known_hosts");
-        goto out;
+        return -EINVAL;
     case SSH_SERVER_ERROR:
-        ret = -EINVAL;
         error_setg(errp, "server error");
-        goto out;
+        return -EINVAL;
     default:
-        ret = -EINVAL;
         error_setg(errp, "error while checking for known server (%d)", state);
-        goto out;
+        return -EINVAL;
     }
 #endif /* !HAVE_LIBSSH_0_8 */
 
     /* known_hosts checking successful. */
-    ret = 0;
-
- out:
-    return ret;
+    return 0;
 }
 
 static unsigned hex2decimal(char ch)
@@ -501,20 +485,18 @@ static int check_host_key(BDRVSSHState *s, SshHostKeyCheck *hkc, Error **errp)
 
 static int authenticate(BDRVSSHState *s, Error **errp)
 {
-    int r, ret;
+    int r;
     int method;
 
     /* Try to authenticate with the "none" method. */
     r = ssh_userauth_none(s->session, NULL);
     if (r == SSH_AUTH_ERROR) {
-        ret = -EPERM;
         session_error_setg(errp, s, "failed to authenticate using none "
                                     "authentication");
-        goto out;
+        return -EPERM;
     } else if (r == SSH_AUTH_SUCCESS) {
         /* Authenticated! */
-        ret = 0;
-        goto out;
+        return 0;
     }
 
     method = ssh_userauth_list(s->session, NULL);
@@ -527,23 +509,18 @@ static int authenticate(BDRVSSHState *s, Error **errp)
     if (method & SSH_AUTH_METHOD_PUBLICKEY) {
         r = ssh_userauth_publickey_auto(s->session, NULL, NULL);
         if (r == SSH_AUTH_ERROR) {
-            ret = -EINVAL;
             session_error_setg(errp, s, "failed to authenticate using "
                                         "publickey authentication");
-            goto out;
+            return -EINVAL;
         } else if (r == SSH_AUTH_SUCCESS) {
             /* Authenticated! */
-            ret = 0;
-            goto out;
+            return 0;
         }
     }
 
-    ret = -EPERM;
     error_setg(errp, "failed to authenticate using publickey authentication "
                "and the identities held by your ssh-agent");
-
- out:
-    return ret;
+    return -EPERM;
 }
 
 static QemuOptsList ssh_runtime_opts = {
-- 
2.24.1


