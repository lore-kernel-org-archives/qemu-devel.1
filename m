Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEB9C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870662067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKSMcsPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAfL-0000LH-2f
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWH-0003b5-7Z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWF-0004EK-Qq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:05 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWF-0004Dp-KJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id b6so3248440wrq.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=agawO6TXQ8QKofPYWK1JN+cVyKSPsslwSY+orcmanTg=;
 b=DKSMcsPgSjpTuZpo+8ShGEF30gQ/WwN0TeasPiEiXKoDNRo2SEZHm89bULv1+2eXmS
 gClbr+j+YtCx/lvwLELXCE8Wntz++78EPuyA988bgnX1Mn+oT5U+eXpZruAsMw1s/XaD
 1tIU67bbtgClEyanO+A6EkTSaf//usFGfp/mzvALpu/lSZ9yjIT6DR0KH6GP/E9uvj+e
 smJNZlBQZ0AeiCKhiUQobx+plrIjSyW9gLMLdUo5/VENSUFhkTWthwIYyvd8w9Zs35U1
 50Q+bbc4HT9aPg9Eg8rH8eQxlc+CmSpkLeq7pvAcPv+nStiktwKdkvodElTn7ROFR9e4
 neTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=agawO6TXQ8QKofPYWK1JN+cVyKSPsslwSY+orcmanTg=;
 b=SoAOt5ad0qkhzt3US6jjRnJmpNySRnWssnnEbnY3VrzYiMIdaJsPc1jp7EckjuRJjF
 7nqQZ4V+oKcuXiwqcbO7tTsW5ip43hjdsn/8gqIZzlB7wOhq0WwOAECZNAYJEBrMgRGq
 OR+v25T5GhZDA5qnUJ7i38DJJSiOtRvXS9AspU3TfqJntI73Oa1DckttrmMhuLF7/py6
 6ZWzdinWlfliPMSGqCadvnPDn137PSLTwYXf5zQA1WZTJfJ+0+0zycz/KVDKbZ3k4sle
 yhe+uivdOW9XPBa0tXTMqJhFjFsmHjHlv1GGpLy2Sp9pGrDG3oi2RYlTV+a5fDyp+NV4
 jcCQ==
X-Gm-Message-State: APjAAAVmcoco41vZEkFa5b+1F8cOXc1v140jV0FBSaCwRwDTMCDb947g
 vQ1A2hhdbe3Y2wR3UwdlDW96a+X3
X-Google-Smtp-Source: APXvYqwxR8dT45kjmEIyWjPVD9ZCaGrk+F8DCaYI37Ou+6lPMnLUXHGQGyEdczreTNHlD8M8YAWe3A==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr4116583wrr.309.1578486782175; 
 Wed, 08 Jan 2020 04:33:02 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] replay: record and replay random number sources
Date: Wed,  8 Jan 2020 13:32:22 +0100
Message-Id: <1578486775-52247-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

Record/replay feature of icount allows deterministic running of execution
scenarios. Some CPUs and peripheral devices read random numbers from
external sources making deterministic execution impossible.
This patch adds recording and replaying of random read operations
into guest-random module, which is used by the virtual hardware.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <157675984852.14505.15709141760677102489.stgit@pasha-Precision-3630-Tower>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/replay.txt          |  1 +
 include/sysemu/replay.h  |  7 +++++++
 replay/Makefile.objs     |  3 ++-
 replay/replay-internal.h |  2 ++
 replay/replay-random.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 replay/replay.c          |  2 +-
 stubs/replay.c           |  9 +++++++++
 util/guest-random.c      | 13 +++++++++++--
 8 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 replay/replay-random.c

diff --git a/docs/replay.txt b/docs/replay.txt
index ce97c3f..f4619a6 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -67,6 +67,7 @@ Modifications of qemu include:
  * network filter for recording and replaying the packets
  * block driver for making block layer deterministic
  * serial port input record and replay
+ * recording of random numbers obtained from the external sources
 
 Locking and thread synchronisation
 ----------------------------------
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8df5172..5471bb5 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -117,6 +117,13 @@ int64_t replay_read_clock(ReplayClockKind kind);
             ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
         : (value))
 
+/* Processing data from random generators */
+
+/* Saves the values from the random number generator */
+void replay_save_random(int ret, void *buf, size_t len);
+/* Loads the saved values for the random number generator */
+int replay_read_random(void *buf, size_t len);
+
 /* Events */
 
 /*! Called when qemu shutdown is requested. */
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index cee6539..939be96 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -6,4 +6,5 @@ common-obj-y += replay-input.o
 common-obj-y += replay-char.o
 common-obj-y += replay-snapshot.o
 common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
+common-obj-y += replay-audio.o
+common-obj-y += replay-random.o
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 55fca1a..33ac551 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -34,6 +34,8 @@ enum ReplayEvents {
     EVENT_AUDIO_OUT,
     /* for audio in event */
     EVENT_AUDIO_IN,
+    /* for random number generator */
+    EVENT_RANDOM,
     /* for clock read/writes */
     /* some of greater codes are reserved for clocks */
     EVENT_CLOCK,
diff --git a/replay/replay-random.c b/replay/replay-random.c
new file mode 100644
index 0000000..afc7a0f
--- /dev/null
+++ b/replay/replay-random.c
@@ -0,0 +1,44 @@
+/*
+ * replay-random.c
+ *
+ * Copyright (c) 2010-2020 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/replay.h"
+#include "replay-internal.h"
+
+void replay_save_random(int ret, void *buf, size_t len)
+{
+    g_assert(replay_mutex_locked());
+
+    replay_save_instructions();
+    replay_put_event(EVENT_RANDOM);
+    replay_put_dword(ret);
+    replay_put_array(buf, len);
+}
+
+int replay_read_random(void *buf, size_t len)
+{
+    int ret = 0;
+    g_assert(replay_mutex_locked());
+
+    replay_account_executed_instructions();
+    if (replay_next_event_is(EVENT_RANDOM)) {
+        size_t buf_size = 0;
+        ret = replay_get_dword();
+        replay_get_array(buf, &buf_size);
+        replay_finish_event();
+        g_assert(buf_size == len);
+    } else {
+        error_report("Missing random event in the replay log");
+        exit(1);
+    }
+    return ret;
+}
diff --git a/replay/replay.c b/replay/replay.c
index 5cc25bd..706c7b4 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02008
+#define REPLAY_VERSION              0xe02009
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
diff --git a/stubs/replay.c b/stubs/replay.c
index 10b3925..5974ec1 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -79,3 +79,12 @@ void replay_mutex_lock(void)
 void replay_mutex_unlock(void)
 {
 }
+
+void replay_save_random(int ret, void *buf, size_t len)
+{
+}
+
+int replay_read_random(void *buf, size_t len)
+{
+    return 0;
+}
diff --git a/util/guest-random.c b/util/guest-random.c
index 9453968..086115b 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #include "crypto/random.h"
+#include "sysemu/replay.h"
 
 
 static __thread GRand *thread_rand;
@@ -44,13 +45,21 @@ static int glib_random_bytes(void *buf, size_t len)
 
 int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
 {
+    int ret;
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        return replay_read_random(buf, len);
+    }
     if (unlikely(deterministic)) {
         /* Deterministic implementation using Glib's Mersenne Twister.  */
-        return glib_random_bytes(buf, len);
+        ret = glib_random_bytes(buf, len);
     } else {
         /* Non-deterministic implementation using crypto routines.  */
-        return qcrypto_random_bytes(buf, len, errp);
+        ret = qcrypto_random_bytes(buf, len, errp);
+    }
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        replay_save_random(ret, buf, len);
     }
+    return ret;
 }
 
 void qemu_guest_getrandom_nofail(void *buf, size_t len)
-- 
1.8.3.1



