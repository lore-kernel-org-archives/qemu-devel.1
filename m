Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3836DC4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C497D20780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8xotYvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C497D20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO00q-00085T-Kx
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsa-000552-Ql
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsY-0002yg-Px
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so3432888wme.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yp/YjDj5QeuPSc08DCe+GT6Bj66xcIoVhoaUCUMskJk=;
 b=A8xotYvCTaKUGYSwxBadJsY2MyxpU/HtDYqnsz4MvOK229Rt7Q8tPw0+5AB74Jo4ZM
 O+4WgY9wa4toQvj6MQPrmViT4KTC97KcmT6DQ67MFQSPZCp7S32MppZSmQ+faMIVdo7N
 /BpPIQqEcPHltok0WiQbR4IbdsOPyv/Mhu5Re7rjgpzfodizoLbdVPt+yTo6sC3RPEYl
 UxWS4aF4pmv/Xo+hPDzSgqItYxEeixXi88YRh22FGR92vh02bs0W4xsn49PKtdQCAvv9
 bQZ5UZNKO2kU2djiD6uo5SaT9IzNBS74prXbKml6cfW8SXwjZtCB2Ml23VQIHbfWNmr2
 XjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yp/YjDj5QeuPSc08DCe+GT6Bj66xcIoVhoaUCUMskJk=;
 b=Y5nkaYiJMKWzCFY0yL5mz42QZg0D+9cU7TBNcFg3nzQQWPOKF0MWt5m/RjuNZst5fa
 n3qUsg8TAOj23MWkg86/fklVnsU7Ze00i02YF/mmFytjgQR8fotSAckrCJZOn/zYAmCz
 sJJp6Dol2w7iiSDBTg37+PzZsFK5w+gBD8h1+oOksz1LkBCbho6Dl15aFCpo2458Vvf0
 RBnWgIAVet3ecTww8W5LBamQPBZ0HQTW3TP7HT5BRV7FXLDE5h6MJX05PdF5gwmFciNf
 o55Hk0Z/D0V7NP+PVZbCrrr0qPwArRzYz5OvMLYILdeGeuwPoBmqXVuyeZLg9kEgJ2LG
 /xyw==
X-Gm-Message-State: AOAM5302pDQxxaG65k1ZSeyAfdugHYYWm/BvzcXZ3T0sgDa6v2RBu2lW
 Td2J5x8RdVKVdA7vbgu2RDJFHqVeDW8PhSgO
X-Google-Smtp-Source: ABdhPJyo/faLOSk98d4VPownqniU+ZzeyFFg430HD9v+K2YBrlMGwdoUCY0b7h7BYlZqL1PxYbfdpQ==
X-Received: by 2002:a1c:9893:: with SMTP id a141mr375610wme.188.1601563697182; 
 Thu, 01 Oct 2020 07:48:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] hw/arm/raspi: Remove ignore_memory_transaction_failures
 on the raspi2
Date: Thu,  1 Oct 2020 15:47:51 +0100
Message-Id: <20201001144759.5964-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Commit 1c3db49d39 added the raspi3, which uses the same peripherals
than the raspi2 (but with different ARM cores). The raspi3 was
introduced without the ignore_memory_transaction_failures flag.
Almost 2 years later, the machine is usable running U-Boot and
Linux.
In commit 00cbd5bd74 we mapped a lot of unimplemented devices,
commit d442d95f added thermal block and commit 0e5bbd7406 the
system timer.
As we are happy with the raspi3, let's remove this flag on the
raspi2.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200921034729.432931-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index d2f674587d3..811eaf52ff5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -321,9 +321,6 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
-    if (board_version(board_rev) == 2) {
-        mc->ignore_memory_transaction_failures = true;
-    }
 };
 
 static const TypeInfo raspi_machine_types[] = {
-- 
2.20.1


