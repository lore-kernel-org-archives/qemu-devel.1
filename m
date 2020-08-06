Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4F122D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5v1vZUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4F122D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eH1-0003Jo-Q8
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eGQ-0002uU-Tk
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:40:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eGP-0006Jc-1h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:40:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id a5so33714747wrm.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=chlYlmg1y+jGFcu7MLZcX9cVTv/UER0aYzDkRYc+PeE=;
 b=Y5v1vZUUrc8/KOdqlge8PXwotvagrVhI7iaBDtXclP0LmcgNqA8ivtKElr4Yyaxq8A
 jRy+W5IvwLJmt1QLnJBq8zpQgokhBeqzBvPpKpX6F+CnImniycP7+AbkHWDU/qrMrPhe
 gJqFs9vLsQsAQV3QQrCeIESOaTVP3YPrAosxkZZCRBf8EI5XaLA1DFp+3sH/3az4Uijc
 TQS6SHg5nEyc7Z0Yw06TBNYDvp18AyRUWXx9VCXHdyZtF0t0FTdlkyJBi2yx3miYEQc8
 gJEJ7oTOnXCvGTvoNELpN/0fhXEYMsVceJnZ40Bd5AOLw1B049F+fXcvS56GlqmdbzMh
 uG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=chlYlmg1y+jGFcu7MLZcX9cVTv/UER0aYzDkRYc+PeE=;
 b=rFzQFRgW8jXVCxjmNrPqeIH6oQWtPqG+NiyrX4fyQwea150vN4ad5l2Vp2xO2DBq1i
 Wx+uON5KHQZbctsW5N0iDGw7XXYngU210V5ZaRFlIvtBAoNm61mALP3NcP4Azrcrnqp2
 xJHBgvcG5/ZExkK/GIkakL+GOx0BNOAKqc55MQAmS3xlQkEacUey2A3ZwwXu0tN4ZKkc
 rUxvQuJF6dYqK16qGTJZsQnsLU8H4V2kGK69WHvamhFzNItvSltTKURZrkqLBidE7S1N
 T4JcFZ8U+rO2kV3/fWRzjf4/pmQN8RUjcA8UD8rq4ZougF2GKPJKgUPxTcAZPyuDHH1v
 xzMQ==
X-Gm-Message-State: AOAM5333z/fwjP+C92RrPAaR7/kiQIholJPFwG6tmpf5ILYaXXggnNE0
 S3okzY3EScMu/Fd8oi5zgjV9tw==
X-Google-Smtp-Source: ABdhPJxgj4xYBZGE7ku6V6SFziIDd76SZhreQIPD3UCdbQHBIN6d37HOaD5Zd0YtUw2Yd5yXvto+Og==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr7172286wrs.361.1596714046952; 
 Thu, 06 Aug 2020 04:40:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g145sm8881929wmg.23.2020.08.06.04.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 04:40:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D35991FF7E;
 Thu,  6 Aug 2020 12:40:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] CODING_STYLE.rst: flesh out our naming conventions.
Date: Thu,  6 Aug 2020 12:40:36 +0100
Message-Id: <20200806114036.10646-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention a few of the more common naming conventions we follow in the
code base including common variable names and function prefix and
suffix examples.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 CODING_STYLE.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 427699e0e42..17cb42ba761 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -109,9 +109,32 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
 uint64_t and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
 
+Variable Naming Conventions
+---------------------------
+
+A number of common short naming conventions exist for variables that use
+common QEMU types. For example when dealing with the architecture
+independent CPUState this is often in a ``cs`` pointer variable
+whereas the concrete CPUArchState us usually held in a pointer called
+``env``.
+
+Likewise in device emulation code the common DeviceState is usually
+called ``dev`` with the actual state structure often the very terse
+``s`` or maybe ``foodev``.
+
+Function Naming Conventions
+---------------------------
+
 When wrapping standard library functions, use the prefix ``qemu_`` to alert
 readers that they are seeing a wrapped version; otherwise avoid this prefix.
 
+Functions that are expected to be called with some sort of lock held
+usually have the suffix ``_locked``.
+
+Public functions (i.e. declared in public headers) tend to be prefixes
+with the subsystem or file they came from. For example ``tlb_`` for
+functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.
+
 Block structure
 ===============
 
-- 
2.20.1


