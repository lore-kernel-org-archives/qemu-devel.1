Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE6AC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470572465D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLxckoe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470572465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05M6-0000bY-G2
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058K-0000wL-JE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058J-0004D6-BW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058J-00047j-3I
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so2869375wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=20w7i9jiAm5hvyfwFIkzlqbRcfX9RLZbq6NcYeukZyY=;
 b=OLxckoe3p/ZV52/++8NBWwJliB6tjTDM7yc0RH2OX4Wutq0kcWEFI1ohBipqxVjeRj
 DLZ14vPK1pUv9xrG3Ni1fGdTJgbDoSl5Ic09YpiYJFvyp/wfpwZWGsP2uhDjHjghj6Az
 k+p3PTKVBPDlMj6k5qbhVGZ1hjpf5JN6ABTtzz6S1O4vnQ5eguAczP4wTt57N7AgocUf
 zn62knDIgt5wFA7SXOfZfLSOaaUnRVgz6IN0H0wWUTJ29RUN6ybt5zmyb15qt+yYmxPb
 fS+sTqjgjlQqrxFJeVbMpF12Kx/m1jlbiqgmrGAvy0Bdae4CnE5GpHMWH201757AEEpt
 Hhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=20w7i9jiAm5hvyfwFIkzlqbRcfX9RLZbq6NcYeukZyY=;
 b=UJjlxpNEXXR82YibifaBWhawMTzHWxjMm1XiC5Z8wLMkGf/O9Zpc7QGMbTrBM5EWYS
 tohjlVewGddZahIyCGx65Jv8SkEGSSxI5m073i2P5Rje0i62S39CMBkoaocuLcZNv/b0
 +5xoaHqypZfIVrbSHzWCqU6gkAuaiMM0faNffdiYdPxI6/3r90tQZRHVQeFsUImxmLto
 sGiJ66OqK5o8CaRnA37b8MpUErXsFB64swNwzGfHfB/UFbic2Nsi5rjRgvtcsDgec/O9
 jdZQ+urpp9vcr4SvrDQLmB/f2mEl4m6pAdYVxxLYjxdUWvxiQapRxeHw9RM0h//Wmrw2
 Q7Mg==
X-Gm-Message-State: APjAAAVJ5p/HRnr84WVnXT0m0kZgycd5NnNkBwsuI7w04Uzb8gJNFc+L
 iHEZI8RxdRdjV/axBAof0kJdaA==
X-Google-Smtp-Source: APXvYqwXNo0U8bhZTQ5u7VKINr4aWxa83nVQ2jiIacW88D7c3jN+q99h2VKAB0Pc3dYZ6whUEtkq0Q==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr4819763wmm.98.1581087686129; 
 Fri, 07 Feb 2020 07:01:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s22sm3535449wmh.4.2020.02.07.07.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:23 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CAAE1FF92;
 Fri,  7 Feb 2020 15:01:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/5] tests/plugins: make howvec clean-up after itself.
Date: Fri,  7 Feb 2020 15:01:18 +0000
Message-Id: <20200207150118.23007-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
References: <20200207150118.23007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG plugins are responsible for their own memory usage and although
the plugin_exit is tied to the end of execution in this case it is
still poor practice. Ensure we delete the hash table and related data
when we are done to be a good plugin citizen.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/howvec.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 4ca555e1239..7b77403559d 100644
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
@@ -213,12 +220,15 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         g_list_free(it);
     }
 
+    g_list_free(counts);
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


