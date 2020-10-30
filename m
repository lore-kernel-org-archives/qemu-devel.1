Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3185C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D22B20706
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xqju9OGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D22B20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYWU-00080r-78
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUX-0005pl-2k
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUV-0002cL-7r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id 13so3642907wmf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kaf6S3CXD8ewRwpMNYi9VPm3Wdu0Xi27kiY4zNfIfao=;
 b=Xqju9OGzIk+DT/+hopWc1Rf5owoU7lCz+EjhLUNFfywNmVaYD3POevbHQMK6FTVS77
 lbj5MPRS4sNKNcIHtmzfrzVBFGHMwtGlRAZuV/loEAvMaGTq0ORUOtRPxtzbPKsD4nLI
 xYQWRT7Te1fp10rT/LSYiCEpW4XVUN6ixmQsFpk8toYZeP7UfgBEH8PPBvTFW7N7XtcX
 CWsgS1Cted8X+BJdvyS2ta1DU5zfwMpIH7LJP+ZOeevVkMs6FmLGCpg3JjEEdza5XlQ/
 8u5RbQ/Ru8F1c0J05/YKnq7K4kx+/C98tF5N50VCP/LGCR0/NUlftBDO+pjNYkoN28di
 e1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kaf6S3CXD8ewRwpMNYi9VPm3Wdu0Xi27kiY4zNfIfao=;
 b=VeycjZq1W0Dzv7W/whS6679gdsr/xCTMTCebKbDVmMdYzSv5e9l6D0rEc3D0Np+JQm
 P8nyVw+dH68bD3m2xEeYvFIcgdvQ/muKDQmQNf2LSjUDiNrkiSLbXLpROPhatnjI/x3o
 h5/p+uX2DMeduDexiq7bg/o2DRpBXC3dWYp0krpEDIi+27oU2dD0xRYbCs3KSpvfHFOY
 kg2QWm/TOy/7iRqhHHantOFkjZWkBJOg1S8wihND8Tb0OmfnBDmXislpTzyH4vawBIP6
 1PWPNp9v8Egf29E5XmLn+5KTkiwVCGCdaq3qjv2r4OBUbrcTVk8aTbJXKLoJFe/HRgtv
 9TZA==
X-Gm-Message-State: AOAM531m8/sf6zAjMxLxhjRhuY9pweIPxfTTPRn+vopIIGJ8/L9mx24s
 IPpyPj293OYcqBROUkf7AU+k0Tfd6M8gMg==
X-Google-Smtp-Source: ABdhPJwXW8DBizZO10IHaeymYB7sYn8caHfESqSXMJOlJImrC2qyLKsl9N4skMChJrLBQOCjvwwF+A==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr3825304wmc.57.1604080025609; 
 Fri, 30 Oct 2020 10:47:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 1sm12522655wre.61.2020.10.30.10.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 10:47:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-option-trace.rst.inc: Don't use option:: markup
Date: Fri, 30 Oct 2020 17:47:00 +0000
Message-Id: <20201030174700.7204-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201030174700.7204-1-peter.maydell@linaro.org>
References: <20201030174700.7204-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
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


