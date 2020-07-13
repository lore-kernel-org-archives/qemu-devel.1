Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C8AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75222072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnodcJof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75222072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzFI-0005F9-Sj
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAu-0005BU-IV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAs-0006d9-QQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id f18so13313954wml.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7rQjw1rOqhAJCjmAz6yvmJBAWq0/Oe9unTgHrAzUqpE=;
 b=nnodcJofB78anUr2Wfa1/udAvIB5JFFgMBNuyXkDVh236+BBNJ34jXnqdXwcW3BYD3
 3NaNjtQj2W8KXfz/+6EvcHlejQf449mgtMjTS9Y93y2+gy7l7PhwU8J3RbeEoTyNgx9L
 XdBE8o4aIWjBNZT/Ut5aN+tnmf7YJWPJQAbsy0GYaiFWLrSVGAV9xdWSCbUP3AM9G3Ue
 CZBAPUvGypODm1pp0548MhUp0/w1cAEEya4u04nR862W9jTrpQ/qA0UrG+OFWRQQZJ3j
 w3xjIn3Uyd9aFYgsfHYHn2oHtXwv/I0xyMbYCct7hHklIAfzuaTvbR+6l1mj8lP/Nm+R
 p6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7rQjw1rOqhAJCjmAz6yvmJBAWq0/Oe9unTgHrAzUqpE=;
 b=K6wE5byeaRB1IgoF7Sh4W3GJd3qXPvS+jsEExZN1cpdPwVkBNVnq3SA7jZBBTRRBMj
 NzyHE0oGrBichjYAnbA4MOPxknGRZ8K2vEm4Rg556VlEaxdqrT9V1z6iDVhuRHaTQfmY
 xxm8fmP4963zk5usCRKwgeOk5nGy2FUN/7rzM9kQhC9y2ARSHCiGWbn+KTbPGD4GOiEh
 dcTNPg9cOstrz65drn5kE7HYAahSW4T7Q/+LOnoYTx5+6k5LRjQGCoJj78oRmRpFzeYu
 5Q79RvpPJRhM30YwInQNu5SYrKQKt/h+659wHRnjnuKv3iOs17zc9CBZNSqC+zyZaz4V
 yXpw==
X-Gm-Message-State: AOAM5321rGTsouud21PN6ivt4tptIMYfDkjqWthsSEk97Yz5ZW1kVGEK
 pdXB5qrbNp+j8/8aXT8BW0UOMvrm6jGt/Q==
X-Google-Smtp-Source: ABdhPJxUZUf9Eac6toyngWZD5RWLe7Fz/ynGDo2Is8xzfojrXZdIjnSlhYeLWhG6qEAPeC59nX9Q0A==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr143238wme.43.1594649477082; 
 Mon, 13 Jul 2020 07:11:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/25] util/qemu-openpty.c: Don't assume pty.h is glibc-only
Date: Mon, 13 Jul 2020 15:10:48 +0100
Message-Id: <20200713141104.5139-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: David CARLIER <devnexen@gmail.com>

Instead of using an OS-specific ifdef test to select the "openpty()
is in pty.h" codepath, make configure check for the existence of
the header and use the new CONFIG_PTY instead.

This is necessary to build on Haiku, which also provides openpty()
via pty.h.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-3-peter.maydell@linaro.org
[PMM: Expanded commit message; rename to HAVE_PTY_H]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure           | 9 +++++++++
 util/qemu-openpty.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index c70b43d1394..978505611b1 100755
--- a/configure
+++ b/configure
@@ -2402,6 +2402,12 @@ else
   l2tpv3=no
 fi
 
+if check_include "pty.h" ; then
+  pty_h=yes
+else
+  pty_h=no
+fi
+
 #########################################
 # vhost interdependencies and host support
 
@@ -7893,6 +7899,9 @@ fi
 if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
+if test "$pty_h" = "yes" ; then
+  echo "HAVE_PTY_H=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 4b8df96f383..eb17f5b0bce 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#if defined(__GLIBC__)
+#if defined HAVE_PTY_H
 # include <pty.h>
 #elif defined CONFIG_BSD
 # include <termios.h>
-- 
2.20.1


