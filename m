Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EE1C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9843520872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="DoyjAtpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9843520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK7T-0003Q2-P5
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGK6k-0002GU-Fi
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:47:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGK6h-0004xj-Vr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:47:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id s2so2836795pjr.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UZ3usPZQMy5X6Hme0WfoonfrWOf+pic6zqR1s5SrtwE=;
 b=DoyjAtpPHQ1XTzjMrbnIBTknbpQh78XNnLTz54LixlHXhpzyUwgIzGYn3u8R9iMmBF
 siqiK8FLgnzbwkzMjwhEJr9ocP/0A5cd7HVjqFwBghYXq4yffGL3FYi31klBf4pTaKS1
 2np/xlVGbZRshbbCadygQkyAG0Jz+tZitE5d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UZ3usPZQMy5X6Hme0WfoonfrWOf+pic6zqR1s5SrtwE=;
 b=Z8cTKOqDYFYt/A35dAGEHwyOH5RuBMG4HvVWTP4h3d2uO3GYfBYGX59VGQIhwNMDUc
 sODf9Xqtu6AS91ox1nrm5+uBPXi/XJIIlqvPpGpjFjfiM/6EjOtADqF28g3d6V/80KqN
 sWYfp2OqJ4EwjDGbWLGWFm3A0BALTMur85NMqAT70JsOTnGpTuNmEQ4z7GohuI+z0dZ+
 Roj2jLAsvAZd+EjY1C9hflusxOtPW0kcecwWuTmVnEcyXXoLa/dvTKh4Llm3elOjxsPU
 rNRpC+RzlupiO1E3F2DmSS4Lhj+foqi2FfKxWOgD2bZ+P+e+H9xBRaAFX+BLaBQMY1eD
 ZJYA==
X-Gm-Message-State: AOAM532RnzEUQ0irMpGj/VPJIEnlXINcBUeIZnfvDl22s+W8gv/bzbXD
 4cumOkfFN2+4VN3CZRca8Vm8oVqcBteiFaKf
X-Google-Smtp-Source: ABdhPJx6Poo5lFTmOURBD7yj7GgBQC7S5BbQ5geZNvLkbAEVeGJeAZ3gT6SMJ6pPSRWFAXrI6xW3vQ==
X-Received: by 2002:a17:90b:93:: with SMTP id
 bb19mr4780966pjb.162.1599734829820; 
 Thu, 10 Sep 2020 03:47:09 -0700 (PDT)
Received: from localhost.localdomain (125-227-154-100.HINET-IP.hinet.net.
 [125.227.154.100])
 by smtp.googlemail.com with ESMTPSA id 31sm4783840pgs.59.2020.09.10.03.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:47:09 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
Date: Thu, 10 Sep 2020 10:46:50 +0000
Message-Id: <20200910104650.1182807-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910104650.1182807-1-dereksu@qnap.com>
References: <20200910104650.1182807-1-dereksu@qnap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=dereksu@qnap.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Derek Su <dereksu@qnap.com>, zhang.zhanghailiang@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In secondary side, the colo_flush_ram_cache() calls
migration_bitmap_find_dirty() to finding the dirty pages and
flush them to host. But ram_state's ram_bulk_stage flag is always
enabled in secondary side, it leads to the whole ram pages copy
instead of only dirty pages.

Here, the ram_bulk_stage in secondary side is disabled in the
preparation of COLO incoming process to avoid the whole dirty
ram pages flush.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 migration/colo.c |  6 +++++-
 migration/ram.c  | 10 ++++++++++
 migration/ram.h  |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..6e644db306 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -844,6 +844,8 @@ void *colo_process_incoming_thread(void *opaque)
         return NULL;
     }
 
+    colo_disable_ram_bulk_stage();
+
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -873,7 +875,7 @@ void *colo_process_incoming_thread(void *opaque)
         goto out;
     }
 #else
-        abort();
+    abort();
 #endif
     vm_start();
     trace_colo_vm_state_change("stop", "run");
@@ -924,6 +926,8 @@ out:
         qemu_fclose(fb);
     }
 
+    colo_enable_ram_bulk_stage();
+
     /* Hope this not to be too long to loop here */
     qemu_sem_wait(&mis->colo_incoming_sem);
     qemu_sem_destroy(&mis->colo_incoming_sem);
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee5d5..65e9b12058 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3357,6 +3357,16 @@ static bool postcopy_is_running(void)
     return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
 }
 
+void colo_enable_ram_bulk_stage(void)
+{
+    ram_state->ram_bulk_stage = true;
+}
+
+void colo_disable_ram_bulk_stage(void)
+{
+    ram_state->ram_bulk_stage = false;
+}
+
 /*
  * Flush content of RAM cache into SVM's memory.
  * Only flush the pages that be dirtied by PVM or SVM or both.
diff --git a/migration/ram.h b/migration/ram.h
index 2eeaacfa13..c1c0ebbe0f 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -69,4 +69,7 @@ void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
 
+void colo_enable_ram_bulk_stage(void);
+void colo_disable_ram_bulk_stage(void);
+
 #endif
-- 
2.25.1


