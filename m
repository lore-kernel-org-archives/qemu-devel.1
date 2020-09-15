Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DBA2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ1StaBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DBA2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIA0f-0002zF-FC
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qE-0000TF-BT; Tue, 15 Sep 2020 08:13:47 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qC-00088x-EN; Tue, 15 Sep 2020 08:13:46 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so1238554plt.9;
 Tue, 15 Sep 2020 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hrJEqDkxFKpoRhRzMOgEeJejUGbXqPW0+cFjCJrQlA0=;
 b=GJ1StaBr/nZdQchwU/7KeA7/NzcOt0HN5hJLx1Kbbhh6vaoV2oM7Make5Pwx5Wqh0s
 cJXJgAwi6Cv4Y1PArVIl+BxCaLGtVpZFnmEOjdQQY1JPXNrnLqVZKMUhM9n/oMTpIl27
 0mVvzpzst0iJqZmhGiZiC+naauOy4A04VQkbbmwuyzuRU+fABqkHaGWyj6lipSwJYmVP
 EqAdRLRFY1dFwcKx/3jR9ws18Tj9nzcfI0+BsSeQUrvzpKEZqcK+gXpDZlYfYeAayUmW
 s5cnOGKbKjQ6enQdCIwqOOkvBe7DTxSg91nrZdSNilW1SyUAdnCPKbWFnbjwasocuKvO
 6BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hrJEqDkxFKpoRhRzMOgEeJejUGbXqPW0+cFjCJrQlA0=;
 b=PGfV9PqsHKA7ytDzgAnTMelhNyIcB29ICzj9SkY6n62gM6aSS4oXkx3/MUemc8viUB
 lyXwJFGRbbsfEjKDP/LGR9I4HS4RZ7UMvXbdKR21KhkHXj0FP9aF61SOSaVTMtW8lEBF
 daVfVdu4geWiI33STIV8c3pQred2MkcjQkgHjAx0xRqT0GEyGiFNpFu7WN87Im77Tt5J
 S4tJnIaSVj0TEJSX9MLKCRnEHCa40n9WbzW/Rup0gchL1KTH4r3pABB33iALLvlzKaTj
 nXeBl00PX6XduZ3IeYQnuKugYNAcR9gnGsi+maCKlWC+NgkvkbhdNUN+dBaUyl5JPZMs
 IoTQ==
X-Gm-Message-State: AOAM5320Tsc37LgNeCJD0qt3JvlehM+pD+1R6KJASHdOZUzp5txGSDCj
 lJbkTj8LQVP/kFBIFYx9zfbojuMGMi77WJIe2Ek=
X-Google-Smtp-Source: ABdhPJwmjqGvN4a+j3C220iTzyKPgVJJria+iIneKlGbcg1aJmnxM3IeYRl2ySuay3yttnhKKhZUrg==
X-Received: by 2002:a17:902:d714:b029:d0:cbe1:e7a2 with SMTP id
 w20-20020a170902d714b02900d0cbe1e7a2mr18447239ply.19.1600172022299; 
 Tue, 15 Sep 2020 05:13:42 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:13:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/26] rcu: Implement drain_call_rcu
Date: Tue, 15 Sep 2020 20:12:53 +0800
Message-Id: <20200915121318.247-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This will allow is to preserve the semantics of hmp_device_del,
that the device is deleted immediatly which was changed by previos
patch that delayed this to RCU callback

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/rcu.h |  1 +
 util/rcu.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 570aa603eb..0e375ebe13 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -133,6 +133,7 @@ struct rcu_head {
 };
 
 extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
+extern void drain_call_rcu(void);
 
 /* The operands of the minus operator must have the same type,
  * which must be the one that we specify in the cast.
diff --git a/util/rcu.c b/util/rcu.c
index 60a37f72c3..c4fefa9333 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -293,6 +293,61 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
     qemu_event_set(&rcu_call_ready_event);
 }
 
+
+struct rcu_drain {
+    struct rcu_head rcu;
+    QemuEvent drain_complete_event;
+};
+
+static void drain_rcu_callback(struct rcu_head *node)
+{
+    struct rcu_drain *event = (struct rcu_drain *)node;
+    qemu_event_set(&event->drain_complete_event);
+}
+
+/*
+ * This function ensures that all pending RCU callbacks
+ * on the current thread are done executing
+
+ * drops big qemu lock during the wait to allow RCU thread
+ * to process the callbacks
+ *
+ */
+
+void drain_call_rcu(void)
+{
+    struct rcu_drain rcu_drain;
+    bool locked = qemu_mutex_iothread_locked();
+
+    memset(&rcu_drain, 0, sizeof(struct rcu_drain));
+    qemu_event_init(&rcu_drain.drain_complete_event, false);
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
+
+
+    /*
+     * RCU callbacks are invoked in the same order as in which they
+     * are registered, thus we can be sure that when 'drain_rcu_callback'
+     * is called, all RCU callbacks that were registered on this thread
+     * prior to calling this function are completed.
+     *
+     * Note that since we have only one global queue of the RCU callbacks,
+     * we also end up waiting for most of RCU callbacks that were registered
+     * on the other threads, but this is a side effect that shoudn't be
+     * assumed.
+     */
+
+    call_rcu1(&rcu_drain.rcu, drain_rcu_callback);
+    qemu_event_wait(&rcu_drain.drain_complete_event);
+
+    if (locked) {
+        qemu_mutex_lock_iothread();
+    }
+
+}
+
 void rcu_register_thread(void)
 {
     assert(rcu_reader.ctr == 0);
-- 
2.28.0.windows.1


