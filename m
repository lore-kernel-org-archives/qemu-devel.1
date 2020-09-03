Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC946C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE89205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqrq/EX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE89205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxDZ-0007iS-Mu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMD-000570-AP; Thu, 03 Sep 2020 17:01:21 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMB-0007uN-9t; Thu, 03 Sep 2020 17:01:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id v16so3996086otp.10;
 Thu, 03 Sep 2020 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Z36mXy2WFBF5NBY+RBTjJ9WAglVt96yt/HKBybxipmc=;
 b=tqrq/EX93AgUny/nwg6QFR/ysHJWMEXT7xEsDAzeE03v7b1LpoJytVDxuH4MlUkpO+
 UAv23RRpw+fKWhTomHu2TjqDjBA7TUNz1ZWpY+8/FCXb+m0uqCHdXOmGG61YpjqqJbtI
 mSyKBVRnu+lDl2oK57nFyAj1NFMsIEvVm+PO5evDWw02KYAdYkX3mn037fXqq7gnDzLg
 2xSdnXBVIpfN2fzx1fW2RAT630vQHT8IJpHLjU16HwheYbSgEiKBjt9hgawb6AUe6QOy
 uT+MZDfZ6dSeaS8uUqDMrmjcS7bN8Ij5uq8ajvnGfvS+BGs6s8PnwHzHuf5YNK7KANZE
 Wa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Z36mXy2WFBF5NBY+RBTjJ9WAglVt96yt/HKBybxipmc=;
 b=kzperAtt0DfNfn1FaVYHwgzQ4hgS4PZ9lbaT01/w7uqbOHpb05sRjRa1b9grN/aTIr
 +q7e7CKjEHMUilQRBPAq3G03gDinUDxiMq3P5Dlih8TwE61bXjkomFlQQyJ64t1BdgWB
 497oUNgrTljESWflsXayAmYoVvUv7awAjHL977gUgKA9TJXn4edanYneyC4+1pCJOw1T
 lDa0vynxvnCEBp5nkwLGYgaEd8rldXHtsMAJP/CQav5tXENnkPoYJGQzycGS/DjsUCrS
 VT6gjZXWXk8uteq1pR3orUcZ3TXT19h0cm9XZMOQmN0FWJCBuPpqWkEspAGXKjUB46j1
 T9nw==
X-Gm-Message-State: AOAM530I5GHHYpjA9lc3y/7ETxOzAoUJIzsMJt7TFQLR/uNTeN6xkDh5
 W0Imy34+rH8+a75e7cfhf1dvpktAUsbKkg==
X-Google-Smtp-Source: ABdhPJxpMoKcMGqhfnLo9UAm0rAGuaMQTMP2Je1Sw63Bo3LcdoMNRofxG28N5ToEjte4Rbqz2eyNgA==
X-Received: by 2002:a9d:21c4:: with SMTP id s62mr3086347otb.350.1599166877385; 
 Thu, 03 Sep 2020 14:01:17 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id j20sm767305ots.5.2020.09.03.14.01.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:16 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/77] nbd/server: Avoid long error message assertions
 CVE-2020-10761
Date: Thu,  3 Sep 2020 15:58:24 -0500
Message-Id: <20200903205935.27832-7-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Ever since commit 36683283 (v2.8), the server code asserts that error
strings sent to the client are well-formed per the protocol by not
exceeding the maximum string length of 4096.  At the time the server
first started sending error messages, the assertion could not be
triggered, because messages were completely under our control.
However, over the years, we have added latent scenarios where a client
could trigger the server to attempt an error message that would
include the client's information if it passed other checks first:

- requesting NBD_OPT_INFO/GO on an export name that is not present
  (commit 0cfae925 in v2.12 echoes the name)

- requesting NBD_OPT_LIST/SET_META_CONTEXT on an export name that is
  not present (commit e7b1948d in v2.12 echoes the name)

At the time, those were still safe because we flagged names larger
than 256 bytes with a different message; but that changed in commit
93676c88 (v4.2) when we raised the name limit to 4096 to match the NBD
string limit.  (That commit also failed to change the magic number
4096 in nbd_negotiate_send_rep_err to the just-introduced named
constant.)  So with that commit, long client names appended to server
text can now trigger the assertion, and thus be used as a denial of
service attack against a server.  As a mitigating factor, if the
server requires TLS, the client cannot trigger the problematic paths
unless it first supplies TLS credentials, and such trusted clients are
less likely to try to intentionally crash the server.

We may later want to further sanitize the user-supplied strings we
place into our error messages, such as scrubbing out control
characters, but that is less important to the CVE fix, so it can be a
later patch to the new nbd_sanitize_name.

Consideration was given to changing the assertion in
nbd_negotiate_send_rep_verr to instead merely log a server error and
truncate the message, to avoid leaving a latent path that could
trigger a future CVE DoS on any new error message.  However, this
merely complicates the code for something that is already (correctly)
flagging coding errors, and now that we are aware of the long message
pitfall, we are less likely to introduce such errors in the future,
which would make such error handling dead code.

Reported-by: Xueqiang Wei <xuwei@redhat.com>
CC: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
Fixes: 93676c88d7
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200610163741.3745251-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit 5c4fe018c025740fef4a0a4421e8162db0c3eefd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c               | 23 ++++++++++++++++++++---
 tests/qemu-iotests/143     |  4 ++++
 tests/qemu-iotests/143.out |  2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 02b1ed0801..20754e9ebc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -217,7 +217,7 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
 
     msg = g_strdup_vprintf(fmt, va);
     len = strlen(msg);
-    assert(len < 4096);
+    assert(len < NBD_MAX_STRING_SIZE);
     trace_nbd_negotiate_send_rep_err(msg);
     ret = nbd_negotiate_send_rep_len(client, type, len, errp);
     if (ret < 0) {
@@ -231,6 +231,19 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
     return 0;
 }
 
+/*
+ * Return a malloc'd copy of @name suitable for use in an error reply.
+ */
+static char *
+nbd_sanitize_name(const char *name)
+{
+    if (strnlen(name, 80) < 80) {
+        return g_strdup(name);
+    }
+    /* XXX Should we also try to sanitize any control characters? */
+    return g_strdup_printf("%.80s...", name);
+}
+
 /* Send an error reply.
  * Return -errno on error, 0 on success. */
 static int GCC_FMT_ATTR(4, 5)
@@ -595,9 +608,11 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
 
     exp = nbd_export_find(name);
     if (!exp) {
+        g_autofree char *sane_name = nbd_sanitize_name(name);
+
         return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_UNKNOWN,
                                           errp, "export '%s' not present",
-                                          name);
+                                          sane_name);
     }
 
     /* Don't bother sending NBD_INFO_NAME unless client requested it */
@@ -995,8 +1010,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
 
     meta->exp = nbd_export_find(export_name);
     if (meta->exp == NULL) {
+        g_autofree char *sane_name = nbd_sanitize_name(export_name);
+
         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
-                            "export '%s' not present", export_name);
+                            "export '%s' not present", sane_name);
     }
 
     ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index f649b36195..d2349903b1 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -58,6 +58,10 @@ _send_qemu_cmd $QEMU_HANDLE \
 $QEMU_IO_PROG -f raw -c quit \
     "nbd+unix:///no_such_export?socket=$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
+# Likewise, with longest possible name permitted in NBD protocol
+$QEMU_IO_PROG -f raw -c quit \
+    "nbd+unix:///$(printf %4096d 1 | tr ' ' a)?socket=$SOCK_DIR/nbd" 2>&1 \
+    | _filter_qemu_io | _filter_nbd | sed 's/aaaa*aa/aa--aa/'
 
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'quit' }" \
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 1f4001c601..fc9c0a761f 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -5,6 +5,8 @@ QA output created by 143
 {"return": {}}
 qemu-io: can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
+qemu-io: can't open device nbd+unix:///aa--aa1?socket=SOCK_DIR/nbd: Requested export not available
+server reported: export 'aa--aa...' not present
 { 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-- 
2.17.1


