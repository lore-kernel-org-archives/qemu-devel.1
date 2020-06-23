Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B155C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B9D20768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWuJXmrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhI4-00045j-FH
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGi-0002H1-Op
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGg-00032s-Cq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id f18so2852072wml.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e3yZlBX9xNiG28mBJ+uBjbIqL32jKJprQAQLqWGSi0A=;
 b=VWuJXmrqw5jLLWYk1lXl9ByPaFD/NRv9X7Xadp3Hzi8ZQBz3mPe4r+JFKlsDYpgCsz
 1HP1bKaxXNVTCJn1fyw5ru0AxaeZASByNijBWrHhe4fnHVHZwAYbXgGE22COfgL/BPvD
 KvU9w2F5DhWO7qVMrqWbscf8uJ7Dg3oRousyncgy7TGV6AGCJ5LaBWIDcnObV1ZESb3h
 2yt/CKzYV3Vnfp5KGCQ81eILjhswDLbRzoZF1VCCiqOntMzIfxg4zfQ9qcNwCOQgeog7
 qxTwFa15UyijDPzxkEU5wzJopwq4pkP4h2UHnOMK/uZkuTaEZtXG+q8auDNjpn1LfrP7
 QpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e3yZlBX9xNiG28mBJ+uBjbIqL32jKJprQAQLqWGSi0A=;
 b=rBDauGkPqpojmwDcIrinHuivdn0Kc+Y4rwhLpMGbF+CKUPUWgyJYIfk1H4iEdnb+lw
 rcpTHOk6k8CEt8VSUOl5rjmYgusH0VshOwbxpIJy/hsBqA5g9STjLzqDPKB7q9GxsXTX
 qK9WUmg4UCfq+uUViDKoTZtvUsnDUOfxOz2MyTJ82qWM3TvSXZUD//ImRDukwI0AUMkx
 WXF+5gpAEOa9R547YeAMOYExSE8Qo2Wj0WHB20pUJ+JmS9elsmgIbdPkDzj6Am9x8EDb
 LyhpVUk1HUQUicRKYTXoj809CHbBtB1PujUkkgFXscazK6pbSvwfQ/K9EPQX7jcAXHYg
 pETw==
X-Gm-Message-State: AOAM531f44W1Msoas31p2LOXzLG2xBMEXfg1c6UnxdAsQDjl9b/hgaht
 6lYCrStOATC3jy/4h+N6pfcSo045Wg2hWw==
X-Google-Smtp-Source: ABdhPJxIaUycr491S7rgBlTgZKK1cO6pzvKeF0E4BO5MooNaF1yLcojznUKRJ/UdIX2QOCFgVLs4XQ==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr9086839wmm.48.1592912347866; 
 Tue, 23 Jun 2020 04:39:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/42] hw/arm/virt: Add 5.0 HW compat props
Date: Tue, 23 Jun 2020 12:38:23 +0100
Message-Id: <20200623113904.28805-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Andrew Jones <drjones@redhat.com>

Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20200616140803.25515-1-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index caceb1e4a05..8b6e6aa7b13 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2375,6 +2375,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
 static void virt_machine_5_0_options(MachineClass *mc)
 {
     virt_machine_5_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
-- 
2.20.1


