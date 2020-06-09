Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D498C433E5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB85420734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIb/mC8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB85420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih5A-0001sq-1e
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3o-00006E-9N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3l-0000Se-Gl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id a127so10272443pfa.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=PIb/mC8HdNmYPaLb3g9FR4yCIpXUSdSiUEms8FMGgyunc0fLEQDWP3DoOehkjNTvMQ
 m/DQAP9UUXVg8QHtjyjV+0NHw31anafNbrPXW+mA8RvzfCNExpGtuwnTLbR+Ioo6l1nn
 u0W5Va006Jpwuh5kWLVdbBIjiztTZHqPCS3BqIwHfQjBiAcS6p/9dUJ59AAtKT2Y+OOf
 UnRSQGkpKKeC+1b3FQyyyYLemXTyt32eMVuvAyeH9YK4AIL02BNFY5Ksu9AQ4k9YiLC9
 Z034UI47Gl1853hHC1VM9SbdgBwghMwCCFxNgENb0etr6uqlzEDpSBO24y4jzDg0USH0
 3uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=bF57v3ma3+DUxHMitYRh+2U6pUI0LznswWUS+FpxahbTYU5QB//pkmJB5xWwe6+7a0
 glthtB3QWM49OgnojsDV0ddBFn1ujnK4XCVgDOnW3wIRJpa7F1dNMYHEhcKXp0eL3mXQ
 ITpJwbtV+m5V82FxJWcO1Uh91F7Iw5OUiE7veqAqtAtv/ZQFPfgfS6q/hfUTwQerWhN2
 RAIJbslTLD1dgcKtAjAaUlS1QrjoLMJh9ObvBHCyUKINNGfqJXBLa7WliggK/bKw9HWH
 GJy35jYAEZ2kIfv6PUgNQvBM19q4lSmqjgUooioEMnOq/iIRQw+XBAr92tLjD7xVMSyv
 NwSA==
X-Gm-Message-State: AOAM532wey18FyND5u2jCfZb79+ndpXis2HalQX54xLdgnMuSJDV6IYe
 Wct/rr+SA5sV5d2Dmi2E9ASiKJaEc3I=
X-Google-Smtp-Source: ABdhPJwjXfQib48kwkv/wb0zeU2pxbzpP6iCwsDZl0FIVD12yXSOU+frgPQLBDdH5RDstObCHY4PRA==
X-Received: by 2002:a63:d318:: with SMTP id b24mr23270750pgg.403.1591719907745; 
 Tue, 09 Jun 2020 09:25:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] decodetree: Tidy error_with_file
Date: Tue,  9 Jun 2020 09:24:56 -0700
Message-Id: <20200609162504.780080-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


