Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC29C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314932074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQP9Tyds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpLy-0004ni-4j
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8L-0002bk-1a
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8J-0007aZ-7W
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id w2so168837wmi.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9K+3sRtUMkIl+nho0SY+n71f40GQMbihw4qEScJq0L8=;
 b=wQP9TydsxVICpi6h3bfsmh6pc5C53eBOcWvsLUHeGIp8bF6OwXUJx2Q+9Fb+Vu21AX
 ccDrAUYK/4BZ9AQhCwnIIJVePJw7IauaP2FuTpTA+o/OSIa8LkfnShZmBDcTI8YlCW34
 IG46kM1ku08vqKo6Tgp7DnC8UGSskredgEyKS1CzGtRaEPzfjVxNURU0iMLoZ0LFaYiQ
 iqexx/qRF/J/54YgYUuhtdh90zyNs+i3Q8BKj35VCQ0yU0iq944RENMNvPoLCE3ZqyVm
 egVIByerlUX8dnsipBT2Yb9TGpemRVfFomyaAPhF365y4vZsSfznPFNEfr2Xjz29kgav
 vMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9K+3sRtUMkIl+nho0SY+n71f40GQMbihw4qEScJq0L8=;
 b=Ov2FJAOgCaWDEWWsOI4T3ZmzBCQttB7YHJ2h5ai9QP/ls5Xi63qilJTjwhdKrq4FoR
 QrqissGhZQG6Gbr63IbK0ZOma7nKxR/mB8P1IVWWGEdNeASGMfSuo/wJZiWzR0ed43Rj
 MPqfvE6uHivbe5ePn4Ri6DNawwEXGqvlw27FyG6BECK7iiSErqUKqWZ4Ub8Uc08T43Po
 K81Wq9GHh2FFg+6EePGYzfDFs7THdVkdoiM0AxYz8NZhBfBaMzJSHsNlQ5PkE/pzz0p4
 /e4vKaMLdxXz/kHttt+T6o7yakwq7CnFp5pwoVUAxJRXTyePJfKSTA1mt28s4fKOjuoT
 YXSg==
X-Gm-Message-State: AOAM530U7nMKoz69t5FsxoFfrpMeDcZYaPqKwW1LUGJRvqfGSddVvxgm
 DoyPKP7suRKHUvLiP35kZfuECOBOWqcUuZ60
X-Google-Smtp-Source: ABdhPJzTEIOYfMFX96hCPkidkOPsLNU0k30and3YvzR/0VTWIB5p/f/0R75ysI+Bb0SjiiEkQTIN2w==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr14863279wmc.76.1600092421462; 
 Mon, 14 Sep 2020 07:07:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] Deprecate lm32 port
Date: Mon, 14 Sep 2020 15:06:21 +0100
Message-Id: <20200914140641.21369-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Deprecate our lm32 target support. Michael Walle (former lm32 maintainer)
suggested that we do this in 2019:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
because the only public user of the architecture is the many-years-dead
milkymist project. (The Linux port to lm32 was never merged upstream.)

In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
the MAINTAINERS file, but didn't officially deprecate it. Mark it
deprecated now, with the intention of removing it from QEMU in
mid-2021 before the 6.1 release.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael Walle <michael@walle.cc>
Message-id: 20200827113259.25064-1-peter.maydell@linaro.org
---
 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3f8a00e9095..0cb8b014244 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -408,6 +408,14 @@ The above, converted to the current supported format::
 linux-user mode CPUs
 --------------------
 
+``lm32`` CPUs (since 5.2.0)
+'''''''''''''''''''''''''''
+
+The ``lm32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. The only public user of this architecture
+was the milkymist project, which has been dead for years; there was
+never an upstream Linux port.
+
 ``unicore32`` CPUs (since 5.2.0)
 ''''''''''''''''''''''''''''''''
 
-- 
2.20.1


