Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF49C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F73C206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQxVVthB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F73C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwfh-0002oQ-Dp
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKq-00036x-VV; Thu, 03 Sep 2020 16:59:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKo-0007Kc-Is; Thu, 03 Sep 2020 16:59:56 -0400
Received: by mail-ot1-x32b.google.com with SMTP id h17so3206982otr.1;
 Thu, 03 Sep 2020 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ATS4oJGp1SnQFEtm6D13xyOuW3gjvEjZ49ChbnGmBj8=;
 b=JQxVVthBAM6VrGy8C3f9nic65DczEc46Cp9V5Mxu9hHcIaAzgf3RF8UyJWXRsOylti
 w52+X25sFLaBe1s5DDbW3LOQO/irfcvkIE5dfsIZsZDwyjqmXloET4xRdlRHORGOFGTA
 EsFZheMmslq1k5gtJZsgsQLWQUxuf9hoi0gwJBCwkEKjRyQQ+4GeLlCh1ZOV1lMnxILk
 fLQX2Gass9MS1jvGyp4JJcF7ZCwDaQv63/iuzJ9HDwP7b/+nzCQpcgbtKMRh3QLnJXST
 9b1WS2smuJn++llMPS8eo0cue3R0UG9AZFrZlSUvi6bsBO3aunokKYZzVy7lkrH2ICeQ
 thRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ATS4oJGp1SnQFEtm6D13xyOuW3gjvEjZ49ChbnGmBj8=;
 b=jIc9G/4JgEhQudfXmf/8KiAmQyPiVjf4502W0q5kXbU+Lo0cZMUw3OXM8kOPohpfdv
 Sv+JmUlmNm3J++ASMygOfuSg2fLJ+bzhpjtTvovMOxeiWE15rtEIBDihqVq8X0ZOFplB
 634b0vj8TrXtQyraaZcQpRXjQId23n3RHr43NelNLwLeb5ZkqB+nYNfb7/xnTGtwbkHB
 isSBbUDCE5hhMc/MfeaQDPJ7Zun6l32+06g7fiQOjoPBdOVC+ZnM8uyIqurlpzSiIK0e
 xGb6B524J9BGJzRVTB+TvPL9gTcnFHIkG8RCgiin0J3bk4mCDYRtg1Yf+zygBO/NiN8F
 fE8g==
X-Gm-Message-State: AOAM533iOjQ0dt9PZKFxHumJ93dLY9rIGKFU/W6YnPPHvI0+fof9UVhY
 Wq9zFUgeAfdwHsA+1KBoOkAnZeEqE24=
X-Google-Smtp-Source: ABdhPJz6clO8z8h2N8WRpMaGoGVhsHkrTNj3w8kjPgBbKmmcFKwMVlZrHox9qCdNgaGeF2EhAkUhZw==
X-Received: by 2002:a05:6830:20d1:: with SMTP id
 z17mr3131709otq.179.1599166791772; 
 Thu, 03 Sep 2020 13:59:51 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r33sm828082ooi.48.2020.09.03.13.59.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:51 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/77] block: Call attention to truncation of long NBD exports
Date: Thu,  3 Sep 2020 15:58:28 -0500
Message-Id: <20200903205935.27832-11-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32b.google.com
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
index 2e3905c99e..e7e0a92536 100644
--- a/block.c
+++ b/block.c
@@ -6710,8 +6710,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
index 2160859f64..bfc0be6af6 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1986,6 +1986,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
     const char *host = NULL, *port = NULL, *path = NULL;
+    size_t len = 0;
 
     if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         const InetSocketAddress *inet = &s->saddr->u.inet;
@@ -1998,17 +1999,21 @@ static void nbd_refresh_filename(BlockDriverState *bs)
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


