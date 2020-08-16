Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F84C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 17:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C930920708
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOTfaRUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C930920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Mko-0001dw-4U
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duboisj@gmail.com>)
 id 1k7Mjs-00010a-Rq; Sun, 16 Aug 2020 13:46:36 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <duboisj@gmail.com>)
 id 1k7Mjq-0001pq-1R; Sun, 16 Aug 2020 13:46:36 -0400
Received: by mail-io1-xd41.google.com with SMTP id g19so15399199ioh.8;
 Sun, 16 Aug 2020 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kgFG4OuRUVY8jfu20p/rmn2M6K7fE9N8kFx4N9NUlKc=;
 b=VOTfaRUf+I9dDf7rSckjRdqAuGWVR4g2ay/vngO6AjJsJtjqamFVVKHL6AATv0r9CV
 q+fEmzGW1Bn8x2khWm6zxfy1CsrCzo9OxFDsjR9xbvAWXmKpCM3lVGh6uvTQWjRpt6sW
 5UrjIAQKey/Zn+4ljjgPGtMyMfDSKnDOSDqQT6CGVqGI1YJqWbGcfNW/CLFiognKPiqO
 zQ+5ofUo5g2LdBLdGy0gBdBHSJEJQ+BwomiKSaEH/CrIqBjHbx/oxIf+j9dsZ9OZU4Dg
 H7qAY+r8V4do2XdEpd+w5heIG43BDuuQW41TqZKoelUTC17ljW5GsxTxhWyscKQx0fwE
 zYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kgFG4OuRUVY8jfu20p/rmn2M6K7fE9N8kFx4N9NUlKc=;
 b=pvrVE/lT7EbjboRhIP4yQO7UnengaEq/koONuOdbFMJE9GR+XP/UQQELndAI+2gb2A
 fNIGFEqnZKvQ7L/RanHF5JTUQk0jBPDQhM0BmuEsIMzFLxKS7JJ3rcB10RrwJyMJ7uEC
 fegcawG+y8ohBm6FgmYHbz0rCabloC9TLNgW5GIgdoj9XNRZRDWyXMchY8SEXwXqeUJM
 BGf0rETHSI689W/hhTqWPTuEPYOHqymHKiL/9SRQ1jzTsEe9i+XOC8FLDxs/IRCHVFHf
 LkZiRCp+2AYZ7bZaC/sAzZjxzhLkD8vCAHiZc4u9kTPHvmG2VWKuMRGUKH/MVg70G7N5
 E43A==
X-Gm-Message-State: AOAM530fQtNB+lw3KGcteHcmEssmSajB4iRcPTqPJvX/+rJiKP9gaC+s
 /VyQxxXQXkIB02ooGPi7o2n1fiiGUe7qtAyp
X-Google-Smtp-Source: ABdhPJzjkY56BxygBYrUd9Clz4N0iXaK4knYhz0ZVuTDiNOf94/g52DAuQc7QaQooGjDwsCtfvhaXw==
X-Received: by 2002:a05:6638:12c4:: with SMTP id
 v4mr10713227jas.11.1597599991677; 
 Sun, 16 Aug 2020 10:46:31 -0700 (PDT)
Received: from localhost.localdomain (50-93-248-134.fttp.usinternet.com.
 [50.93.248.134])
 by smtp.gmail.com with ESMTPSA id x2sm7654667iom.14.2020.08.16.10.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2020 10:46:30 -0700 (PDT)
From: duboisj@gmail.com
X-Google-Original-From: josh@joshdubois.com
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] trace/simple: Enable tracing on startup only if the user
 specifies a trace option
Date: Sun, 16 Aug 2020 12:46:10 -0500
Message-Id: <20200816174610.20253-1-josh@joshdubois.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=duboisj@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: armbru@redhat.com, Josh DuBois <josh@joshdubois.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh DuBois <josh@joshdubois.com>

Tracing can be enabled at the command line or via the
monitor. Command-line trace options are recorded during
trace_opt_parse(), but tracing is not enabled until the various
front-ends later call trace_init_file(). If the user passes a trace
option on the command-line, remember that and enable tracing during
trace_init_file().  Otherwise, trace_init_file() should record the
trace file specified by the frontend and avoid enabling traces
until the user requests them via the monitor.

This fixes 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4 and also
db25d56c014aa1a96319c663e0a60346a223b31e, by allowing the user
to enable traces on the command line and also avoiding
unwanted trace-<pid> files when the user has not asked for them.

Fixes: 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4
Signed-off-by: Josh DuBois <josh@joshdubois.com>
---
 trace/control.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/trace/control.c b/trace/control.c
index 6558b5c906..8f94f09444 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -39,6 +39,7 @@ static TraceEventGroup *event_groups;
 static size_t nevent_groups;
 static uint32_t next_id;
 static uint32_t next_vcpu_id;
+static bool init_trace_on_startup;
 
 QemuOptsList qemu_trace_opts = {
     .name = "trace",
@@ -225,7 +226,9 @@ void trace_init_file(const char *file)
 {
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
-    st_set_trace_file_enabled(true);
+    if (init_trace_on_startup) {
+        st_set_trace_file_enabled(true);
+    }
 #elif defined CONFIG_TRACE_LOG
     /*
      * If both the simple and the log backends are enabled, "--trace file"
@@ -299,6 +302,7 @@ char *trace_opt_parse(const char *optarg)
     }
     trace_init_events(qemu_opt_get(opts, "events"));
     trace_file = g_strdup(qemu_opt_get(opts, "file"));
+    init_trace_on_startup = true;
     qemu_opts_del(opts);
 
     return trace_file;
-- 
2.25.1


