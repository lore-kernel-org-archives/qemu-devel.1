Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A102CC76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECDC20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHMhxfnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECDC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZm8-0003sK-0Z
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlK-0000vl-RY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlJ-0006CM-Pc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlJ-0006C9-Ji
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id p184so10037688pfp.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wPqs8L4AEA0rcGYgmc6N0qNsLBP0T+Vh12xM4e8iNf0=;
 b=PHMhxfnA0KdpMf6rxJlb/kMjukfX5Fxh6SEa5x3lOnkoBykm9OMcTmlD0HqKSd2oPf
 QMWUVTdIo0FYcBCb6YqQE2H9LtW0aMT2AkAbQG9xhQcrOE0N+KDlV87WuzTqevkCmiUC
 gpHCKNsbguZfOsI0RpGhGZvWc270C2YVJqAqruHw9G5mQWKMLUC2Wvgbq0Hqb7lRIUti
 lyPPaKgmJSc5LcDKk0ZesiHvanzYfWc5elI3GzFIdO8JejgmKdYaiUaKaltYhrKYMU7D
 jS7r++5w6qhxCrH8O/PBUnH7Rsb8i8txPgPSkZJRuytI6On8sB+VEvNItQx7pk6jPOje
 Tkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wPqs8L4AEA0rcGYgmc6N0qNsLBP0T+Vh12xM4e8iNf0=;
 b=eHoVqJ3ASnNkXgRVG1Helvq/2dnk5pkTaW6Liofxv9dRKPgLQyvwQiqF5qNxhHqzH7
 OJeU2BIELro4ay1S4AUx3JYVm3VqxmNGwSldmawUnj36x6tHZ/ZjSpziOiH5iz9C9c5S
 4KN/t/Hh12eUvDTfxpCRmUR/cCNmok7uv1vqJwb8GjpzcdJg+sCi8XMatQ+n/9V7ABoE
 NuQowqZuTDMJJapN0GNcBmOZL8cD6kCgwSGCtVybxTsXKLYjGxcUVi1TD5obIpkDbwoI
 8FoiIEzTNhJBSHf1PQ7V63X1QDrc3+DkUOq80TzslT1C844ddCzlLPcCD4mqNf9Tl7dx
 nQVg==
X-Gm-Message-State: APjAAAUDBsPfFm8x261C0hi+0qOO+QvghcCKUyTgAkvfUA6IEP0hMM8A
 Db+eBzspuw00aKhAloiQ6lEjBFih
X-Google-Smtp-Source: APXvYqxEV2u/v/IBFX7RU0658qeRULWsM5fDxflLiY9dwodedPIWceeDzlErfTac4GfBkdencRxjQQ==
X-Received: by 2002:a17:90a:8c92:: with SMTP id
 b18mr39831215pjo.97.1563330824296; 
 Tue, 16 Jul 2019 19:33:44 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:43 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:04 +0800
Message-Id: <20190717023310.197246-6-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v14 05/11] qemu_thread: supplement error
 handling for h_resize_hpt_prepare
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Add a local_err to hold the error, and return the corresponding
error code to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Fei Li <fli@suse.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_hcall.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index d64b634526..c9de3c0204 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -448,6 +448,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     SpaprPendingHpt *pending = spapr->pending_hpt;
     uint64_t current_ram_size;
     int rc;
+    Error *local_err = NULL;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -508,10 +509,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->shift = shift;
     pending->ret = H_HARDWARE;
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending,
-                       QEMU_THREAD_DETACHED, &error_abort);
+    if (qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
+                           hpt_prepare_thread, pending,
+                           QEMU_THREAD_DETACHED, &local_err) < 0) {
+        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
+        g_free(pending);
+        return H_HARDWARE;
+    }
 
     spapr->pending_hpt = pending;
 
-- 
2.11.0


