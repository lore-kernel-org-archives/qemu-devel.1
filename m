Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56220C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1711E206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WctLj0Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1711E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwdl-0006kf-9j
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLb-0004Q8-FZ; Thu, 03 Sep 2020 17:00:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLZ-0007jt-Fb; Thu, 03 Sep 2020 17:00:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id 109so4028038otv.3;
 Thu, 03 Sep 2020 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w38XkoSgsQCl7EMizVOYfGqy/RlUpRR6kLGOQ4mK540=;
 b=WctLj0Tzmm7OSN6rFyOOc08/0rtC0gkGyYOYq/7Lkjowvog6BRvqwxHO/wrzr43UD0
 0BUtlihlHOrbJyURvAsDkTsFcVv+FIlkKnhi46AsWHd7I3LDwiDtz8bheBDA5r3gVpuV
 4QXyRWei/TGZhyKlYnmK26B+Hpe/i1MoDdZXVAA9SCTAkeP03dapcUq8iTMVxQt0oLEH
 5j3POIKhIZsmBklCTU827VRyxQ+6oGTE4DziPVVJJ+RFXyG/eH4Snh9sHEDdAtHs2/3w
 t+EFCKRL1nuCf75zfhMJZyrA3QLJxzd7j6bkzSMCC+VrrHCBIFn8UxM5q2GkD5r3sYlc
 IR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w38XkoSgsQCl7EMizVOYfGqy/RlUpRR6kLGOQ4mK540=;
 b=aMK9HUlNoJ/nX4qHbJl7bSCz2zleEGsu007oJ/t/ViG9HUQm1entZGQfl9Jsc7UcON
 TPAM3dTH2JRNElZDvB3JSxHagMB8m+NpE1XzVHAJtzjYSyy4fWYRdNHiS7ot0CRr0nLu
 l4cxe7hOhEdS2PWq6xPQttwQIPOs3lzEPuEURwQ27GFLegbUDkzKPrcyQor/1zZ3d9M3
 x7ATUH+jJBEuPBfrVxr2OcA0cR/aAzWXkXVCp57XP55lrHXwHdi/4WM94RUtn1R+FRDW
 jz9roqI1DkHm6j5p3mrrH0ZbUTtOng76HYUbdI40oWUQQbyK9HGCpwS3pvPEwLtYLF3P
 SsXA==
X-Gm-Message-State: AOAM532nwhGIJ8T6YjbIzLsTnnsQuNgOKqyp4AEjSoR0zt9mHGky8wIZ
 YYRQKcsusoy+Ikb3luZwCwc7MRWabQ4=
X-Google-Smtp-Source: ABdhPJzROkcKW7j6E4/CwBa/8Vw6+TmqoRbTrkljvPDFaaPKFXJLBF9dxYHVi+tpDrFY2eepmyCDGA==
X-Received: by 2002:a05:6830:1242:: with SMTP id
 s2mr2940375otp.167.1599166839691; 
 Thu, 03 Sep 2020 14:00:39 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g26sm775467otn.77.2020.09.03.14.00.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:39 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/77] qga: Use qemu_get_host_name() instead of
 g_get_host_name()
Date: Thu,  3 Sep 2020 15:59:02 -0500
Message-Id: <20200903205935.27832-45-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

Problem with g_get_host_name() is that on the first call it saves
the hostname into a global variable and from then on, every
subsequent call returns the saved hostname. Even if the hostname
changes. This doesn't play nicely with guest agent, because if
the hostname is acquired before the guest is set up (e.g. on the
first boot, or before DHCP) we will report old, invalid hostname.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit 0d3a8f32b1e0eca279da1b0cc793efc7250c3daf)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index efc8b90281..d3fec807c1 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -515,11 +515,20 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result = NULL;
-    gchar const *hostname = g_get_host_name();
-    if (hostname != NULL) {
-        result = g_new0(GuestHostName, 1);
-        result->host_name = g_strdup(hostname);
+    g_autofree char *hostname = qemu_get_host_name(errp);
+
+    /*
+     * We want to avoid using g_get_host_name() because that
+     * caches the result and we wouldn't reflect changes in the
+     * host name.
+     */
+
+    if (!hostname) {
+        hostname = g_strdup("localhost");
     }
+
+    result = g_new0(GuestHostName, 1);
+    result->host_name = g_steal_pointer(&hostname);
     return result;
 }
 
-- 
2.17.1


