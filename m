Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B21BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D192076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugsig8zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D192076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS05x-0003BO-PD
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqg-0007BO-S8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqR-0007Lb-Bq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id y12so14320746wrp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ZOYJQFgwtkRMUbE80VKve55fsHkUx0xDSOrENJ6dJU=;
 b=ugsig8zpC0Qx+KkGOBRBlUNonfjfYMyA7gA5Jc3AdMBV/ins+/IP15NmtVWDhFaoj8
 9Ih+F4xShgRP8g3vyGIRx1APoaUM00QiQnvwPRbSNap5a/owy5IviEeRJoUr/1F/7l/M
 b+E4b/HX2tfEdgAklY9iIsimd6uJtWp8oUpu7uail11Vi6RATSWnvut1Y4Y9EXFXv9/z
 tgpfvV+bjkU2a7LR4cHUJvteOvqSWSUm81xHAuA7S8gG4CDCjEFOahnnhTPJ+hpkJer+
 UqUBUvXjtmVr+Wozf0Fpq9f4umI4GEedDkmzhK8V76aaHsYc6+Q8bzleAEcgepzizY12
 /vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ZOYJQFgwtkRMUbE80VKve55fsHkUx0xDSOrENJ6dJU=;
 b=NfX+u526EkXW9LCRLvcu3MUBO4qvZRHR7L3WXEWWI0zMOpfDeFYPGChoCDEzE6xhKJ
 LpBOgV8LnXBzcw1nfje3yLGFuHYHthYzR3BEJTHTe+2N3NmoTHgp6i1W0B4Q25FympG1
 7Ed45zq0Jn1RS10LyzCMh5jOLquZrQRwUS/qkUkJCAU6TTuMISFXGFXfA4GFSKz9Hhm+
 8viQtne05BTfA/qXnYXp2dSRVJWAzNoL0+ln5PTzXr52sXkm1oFCrPmdqbN4g/HtmM7T
 Yc2aNykW43wCwtG6wd4ImsNBxyMK995h7WzvgePQ3/QbNUoskZUFF2eKMNn0w3qsVtOA
 jHfA==
X-Gm-Message-State: AOAM530hR+co4EabXZ/vN/AQN8Cw1Voe6FTM30e9ut9eEpHr06obWqob
 WDOG8rPn8wq9UFQfqEyBsWj0EqlkOQoEg9Vf
X-Google-Smtp-Source: ABdhPJxZm6nnn0K48lVEgiUOdZmwQiTJ0RP/8c3cPgDbRk09d+UNt0geOYKLeCGxNb/9WWn9Y4n09Q==
X-Received: by 2002:a5d:6642:: with SMTP id f2mr30396139wrw.374.1602516876795; 
 Mon, 12 Oct 2020 08:34:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] meson.build: Don't look for libudev for static builds
Date: Mon, 12 Oct 2020 16:33:46 +0100
Message-Id: <20201012153408.9747-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit f01496a314d916 moved the logic for detecting libudev from
configure to meson.build, but in the process it dropped the condition
that meant we only ask pkg-config about libudev for a non-static
build.

This breaks static builds of the system emulators on at least Ubuntu
18.04.4, because on that host there is no static libudev but
pkg-config still claims it exists.

Reinstate the logic that we had in the configure check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We could certainly do something cleverer here, but basic "convert
from configure to meson" should in general not also be changing the
detection logic IMHO.  We can make the logic smarter as a follow-on
patch if desired.
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 3161c1f037a..07da66e1d81 100644
--- a/meson.build
+++ b/meson.build
@@ -271,7 +271,7 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if targetos == 'linux' and (have_system or have_tools)
+if targetos == 'linux' and (have_system or have_tools) and not enable_static
   libudev = dependency('libudev',
                        required: get_option('mpath').enabled(),
                        static: enable_static)
-- 
2.20.1


