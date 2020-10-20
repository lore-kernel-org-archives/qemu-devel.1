Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A3C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C4E22249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k30pFzMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C4E22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu59-0001T7-26
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0q-0004dW-1w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0o-0003t2-6Q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id b127so2507274wmb.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QxPmVnrfSjFTEg3WYheghSIjLNIn+PX9t57cQEz8lUM=;
 b=k30pFzMaCBR0znJb+gqeyN4qH17fKLQDLH9FcGaL0A2XuPYetPnAY7pih4dyjuyLP2
 IG71hxdGxiIcqEU4s41gZibY+4iJxFazj50AlXrLjqQph2/BLeYhKeklcaWd1SsdZQpb
 V55MXxN7WBgONnSUkowZMUE/fmdWhbMpdnVMjizixihskQwX3yaKmFu9ung4MQfwu1s8
 7YMWoAiizERmKAI80tCzuYujsBZekSQFxucsn5/ObHv4Qg2YSAVfjAUWTlDLp6bxTTti
 uM7/TyUzoIVW0q3I8apJ9IVRcShMx0Q7PWu92FK9v/3n5y4q/wD9Hr6zWvGSKTqK4dC6
 gbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QxPmVnrfSjFTEg3WYheghSIjLNIn+PX9t57cQEz8lUM=;
 b=MXpzbefaRCpaLRY5pfKAmCeHpDLr5A4FajQqaqRV79aGO5lm6HH/n67RzphptIiKoJ
 O+A7if/1CDLzTi7C1Rp3qHP1mS3N44441AyEEnMqgoMqiRdayCy3WEOhIiIZb07NvLon
 NHtGN3dMPUDLk7BgZo+cXXO1uWeGPTDlYduSYICkdDSamHrV2BV4bkcwiBc3aIgtdxd9
 c1onCC0aHbWfes2s/dhsgyzw1CzjaBCKflvTZaJOEklxh6wMlTMPJ3YsG05ktPgywx0P
 thNlVaXfX1IMPbMHKiCxcB45M8Q0D81Gud0mmgAvtUMLC3D+MjN4lIJP60IiIDoLhd2d
 4XFg==
X-Gm-Message-State: AOAM5309PSBX82pwJK3oN+snQ2w0qywtNeiIlNtaBvDYfAPVhCFNmEkX
 3zuF8K9fUNHyqJs5MVtiJMKXHYojuaCCYg==
X-Google-Smtp-Source: ABdhPJxA/GgGj76dkxxvXJ1vNzLrk73A79CCx+lXNLIUEbw5HY5S+jB6Se59LKZRM3FuB/I8zP8TRA==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr3586080wmj.123.1603209440443; 
 Tue, 20 Oct 2020 08:57:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] loads-stores.rst: add footnote that clarifies GETPC usage
Date: Tue, 20 Oct 2020 16:56:27 +0100
Message-Id: <20201020155656.8045-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Current documentation is not too clear on the GETPC usage.
In particular, when used outside the top level helper function
it causes unexpected behavior.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-id: 20201015095147.1691-1-e.emanuelegiuseppe@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/loads-stores.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9a944ef1af6..59c1225391c 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -93,7 +93,13 @@ guest CPU state in case of a guest CPU exception.  This is passed
 to ``cpu_restore_state()``.  Therefore the value should either be 0,
 to indicate that the guest CPU state is already synchronized, or
 the result of ``GETPC()`` from the top level ``HELPER(foo)``
-function, which is a return address into the generated code.
+function, which is a return address into the generated code [#gpc]_.
+
+.. [#gpc] Note that ``GETPC()`` should be used with great care: calling
+          it in other functions that are *not* the top level
+          ``HELPER(foo)`` will cause unexpected behavior. Instead, the
+          value of ``GETPC()`` should be read from the helper and passed
+          if needed to the functions that the helper calls.
 
 Function names follow the pattern:
 
-- 
2.20.1


