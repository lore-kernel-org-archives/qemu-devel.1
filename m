Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF5EC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB7D206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7E1HqtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB7D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsKnF-00084w-SA
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 01:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hsKlm-00051Q-3z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hsKll-0005w1-47
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:33:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hsKlk-0005vU-Rv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:33:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id m30so29219364pff.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QCrnLyFX7GeHT2VIRx05q972prI8iELjQsvih+xloI8=;
 b=h7E1HqtPtdT0GpdqvCtKcc6loo74OBs9naMBaLlTa1WZw/l2waSyuLmqmUmey+mWIA
 DEzsSsHXO/ky8/8oyXQ7ZvagRGrPQTqR/MLsm5RChaJwPbq2KMKdblHwg4KCIv0JhCmh
 XMLownw9lAZvYiIKVJdX4tXoCas9TpZium+7LuN0VvL97orkBxQ3BiddOLo82UrAbA9v
 JD8Gla35Jpdzsa/XlBX8SXAKo7fxe8Zdo/BQeo3xzEhPcV6NlFZq1Q8AWmehxy6L/LZR
 NbYiveiC+1k6RDXUrtrbA/zOtstrIKlH6x6oZ6Vh6f/KZYAXvkWz0StPSwOXy9WrRHbS
 b/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QCrnLyFX7GeHT2VIRx05q972prI8iELjQsvih+xloI8=;
 b=JDP1XOlgPHz21mlnei/+pdAMC/R4GKiFoPuuaYpkd0O/sSPDlG4UUxfEzGsnZ9cn87
 lnB13t5lIrjGJO4AJMKV4udJ/QnFilU4SNU2bQjypUYlFCmgYBA4V1Pzuh9/2ToNkbL8
 ji02QNX+lBuOjgg88e3KQefpj/m/Vw7/RmX7TvfhZ0GdJ7tTtcvqJRdzQd+4+lunpb4W
 tD0ifq5oYz4xcfM9YkRyg/MfR+Do9qwe38CTmZQr23e+NRigVQIhzTQXM3hjz+m1FvIE
 +pFmgdWT2fTNXI8Gjb6AP3JEsImIMAineyYL9YRSvDLw1CQP1iIn4onUpLQ27sEwh699
 MGhQ==
X-Gm-Message-State: APjAAAVkrm+da/JZDM9yRA//T82KK94/N05mJMWonftK/a8vgdy2cPJ+
 7eZCpI2KZ7nw0a3L93lcLvM=
X-Google-Smtp-Source: APXvYqyo3q9ZyovKHkwL4lSoeWHxcYNlG9l/+uHRHcaZYRwNCWHOWjDjknEWALdFzYbIpmRWlonnZw==
X-Received: by 2002:a63:4a51:: with SMTP id
 j17mr107209791pgl.284.1564464831920; 
 Mon, 29 Jul 2019 22:33:51 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id 11sm64055886pfw.33.2019.07.29.22.33.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 22:33:51 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 30 Jul 2019 13:33:36 +0800
Message-Id: <1564464816-21804-4-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564464816-21804-1-git-send-email-ivanren@tencent.com>
References: <1564464816-21804-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH v3 3/3] migration: update ram_counters for
 multifd sync packet
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
Cc: richardw.yang@linux.intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

Multifd sync will send MULTIFD_FLAG_SYNC flag info to destination, add
these bytes to ram_counters record.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 88ddd2bbe2..20b6eebb7c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1085,6 +1085,8 @@ static void multifd_send_sync_main(RAMState *rs)
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
         qemu_file_update_transfer(rs->f, p->packet_len);
+        ram_counters.multifd_bytes += p->packet_len;
+        ram_counters.transferred += p->packet_len;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
-- 
2.17.2 (Apple Git-113)


