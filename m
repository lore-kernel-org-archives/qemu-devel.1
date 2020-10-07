Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D62C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310D9206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dijSX8gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D9206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCQQ-0008Ql-Sy
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0x-0004VB-IR
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0t-0003G1-Ql
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id n18so2861684wrs.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T4OlA2fKjLB2JyoNuPi1vxgCv/+/8y6KBFdMXYJZSgU=;
 b=dijSX8gwzjlbPx4Bm1VhiES6AApqzaNQeI6LhUXgVh1RDeUIU04SZN//GbzSudzSK/
 JVSWQtek+6r06qEQQHgrO8Wy4AkFZsi47p1HWLLqe4i3FwhnApq9IOmZKgNwdKL9+EDs
 qAbt2ZT8IUfiN9seShoXUUXKdglMoH5Tn8/QprPWveaix4Mpzo9H/SXnZMAeSJuKEKxy
 miSgAPEu319Ny7oV7eASHuQn8+hl/lCBPGDm32nHtqmJ563q77g2L+anwQ2rgXUgSSL2
 14bJTPaU+O8g23LEHBcutJBi7OK/lrCeQSNVolRJ0vJZmtEqgRyGf3XHTYjv26c+2/8E
 nJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T4OlA2fKjLB2JyoNuPi1vxgCv/+/8y6KBFdMXYJZSgU=;
 b=Hf+GH5wT/bSQ080ZcmLoQz0O7aFwJywlJ3oXxlaX3VTPDxDRUvqHSaIjsjj9Zs/LrC
 N8luMnalDu5vEpzuPxcQfMj/BrYL6w69nhRg/W3GxTESFpNBkiMvAK7isCqcdyqm1JsO
 r34LYvgra435jsOrHxwoZkgVdsh4PCpNaAIFXNWFaG5Is8KH7wht3EZaDG8U+0kfQFtK
 qCyGeBU1XD7yClk4YDhJfSPfpwUbfYPQvtbRtoqZyT16fNyvwHxdLU2oLBSTHRn4THuM
 AcBRzRtyytOs5AFyiqEsKqqIZxLS0KpeKb3LeX38zMt6nezoz7MFuKZOAZT60GKZCmSD
 IOrQ==
X-Gm-Message-State: AOAM533IXC3bToJ1SeAMlvnzn82GksnlGZ8M9y323JZlRJ/MnlrBxz/m
 mga/NSgJw3uOLFCcimpWfPZ3Oo9mFndiDQ==
X-Google-Smtp-Source: ABdhPJyqT0R2/Ju/AAqXpw0J/QBIbkXpCWwBYdHps4h28nKSnKQot3Jg6Uo82Isy7p6GriIVv5wxOA==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr4623521wrt.255.1602086997956; 
 Wed, 07 Oct 2020 09:09:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm3338295wmf.25.2020.10.07.09.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29EAF1FFAB;
 Wed,  7 Oct 2020 17:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 22/22] tests/acceptance: disable machine_rx_gdbsim on GitLab
Date: Wed,  7 Oct 2020 17:00:38 +0100
Message-Id: <20201007160038.26953-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While I can get the ssh test to fail on my test setup this seems a lot
more stable except when on GitLab. Hopefully we can re-enable both
once the serial timing patches have been added.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_rx_gdbsim.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index 0c72506028..32b737b6d8 100644
--- a/tests/acceptance/machine_rx_gdbsim.py
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -22,6 +22,7 @@ class RxGdbSimMachine(Test):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-- 
2.20.1


