Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 08:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965F220732
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="entXNAAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965F220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNBiG-00070a-OC
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 04:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1jNBhK-0006Rz-RU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 04:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1jNBhJ-0004GN-QP
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 04:41:06 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:35552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1jNBhJ-0004FX-MY
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 04:41:05 -0400
Received: by mail-qv1-xf42.google.com with SMTP id q73so2036731qvq.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qd6ivzJhpKuUM9jOWDPPjJJBiAr849NUJJ4FrjgcF9o=;
 b=entXNAAZroEoQhs/CzzztM+5GwdH3fX4pC+H0Dl+jQzwc4iZmL42oMuRlpn9Eqyu5Q
 Q/Dy3H8/QqED7KsocfNUEpORgfs8Qi95qONyU7gzBruTYWErnHZH5gtptZKNaTKY7joN
 jk3Ym1rtZe8hVXZ874mUGMYXp7VC5p69QomgFyL9G2noohDoZVrDPnnZiPa8mwz2KPE8
 dgfuJuNQfoc3uF0kNGoS8A+0E+nzGGvn0H/+XNlzvAiXqxUBUluoy3/qkrX1UtcRulgi
 RCVXOw3HWoF9DduVC9uOYnReuFa3fQnPmVVEGf/lxUp+Y0bo3NVaUVmSQ2J5YwV0r3J3
 2vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qd6ivzJhpKuUM9jOWDPPjJJBiAr849NUJJ4FrjgcF9o=;
 b=q1lldqr/koqG/S9HxiFs+QWmW2ftGn52gg1upwaa/nAOl7WHDcp66lcqaKX8htdUIl
 WdCNgXjW15JXxxrCA4vl6lxsznHnvBo60VLRV/Jd2xKUu0v8yN0ZNOt75gHT/EQsygMo
 o6001O4BdmrLkap61p+Km0kRpFDCJAEWPusDNymQlBIf3JJM5AGR+v9ww/vyGvB4hJBQ
 0a2osvnIOZ7nM9SkkTwQvvtdsRBBbUSAnIoxgWSw2ZJ5wOe+L9+qwYZzIN3rd6owKM1V
 W3Q307FobdfnnZjycWueb8ok2y5+zqQFIxlB4Ne2nnImu4oXhWiErkW1k0GfuXmTkxJY
 1agQ==
X-Gm-Message-State: AGi0PuYvr+u3oPed7s+ABU856znGEUY3VjNDdpStLqzH3MgMezhVab6p
 MvaiyIUmQzoz7OiwOx523BU=
X-Google-Smtp-Source: APiQypIKNiAHJU+6p5f4cLhixnZ0FitMHrjFZYCyG4sTHz5dl8hVQJj2zvlAB0lUKi1/724hmyNeRw==
X-Received: by 2002:a05:6214:1863:: with SMTP id
 eh3mr8769912qvb.71.1586594465225; 
 Sat, 11 Apr 2020 01:41:05 -0700 (PDT)
Received: from host.localdomain ([104.129.187.94])
 by smtp.gmail.com with ESMTPSA id l22sm3443217qkj.120.2020.04.11.01.41.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 11 Apr 2020 01:41:04 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] virtiofsd/passthrough_ll: don't remove O_DIRECT when
 cache=none
Date: Sat, 11 Apr 2020 04:35:44 -0400
Message-Id: <1586594144-24605-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586585997-24446-1-git-send-email-catherine.hecx@gmail.com>
References: <1586585997-24446-1-git-send-email-catherine.hecx@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: Catherine Ho <catherine.hecx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cache=none means to bypass host cache. So we can't remove O_DIRECT flag in
unconditionally in update_open_flags();

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
v2: Fix to keep flags unchanged if cache=none, otherwise changed the file
    without O_DIRECT incorrectly.
 tools/virtiofsd/passthrough_ll.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 4c35c95..59e64dd 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1677,7 +1677,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
     fuse_reply_err(req, 0);
 }
 
-static void update_open_flags(int writeback, struct fuse_file_info *fi)
+static void update_open_flags(int writeback, int cache_mode,
+                              struct fuse_file_info *fi)
 {
     /*
      * With writeback cache, kernel may send read requests even
@@ -1702,10 +1703,11 @@ static void update_open_flags(int writeback, struct fuse_file_info *fi)
 
     /*
      * O_DIRECT in guest should not necessarily mean bypassing page
-     * cache on host as well. If somebody needs that behavior, it
-     * probably should be a configuration knob in daemon.
+     * cache on host as well. If cache=none, keep the flag unchanged
      */
-    fi->flags &= ~O_DIRECT;
+    if (cache_mode != CACHE_NONE) {
+        fi->flags &= ~O_DIRECT;
+    }
 }
 
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1737,7 +1739,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out;
     }
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->cache, fi);
 
     fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
                 mode);
@@ -1947,7 +1949,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
     fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
              fi->flags);
 
-    update_open_flags(lo->writeback, fi);
+    update_open_flags(lo->writeback, lo->cache, fi);
 
     sprintf(buf, "%i", lo_fd(req, ino));
     fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
-- 
1.7.1


