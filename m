Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C295C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20221205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InmqEqad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20221205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvac-0005ZX-Jp
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXm-0000rI-5L
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXl-0004yU-9W
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id h17so512344wrc.8
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DRD2Oc+28edn4pGWZOmfAbES32+12APNylpSTMMls1g=;
 b=InmqEqadv4fWc0UnVha5DVjkWZAY4cxuqXGO4upPEenVBpYAX82j3E9FoXNQ2HzNOj
 MqAG6Pw5+nJkbh2w+MVTH+m9mqyF/rO/RMfUdQxwCp6AYl1HZMFkfHeVrRurDHs5a+rE
 oPFeYF0jj1hxkWFIMIvhHp4pYSSInlIPm6q05oS6P8iq8HEMoALE2WOKhaq8FO3gBUff
 NaLD8jub6iozDi+ATPTpQgomNHntfryh9Goqe1sqITmKDAYqNQvuRY/htct5lmYu3hqF
 wbzsHijjEzuxN+MjOQSX8DVKBP0viLVfvB1VnOtCDqNQiXoYWywwHSwa8Y3HuWLwvaVQ
 P8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DRD2Oc+28edn4pGWZOmfAbES32+12APNylpSTMMls1g=;
 b=fGK2oxBXxQw6MILsdQipvfVB86E6bl2zJNHJzDr85PUrYUiXBpj8Ph4LexBEjuYCj+
 rT1en4bOG/aaGLuPmARfE4K2ij5iIUsTFvbOOvbJbZlucih4WwGUAcvJJ7Dt6Rf0edSG
 xI/eZc20+6KGR2ieclXO+2Q7jEiZ1YpRWQLNapNpvglRL6QBwvbDj/P88vpuYjZF6cqn
 qeRZl7q6m3QWbP1oYHDhiTj+SfKE+w2GMZUztj+hP678AuzrdrTsFcfNG0mk/MAt9tvg
 5ABJCQ8TrZKnOYUoSyFG3D7prBxNRmrXgSF5+7AE7jGq9dHuBTYjFUqjE9o2Km0CadxN
 OjLg==
X-Gm-Message-State: AOAM530QcLkEGrKlpOUew4XSFjFfvCjP+YVYFM+TsQ9FJT0cxuVGnyeN
 JR0Oitll1HLWfJAca+gRDqSOBcoHe5I=
X-Google-Smtp-Source: ABdhPJxBw5cApTJxruh6P0AH74umhM5DmrvNzzAfzYU1cnNqcQdtSmGpJHn/MfWa4x8kAzol9LSmig==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr559591wrh.254.1589392303678; 
 Wed, 13 May 2020 10:51:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u67sm24162531wmu.3.2020.05.13.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8101E1FF93;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/10] accel/tcg: don't disable exec_tb trace events
Date: Wed, 13 May 2020 18:51:31 +0100
Message-Id: <20200513175134.19619-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I doubt the well predicted trace event check is particularly special in
the grand context of TCG code execution.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/tcg/trace-events | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 01852217a66..385b9f749b8 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -1,10 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
-# TCG related tracing (mostly disabled by default)
+# TCG related tracing
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
+exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.20.1


