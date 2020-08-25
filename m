Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71869C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E02D2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faZbjc9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E02D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUaU-00037b-Bq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQl-00086t-18
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQh-00010K-F1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id t9so2590298pfq.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=faZbjc9KpzRCNppP5iiWIh9cjaI4/rLkD82RKbX4NJFQLIj2PKF/D7fbQruN8JtD+q
 zfnIBcz21sQ7YQ4SmQC8J8hjOq1o5QR4x6PkdGJgM3oDVw9pwk2S8kRSd8+NdN6jnhQz
 EB5IAfJVXS31QrCNV9Jr1NuAsMmhEjV30KRxJzZ9FxZU+dSFip1MRkSQrcg3mEXeSKRV
 HsaOFFQKKeCeRpBHBUGm8fFHqtsqhFsIvegXrHA14gZfCBl20WmLxHIZWAV5B+4pFZ+9
 eTa6m6dIc8oIRrntn9aDNy04+/qoS4J13qXKmO9FJfWGqqh6syeWWIMa8BOVCxO2u7PD
 symw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=HdQ89eaDbX6Bu+s+a83HUj7DUAG+cKUwEt80+I/ikQettvojnFOr2jqZHnw4HoY07z
 Kltfkn4COAR6okk8vm5fCTXQTwabYxHTmvIVP7R2pkfgSbom97oYdlMEcgpi8NfoJllX
 whX9nhz1NONncFApOuVCU6kdstO/HtTM4hKuyjp8CmMH4uvgZYoe1JogdbuayTziNYaE
 DDxpq0x1voOALbdVeEnpEKJTLLQ4xXXxIDQiHWRF0CCmHaSgVJSxHV8dfTInKWBEPnZv
 0AbkW3rLbiZLfRFeWme3/w9EKB5o62f4ohR33E1EBdEfFerm8pUR7X9q5a2Q5xG2qfwO
 73dw==
X-Gm-Message-State: AOAM530AWIq+c9FpVAiyp4hSg52OJX7GRdgTCaoGd0evvxH8WNrV17Gs
 8cWK4OJ80xpu+KHB54/9ar46jSRlZRXaJ3nK
X-Google-Smtp-Source: ABdhPJzlWxsMwAmPYmI8F5bJGHsvKN8v3XSABZtgkEVsSCbc/iKOpLQAXbJHzf2yZF5nq+azp85UjA==
X-Received: by 2002:a65:5849:: with SMTP id s9mr6322324pgr.145.1598344541468; 
 Tue, 25 Aug 2020 01:35:41 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id bn14sm1146683pjb.0.2020.08.25.01.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 01:35:40 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] meson: fixes relpath may fail on win32. for example
 C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
Date: Tue, 25 Aug 2020 16:34:57 +0800
Message-Id: <20200825083500.359-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825083500.359-1-luoyonggang@gmail.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x431.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 scripts/mtest2make.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index bdb257bbd9..d7a51bf97e 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -53,9 +53,16 @@ i = 0
 for test in json.load(sys.stdin):
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
-    executable = os.path.relpath(test['cmd'][0])
+    executable = test['cmd'][0]
+    try:
+        executable = os.path.relpath(executable)
+    except:
+        pass
     if test['workdir'] is not None:
-        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+        try:
+            test['cmd'][0] = os.path.relpath(executable, test['workdir'])
+        except:
+            test['cmd'][0] = executable
     else:
         test['cmd'][0] = executable
     cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
-- 
2.27.0.windows.1


