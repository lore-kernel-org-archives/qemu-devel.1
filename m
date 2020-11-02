Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC3A20715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cirx/Fu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC3A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdc4-00064Y-42
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM5-0001PL-Hi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM3-0006eX-QW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id 13so10160900wmf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UP1n0K2qtWKcroM5xmLdq4+koLBx0NwxnaUUM2A/CGU=;
 b=Cirx/Fu7gnDaFZx1nWzqOvrdDwioh2/I5VuLofjwmlxUTV3bUfTl7OZpq/ShmO5mmq
 ZrVyQ6qoBcRDhmKRbvmVXMrr7IP04VKrzcTq660QMTmKCOtocHy/Nfujw38neeYnsOF5
 hUr5zstHTRgOLL3w+TwP2FjAnVCnkHPGwaDFIZpf15JBEo90l1Mc2UE4eS9sMA5esWlR
 G5tlRCh1NqRflBGVsnaUIcbUK2KeI65fdLGi8dl9lG6Tp5+/OqeYE7UcJhhl/ANC6pxH
 WyOZ2bHIrFciIcIzxvCePDGTwHm5Ck6ek6oCg98MEPEgmiesaZT3c7AN2O082zVQWGCR
 q4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UP1n0K2qtWKcroM5xmLdq4+koLBx0NwxnaUUM2A/CGU=;
 b=UB9uRm81NPthFzaU20nK836WXfFzcMv8i/tOv1RB5+8+siK5uv7+15EG4Roob4a3vj
 28XYLbfcvZoV8H5xF21fVnPpWyNB9vq+InDWShUrl2M9r7PLNT0+cMPxzQmHQq4pFx3L
 siDr7uaXZdKX3KyUvpVIFd/Esvsn90FrtmZuHMkq1UAEvkAQxNzxa7wGdFRIc1nkG+8u
 fIRZgd4s9kR4rHKD2weQL+1dPzDP81me7JOShF/8x5Lzy7L/ZjYydX4ddPBMAU24/+Mn
 W5mlnso+gJl0HtpoU7uZtbkG6etWkuYB792h/rLJfEjdPUgMWSoEl17oQb2aWaMKF0GS
 xorA==
X-Gm-Message-State: AOAM532ydsa2rwG7YhGTmP4sjU5XNMb0QNICerh6NgYVFekf/YF60YC/
 ogBbzIfE8Hhu6VLH0IMh7T1zqcbfYXgMlA==
X-Google-Smtp-Source: ABdhPJwm9xC3EAt0OHfEC1G8Xm0RCgBhEpyucX8BBn6b8hhwkI9VNO5UYzc5bvaN9CIirQIC5Okfrw==
X-Received: by 2002:a1c:ac87:: with SMTP id
 v129mr18630593wme.119.1604337047232; 
 Mon, 02 Nov 2020 09:10:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] qemu-option-trace.rst.inc: Don't use option:: markup
Date: Mon,  2 Nov 2020 17:10:04 +0000
Message-Id: <20201102171005.30690-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Sphinx 3.2 is pickier than earlier versions about the option:: markup,
and complains about our usage in qemu-option-trace.rst:

../../docs/qemu-option-trace.rst.inc:4:Malformed option description
  '[enable=]PATTERN', should look like "opt", "-opt args", "--opt args",
  "/opt args" or "+opt args"

In this file, we're really trying to document the different parts of
the top-level --trace option, which qemu-nbd.rst and qemu-img.rst
have already introduced with an option:: markup.  So it's not right
to use option:: here anyway.  Switch to a different markup
(definition lists) which gives about the same formatted output.

(Unlike option::, this markup doesn't produce index entries; but
at the moment we don't do anything much with indexes anyway, and
in any case I think it doesn't make much sense to have individual
index entries for the sub-parts of the --trace option.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20201030174700.7204-3-peter.maydell@linaro.org
---
 docs/qemu-option-trace.rst.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/qemu-option-trace.rst.inc b/docs/qemu-option-trace.rst.inc
index 7e09773a9c5..d7acbe67f73 100644
--- a/docs/qemu-option-trace.rst.inc
+++ b/docs/qemu-option-trace.rst.inc
@@ -1,7 +1,7 @@
 
 Specify tracing options.
 
-.. option:: [enable=]PATTERN
+``[enable=]PATTERN``
 
   Immediately enable events matching *PATTERN*
   (either event name or a globbing pattern).  This option is only
@@ -11,7 +11,7 @@ Specify tracing options.
 
   Use :option:`-trace help` to print a list of names of trace points.
 
-.. option:: events=FILE
+``events=FILE``
 
   Immediately enable events listed in *FILE*.
   The file must contain one event name (as listed in the ``trace-events-all``
@@ -19,7 +19,7 @@ Specify tracing options.
   available if QEMU has been compiled with the ``simple``, ``log`` or
   ``ftrace`` tracing backend.
 
-.. option:: file=FILE
+``file=FILE``
 
   Log output traces to *FILE*.
   This option is only available if QEMU has been compiled with
-- 
2.20.1


