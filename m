Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8EC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496CE23888
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBulUDn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496CE23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnXs-00023j-8X
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJf-0002WQ-LD
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJd-0002Gh-G9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so3208965wmi.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sln1IsFPWRFtNzDapJfqz9D0UXVcbAOIwCVnS/WVrtY=;
 b=ZBulUDn5etyg+1dgFomway7kca2EbjmeP6HXXUn2kPBv7e7AxynvYVSXdfxdyMdsoU
 xEK2ZtRZVQD+4fy7Et8CsSFF82ZVYh3tL0ehKCKvCe0Wvi8ciIArcncdn0L/wGVeSM3X
 aYv85YBs14SG+7zMjCj0rcm+Xx41zh4wMGs/dKmBOF5L6eBSb2UvS57QZDKSKb7jEBqW
 YnQZnZfqzXDevKvT/WTNM83s9lDRmS5JvZr26qlvg6rWPXmQdouKNzvzCTNpH4WJ2lPu
 zJiJQpf5g9nCDXCKIFFmqd1gVULLBqJ9fdyYqC5xlG3iD1yaF0PiyWJ4irYUtCwQKT4m
 8nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sln1IsFPWRFtNzDapJfqz9D0UXVcbAOIwCVnS/WVrtY=;
 b=thoRc0xawXr/fEmo3VeJHtCWMXniGbTt4SRuCDZBSobP7oYEEMkGZmi1AIo23Y6EOc
 MHz9rqDWQxygycKkloqUKqi94yrCk9B/dEbxxNiYmYiSh8Wn8CsLgNwQAsgk2UP6gikc
 pt5GNyBql+IU6hrWkycJNpo0aws/kFKnQMZWupo5t9EOvNAx4KqrGRL5zpDQhZFOVQq3
 WUspbBANkBjxnvYnO6FIj7inrnO4beLd4LoMljie6NvtDnX2jcWsrMiJSQLMSns5G4+T
 MW4OiAg+5fetlkhTaZnIttZEUauShD+mHbbnbIXt2dQlitG8sa47CgSlcHh840fTUvQV
 PWLg==
X-Gm-Message-State: AOAM531zdVOEuzpeu/eVpsY+hSWc1lsygZhUNHjIYU0jN9qAx++lBohe
 uGKEqn+fQmNBucmaAGEFyWUYPA==
X-Google-Smtp-Source: ABdhPJwOvPxIbh1o3qPJsaGqkunGlbhgt2Yfji/eep9aSP6iGhmKJbXwgWNt3MCRzqxCCkT92+9UHw==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr3135313wmo.183.1601038748151; 
 Fri, 25 Sep 2020 05:59:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm3112612wma.29.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2DCB1FFA6;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 18/19] tools/vhost-user-rpmb: allow setting of the
 write_count
Date: Fri, 25 Sep 2020 13:51:46 +0100
Message-Id: <20200925125147.26943-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mostly useful for testing. Practically all guest operations
will probe the write count before any write transaction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 34607ad19429..c798a6f66cd2 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -39,6 +39,7 @@
 static gchar *socket_path;
 static char *flash_path;
 static char *key_path;
+static gint initial_counter;
 static gint socket_fd = -1;
 static gboolean print_cap;
 static gboolean verbose;
@@ -49,6 +50,7 @@ static GOptionEntry options[] =
 {
     { "socket-path", 0, 0, G_OPTION_ARG_FILENAME, &socket_path, "Location of vhost-user Unix domain socket, incompatible with --fd", "PATH" },
     { "flash-path", 0, 0, G_OPTION_ARG_FILENAME, &flash_path, "Location of raw flash image file", "PATH" },
+    { "initial-counter", 0, 0, G_OPTION_ARG_INT, &initial_counter, "Set initial value of write counter", NULL},
     { "key-path", 0, 0, G_OPTION_ARG_FILENAME, &key_path, "Location of persistent keyfile", "KEY"},
     { "key-set", 0, 0, G_OPTION_ARG_NONE, &key_set, "Is the key already programmed", NULL},
     { "fd", 0, 0, G_OPTION_ARG_INT, &socket_fd, "Specify the file-descriptor of the backend, incompatible with --socket-path", "FD" },
@@ -797,6 +799,10 @@ int main(int argc, char *argv[])
         vrpmb_set_key(&rpmb, key_path);
     }
 
+    if (initial_counter) {
+        rpmb.write_count = initial_counter;
+    }
+
     if (!socket_path && socket_fd < 0) {
         g_printerr("Please specify either --fd or --socket-path\n");
         exit(EXIT_FAILURE);
-- 
2.20.1


