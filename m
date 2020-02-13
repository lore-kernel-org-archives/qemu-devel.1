Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE70B20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HETjkqaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NUx-0004TA-UT
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTV-0002PN-Jg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTU-0002T2-4v
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NTT-0002Qg-TZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:48 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q9so8070047wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=py9bcDZz909NEUPFg69hhSHq8thghQZDr3PiUGhEcOg=;
 b=HETjkqaCsZnbseyYwDHmOQypUJuhl3zS5WaQLTWTJL5QazZy0NBdJRmUtTpAkewGaK
 SVUbV9uNQlt8Z+AOsDo/ZJ9DFRASPWFWjILsSZo7u98tWhCLn0yLg0OKUsgP4lriIh+8
 Xf1CAwBF9Q4b3X3Vo/C8OIXRoT6Cn1iFi9IO455MxPKYN1sJfD6AuYuZ4W6ipwUqr0y/
 7MhQFyN2B31x/uoRr2MiPaop/7YZ6UzxsR6YoIQNLwH4DjfGc/hGIxUcgjxIvHnLE6LW
 lXimG0kez3PmHttEOXn4GYM36yigxqoLvOE/0ebbQqGlnOpgod8e7bo8Dh08qObk+jUK
 hu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=py9bcDZz909NEUPFg69hhSHq8thghQZDr3PiUGhEcOg=;
 b=RaAZDwE/f3HaPANDJlTTUSIxbB8EG2zpPRyFb3CmIutQSAWOm9c042gm2Ktw2yfy8l
 njg3cjb5FyzA0Zq12W/1wvmS9hvJoZwVuszPsyp+Gi9Ym/9vw3aBu/JsMlya/4+TtNLm
 qM8wwSGqioZGvO2RbPIRoEIbQ4ek94Sl1DqfmpK5N3Y2otzKX14w7w84EwNqEVPS43mq
 aCJEFKEOQ1ybNRZY0BGCILI3q7NiNspwPoaGsyLen91H3P5IhBpsbr2jzcKcbuHZBQ8/
 7kME+flc94+w4GjFmDOH/T6ApTX9OixGGsYl4uP89AJImCNr7xjxBUaEZswxPGmTaN6K
 J9WQ==
X-Gm-Message-State: APjAAAXKQwnd/7EuBAcmaPWB6fPaHWW+TRKmwzCa8O7vw8MATo6e5xOB
 GLiWBjGZ/Fqg9xt0MfS0c8HFfw==
X-Google-Smtp-Source: APXvYqzRizH25M2LRBGja+qk2XzA6wzbXAaCCmIxS9okVyW+WFRMLBLei6/2ls+4gBGcELD9LySPeQ==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr337769wmj.27.1581634846542;
 Thu, 13 Feb 2020 15:00:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a9sm4612064wmm.15.2020.02.13.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:00:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED62F1FF9F;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 15/19] tests/plugins: make howvec clean-up after itself.
Date: Thu, 13 Feb 2020 22:51:05 +0000
Message-Id: <20200213225109.13120-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG plugins are responsible for their own memory usage and although
the plugin_exit is tied to the end of execution in this case it is
still poor practice. Ensure we delete the hash table and related data
when we are done to be a good plugin citizen.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - re-use counts for g_list_sort() as it modifies list
  - drop it list

squash! tests/plugins: make howvec clean-up after itself.
---
 tests/plugin/howvec.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 4ca555e1239..3b9a6939f23 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -163,6 +163,13 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
     return ea->count > eb->count ? -1 : 1;
 }
 
+static void free_record(gpointer data)
+{
+    InsnExecCount *rec = (InsnExecCount *) data;
+    g_free(rec->insn);
+    g_free(rec);
+}
+
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("Instruction Classes:\n");
@@ -195,30 +202,31 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     counts = g_hash_table_get_values(insns);
     if (counts && g_list_next(counts)) {
-        GList *it;
-
         g_string_append_printf(report,"Individual Instructions:\n");
+        counts = g_list_sort(counts, cmp_exec_count);
 
-        it = g_list_sort(counts, cmp_exec_count);
-
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
-            InsnExecCount *rec = (InsnExecCount *) it->data;
-            g_string_append_printf(report, "Instr: %-24s\t(%ld hits)\t(op=%#08x/%s)\n",
+        for (i = 0; i < limit && g_list_next(counts);
+             i++, counts = g_list_next(counts)) {
+            InsnExecCount *rec = (InsnExecCount *) counts->data;
+            g_string_append_printf(report,
+                                   "Instr: %-24s\t(%ld hits)\t(op=%#08x/%s)\n",
                                    rec->insn,
                                    rec->count,
                                    rec->opcode,
                                    rec->class ?
                                    rec->class->class : "un-categorised");
         }
-        g_list_free(it);
+        g_list_free(counts);
     }
 
+    g_hash_table_destroy(insns);
+
     qemu_plugin_outs(report->str);
 }
 
 static void plugin_init(void)
 {
-    insns = g_hash_table_new(NULL, g_direct_equal);
+    insns = g_hash_table_new_full(NULL, g_direct_equal, NULL, &free_record);
 }
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
-- 
2.20.1


