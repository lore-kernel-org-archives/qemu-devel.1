Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51C32224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmFXsIHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51C32224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQRa-0001ot-FT
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQQ3-0000XH-Ow; Mon, 19 Oct 2020 04:21:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQQ2-0001Ur-BW; Mon, 19 Oct 2020 04:21:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id p15so9379624wmi.4;
 Mon, 19 Oct 2020 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hM1ZHQchOaueRw4tlfbygWyj5MUN7emcMZzc9ul6e4k=;
 b=cmFXsIHKBuTUv7g6TECbXzKVSMBLRAMPh4IcJnTcZL9wU8BA6XgEJsJlBiGhdzuOJ1
 r75RBephtUH4Ce6WVkGgkh21brj5BJm1UnIPg8Te05bFWqwFmXOLxTHlU3JtOT+Y5VpC
 GXdpUmA1zR4UKp30ocx93MhUPloM0qQ/H9D+56wT9Y0yTY65NuFkPE0YXBLGuY2VgtcM
 f9ZuDrxv5RW2gojdYbLHkqcwZmYdy5w3ywbfC1pJOlPL+Ayb7Pk1z1RjwPIcNKFV+3a1
 s/23rKS5x8EeyWnpBDmyyUayJnlcCTxjRG1dMmz5v4n4TYmcGmeIQmSxxscQPXRlum0m
 FAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hM1ZHQchOaueRw4tlfbygWyj5MUN7emcMZzc9ul6e4k=;
 b=c9hm7IftYKpuN07psJJxxKp1rHOk1FUMFaNtOYAXJatzDRXsaAEGnUtlJSP40OcQt+
 05p7ZTr+NU32D0AgHDX1l3mx7aWFOZzFUVQ2RBETRKN6oBMMq0QrXQOW+vF9Pnd60Rde
 FQc77Qly6F5OdAxwn2LfNuTgQpcj5Mv6zWqdGX7WMCaITEORlsaqgLTeTG3aZcfCD9ah
 TCUSMNSvJ7zdkaF+DkZBvFpPlULsc13EFRdSLNjyO1OxL7CMA08S3P++tnbrbKtVIV/V
 UremTiFFQal20DZEH9LLH9nG9mnHIRFl1su+AjroXPzLztDYzG9EuMV8KHAENjrzHLbb
 eNlQ==
X-Gm-Message-State: AOAM530wF/QXeVyJa+ZBIOeXPvddNXnI1K2UXX2+8LVx3pGK81gR98Sq
 HV+20eEZD7bHb2+AFqe8CPgTgwSiDsw=
X-Google-Smtp-Source: ABdhPJzxvYH7eKlZ4OpgyK5IGNvEwdccJvuu7t6wkoUcQ1zykT98a5ut9jl6CA48lrr4PK9Hl9n55g==
X-Received: by 2002:a1c:6355:: with SMTP id x82mr17196952wmb.177.1603095683572; 
 Mon, 19 Oct 2020 01:21:23 -0700 (PDT)
Received: from localhost.localdomain (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id a3sm17315127wrh.94.2020.10.19.01.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 01:21:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/system: Deprecate raspi2/raspi3 machine aliases
Date: Mon, 19 Oct 2020 10:21:21 +0200
Message-Id: <20201019082121.1544550-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: libvir-list@redhat.com, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit aa35ec2213b ("hw/arm/raspi: Use more
specific machine names") the raspi2/raspi3 machines
have been renamed as raspi2b/raspi3b.

As more Raspberry Pi 2/3 models are emulated, in order
to avoid confusion deprecate the raspi2/raspi3 machine
aliases.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/deprecated.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 905628f3a0c..f0c7aaeb2ff 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -355,6 +355,11 @@ This machine has been renamed ``fuloong2e``.
 These machine types are very old and likely can not be used for live migration
 from old QEMU versions anymore. A newer machine type should be used instead.
 
+Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
+'''''''''''''''''''''''''''''''''''''
+
+These machines have been respectively renamed ``raspi2b`` and ``raspi3b``.
+
 Device options
 --------------
 
-- 
2.26.2


