Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FCAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 02:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F192077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 02:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igOm3Dy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F192077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3A0h-0002Px-JY
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 22:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <renyime@gmail.com>) id 1i39zR-0001aw-Ah
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1i39zQ-0001Or-7E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:16:45 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1i39zQ-0001OW-1t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 22:16:44 -0400
Received: by mail-pf1-x441.google.com with SMTP id y9so995483pfl.4
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 19:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rpJiFNtVBZf46LBvl66xUeKwwhdxxSngiM3KlKxLWPw=;
 b=igOm3Dy2tGNCy6DN37YYvK6V8M6whUyftWArRuz8klGSD4drFGBm/2oBGxvK1UJbHX
 yt/Gw1IKkr1xTFQp1UopRqEveUH8ud9b9RwG32gdJfmMVrZNGg1IfayabibkcoafTUoM
 CtGfoWs+GWIF4qgaefnIKOfvDGniZiMZrDODCG3gGyba36xNgI7U7zPeWhoJDHBqYjHd
 s+jy3QijpaleQBBBD5lltO9o1L+rR332RssvnqBbhRy6vWG1vLZNpOu+H3fUNA9UXgwL
 5aZ8IX3WVdqQmTV6pVTedcSz+Lo+QDzyIbO6cP7ROwT76D0b9SmVkCf4teG8Z6y4svS8
 HveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rpJiFNtVBZf46LBvl66xUeKwwhdxxSngiM3KlKxLWPw=;
 b=A7l7M6oMkvvTu6hvqFMVAlCL6xlUU62hGxoIJjOj/O9VVGqDHheHkmDMhZY+Ce1+wC
 FG2c0xyaUl1xqFOixsuowz8r79i+7fa0z/68Ryy9vxeBCIZ78FFB2pYzW5/BSCwpSPRQ
 n0DkumtAveyDIW4JW8AciOApcUdZvR53n3X//JFJKu5Y/r4c5IcBVNdgAVkIh/mp3hs+
 lxXg2A/kdfTVWn/+Du8pGqPX/IgNxvp4RrROzxwzKPi4pkdOl/DcuUlTGwdpuGdpeVP/
 xbvqPErRdQAKnqpQhQHWsidRhu6tgJIxIBk4SxjI2wUP/pzexgJsMnnQJfBDTALo+BxL
 adAw==
X-Gm-Message-State: APjAAAWB5OVVESfelRFMPiLYgp6NwIv8IBxmKqz9PwulFxLiL9NlIecO
 n7gEjen3bY8IxrNAGRtcims=
X-Google-Smtp-Source: APXvYqyJFliZDMsb1F6t0BUO+3QEJTdj+6ktrLQw2V4As7bFJ++E1Q5Ig+zjY0xaGjwMB23syS9pkg==
X-Received: by 2002:a63:221f:: with SMTP id i31mr6251689pgi.251.1567045002187; 
 Wed, 28 Aug 2019 19:16:42 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id x128sm786038pfd.52.2019.08.28.19.16.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 19:16:41 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Thu, 29 Aug 2019 10:16:36 +0800
Message-Id: <1567044996-2362-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH] migration: multifd_send_thread always post
 p->sem_sync when error happen
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

From: Ivan Ren <ivanren@tencent.com>

When encounter error, multifd_send_thread should always notify who pay
attention to it before exit. Otherwise it may block migration_thread
at multifd_send_sync_main forever.

Error as follow:
-------------------------------------------------------------------------------
 (gdb) bt
 #0  0x00007f4d669dfa0b in do_futex_wait.constprop.1 () from /lib64/libpthread.so.0
 #1  0x00007f4d669dfa9f in __new_sem_wait_slow.constprop.0 () from /lib64/libpthread.so.0
 #2  0x00007f4d669dfb3b in sem_wait@@GLIBC_2.2.5 () from /lib64/libpthread.so.0
 #3  0x0000562ccf0a5614 in qemu_sem_wait (sem=sem@entry=0x562cd1b698e8) at util/qemu-thread-posix.c:319
 #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=<optimized out>) at /qemu/migration/ram.c:1099
 #5  0x0000562ccecb95f4 in ram_save_iterate (f=0x562cd0ecc000, opaque=<optimized out>) at /qemu/migration/ram.c:3550
 #6  0x0000562ccef43c23 in qemu_savevm_state_iterate (f=0x562cd0ecc000, postcopy=false) at migration/savevm.c:1189
 #7  0x0000562ccef3dcf3 in migration_iteration_run (s=0x562cd09fabf0) at migration/migration.c:3131
 #8  migration_thread (opaque=opaque@entry=0x562cd09fabf0) at migration/migration.c:3258
 #9  0x0000562ccf0a4c26 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:502
 #10 0x00007f4d669d9e25 in start_thread () from /lib64/libpthread.so.0
 #11 0x00007f4d6670635d in clone () from /lib64/libc.so.6
 (gdb) f 4
 #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=<optimized out>) at /qemu/migration/ram.c:1099
 1099	        qemu_sem_wait(&p->sem_sync);
 (gdb) list
 1094	    }
 1095	    for (i = 0; i < migrate_multifd_channels(); i++) {
 1096	        MultiFDSendParams *p = &multifd_send_state->params[i];
 1097
 1098	        trace_multifd_send_sync_main_wait(p->id);
 1099	        qemu_sem_wait(&p->sem_sync);
 1100	    }
 1101	    trace_multifd_send_sync_main(multifd_send_state->packet_num);
 1102	}
 1103
 (gdb) p i
 $1 = 0
 (gdb)  p multifd_send_state->params[0].pending_job
 $2 = 2    //It means the job before MULTIFD_FLAG_SYNC has already fail
 (gdb)  p multifd_send_state->params[0].quit
 $3 = true

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b01a37e7ca..0047286b7e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1112,6 +1112,7 @@ static void *multifd_send_thread(void *opaque)
     rcu_register_thread();
 
     if (multifd_send_initial_packet(p, &local_err) < 0) {
+        ret = -1;
         goto out;
     }
     /* initial packet */
@@ -1179,9 +1180,7 @@ out:
      * who pay attention to me.
      */
     if (ret != 0) {
-        if (flags & MULTIFD_FLAG_SYNC) {
-            qemu_sem_post(&p->sem_sync);
-        }
+        qemu_sem_post(&p->sem_sync);
         qemu_sem_post(&multifd_send_state->channels_ready);
     }
 
-- 
2.17.2 (Apple Git-113)


