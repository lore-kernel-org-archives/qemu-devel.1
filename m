Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8286C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CB9207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rELaVH3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CB9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwzW-0000rf-3w
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxZ-0007ee-MM; Fri, 23 Oct 2020 09:18:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxY-0000cM-4S; Fri, 23 Oct 2020 09:18:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id x7so1807760wrl.3;
 Fri, 23 Oct 2020 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wLnfUB1E+Omdt6l8atwBLe1J9aeiH1JFkUJl824leKI=;
 b=rELaVH3qb1SPVUH7QdK6VyjOZYzYMe412z748/q63NvGwmgEyWHB2eyIfRprk9vWi3
 H1qpi1yBxzAVxC35uV/x2M2FiONYJU/zvmkNQx3I2MfTlwhl88ofo45gkT8OLGaloRp8
 ubRHQZVzFUMrq+H3Xw1D4OCKIlkkLVmet4jpFjSz1p5sTEFOBUPkUIQZOfdcNepBGHMY
 M8LSt4UMCpnSkmvZgw9ynD69op84C6JqkN+UqGk/AQHepEacZ4qFT8JcKiOgBCojACD7
 a3AZa6y6r5dxc55jBTvpsh/E2sysb/kAQMmRQyXh1OypdjfTZ7Gth8cmoliMm5penrJ8
 RAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wLnfUB1E+Omdt6l8atwBLe1J9aeiH1JFkUJl824leKI=;
 b=rqT00kT7n5NcSW+pGh2nNINCPWvCLWV3AtILew3DgKcyFgGblnAXNSpsDvf2Q78Qck
 O2EYBlomrHAL6TH1D11nSApU+qhpVyMd7ow+AxbwQMS3qOPUf/gVidjdh2XJIxun7euz
 ypXNyfGVI104EBKNPieBAcCBjIMTApG6jifRix44ZqJ97jdDOqh5t1N8RSP9lhRZ1+vh
 Glhsbo9FSVdCAyRcurudsMAJk9WBAgUDx6MxozP4qf2u1pdznLIGYKmdfhm79uKD7iMv
 o5XoR4u3kaguOd0NfHivSViDfDH0wYVPsWsVrV0M2Bm2Rjra2qpm8ssOP0kw1lmr8h1w
 824g==
X-Gm-Message-State: AOAM532cd4y3eBpA0IZuOpc1wz3kUm+paTxf6IBv8iz6o0nlsWRO2kl9
 7NLTCdxJ2Eg0OM8u0mltsPaOTr5AWDU=
X-Google-Smtp-Source: ABdhPJziDLnHcrCPbzpxoMFk7/9rzIXvgrr93Hb+ODjvg0SdExy0vvgi1q5SyW9HX3vdl/ppi5o+GQ==
X-Received: by 2002:adf:8562:: with SMTP id 89mr2536311wrh.214.1603459096308; 
 Fri, 23 Oct 2020 06:18:16 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e11sm3110359wrj.75.2020.10.23.06.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:18:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/4] Revert "hw/sd: Fix incorrect populated function
 switch status data structure"
Date: Fri, 23 Oct 2020 15:18:05 +0200
Message-Id: <20201023131808.3198005-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
References: <20201023131808.3198005-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit b638627c723a8d0d2bb73489bc6bf9ff09b8d53a.

Currently booting U-Boot on the Orange Pi PC we get:

  console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
  ...
  console: Autoboot in 1 seconds, press <Space> to stop
  console: =>
  console: => setenv extraargs 'printk.time=0 console=ttyS0,115200 loglevel=7 nosmp systemd.default_timeout_start_sec=9000 systemd.mask=armbian-zram-config.service systemd.mask=armbian-ramlog.service'
  console: => boot
  console: unable to select a mode
  console: Device 0: unknown device
  console: BOOTP broadcast 1
  console: DHCP client bound to address 10.0.2.15 (12 ms)
  console: *** Warning: no boot file name; using '0A00020F.img'
  console: Using ethernet@1c30000 device
  console: TFTP from server 10.0.2.2; our IP address is 10.0.2.15
  console: Filename '0A00020F.img'.
  console: Load address: 0x42000000
  console: Loading: *
  console: TFTP error: 'Access violation' (2)
  console: Not retrying...
  console: missing environment variable: pxeuuid
  console: missing environment variable: bootfile
  ...

With commit b638627c723 reverted:

  console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
  ...
  console: Autoboot in 1 seconds, press <Space> to stop
  console: =>
  console: => setenv extraargs 'printk.time=0 console=ttyS0,115200 loglevel=7 nosmp systemd.default_timeout_start_sec=9000 systemd.mask=armbian-zram-config.service systemd.mask=armbian-ramlog.service'
  console: => boot
  console: switch to partitions #0, OK
  console: mmc0 is current device
  console: Scanning mmc 0:1...
  console: Found U-Boot script /boot/boot.scr
  console: 3967 bytes read in 16 ms (241.2 KiB/s)
  console: ## Executing script at 43100000
  console: U-boot loaded from SD
  console: Boot script loaded from mmc
  console: 153 bytes read in 10 ms (14.6 KiB/s)
  console: 11185760 bytes read in 6698 ms (1.6 MiB/s)
  console: 7788240 bytes read in 2966 ms (2.5 MiB/s)
  console: Found mainline kernel configuration
  console: 32121 bytes read in 50 ms (627 KiB/s)
  console: 4185 bytes read in 23 ms (176.8 KiB/s)
  console: Applying kernel provided DT fixup script (sun8i-h3-fixup.scr)
  console: ## Executing script at 45000000
  console: ## Loading init Ramdisk from Legacy Image at 43300000 ...
  console: Image Name:   uInitrd
  console: Image Type:   ARM Linux RAMDisk Image (gzip compressed)
  console: Data Size:    11185696 Bytes = 10.7 MiB
  console: Load Address: 00000000
  console: Entry Point:  00000000
  console: Verifying Checksum ... OK
  console: ## Flattened Device Tree blob at 43000000
  console: Booting using the fdt blob at 0x43000000
  console: Loading Ramdisk to 49555000, end 49fffe20 ... OK
  console: Loading Device Tree to 494e4000, end 49554fff ... OK
  console: Starting kernel ...
  console: Uncompressing Linux... done, booting the kernel.

Fixes: b638627c723 ("hw/sd: Fix incorrect populated function switch status data structure")
Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c3febed2434..c17197785bc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -823,12 +823,11 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     sd->data[11] = 0x43;
     sd->data[12] = 0x80;	/* Supported group 1 functions */
     sd->data[13] = 0x03;
-
     for (i = 0; i < 6; i ++) {
         new_func = (arg >> (i * 4)) & 0x0f;
         if (mode && new_func != 0x0f)
             sd->function_group[i] = new_func;
-        sd->data[16 - (i >> 1)] |= new_func << ((i % 2) * 4);
+        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
     }
     memset(&sd->data[17], 0, 47);
     stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
-- 
2.26.2


