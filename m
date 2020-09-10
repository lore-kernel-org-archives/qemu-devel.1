Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F64C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9F220BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtHyrs6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9F220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJuG-0002rq-Hd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrZ-0006h4-Hd; Thu, 10 Sep 2020 06:31:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrX-00034v-UY; Thu, 10 Sep 2020 06:31:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id m5so4001872pgj.9;
 Thu, 10 Sep 2020 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hrJEqDkxFKpoRhRzMOgEeJejUGbXqPW0+cFjCJrQlA0=;
 b=VtHyrs6W59+ZMPKsMatHUlP5LUz4ht3SgEbKjtYNX5I0OHoH6qmNChGGR4vcdAPT2b
 e3LUETCafApG4e0EUeuEFPx1uIDXC+CZsrLUIxeDANqGln/QEcT0sanfQrP8RGJ1E2bJ
 kn1GPUdME+0dX9tmLdETylGWWN5/WpAXUaYnGdrp1MtT6jFR721OVwRrjyJ6wogY0F9Q
 dfUs6guIP4rZmVPnywCv7VuEEy9ETYJW97B473C8Hlb3ecSMTRMvQIsaUNsn5EFIrqoS
 6+K5UYTZHB+6W1NYiIz5tGFKyI+Jb+sIkY0IpTqISmvy5zE7hnRX6TYdKeNBHG2V3Mxs
 BmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hrJEqDkxFKpoRhRzMOgEeJejUGbXqPW0+cFjCJrQlA0=;
 b=Z95zR27xdN/lUz5H1dRt8AqkFnYidtNFuVCN8owdpG3Za6OevgxXja7MoiMdHflydp
 S81fjerbz5C7uCQ7pznGsOAEAVvyGSYUrsydCQyxaPWJzUnqkeV2rpWcigjqNqQ2UGkh
 EQ7bfvNMAsZeOiq/1BdzlQZ64/V6hvvsRaZMZOEieArMPniZ0VtkaU0H2Sg9phtZHBti
 HOvEnZ0+UjZK5rcYgXXjY+q4IpMtsTy6GuMHka0GjpjYDS7rQw4fS1Fiutc1A+k8t8sS
 bDM9PwoIw5MX69QvHVqSVRVSa1VfOKYihyK46hSRlU1NrftuD9YbmPC7TucbAlDLRL8v
 W/Yw==
X-Gm-Message-State: AOAM533Ts8tFQV4u0sI8kHsQm3V3ZQa+MXWWZMbqp9vhuAIcWHT6F2Wc
 LG19KAPKTEdhworB4WyRSG55X5uzSD26JsbNpXs=
X-Google-Smtp-Source: ABdhPJwlDMV6t16kMXnhqrgL5W2pVpRNuK1hp9ODmj2VUBdU4RTrvvaR+Ae9IVjtr+KqnrMBv5dHIQ==
X-Received: by 2002:a05:6a00:2b1:: with SMTP id
 q17mr4723301pfs.74.1599733889567; 
 Thu, 10 Sep 2020 03:31:29 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:31:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/25] rcu: Implement drain_call_rcu
Date: Thu, 10 Sep 2020 18:30:36 +0800
Message-Id: <20200910103059.987-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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


