Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB400C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB79207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9Cv00Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB79207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiv1-0003Fx-Sm
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip2-0001yt-Ak
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:00 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:50989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip1-0005pj-73
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:00 -0400
Received: by mail-pj1-x102e.google.com with SMTP id nu7so84693pjb.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=23ujhSNHwAa6m2PV/44zvOLpUgf1M+P1yqoPvCdPMfY=;
 b=e9Cv00AaKl1LCY9WqohCEiRKz1OrlndQHn+JPCOweENat+0toMfJxMg5CumlBmXvxd
 hUC5RLplZiB4EFPPexZIsv4hDojSJ4qlB9ftV6GfWwFoDRiUVhmvl+qdtm6AYXLYJjq7
 KpVTeE1YzZ8qjM0/Bc2c65CcZivBPJjcjzD+WDBSdkpxuaAfgVo23oFfeGDixC/IE18i
 DZo9w+zKUrVx4LpWtv33/Cx2WwNTIEutYFiTV6lSJPYPTtjgDMa4K8BDXNpVIrZP6nOf
 kOHE/EEXo/shb/yBgMVWrnT3aDSbu89DDsRmjzF3oylNXcUs7Peb9SWesRKARk+YVr86
 wIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=23ujhSNHwAa6m2PV/44zvOLpUgf1M+P1yqoPvCdPMfY=;
 b=RnuL0hFz+PvkwrtkgHpSWlcL+bScrQeDTDylQr+ZlcfLPHO/NPRNRp7oBU6fh3D+eZ
 InO34UgW3mFZyCWjVMxDlhNdFD9Eve42M9pD5WMHm8PqplVkNDWaoD5BmR61V6J9A69e
 vbFs3otgcoxmkzAl1iCpaGbWH3ekXMGTeGdNY0aun1Gi6LP7nboOOTs6qdawOlvT6JEH
 NzNTQVECu7n+QfgpdyyvuxG0oeJCILRXPKA5+ZPcX1OnDSeKZ/G2z3pVlRBptc3UkSUV
 0rx2O06GzwosMGi98M7fwpYc9bLSZYQXYhKZc/AmNKUVvXgHtlG2McNjpJTgLyBXoosJ
 oAXQ==
X-Gm-Message-State: AOAM531cygHL5pooGbkgknDOPVushe1//3I1NirWmX9xb0GVEDWykFEM
 aVY9kpT6RB0BnZaY3fiD/dUBL9s2jcw=
X-Google-Smtp-Source: ABdhPJyV4aVyh8kLIouKAbUVdQbIZS7R9friQa7pJTK0HlWF3K2n9Fi7xx/ZcVQkh4sb1qYQJxPGSg==
X-Received: by 2002:a17:902:6949:: with SMTP id
 k9mr17288565plt.47.1589820057328; 
 Mon, 18 May 2020 09:40:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:40:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] decodetree: Tidy error_with_file
Date: Mon, 18 May 2020 09:40:46 -0700
Message-Id: <20200518164052.18689-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use proper varargs to print the arguments.

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
2.20.1


