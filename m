Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E309521BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfxU2eZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E309521BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL57y-00010c-TE
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kL53b-0006TN-Kq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:43:39 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kL53Z-0006kH-MC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:43:39 -0400
Received: by mail-pj1-x1043.google.com with SMTP id bw23so3260711pjb.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mlj9cUThfStSxOeamWcckuElNU4KqcGiJ5DV0gO0hxc=;
 b=tfxU2eZWY6wPSA5qAsojzcUDl8bD/gKXfvgV1Trw3pMdJx1wbXXBaTxwS7A6/ciIdF
 8RgNRL7ch6usuq9t+WQB/eS5PWijC43f071pFA8+pyAA2Ih6su5JJIzDcjZeSNOpGDoC
 HiZpOpGK0OAEoRlFqWyIAyvYShFRAf3kxP9iNpYC4AuRdut2ZEC/Ih/DQG/LV89gEEwy
 AbZtEwlj4k04b7Lbw0WqMltlWXFk0Jy7JXGsqYl+kQjZUHybHrW/q0uedU/fV2bhn7QJ
 +4crM+p7l9+fTTFcFKVtiUe9lfWzLSdKZSt2JeGIW9KxXOLUyt9wy1Nyv8Spcg0iKgNT
 0vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mlj9cUThfStSxOeamWcckuElNU4KqcGiJ5DV0gO0hxc=;
 b=rxS7J8wFMSowas2bY1+prGTYfuwXcaiYyuugAVQeHHLafTXSvdD6AeS9ncujUFGQVo
 hJkCkeXry1JBnrSopwx9K82KK18lGOui+JAywIkTi2edWFK6WLSEbk9FY0SbsQyJZtkF
 4EDnlgmqjQHDTocww+Xj3EbMPyEubzpqtksUz1riDi48U7IAgdYrK8n6Fr7co0W1K4jn
 9uvRonTn4TElcwFo8gD5ozp5WBQNa7q+U8zkK+j9oq4wky1W9NbFCNf5wqWhHwhFSF9u
 tfFxL0UiHKq8vN2qyBqaqga5jTrB7bRUuQLO3xx2hYMMNRMg3xpkcn1d/OP9YEyzJOYT
 w2sg==
X-Gm-Message-State: AOAM533yam74wd6zy1vq3tGNgBvjweidAnIkC9Ijx9V0q28NqzY4Z6Ux
 PG9P7KDq22wtH3tichDjG7rV4iMpbSY=
X-Google-Smtp-Source: ABdhPJyElXbHs2CnRVi5EK5n9Wv1LEnp1iyAWpaDh7B358I9EZC57pRYD7dQgZb9z1WZBHQp8pK/7A==
X-Received: by 2002:a17:90a:dc13:: with SMTP id
 i19mr8529318pjv.18.1600868612659; 
 Wed, 23 Sep 2020 06:43:32 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.139])
 by smtp.googlemail.com with ESMTPSA id b18sm18232930pfr.4.2020.09.23.06.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 06:43:32 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb: Use lock guard macros
Date: Wed, 23 Sep 2020 19:13:27 +0530
Message-Id: <20200923134327.576139-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Amey Narkhede <ameynarkhede03@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use qemu LOCK_GUARD macros from "qemu/lockable.h" in
hw/usb/ccid-card-emulated.c, saves manual unlock calls.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 hw/usb/ccid-card-emulated.c | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 3083124556..7ee3563f89 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -30,6 +30,7 @@
 #include <libcacard.h>

 #include "qemu/thread.h"
+#include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ccid.h"
@@ -243,34 +244,34 @@ static void *handle_apdu_thread(void* arg)
             card->quit_apdu_thread = 0; /* debugging */
             break;
         }
-        qemu_mutex_lock(&card->vreader_mutex);
-        while (!QSIMPLEQ_EMPTY(&card->guest_apdu_list)) {
-            event = QSIMPLEQ_FIRST(&card->guest_apdu_list);
-            assert((unsigned long)event > 1000);
-            QSIMPLEQ_REMOVE_HEAD(&card->guest_apdu_list, entry);
-            if (event->p.data.type != EMUL_GUEST_APDU) {
-                DPRINTF(card, 1, "unexpected message in handle_apdu_thread\n");
-                g_free(event);
-                continue;
-            }
-            if (card->reader == NULL) {
-                DPRINTF(card, 1, "reader is NULL\n");
+        WITH_QEMU_LOCK_GUARD(&card->vreader_mutex) {
+            while (!QSIMPLEQ_EMPTY(&card->guest_apdu_list)) {
+                event = QSIMPLEQ_FIRST(&card->guest_apdu_list);
+                assert((unsigned long)event > 1000);
+                QSIMPLEQ_REMOVE_HEAD(&card->guest_apdu_list, entry);
+                if (event->p.data.type != EMUL_GUEST_APDU) {
+                    DPRINTF(card, 1, "unexpected message in handle_apdu_thread\n");
+                    g_free(event);
+                    continue;
+                }
+                if (card->reader == NULL) {
+                    DPRINTF(card, 1, "reader is NULL\n");
+                    g_free(event);
+                    continue;
+                }
+                recv_len = sizeof(recv_data);
+                reader_status = vreader_xfr_bytes(card->reader,
+                        event->p.data.data, event->p.data.len,
+                        recv_data, &recv_len);
+                DPRINTF(card, 2, "got back apdu of length %d\n", recv_len);
+                if (reader_status == VREADER_OK) {
+                    emulated_push_response_apdu(card, recv_data, recv_len);
+                } else {
+                    emulated_push_error(card, reader_status);
+                }
                 g_free(event);
-                continue;
             }
-            recv_len = sizeof(recv_data);
-            reader_status = vreader_xfr_bytes(card->reader,
-                    event->p.data.data, event->p.data.len,
-                    recv_data, &recv_len);
-            DPRINTF(card, 2, "got back apdu of length %d\n", recv_len);
-            if (reader_status == VREADER_OK) {
-                emulated_push_response_apdu(card, recv_data, recv_len);
-            } else {
-                emulated_push_error(card, reader_status);
-            }
-            g_free(event);
         }
-        qemu_mutex_unlock(&card->vreader_mutex);
     }
     return NULL;
 }
@@ -365,7 +366,7 @@ static void card_event_handler(EventNotifier *notifier)
     EmulEvent *event, *next;

     event_notifier_test_and_clear(&card->notifier);
-    qemu_mutex_lock(&card->event_list_mutex);
+    QEMU_LOCK_GUARD(&card->event_list_mutex);
     QSIMPLEQ_FOREACH_SAFE(event, &card->event_list, entry, next) {
         DPRINTF(card, 2, "event %s\n", emul_event_to_string(event->p.gen.type));
         switch (event->p.gen.type) {
@@ -398,7 +399,6 @@ static void card_event_handler(EventNotifier *notifier)
         g_free(event);
     }
     QSIMPLEQ_INIT(&card->event_list);
-    qemu_mutex_unlock(&card->event_list_mutex);
 }

 static int init_event_notifier(EmulatedState *card, Error **errp)
--
2.28.0

