Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD3C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304C520780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxdb85ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304C520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO00Q-0007SH-TF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsb-00057G-Ms
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsZ-0002yx-Pt
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x14so6105681wrl.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dzYxyPNSak4m4BxdikZP28jEW5s35X251fWvyhySyCU=;
 b=uxdb85razJFm9v0stQ1btcmy80mZRsjx/8222hiFejATPkoAmRYyDHjhxQyOzQI46a
 gxlcKMBNgTIQY7QOYYFH/VG7WjzygTsTr0hGYNo0EkvZB/GXbQFYo1t5CDE6tenf1lYI
 xqQD7ubWMlg5VbVwy3S/movb6nBQBLPSKAfiHF+GEd+fizGHptIWAOiBTaAu7U4JHcA1
 reK9VuR8vaaU4Wp32VNim+C+8mmpqn9QUgMnnEsViDsQr2MOgXwsbp+nPWckNX7po738
 mb15X2St07YVB2lke7AV6+nbojC6yPUxijzinK+1NIUp76tdqhtwDsKXW1s/WR9hegUv
 VXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dzYxyPNSak4m4BxdikZP28jEW5s35X251fWvyhySyCU=;
 b=CCytavYqglOQOU4jsf2/uUV/ZKg6O5Eh8Rs4jnnxmIWDNT+Zn0pZ9PCGqoxyHTT1oN
 PxStelSv1yLirdSfO3oMgJb4lD2yjeKfp4dzcwWP2n9jPDFNLKOD4x5uvDk/CoVMxPJ4
 Pbj4yw+re777a0vUwjN7nDR08V6Oddd/ws+jN+VxQZlD+6t8Of6cUSkjQwc6xz+Gzllj
 sg9V3gcm/ZXoN53rNTjivaqrKOloDSuSv2bt1zfLqAGCOaU4JwUgm0ccWxChu0/DJHKt
 bOUUI7GPYiu5hwXTNzCVkZflQYStj6ny+8+UqpSnqfyht1jd/vJyE2s/KFfQFsrprLW8
 h3Ug==
X-Gm-Message-State: AOAM530cUTSUY5GKcnJg+01nwctlqvg9VXCSQZjGU3FRb0BPz1SzHQhG
 dnTWn7nJOFOftDOm9v54Ru2hwxT4+rpEXdzU
X-Google-Smtp-Source: ABdhPJzMuqNUaVSKWXCG5hPs+wPqQnjWujHKL6JGIgOOHXjGRm20hfyUQyeWT1OzfRnAk0tLeGN5aw==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr9364940wrp.91.1601563698148; 
 Thu, 01 Oct 2020 07:48:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] hw/arm/raspi: Display the board revision in the machine
 description
Date: Thu,  1 Oct 2020 15:47:52 +0100
Message-Id: <20201001144759.5964-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Display the board revision in the machine description.

Before:

  $ qemu-system-aarch64 -M help | fgrep raspi
  raspi2               Raspberry Pi 2B
  raspi3               Raspberry Pi 3B

After:

  raspi2               Raspberry Pi 2B (revision 1.1)
  raspi3               Raspberry Pi 3B (revision 1.2)

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200924111808.77168-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 811eaf52ff5..46d9ed7f054 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -312,7 +312,9 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
+    mc->desc = g_strdup_printf("Raspberry Pi %s (revision 1.%u)",
+                               board_type(board_rev),
+                               FIELD_EX32(board_rev, REV_CODE, REVISION));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.20.1


