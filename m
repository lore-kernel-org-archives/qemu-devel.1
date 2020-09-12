Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA8C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FE3214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmJkUqjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FE3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0w9-00030R-4Y
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0ut-00024H-Mh
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0ur-00022m-QR
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so13647674wrn.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sRmT9s6gxreTis3LbuIGANYw4jl0FBXlKwAjDaThnyE=;
 b=dmJkUqjQLxjUEhk3JjA28gOZXMqOFceO6OO67PrEV9PzcC3jsl0yeAybKVIW+twfsD
 O08uqax+lqQuAF7zktMpmhFKsdzNaMxc78S+WderMVPT5kECo1CSQSF+K3rMl2YX5b3B
 i1wAItIJmc+WX3Zm3ADXjYwGnOxZ4Le03RiHUqH9TdiUT7FLwzyoNtkOuO7PT6hXJWXS
 baaWyuRXkg632jtXnOKtHYXBy4gjMVvxO4qsaGASrDRy740r7ecXVInHc1kq757HJeTc
 EP+4bFq/YTfHZqh4SVzqg1M03lyrxWRIy/7QEGaNpdB7WrUGBbTFHI5Tmcj+Vf1qTsF2
 LcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sRmT9s6gxreTis3LbuIGANYw4jl0FBXlKwAjDaThnyE=;
 b=FYI9TRb2HpQk6bquTLOy0yfbRCt1imNlcyLyBB4LuC4SMEXtYb+9gEwLYLepRfscre
 SofEbMYUesi4y5C7UtLmQvxGuoL8fcj9fqUXzKyvm6U2RL2DkTYF/dYkPg7D+XZ/iUL3
 uF1LWsrrMfdAIF9Pzf67BBSvlKhCfz2VNaB9Daxj/4OdZuIH+8kJ2bRt0O4Wen1wA229
 AanakOhy3qLFyRoRZH5UTM9kM7TWJjDvoQgFrEqe3Ea6uxwYU3zLfyC48EQR6WV/GZcW
 ZUT44zhJ2QHC20Atl7EixrI5JhujnRChC61USi76GTNFMgcmY0mxB9KST69oXfaPeSo5
 TdCw==
X-Gm-Message-State: AOAM531EgnrPwp2SLyLcQihp/ByyEl2ofbwUtJ5mRemMhbB+To9zY+3Z
 viWjzjde+VkTmedMZjhd7mnmnFUVDXs=
X-Google-Smtp-Source: ABdhPJzJUVFWcGD6npESWVNmWeXi3bzXWmk24AkYwVkVUoNE403MAtZ82QIYNRGIRxodHp+E373hBw==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr6031768wrq.203.1599899388204; 
 Sat, 12 Sep 2020 01:29:48 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm9598698wmf.41.2020.09.12.01.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 01:29:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
Date: Sat, 12 Sep 2020 10:29:43 +0200
Message-Id: <20200912082944.890972-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912082944.890972-1-f4bug@amsat.org>
References: <20200912082944.890972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'mipssim' is not a real hardware, it is a simulator.

There is an ISA MMIO space mapped at 0x1fd00000, however
this is not a real ISA bus (no ISA IRQ). So can not use
the TYPE_ISA_SERIAL device...
Instead we have been using a plain MMIO device, but named
it IO.

TYPE_SERIAL_IO is a subset of TYPE_SERIAL_MM, using
regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.

Directly use the TYPE_SERIAL_MM device, enforcing the
regshift/endianness values. 'regshift' default is already
'0'. 'endianness' is meaningless for 8-bit accesses.

This change breaks migration back compatibility, but
this is not an issue for the mipssim machine.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/mipssim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b7622035..5d4ad74828d 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -216,10 +216,11 @@ mips_mipssim_init(MachineState *machine)
      * MIPS CPU INT2, which is interrupt 4.
      */
     if (serial_hd(0)) {
-        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
+        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
+        qdev_prop_set_uint8(dev, "regshift", 0);
+        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
         sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
-- 
2.26.2


