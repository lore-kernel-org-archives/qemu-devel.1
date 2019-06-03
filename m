Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F0C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B2C24A5F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlMRJPJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B2C24A5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqWC-00009V-Js
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:13:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTz-0006ql-RR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTy-0003nO-ML
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqTy-0003l9-G2
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id v22so11898845wml.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IOjD5AePr0mY9Bxqgs11i965K8q+aZ7uCv8TELzD1mE=;
	b=HlMRJPJ0ydGgx+g05rX4iToBfkbu5SjxC94ZaSSEMSaOdMk6vLMpq3Sv0mjUIaX45N
	gpHls18R17igtRwOosuBxWCU9tXwxxjbEjjHspPeoypaU3nrP8lBfFHQGZppzVttMmcO
	cZWOTu3UI7R700i0hjHKnGxPOs9dcrBPnoTgqQzG575XJrIjGiEKXkmKEiD5urU11CZj
	A2pecz4Zam4pshlyE9JZhkM+iEtmHcB+HeiV9AyGAtOTltQ1u+5PqW8CjwoqN0SFLhWB
	dRQwh5h8/BhGZLnBWdY/DbrJ2OIFSbrq3YHJNu1vpo9P5Qu3CzjkzMxVv2uzJnOOLsO2
	+6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=IOjD5AePr0mY9Bxqgs11i965K8q+aZ7uCv8TELzD1mE=;
	b=RD8F5qhhHoKQDYvAiWROzQIw1H5iJlBaIcWBcAtf9PV9pECqfbUwWtbACiU+HDZ5YT
	vBqRth2gYboqrvro+uL9ysFEy/cKoFp77VrXD75GVXHLTw+ahKpUT+2PRfthjgfGJgm4
	xC28SvBiF3r0MaC6xnR4IArNT172n3fyum1gH++sYYg9T1NWaDWMo6pfmJUJeCQv4m+D
	GXyM7wq1fF83XhFofv5u7nSLj0+rbtjDYPuFCNCUR7J5FAdhi5dEbV6bRGNe9NEnoUwx
	sZigkV8nFUMJfcwuI1pvS0pszkJpqFQPWOXOTU6ujtho0a18zSVwpnxrYmbEX3IhKVfa
	t7gg==
X-Gm-Message-State: APjAAAXm3IvvbwplWbhpifsF7jGhTCBhdfj0LLFnD7GjIrXCvv9m6AWP
	TmGxuzH0t9PZ9IXB0habYAsQmcOF
X-Google-Smtp-Source: APXvYqxdP0vOqm3/PKYf7YlawaeozFxfQmNvQzBq/68ToZ4ZZ22wsMThfluVrPHSpf+nkyQw0FJ8Fg==
X-Received: by 2002:a1c:208c:: with SMTP id
	g134mr15404789wmg.112.1559581848451; 
	Mon, 03 Jun 2019 10:10:48 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:21 +0200
Message-Id: <1559581843-3968-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 02/24] vl: make -accel help to list enabled
 accelerators only
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Currently, -accel help shows all possible accelerators regardless
if they are enabled in the binary or not. That is a different
semantic from -cpu and -machine helps, for example. So this change
makes it to list only the accelerators which support is compiled
in the binary target.

Note that it does not check if the accelerator is enabled in the
host, so the help message's header was rewritten to emphasize
that. Also qtest is not displayed given that it is used for
internal testing purpose only.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190530215755.328-2-wainersm@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 139658d..f023a8c 100644
--- a/vl.c
+++ b/vl.c
@@ -3576,7 +3576,23 @@ int main(int argc, char **argv, char **envp)
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
-                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
+                    printf("Accelerators supported in QEMU binary:\n");
+                    GSList *el, *accel_list = object_class_get_list(TYPE_ACCEL,
+                                                                    false);
+                    for (el = accel_list; el; el = el->next) {
+                        gchar *typename = g_strdup(object_class_get_name(
+                                                   OBJECT_CLASS(el->data)));
+                        /* omit qtest which is used for tests only */
+                        if (g_strcmp0(typename, ACCEL_CLASS_NAME("qtest")) &&
+                            g_str_has_suffix(typename, ACCEL_CLASS_SUFFIX)) {
+                            gchar **optname = g_strsplit(typename,
+                                                         ACCEL_CLASS_SUFFIX, 0);
+                            printf("%s\n", optname[0]);
+                            g_free(optname);
+                        }
+                        g_free(typename);
+                    }
+                    g_slist_free(accel_list);
                     exit(0);
                 }
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-- 
1.8.3.1



