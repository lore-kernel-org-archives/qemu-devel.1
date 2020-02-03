Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688FC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C572070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pmgm5zkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C572070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXrZ-0003YC-Cv
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqc-0002AJ-M3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqb-0002GR-NR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXqb-0002Fd-Gh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id z7so16855311wrl.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d/cGQ7q3chFgVAxw3GyGo50EtRgRX0dgwlhqGJCj744=;
 b=Pmgm5zkYUsLVV6NpFKBPhrTS9ETKcYsU+CSE9YS2di3eExUaaW7fxPIqJoa7ae0FoI
 2TbZGsyEa0fG6FPyi0pteGIQfesrGWIf72xRtSxmKY/hMlz9gVEA8y//MK+twA7py24z
 ipP4zWL9L4KJ5NMQG0nwChk+uJmYFWfO6TcuT1E7D1/cjkezQKBg4Z5o5eEtz3yJi7FD
 ut5Ok68co4mDnIVYYM5sp2F9KBKWZg623SdoL6HRZ3xWIyGCK+dh9tD2890HSED+AmOW
 Np5agBRfE8QGR1mprCBCvWbkorIP83zQxDboALQY6RqnJ7D0L/URdkO5ZPyqXxPgMLAK
 mYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d/cGQ7q3chFgVAxw3GyGo50EtRgRX0dgwlhqGJCj744=;
 b=PKDZyDFWPwhNZYos1df5kmArVl+h2CUL+UONun3xwDmVlQDgN8Qf0TcQq8kZChXRTo
 jcuT9+JdwsgNzvPAFyibuatl4iNRpPjs6pr//ULYVLEAaIdaBJnD3dkjNo2z8ro4PYj6
 FhMeood76zCsbgY58D/R2rIQN0fdze2zda9TewXZRqpWtsl75Fl3NbwhtgAlfnXDHS+a
 /u0ERQTkEdzIHCy4yxXJ87ccScUkkNHnNn0Nqn8ce2Wz5pVFQwuj1Ocw+26TK7vmmJPC
 qNv1jbeWbOaRrxLtTMH28QFfE32wD/FnyZwGkRYvoLT7Dc3EmZxBd945QN7hAWOkMOgu
 zp+Q==
X-Gm-Message-State: APjAAAUtJWHIOTUcgzzkKiFST3msDoCm2VajZwQcZWdq1bKuo7XMaYP9
 4SAtJ9WzKKRYSp2k1wsbLZ8MFg==
X-Google-Smtp-Source: APXvYqzHDmrz8FvSwjIOhIsOA7rK4IxyHlkZo/bse4uzhGM0O92pZgRYzlv82xBEzXYkdERjIOSLQg==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr13430616wrw.281.1580721408334; 
 Mon, 03 Feb 2020 01:16:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm16226636wro.66.2020.02.03.01.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:16:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF371FF9F;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 15/17] .travis.yml: drop the travis_retry from tests
Date: Mon,  3 Feb 2020 09:09:30 +0000
Message-Id: <20200203090932.19147-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was a crutch when we introduced it - however it does have the
disadvantage of causing tests to timeout with large amounts of logs.
Lets drop it and see if the stability has improved since.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 022462f6981..875671325c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -103,7 +103,12 @@ script:
     else
         $(exit $BUILD_RC);
     fi
-  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
+  - |
+    if [ "$BUILD_RC" -eq 0 ] ; then
+        ${TEST_CMD} ;
+    else
+        $(exit $BUILD_RC);
+    fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
 
-- 
2.20.1


