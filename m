Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E8AC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894C4206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8KhjgAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894C4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwbM-0003NE-DM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLa-0004Mz-41; Thu, 03 Sep 2020 17:00:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLY-0007jb-6c; Thu, 03 Sep 2020 17:00:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id u126so4474601oif.13;
 Thu, 03 Sep 2020 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OpNReXfR7oEtNGXMqeGl3rFAqgl3SKXekjVzKbcaap8=;
 b=X8KhjgAbb4mcyWsWM15dzaDEfKZHO8Exg1yGbftCeOLnjppv6RkKEHg3Fq0Ng8GuXw
 HkfVdc0WcYo2DBcJ81JEfqA9Hy5zopID/K1WIoQiT+YcybKTT6UWtI4H8vuS8Pu4utSh
 mwUtd68qWL7dO8U8+lZOED0Nk21KgniqcSbb1PTqOTV3ansddAwortYzzyeiJBhVDtEP
 Grl7/r0fLgf++bY8ZZDSp1kLesJtKdBiawBAzFM+Spb//1qNYxxDX4XkjbLY46Y+VAZB
 7hnI7rxkhfe55/eX6sI07EMk/IN2zLuLcPYC8PgCSdi2ZAcxi5a/4mK3+o4P0UNYHsX3
 s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OpNReXfR7oEtNGXMqeGl3rFAqgl3SKXekjVzKbcaap8=;
 b=FkM3uN+dIGYXrZ4Ie1AO8f1vuszOvmFoKtxIpMfm5XKsiuQpRolq6ZsS6hCs6AqIZN
 iIpXY9j4km1sB3cDZ9O8kQgZGHxW+vfc5Uvr1UG6O/vgo7e3WGPgS+EHXLp4a/zwlicY
 XScgxfMbj31QOC1xU4uVGYYkaLwqt+PFY1Kh2koZmGt4k84uOTQsgoBWpZadaIdpiB4+
 FU139nenaqWYaNqjtEmyYX/N38AkKUDNJPMsd+tB3cilarKODq6PuH6kVlq6lIwcM667
 f6U6Bi+F7tYPxq5Jqcc8JpR7vsaJF5yDmvdBkbbZ2Gd3J/vixA2qPWjeHOztcd7Mm7w2
 sTGw==
X-Gm-Message-State: AOAM53181gkhxwUcu8wazE9DLlvQG5gQsL9S7gsjOhse1MAHsOUGkNQ+
 JcenrhwY95NTCEGiWmnoTVdVFXYMmBs=
X-Google-Smtp-Source: ABdhPJzk9sJOMiX65whUn5idLaP3rbh3WnjTOymLIAZO6JUDSHEHKQ8xYXyrBz1vN4DDokgF7FEJaA==
X-Received: by 2002:aca:c4cb:: with SMTP id u194mr3216387oif.106.1599166838308; 
 Thu, 03 Sep 2020 14:00:38 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g22sm777201ots.35.2020.09.03.14.00.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:37 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/77] util: Introduce qemu_get_host_name()
Date: Thu,  3 Sep 2020 15:59:01 -0500
Message-Id: <20200903205935.27832-44-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
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

This function offers operating system agnostic way to fetch host
name. It is implemented for both POSIX-like and Windows systems.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit e47f4765afcab2b78dfa5b0115abf64d1d49a5d3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 util/oslib-posix.c   | 35 +++++++++++++++++++++++++++++++++++
 util/oslib-win32.c   | 13 +++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20f5c5f197..1866cab3c5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -607,4 +607,14 @@ static inline void qemu_reset_optind(void)
 #endif
 }
 
+/**
+ * qemu_get_host_name:
+ * @errp: Error object
+ *
+ * Operating system agnostic way of querying host name.
+ *
+ * Returns allocated hostname (caller should free), NULL on failure.
+ */
+char *qemu_get_host_name(Error **errp);
+
 #endif
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..e58fbc8e00 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -752,3 +752,38 @@ void sigaction_invoke(struct sigaction *action,
     }
     action->sa_sigaction(info->ssi_signo, &si, NULL);
 }
+
+#ifndef HOST_NAME_MAX
+# ifdef _POSIX_HOST_NAME_MAX
+#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
+# else
+#  define HOST_NAME_MAX 255
+# endif
+#endif
+
+char *qemu_get_host_name(Error **errp)
+{
+    long len = -1;
+    g_autofree char *hostname = NULL;
+
+#ifdef _SC_HOST_NAME_MAX
+    len = sysconf(_SC_HOST_NAME_MAX);
+#endif /* _SC_HOST_NAME_MAX */
+
+    if (len < 0) {
+        len = HOST_NAME_MAX;
+    }
+
+    /* Unfortunately, gethostname() below does not guarantee a
+     * NULL terminated string. Therefore, allocate one byte more
+     * to be sure. */
+    hostname = g_new0(char, len + 1);
+
+    if (gethostname(hostname, len) < 0) {
+        error_setg_errno(errp, errno,
+                         "cannot get hostname");
+        return NULL;
+    }
+
+    return g_steal_pointer(&hostname);
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab178..3b49d27297 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -808,3 +808,16 @@ bool qemu_write_pidfile(const char *filename, Error **errp)
     }
     return true;
 }
+
+char *qemu_get_host_name(Error **errp)
+{
+    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
+    DWORD size = G_N_ELEMENTS(tmp);
+
+    if (GetComputerNameW(tmp, &size) == 0) {
+        error_setg_win32(errp, GetLastError(), "failed close handle");
+        return NULL;
+    }
+
+    return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
+}
-- 
2.17.1


