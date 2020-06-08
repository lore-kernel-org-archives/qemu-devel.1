Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F395AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83BC2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgXbebFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83BC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMfl-0000Xa-Pw
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdm-0007T5-RW
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:36:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:40936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdm-0001Up-3p
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:36:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id s88so194198pjb.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=xgXbebFVLPE7avWBGwmpiKqJZUPa76bEfoJLJOOyXa8cgQ/PDQmpXWuJIKGP/KU4fC
 6U5WBvMZSuApP72T/BxRYvOdswbAvFreUgJnbYSpa1HHJBUh+MU9l7kvOrrm0fb0ZRhI
 r/Jt8z8AiTSzAHcxKduraAcBGHUvUYqRaff1qlovJUcUNqTx8BlcaTOOH0d+HgRjL+/X
 +t2eWM03Lu3E0nWJdkJThBhPnn1z5GZ/un6O1/leuAfb7V2dHEZlRigq0amECjKEw5Fb
 dbovEqsdw4PJ7YLKB5wJ1uMQpUzpzv9Pxm5UuCrQff+Y2NmnM2TEswWUijaSqvJSCX7D
 hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/XVcjpntbxdGusUz05j9FBinJNgwBz4HL/Wlk1yj2E=;
 b=mjWNBXeU6TnnZYlm3I9zkPPC0XXCXBoMVVGpsLxU6Rs6b1SXfkDUY07aNImHI4aYmY
 5Ot0usv9y7/cus60IIopAJPpP6Pzx+/+9gxdUF5lzGvpdpzlMYwck3NI5rWLxrgp+03y
 aYvlEQAGgr69HiNOX9xwZ2Sh2Iv8GgqCa821NVsg9sMZb4XaHy9DayzIq4MnwFyXvxxs
 hgnnQSBXlVjqFz3JgvZHFunlopQcysHpkJfGuhKHBc2C2vKdG1u5K77hksFfrl3y8H/F
 hCsCJNBXJbOnNg+iCM2PhtvHULXl33+vQeQTtZTeLo4aTfZ3MmW0Dbf1PdpGtMuEh9s9
 aPag==
X-Gm-Message-State: AOAM530/rrwFSCGXcUyM542A/zeM8ZN1EQ8eLxhPk0hpcwA9rd+M2KkD
 7BOkGZtVp5bFxI/6oEQGw4WKCE1I9PU=
X-Google-Smtp-Source: ABdhPJwxo0O3a/8+lPPLcayZmXxj4GxwjKgxncdxvNezz3cFhQrBpkVJupGf2tEwQBP4p5jz74AJyw==
X-Received: by 2002:a17:90b:3691:: with SMTP id
 mj17mr556106pjb.152.1591641416259; 
 Mon, 08 Jun 2020 11:36:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:36:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] decodetree: Tidy error_with_file
Date: Mon,  8 Jun 2020 11:36:44 -0700
Message-Id: <20200608183652.661386-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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


