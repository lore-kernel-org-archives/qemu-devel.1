Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03042C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84BD206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc0q7LE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84BD206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGoZ-00065g-16
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 19:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGno-0004gq-2f
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:34617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnn-00023w-BG
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id z64so311547pfb.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=oc0q7LE8Ir+zgj8P7CjTLNYzDwOGofSquj4cPNWu4X2f55BBwaNOf4x6zIrp2h9W5b
 JseoxQooDeat3yLtserJmk+8bN3F5E9iRSxtnh9yi1DHGqt7abmk2aWu0wguPxuOUDd4
 581QuzwySphwwiinxi62TH/IluBcbojUy4vBS640o+SJvDdJPnNSnUdMFI/BbUBL0cdb
 vzOsZ4xJ5G+CmtxahUk8h9oTk9GHpTxov95t6ONGAQY0xHt1OUCph30uxMrBSPViTZ1A
 5pvl2+TNMeLernxhxksMwzid19YsCx6s1CWzICZSJrtAoFAONyW3acV4y3GRrxxKD7IM
 3hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=UC17DxwqfHL8tEOZGg7T/t3sZZhLoZ5FkYSH9COD/Fpq4i8KPkP5KfUYWtptKNw7eT
 SUeQNo8I3AneRXdI1tH7k9xdCgfSDj+B6eavE9SDrPTWqKJRTN78sOfZlGHJRSu8qKP5
 S29zSU/fXUqMRNhYDGbp8yFAJqtG/gsiM4PQsZ6XMykSgmN1dNgm06wIrLMfoaryX3OY
 o+m991+l8L2lZ8JtqsET80EA7/Vo8AeiGsaJSaFKeIGJVsWf/KlB94G++cHWrwPEDBmI
 J3oX8yXS+b7jincIrLUHc9k/AiNo8PcZzMTuDeRx3fo/z25yf7QFNevKgIdXtCqekWXc
 i95A==
X-Gm-Message-State: AOAM533fO5OWXOnAqFhFsnFz3TFoXCgJ43iOzICQeBnGPr7KjAsPLBGL
 ipqpUoBER60ebxp9ZYneO+LofZOHxs0=
X-Google-Smtp-Source: ABdhPJy6v3rHbv7l607aiZmTl5JiDkZV2JdtSX/Ym2LNkRDkmgqJakBTfwRugpyuBCaiZL0WPZh2xQ==
X-Received: by 2002:a17:90b:4c44:: with SMTP id
 np4mr1821245pjb.63.1591142317535; 
 Tue, 02 Jun 2020 16:58:37 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] decodetree: Tidy error_with_file
Date: Tue,  2 Jun 2020 16:58:27 -0700
Message-Id: <20200602235834.470345-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602235834.470345-1-richard.henderson@linaro.org>
References: <20200602235834.470345-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use proper varargs to print the arguments.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index f9d204aa36..b559db3086 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -51,23 +51,27 @@ def error_with_file(file, lineno, *args):
     global output_file
     global output_fd
 
+    prefix = ''
+    if file:
+        prefix += '{0}:'.format(file)
     if lineno:
-        r = '{0}:{1}: error:'.format(file, lineno)
-    elif input_file:
-        r = '{0}: error:'.format(file)
-    else:
-        r = 'error:'
-    for a in args:
-        r += ' ' + str(a)
-    r += '\n'
-    sys.stderr.write(r)
+        prefix += '{0}:'.format(lineno)
+    if prefix:
+        prefix += ' '
+    print(prefix, end='error: ', file=sys.stderr)
+    print(*args, file=sys.stderr)
+
     if output_file and output_fd:
         output_fd.close()
         os.remove(output_file)
     exit(1)
+# end error_with_file
+
 
 def error(lineno, *args):
-    error_with_file(input_file, lineno, args)
+    error_with_file(input_file, lineno, *args)
+# end error
+
 
 def output(*args):
     global output_fd
-- 
2.25.1


