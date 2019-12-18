Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB7B206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8zLeZhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB7B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYu6-0006MG-Sz
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3v-0007O0-Fx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3t-0003Zw-B0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3t-0003Wx-11
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:17 -0500
Received: by mail-wr1-x441.google.com with SMTP id j42so1975432wrj.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YpJua1nbXfmWc7u8N3DBv+ySntOx6HMwLCHAHrE1P9g=;
 b=Y8zLeZhMXuV6LESFo43F7ppdRQTj0tlpPmttnlNqhdDRS2Q44UNVS5093K/V8GD2Et
 g4KCGgmNOICwy8slW0GFd9Rqt8VRcHGyf6R7BvLA9jDA9H6TlIZoXsrVBkHNhjpG6lGy
 LCKu+UlzCRNQ3ZvHBcQQ83IjK+4OVysfkJ/ri4TwX+44p8/UWi9/afMtQjEBuO2Ufh1G
 S8daZa9aFpiJxSd2dc21lCDasZwjtF/oU1iQCsy0fpFjMqPc8K/mp14Ni14PlhFkPpMP
 RgMWNRA9z39qjXG+0waAgUlKg1WY49B59BEgyNQJbVpVc+jiBLsQ6qYBPUGfgOXklhiW
 GJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=YpJua1nbXfmWc7u8N3DBv+ySntOx6HMwLCHAHrE1P9g=;
 b=d1oN0a40UFG8iv15ZcYnaxcv19/1sOvWRxVvQzJLVXMCZM7cZNf4XHM66Gi/ilJwkX
 82qxqbxEQlObgsFNU/EPtpD5I4HRlm9ucTJS22eVOprp5ie4U6l2AKYAkKj5kHpKbVzY
 hvrEiaM3HNWJPX3eO5SMMNyetEU/x7xnshXUCMYw1hTlsaA7FFeVY/dOzAjRONC3VgFE
 J2Qyy2t8nh2gCOPEHcDtDS3nrfpSrd9yq8BOntqibg4g/m832I5EW/DrUv6IYMZ/S1IJ
 gXCXj+h0WJ68rSlZMAsy8v1tr39UTidP6guyyGUAeBxhbTE2HFZhwkTqcbphcZA6AvyN
 REYw==
X-Gm-Message-State: APjAAAVTqnhdjp8QGOoxyD4b2Vb584TScJMJE1b2TUJrWuWCpZcBCxAE
 CgmLXJmBErL4t5G8ldhy9rvul7m6
X-Google-Smtp-Source: APXvYqya2I6NXy72fHMxn0RkQnK2PkVGtLNQGFYrpvm+mMhU8sJYlKv4RIAU/XT4sB+SyZ0+5MPXjQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr2351075wru.99.1576670655834;
 Wed, 18 Dec 2019 04:04:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 73/87] migration: check length directly to make sure the range
 is aligned
Date: Wed, 18 Dec 2019 13:02:39 +0100
Message-Id: <1576670573-48048-74-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Since the start addr is already checked, to make sure the range is
aligned, checking the length is enough.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190712032704.7826-1-richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index a34c348..dfe2096 100644
--- a/exec.c
+++ b/exec.c
@@ -3901,10 +3901,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 
     if ((start + length) <= rb->used_length) {
         bool need_madvise, need_fallocate;
-        uint8_t *host_endaddr = host_startaddr + length;
-        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
-            error_report("ram_block_discard_range: Unaligned end address: %p",
-                         host_endaddr);
+        if (length & (rb->page_size - 1)) {
+            error_report("ram_block_discard_range: Unaligned length: %zx",
+                         length);
             goto err;
         }
 
-- 
1.8.3.1



