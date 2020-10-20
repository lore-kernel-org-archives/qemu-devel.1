Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC9FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E3F21534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3DX9XUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E3F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuA1-0008E3-VS
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0e-0004E1-Ab
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0c-0003r3-GL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id k18so2508274wmj.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fcvS5KwPH9BB5sdq/tDFX01ywohiKwH2/PzxO6MFTBs=;
 b=K3DX9XUSEK3FlPH1aQN7+eCgkbAkO2G+wEI+cYNdxGzCW/Q0xbQm44+MpoehGGyou3
 FGOK6nlWrgolZqbzDXDoT5SrovcWi+YO9MCBU4uUrwvorkZmZEqpSzIps8xosg+qZnGk
 HS+mP0/O54e7cWOTCHlU/4hr7vwTr+qLdvp/EoifYYM2+p/5Kx8TtXisMZSgoYjcMkeB
 nyEJLJoQCoweZDmfSkD4YwRrB1sI50wwzFwyRqN4Mbi1E7Fomo+irC8eOtrMT1it+KhS
 27vPwEww+HhA6z53YFMXdP1DAywPLUhpGL5B410lKhkAaYPDAnYS1NJromwK9OfJOrv3
 0j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fcvS5KwPH9BB5sdq/tDFX01ywohiKwH2/PzxO6MFTBs=;
 b=fOnyrKN2EJ3AjjOf07X+JBWNmzGI6/O7M2gCnTdT7703prbcyHzoYbnDHdg9f4t4fF
 fgZrHCJ3yjV5qFnsnzbK4v/uVFmUN6WfLZ6lpsJHc2ibJ+21nU3uVAGwBWIHl7lUCu1K
 IO3v2eL4XGlwF3K3mt1zudog3ssU8njF2aviHMp2KlMb6RPSUn1vEfl6K0cp4Cci9SOt
 pkw9J0PMbpLAaq3aZ7TcTnENfCzH2oJANPWXjwHaYLpi51iJLeGpZL3/6zHcd84tOVW4
 RtMT3HEVzW654q7vcNuv6uOzEFLVHWj2BtiwI7+mCn5/WszuMeX3Al7p2rKqQ6edng8s
 BNaQ==
X-Gm-Message-State: AOAM533T81Wi6xG+0oitpGIuQZRt5ruFP3Ezqv0hZGBJkz2o/5tfZ2nl
 rR9gjRdNHPW7ChNQwPZHKEtFgiChfSvZmQ==
X-Google-Smtp-Source: ABdhPJwii4ueGHX7QUXzAhF3XO4da7VD4BbngoPASGEJBDYTgeSTCloHng9xECvtJ/+FbARxx0U4lg==
X-Received: by 2002:a1c:9d8e:: with SMTP id g136mr3660010wme.18.1603209428447; 
 Tue, 20 Oct 2020 08:57:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
Date: Tue, 20 Oct 2020 16:56:19 +0100
Message-Id: <20201020155656.8045-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

While APEI is a generic ACPI feature (usable by X86 and ARM64), only
the 'virt' machine uses it, by enabling the RAS Virtualization. See
commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").

Restrict the APEI tables generation code to the single user: the virt
machine. If another machine wants to use it, it simply has to 'select
ACPI_APEI' in its Kconfig.

Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20201008161414.2672569-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 default-configs/devices/arm-softmmu.mak | 1 -
 hw/arm/Kconfig                          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/devices/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
index 9a94ebd0bef..08a32123b4c 100644
--- a/default-configs/devices/arm-softmmu.mak
+++ b/default-configs/devices/arm-softmmu.mak
@@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
-CONFIG_ACPI_APEI=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6bead2..7d040827af4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,7 @@ config ARM_VIRT
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
     select ACPI_NVDIMM
+    select ACPI_APEI
 
 config CHEETAH
     bool
-- 
2.20.1


