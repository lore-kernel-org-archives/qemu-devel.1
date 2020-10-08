Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A330C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E302F2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G28/ASjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVZs-0000hO-TG
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTw-0003ho-HQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:16 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:46152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTu-0001yl-Op
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:16 -0400
Received: by mail-ot1-x333.google.com with SMTP id m11so5322305otk.13
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=afbVfXCyOnplvKb9IQqsRxrxK8WhYnUUFrCjNMF3AZ4=;
 b=G28/ASjTcFEZQLjo/pgajDu2EJPJdsbMWr9EC4tCC94EwD0ivxn3yQx077HJ7iNbav
 K6zzyTQX5sKCu59KHOlicP4Id5qsKQwHFJH0qYVUPsW9rNdJridA6D2LdRB8sNt2+Yex
 oy/vbA6FyWpzLx1DagBK9+yV6wmYzY4cxjzRLCGxkCFJzuBdVCjJmS3WC6/XD4XK/5xo
 6MCyCskVzjdureycwHDQX44h2LaY8RhRhxPIo5NO5u1lPAugbT1Ky63WVXLOGoS7edt4
 nLdicSy6NErneiIaHywjlhMTjjiOb61k1z0gil7qzaAwtq+mMlJzgVQ9xI1HdZ3VTCpM
 OI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=afbVfXCyOnplvKb9IQqsRxrxK8WhYnUUFrCjNMF3AZ4=;
 b=uT/QvfDNrNf8I+CyunLc/slTq5CArHoNs5JcyF3vl5sgq+Lms9aILNZxfZDxzVyK5k
 +Qi3so4Fz55Lg+cvxCaXaPw9M3cFQXotwRBFUA8NZscf0VNwH/KgoetCtsdUdnVYoyhI
 cCiTcUyiNk37LWaMm+uhrbwb6Bfbnf7bQrzQkGlAHuTab5N9e4MRcIk+Lat+Ke6gZQwl
 MW/X5ZFlO+wATaBDFAZ5eSwDhnGNsDrrMf13ANIcRWiUsGjiPd/KI+3D4qeD0qnig1Ge
 tD6HVckLXVCpkO1TtnGklxZ2AsMamiBNU8coU5ZKNXlIHjyvL/0K9ghgNHIU3dz1m+u7
 PYig==
X-Gm-Message-State: AOAM530xgnrlQm8VBFOFoXwEsYdHKiAi16OglbpMcEZxlyioiIybbWmZ
 QAdeQHfmYbCNhsbmgJx6NFD7oofXbmiT+pZL
X-Google-Smtp-Source: ABdhPJywMVs+ZYNf31vHQ7PppXcwCp0hwMJOfhSaUYdgEhiCtHfCNWtOcv2jEcXhwlTSVlfx6wBSOw==
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr4838365oti.333.1602161833346; 
 Thu, 08 Oct 2020 05:57:13 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] tcg: Remove TCGOpDef.used
Date: Thu,  8 Oct 2020 07:56:54 -0500
Message-Id: <20201008125659.49857-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last user of this field disappeared in f69d277ece4.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e8629b58c8..8804a8c4a2 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1015,9 +1015,6 @@ typedef struct TCGOpDef {
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
     TCGArgConstraint *args_ct;
-#if defined(CONFIG_DEBUG_TCG)
-    int used;
-#endif
 } TCGOpDef;
 
 extern TCGOpDef tcg_op_defs[];
-- 
2.25.1


