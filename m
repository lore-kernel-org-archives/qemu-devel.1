Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D82C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADD321D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb9LnuaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADD321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdeE-0000EB-2R
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM2-0001GM-3I
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLx-0006ct-6T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id h62so5403921wme.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1UkAowOgugs4Mdi7jPockoQV3dWs7h5MywTlHoiRgXg=;
 b=Xb9LnuaQmW2ancLD3qM8/p0CHVO9XJLa+/V7oZq8zYIzIxWUwK/zHXLl2A3ZM88cMM
 dj8QLGPlvMJppaV7BnkpuAJhBZ2ogHxfMMUskvIXub/MHQ0E5nZEGobrg3RvVbRpXKIv
 bs0y9lEXa/XOFNZYFHpSCqQkO4mxlYvSfUb/L+TvxggSo5SRcqExqWRjp8f0Jd7e45s3
 D7Ldz98C+4TFIuv3L2voCX3uQR5S0nONwynPw1p2vHR48tbyLYSBwP6fNFEYU8476RuQ
 qs7+05AzkPKPDOhmQWMf99Fzp5gdFioFmTXJbfU7ln0Mm+xVvUlqC/Aao9ycaaIivBPi
 j0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1UkAowOgugs4Mdi7jPockoQV3dWs7h5MywTlHoiRgXg=;
 b=dZ7VbA/tDJXclfX3ZGwZoV4TakOR9KM7+rN+6iNPYVrCL5ZlqS6A9qy4wrkE1bMofX
 VvQ1kqSJhidGCCEjbB4SUek5ox7nBKuu3xiuOG7JhmZ41/zB3NKaquJ7lWeNCeCJNiGS
 55jP6AaXUXTWnoi+bvztnMhaCd2W1Q/PLxmoUaeSwTigCchCSxS1dwv6qCHZo4BFndpi
 W2i7FilLMY60WLZZxXnImTRpvCErku8JQ2Ya8+uhSdDxnzlKdT9SHp9VWk2nLubYdpxn
 UPu8vfX8Dw+j0f3HDIa/wJg90WLVFNqpxkNVIX31M7JF5yRJOYmbmyy8pjbP9+qYhnZz
 YzvA==
X-Gm-Message-State: AOAM5305QNRAvjt5W6NXHQbLkGECL9rnH9ci8tDTa2LvLQpYpVxAD2/J
 t77an1wij5R5tEspqnapi6NEj8cy76au+w==
X-Google-Smtp-Source: ABdhPJy7K07qMXKJdoeO6hcdG6Z6II6mlHIvsfbhzqykcid0r9mZDCYNtu2v2ZDCP9kFZXLR688v9g==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr18417123wmk.43.1604337043584; 
 Mon, 02 Nov 2020 09:10:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] configure: Test that gio libs from pkg-config work
Date: Mon,  2 Nov 2020 17:10:01 +0000
Message-Id: <20201102171005.30690-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On some hosts (eg Ubuntu Bionic) pkg-config returns a set of
libraries for gio-2.0 which don't actually work when compiling
statically. (Specifically, the returned library string includes
-lmount, but not -lblkid which -lmount depends upon, so linking
fails due to missing symbols.)

Check that the libraries work, and don't enable gio if they don't,
in the same way we do for gnutls.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200928160402.7961-1-peter.maydell@linaro.org
---
 configure | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 6df4306c884..2c3c69f1188 100755
--- a/configure
+++ b/configure
@@ -3489,13 +3489,21 @@ if test "$static" = yes && test "$mingw32" = yes; then
 fi
 
 if $pkg_config --atleast-version=$glib_req_ver gio-2.0; then
-    gio=yes
     gio_cflags=$($pkg_config --cflags gio-2.0)
     gio_libs=$($pkg_config --libs gio-2.0)
     gdbus_codegen=$($pkg_config --variable=gdbus_codegen gio-2.0)
     if [ ! -x "$gdbus_codegen" ]; then
         gdbus_codegen=
     fi
+    # Check that the libraries actually work -- Ubuntu 18.04 ships
+    # with pkg-config --static --libs data for gio-2.0 that is missing
+    # -lblkid and will give a link error.
+    write_c_skeleton
+    if compile_prog "" "gio_libs" ; then
+        gio=yes
+    else
+        gio=no
+    fi
 else
     gio=no
 fi
-- 
2.20.1


