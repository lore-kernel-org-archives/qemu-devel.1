Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E1C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4171124AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Yaqlg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4171124AB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqcn-0005EW-F4
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:19:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUJ-0007Dx-Ql
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUG-0004Fy-PV
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqU9-0003vT-4C
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id t5so11904239wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=DIXj6o5VjgWS2++paFrbHI/N4U4fSwkYAKrFon5WWPk=;
	b=d6Yaqlg1ULiXMUJS5U4gE+lkugLQ7c9oorRUM39L5ml12fzoBpFsaA0lHDenwH1/Su
	nvYuYKMKiyVfETI7wplv3O+uyQXoAJsAOFKSTLVbTlzQtDjJSYphq9LtnwS+eu7tkuwi
	bGUQQIIuzxhJHE9A2+TXbd+cBKkWqIeYuodc07P6Af9Gii94eix60hhNlgh2y3L1Qie6
	hsAqBanoNiL3bnaqyID5JTww97I0HUiaKMXr/02ykjy3UcEmk6C4fIT7UwF9mfzEaNrC
	0Igd1rLmWFQq+WYJSynLLgYwPghvan0592li0XXiwRnJiwA6y3dScUpW5Jb0b/tGcLFw
	7OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=DIXj6o5VjgWS2++paFrbHI/N4U4fSwkYAKrFon5WWPk=;
	b=CpbA5DDGFjOh4qzu6ckFQYI6LHJLjbhkT639QHA2w8xQIduSbsJPD1HzCvTtnhgg7s
	SwIPOihs8vsEpGWXL69E4epJZqE0swxwVwDj8YnyaW68aB3JcqvuM1w3Lnq8yab4uEkM
	8wUf/I0W0MZN6KWKR0GKKNpECgv/le+rscEOHB6ZrmE1OqxUIoWVeQCQkCEDiV03chYn
	YeYhD2kmh73clqSKEFd0jJm8vyvcggUPBCYObT6kNRRM6VEbKR6BbCg1uiK7xg+t0hu+
	YU6nXUhXap7ABHhaLM+DfUeuha26Fw/vzDpduAg3s+7wdDyzwizfMfsA4VGNypbs+ThJ
	u4VQ==
X-Gm-Message-State: APjAAAUExgPg2V3MQK0Yoi1PsaakI4Mkt2e36o+fzF5YmYcNEzIbI6TF
	ycnAIZSJp7zqph/WPbk9ICtLFHUf
X-Google-Smtp-Source: APXvYqyXZJaMnjsft4A2ChgNBLgwiZ6SkudRq5GJQ900yJ/4HXrQGLTf1eU9qO4goGUAejYNcW5LPA==
X-Received: by 2002:a1c:ab42:: with SMTP id u63mr15545995wme.130.1559581855003;
	Mon, 03 Jun 2019 10:10:55 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:28 +0200
Message-Id: <1559581843-3968-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 09/24] qgraph: allow extra_device_opts on
 contains nodes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow choosing the bus that the device will be placed on, in case
the machine has more than one.  Otherwise, the bus may not match
the base address of the controller we attach it to.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qos-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qos-test.c b/tests/qos-test.c
index ae2fb5d..01b2a22 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -340,7 +340,8 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     char **path_vec = g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
     int path_vec_size = 0;
 
-    char *after_cmd = NULL, *before_cmd = NULL, *after_device = NULL;
+    char *after_cmd, *before_cmd, *after_device;
+    GString *after_device_str = g_string_new("");
     char *node_name = orig_path->name, *path_str;
 
     GString *cmd_line = g_string_new("");
@@ -363,9 +364,8 @@ static void walk_path(QOSGraphNode *orig_path, int len)
         /* append node command line + previous edge command line */
         if (path->command_line && etype == QEDGE_CONSUMED_BY) {
             g_string_append(cmd_line, path->command_line);
-            if (after_device) {
-                g_string_append(cmd_line, after_device);
-            }
+            g_string_append(cmd_line, after_device_str->str);
+            g_string_truncate(after_device_str, 0);
         }
 
         path_vec[path_vec_size++] = qos_graph_edge_get_name(path->path_edge);
@@ -382,12 +382,15 @@ static void walk_path(QOSGraphNode *orig_path, int len)
         if (after_cmd) {
             g_string_append(cmd_line2, after_cmd);
         }
+        if (after_device) {
+            g_string_append(after_device_str, after_device);
+        }
     }
 
     path_vec[path_vec_size++] = NULL;
-    if (after_device) {
-        g_string_append(cmd_line, after_device);
-    }
+    g_string_append(cmd_line, after_device_str->str);
+    g_string_free(after_device_str, true);
+
     g_string_append(cmd_line, cmd_line2->str);
     g_string_free(cmd_line2, true);
 
-- 
1.8.3.1



