Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8448C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B433620786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3QsKWRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B433620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDDQ-0003nZ-QZ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRJ-0004ww-55; Tue, 16 Jun 2020 10:19:49 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:45918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRH-00074J-6T; Tue, 16 Jun 2020 10:19:48 -0400
Received: by mail-oi1-x22a.google.com with SMTP id p70so19337016oic.12;
 Tue, 16 Jun 2020 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mW4tdTj2Ppv8pYdiGj+XU8GuYMAaamWNuvZU1/Njrmw=;
 b=k3QsKWRCaegqZ9QhSIKH6EbW+yvsSc7D3zoimAWBR1uwaqgs7stk3HNkPpnfkrCSsd
 4zO9Deq55UkQa9B3tpOSZmGgkCyMmdzJ9e55CI2E21k8BEUrTglhF4OfZXMwovWBiu2l
 bXhfk92wRqJs0m7Mf1/XSEOSCQbl7gJ1RcTJg5qmuHV0N8pEXXfq8F49Wk4l3g9S00Bm
 oOHdqk015XcrXqBNDnlY+lkBCeqgjiMMi6jvbIQEmQeKaOmTBNgsty/PrPi6ukww45n1
 DPoDnno82UAIMeliPTAIMLzBrb/yOPxJLq/zI/rCZitY6sN+qXtR6Kir/9tJq2znj3LN
 KNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=mW4tdTj2Ppv8pYdiGj+XU8GuYMAaamWNuvZU1/Njrmw=;
 b=g1tVLTodnbLZp77ydUNb3t6ys+CF1Ylrxp7W7sDbTmxzneI8yVMG1A1MzPsXLL7WB0
 UHx6eiuR4cVayFFcknozDjBG2umUOAcrk+PoqY1o8+jC3nvv8Z8o2SKkHubgKGQEt7GB
 3yzoQaIy3ERZNAgCzHvsjfBUaa4PexpLwPJzPnNqndF2k6J/rGiPwme74gOiALtQjpYk
 W8upQfqAedYqBtKOOZxk03eirbWpYG5v+j68OkxV4Jm6tZmLRWX4rlY64nDxPYWlIMnc
 MPzeYiESvM95yqpcd7SW6mh92WpDkqhIt9ZGAlylVvVqOY3EC7/IPaBr8uXt/xiZINYl
 XKWQ==
X-Gm-Message-State: AOAM531WGMEqfdyB3nhl3tDFAx3925zrUvsCoOJt23s3ZK6pY9Z1QOSw
 50QnHlyF2CClMsZkBZbzYLsblo+qG2g=
X-Google-Smtp-Source: ABdhPJyupdAEsnLLy7BnWdhtf1O0PI4eYXdIodvCzqyAJmnOwnBU3AWYDY6JLL9d4CMv5q5SSiVLvw==
X-Received: by 2002:aca:728f:: with SMTP id p137mr3668116oic.8.1592317185374; 
 Tue, 16 Jun 2020 07:19:45 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x10sm4038667oox.41.2020.06.16.07.19.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:44 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 78/78] block: Call attention to truncation of long NBD exports
Date: Tue, 16 Jun 2020 09:15:47 -0500
Message-Id: <20200616141547.24664-79-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Commit 93676c88 relaxed our NBD client code to request export names up
to the NBD protocol maximum of 4096 bytes without NUL terminator, even
though the block layer can't store anything longer than 4096 bytes
including NUL terminator for display to the user.  Since this means
there are some export names where we have to truncate things, we can
at least try to make the truncation a bit more obvious for the user.
Note that in spite of the truncated display name, we can still
communicate with an NBD server using such a long export name; this was
deemed nicer than refusing to even connect to such a server (since the
server may not be under our control, and since determining our actual
length limits gets tricky when nbd://host:port/export and
nbd+unix:///export?socket=/path are themselves variable-length
expansions beyond the export name but count towards the block layer
name length).

Reported-by: Xueqiang Wei <xuwei@redhat.com>
Fixes: https://bugzilla.redhat.com/1843684
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200610163741.3745251-3-eblake@redhat.com>
(cherry picked from commit 5c86bdf1208916ece0b87e1151c9b48ee54faa3e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c     |  7 +++++--
 block/nbd.c | 21 +++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 2e5e8b639a..19c25da305 100644
--- a/block.c
+++ b/block.c
@@ -6486,8 +6486,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
     } else {
         QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
-        snprintf(bs->filename, sizeof(bs->filename), "json:%s",
-                 qstring_get_str(json));
+        if (snprintf(bs->filename, sizeof(bs->filename), "json:%s",
+                     qstring_get_str(json)) >= sizeof(bs->filename)) {
+            /* Give user a hint if we truncated things. */
+            strcpy(bs->filename + sizeof(bs->filename) - 4, "...");
+        }
         qobject_unref(json);
     }
 }
diff --git a/block/nbd.c b/block/nbd.c
index 3d369fc8eb..eb380102c0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1971,6 +1971,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
     const char *host = NULL, *port = NULL, *path = NULL;
+    size_t len = 0;
 
     if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         const InetSocketAddress *inet = &s->saddr->u.inet;
@@ -1983,17 +1984,21 @@ static void nbd_refresh_filename(BlockDriverState *bs)
     } /* else can't represent as pseudo-filename */
 
     if (path && s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd+unix:///%s?socket=%s", s->export, path);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd+unix:///%s?socket=%s", s->export, path);
     } else if (path && !s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd+unix://?socket=%s", path);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd+unix://?socket=%s", path);
     } else if (host && s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd://%s:%s/%s", host, port, s->export);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd://%s:%s/%s", host, port, s->export);
     } else if (host && !s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd://%s:%s", host, port);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd://%s:%s", host, port);
+    }
+    if (len > sizeof(bs->exact_filename)) {
+        /* Name is too long to represent exactly, so leave it empty. */
+        bs->exact_filename[0] = '\0';
     }
 }
 
-- 
2.17.1


