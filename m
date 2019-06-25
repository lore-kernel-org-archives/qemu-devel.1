Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C9C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E6B2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqOZALO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E6B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflnV-0005A0-Iy
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hflLD-0001b4-ET
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hflLC-0007N5-C0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:31 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hflLC-0007MW-50
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:30 -0400
Received: by mail-pl1-x643.google.com with SMTP id bi6so8836240plb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+79mAr/7Gf0QAGwn8jdzz/emVw6D7Ys9kqIb4RtqpPA=;
 b=JqOZALO1Juwb7JyBzK6EP5Yx+/dDKgjl2LyjylpMKaPcIh9dQJkYP1PaQO5leyOSYy
 6sxQlheubiS/mricv0RNgtCLv4zJPR6crbHDC7PieSD7U8tl5K3om0cOgt0vk186tB5b
 TaTurwOAPlIRnB8fXwlZ62e2iSvdjJjd4IjchAeup1Iwlh/ndmIjbvtI3ldtIkAUHERM
 gyJgYvAlIbS3X+eUG0qJU7VjKOfhIZTrBWy1qYBEFRyRldQxp4Kr6ix/YSzGEh3IlpB0
 5z9t4iZJ7p6qo2BZx/GZ/oG0z5ntIGexjMlCKtvDpjZYzVEovP3DFevvOf7IsPTHeBlA
 qRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+79mAr/7Gf0QAGwn8jdzz/emVw6D7Ys9kqIb4RtqpPA=;
 b=piGL8kVijHLXnq/JFglucoN6QR1zw5LlbnpS2AhgWc4rIBWnzLTbbt+RHdpI6p5iTR
 0yVlfuvnD6QyBD0+NvHeEoaMsvokIk3wDRFBFmzkle5FbXijKspTUQfEHUjCDoOAKc19
 y9sRxEYXh0EQ7FVQOCl/0IwTIt1//3qUdmJ/1DaWiibZ71WE3AYfRLO1QpmRO2cigvjJ
 lFirzsZ1qYmg79h5pH6N1zegnDFVagjdMrjfCV8UuBRNCRfehyNwJALzvy7zfjWPv12L
 zhkm1iQ76y57/xvQdVBvrC/yS7RTWLkkxU/YWOaQJXjQt+HteoiSYgmnhsXp3IhvH9uW
 S1Ng==
X-Gm-Message-State: APjAAAVRR1Bjhz9HGmswYppjcMhhhFI+9YP0ni6osAVCkhKzekvwFjFv
 R7EPwQQ5+15K9a+Rc8vEFaTU466FLMJ6ezhY
X-Google-Smtp-Source: APXvYqwj+LQR12XsU1rHs7fyRwOhj5+NX6C3Ud951nbg9AzcNh1JvUxPrSSMVsFBScZbPJi3h5PUgQ==
X-Received: by 2002:a17:902:e6:: with SMTP id
 a93mr112356342pla.175.1561468709319; 
 Tue, 25 Jun 2019 06:18:29 -0700 (PDT)
Received: from VM_64_241_centos.localdomain ([129.226.57.92])
 by smtp.gmail.com with ESMTPSA id f186sm15675814pfb.5.2019.06.25.06.18.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 06:18:28 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 25 Jun 2019 21:18:19 +0800
Message-Id: <1561468699-9819-4-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 3/3] migration: fix migrate_cancel multifd
 migration leads destination hung forever
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When migrate_cancel a multifd migration, if run sequence like this:

        [source]                              [destination]

multifd_send_sync_main[finish]
                                    multifd_recv_thread wait &p->sem_sync
shutdown to_dst_file
                                    detect error from_src_file
send  RAM_SAVE_FLAG_EOS[fail]       [no chance to run multifd_recv_sync_main]
                                    multifd_load_cleanup
                                    join multifd receive thread forever

will lead destination qemu hung at following stack:

pthread_join
qemu_thread_join
multifd_load_cleanup
process_incoming_migration_co
coroutine_trampoline

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index e4eb9c441f..504c8ccb03 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1291,6 +1291,11 @@ int multifd_load_cleanup(Error **errp)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         if (p->running) {
+            /*
+             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
+             * however try to wakeup it without harm in cleanup phase.
+             */
+            qemu_sem_post(&p->sem_sync);
             qemu_thread_join(&p->thread);
         }
         object_unref(OBJECT(p->c));
-- 
2.17.2 (Apple Git-113)


