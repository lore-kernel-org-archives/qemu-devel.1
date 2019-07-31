Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FADC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D27206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPHwt37C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D27206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrEB-0002OR-Ss
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8Z-00025f-Sf
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8W-0000hT-A8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8T-0000dG-V1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so60318717wmg.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q2ZVpkuPZWWQPipjqK7QM3P7xcGJr7m8OUgkDGruy80=;
 b=yPHwt37CO8xUdFkdMw0bpZRaFeSdTJIGAsDdqTiQlRFh63rYPgIUS1Dejn8lsSvvFZ
 56FeZqkcNA5kMQJL8DSNBmwY3cskkyHQcoQp9GXl3CySbkZoFCmiE3YJ8WhxF1qhqpnR
 p3f4KNTEiizPqmgWm22UGHzSUyzlvc5PG1WYtJ4czezbzpepFHHmUEOeeBlfavTAQgBo
 1MoZxkrh0vich5TRTOtSDj0GtKq4fPb/hIynlvX1U4cs98uZuMQv35XQKbeKY6AXwAYJ
 9h41q9OdAnTVoKnJdMwIEy+RGjowYpmwpH+I5xt89xZ/2cBi1SHDZkE4RsO80KoSfL9b
 ifNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q2ZVpkuPZWWQPipjqK7QM3P7xcGJr7m8OUgkDGruy80=;
 b=bxMBsN4CqoqGsBq02QMSZuW4tAFEy/HNbCGG1kuQkWvfik3s38nKXjVFmhEcy9dZmJ
 KmTn3GTpvGu4x/INmHxeLy7vtXU85bJ5r3Bhki1Bet/96V2D2ai7SqNuyN5bf8CHcCGE
 +kRC19btV+VMznAKnuTBOff6g2ps85R7gUZKs3WoMQp41GCCcgSh3gEelT6/GE/HYq1F
 d4MRfp8Fdm6ycRTjshOD/h8IYPrjUQF3Grdo4ps7Bm/lJhUSWDtcLeWV4lMJ+iTG6E1z
 eM64bao/93r6ItYZq80u1vx7H+4BpUU5YF7C283Dw5VCMmTGBrXc/DB8cGBwe3c+iKMb
 m/hg==
X-Gm-Message-State: APjAAAUFhPB68apXfdMKxmWNVXV2U0ltElL/ypQXKJFiVQg/zhbiKQan
 7CTqSTdYX/7M7yOu28lFDR9o0A==
X-Google-Smtp-Source: APXvYqwjijozrDRhWUAndMWO5/xdg0VgA1fpRQYaJeShpUiGqcveaJquSgLpfUt1lvD7+ylXBxEg9A==
X-Received: by 2002:a1c:be11:: with SMTP id
 o17mr110956032wmf.115.1564589244207; 
 Wed, 31 Jul 2019 09:07:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y16sm149394681wrg.85.2019.07.31.09.07.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F01FB1FF93;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:31 +0100
Message-Id: <20190731160719.11396-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 06/54] trace: expand mem_info:size_shift to
 4 bits
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will allow us to trace 32k-long memory accesses (although our
maximum is something like 256 bytes at the moment).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: expanded to 3->4 bits]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-events b/trace-events
index aeea3c2bdbf..63bb192ade6 100644
--- a/trace-events
+++ b/trace-events
@@ -149,7 +149,7 @@ vcpu guest_cpu_reset(void)
 # Access information can be parsed as:
 #
 # struct mem_info {
-#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
+#     uint8_t size_shift : 4; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
 #     bool    store      : 1; /* wheter it's a store operation */
-- 
2.20.1


