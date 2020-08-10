Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C0CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE6120709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko1WLEpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE6120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k55Qn-00041N-Ng
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k55PM-0002Gu-BQ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:52:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k55PK-000558-BO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:51:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id y3so7706060wrl.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZFMHqgtK4joNIT/9rWbW+hlBCF9dx6g0E6pjSUq3iHE=;
 b=Ko1WLEpYrwDjUycTAUFZMegY7nQxEYL9f0JsubwIRKfIazXcXXtVWHCZw1oX1XqMLy
 mMHFO9caAiXj4znMm5G1AiNxARwTdiGnDPG87xA+/kUA1DfZRgvxPPcS9hSseX5FqKzg
 H+W4MsptHyS5FAHgSE7BJwLNwxSJUu9AswDJKjVgEBgF3rCc236cNN6Z0AV9GyYvYOjx
 Yab3SZ8M6zobDB9A9zH9qhvEA15wDhNgnm0rcGgiXdmw/2JstBjiqgL6ASXUAVl6x76K
 fFplc3Zio34QSwBySK89haCb0wj2tVPxeSWtu2T5CAkFgZvJR/nBEvZ7ehnfXB/9F3Dz
 OieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZFMHqgtK4joNIT/9rWbW+hlBCF9dx6g0E6pjSUq3iHE=;
 b=QCohaUTlmrMGseb1dPVfHXjPH2/L7ampsI5T8fCc6kSGUs6nJZSw1C9ptdzJRkzbbA
 q45210DbmgiTjSN3cGdIKJnaRdii+0GIySBQX3P1p36IKqWp+YacDymk2MDaX6RI4Xb7
 2tcy8aKjSDHcX9eFoAa2iUIrzIcMKYtqNSHZ2UItxlp74Y0if2AZWAoTHW6rKvX9fO67
 BEUFHIxTVVii/0XiPmmPs0MiE1gy1Kx3ZNTF0jyy86pIC/vfSNJBACm8RR5rcLTsfEE+
 GnhpQllnZqzUoNGE6xVhAQ0u0mboxeWoer83oy3TRbdqSeSE7gHr03gruAFCGS2aohKK
 Af6w==
X-Gm-Message-State: AOAM532FGtmqsUaAh6l6XQbJirFkSvfpuNBqU/WMziuex/Xwn7ZR10+K
 //o0gmopvMumF35ey2Vs2jSdEw==
X-Google-Smtp-Source: ABdhPJy96PgPtawk91ylSNsPU63ReomYSEc+oN93a24khDnUOFo/wLxSkEsnXckQJBhrz5bAOSM9EA==
X-Received: by 2002:a5d:5641:: with SMTP id j1mr24495239wrw.399.1597056716293; 
 Mon, 10 Aug 2020 03:51:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 6sm6268969wmf.4.2020.08.10.03.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 03:51:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4868D1FF7E;
 Mon, 10 Aug 2020 11:51:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] CODING_STYLE.rst: flesh out our naming conventions.
Date: Mon, 10 Aug 2020 11:51:47 +0100
Message-Id: <20200810105147.10670-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
v2
  - punctuation fixes suggested by Cornelia
  - re-worded section on qemu_ prefix
  - expanded on _locked suffix
---
 CODING_STYLE.rst | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 427699e0e42..e7ae44aed7f 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -109,8 +109,34 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
 uint64_t and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
 
-When wrapping standard library functions, use the prefix ``qemu_`` to alert
-readers that they are seeing a wrapped version; otherwise avoid this prefix.
+Variable Naming Conventions
+---------------------------
+
+A number of short naming conventions exist for variables that use
+common QEMU types. For example, the architecture independent CPUState
+this is often held as a ``cs`` pointer variable, whereas the concrete
+CPUArchState us usually held in a pointer called ``env``.
+
+Likewise, in device emulation code the common DeviceState is usually
+called ``dev`` with the actual status structure often uses the terse
+``s`` or maybe ``foodev``.
+
+Function Naming Conventions
+---------------------------
+
+The ``qemu_`` prefix is used for utility functions that are widely
+called from across the code-base. This includes wrapped versions of
+standard library functions (e.g. qemu_strtol) where the prefix is
+added to the function name to alert readers that they are seeing a
+wrapped version; otherwise avoid this prefix.
+
+If there are two versions of a function to be called with or without a
+lock held, the function that expects the lock to be already held
+usually uses the suffix ``_locked``.
+
+Public functions (i.e. declared in public headers) tend to be prefixed
+with the subsystem or file they came from. For example, ``tlb_`` for
+functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.
 
 Block structure
 ===============
-- 
2.20.1


