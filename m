Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BCE20671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qql1VEps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BCE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahMU-0003zl-Ub
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jahKf-0001RL-8l
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:05:33 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jahKd-0003R6-N7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:05:32 -0400
Received: by mail-qt1-x842.google.com with SMTP id n22so5856805qtv.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:organization:user-agent
 :mime-version:content-transfer-encoding;
 bh=v9HQDyixOEy8PN4aXkSXCo75jYMSqaydCTELag9mOxo=;
 b=Qql1VEpsbWUo2PmS7wpf8snI7E9WXZwuWrfKyNEodCAE7aQD9S86VASokyYx+EWTNU
 weRUVHHyfhjUZSmL1/1xJ64SFCp3Ls08U9gaB39qeGK/wrJ0TucxaecKqBolnlh5qDgR
 WaA2HtS/S0YcfGx04+A0VUWaSuXtBtYlvVLjkPsHaLg+SEnjJbO9UettBQZxlNJvVYQz
 lo1ryaVP41TlquMsN5uF2dRb2FnVTK6qN8MDCsZANxQabf7z1QKFBqYAAev/7iyHIwrN
 fCuBlurj8KUqwzXRQA5j4kZcmuz1dakcYDY+kVI4KUbfVDts2l5+gn7Hce8NEHSTHlOL
 VEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=v9HQDyixOEy8PN4aXkSXCo75jYMSqaydCTELag9mOxo=;
 b=NJ0eyDvEWGO5pW2V8YK9qivsokK1i3YgfnnxZMANcpGzoMtiFdH119Mob/Y99rkjLU
 3/4FPPyTzTs755GqAeUofI/vtNxdPX1frt84oLGUxDPSMbjSTu0PIz0Cvt6NZ1ycDbLn
 AljrwPkod7ePnFt6JqYaEpGLPyR5vqsf6ImAB92PfbGWjs2cuRaKkmQPGYeIgMNFdBYd
 FdB2WBJrAQSHLcSN37hBE3va1Y/91U9dECMrv8uWG/F+f0e9O3rZnAH+psZWXCOrk9Qa
 LZlOuhOU5QcDFzPG4HwQJp3S0vMFFbmyGoobrPLz1xpyuQ4Ka3Wp9AcyIpGSXt9wqrHb
 1fQg==
X-Gm-Message-State: AOAM530tAj1cPbv1PZwg5lNLlrfmK4uJl9QGuHMl92rxktGFa82rb3iu
 3wAN9BGiV9Qw//XFsSTMTW8=
X-Google-Smtp-Source: ABdhPJxYp4ix/BlkuKEKGns5Irv0mR1bVhWMaopZj0y83V5FMwy16X2/MrfviE7ywWjKoc99qRh8/A==
X-Received: by 2002:ac8:555a:: with SMTP id o26mr16752839qtr.190.1589814330283; 
 Mon, 18 May 2020 08:05:30 -0700 (PDT)
Received: from LeoBras (177-131-65-239.dynamic.desktop.com.br.
 [177.131.65.239])
 by smtp.gmail.com with ESMTPSA id d4sm3303267qkc.21.2020.05.18.08.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:05:29 -0700 (PDT)
Message-ID: <8f5ae1658103b71b09555d3ab499edaf3f36a15d.camel@gmail.com>
Subject: [RESEND PATCH 1/1] vfio/nvlink: Remove exec permission to avoid
 SELinux AVCs
From: Leonardo Bras <leobras.c@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Date: Mon, 18 May 2020 12:05:24 -0300
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=leobras.c@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Leonardo Bras <leobras.c@gmail.com>, qemu-devel@nongnu.org,
 dgibson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If SELinux is setup without 'execmem' permission for qemu, all mmap
with (PROT_WRITE | PROT_EXEC) will fail and print a warning in
SELinux log.

If "nvlink2-mr" memory allocation fails (fist diff), it will cause
guest NUMA nodes to not be correctly configured (V100 memory will
not be visible for guest, nor its NUMA nodes).

Not having 'execmem' permission is intesting for virtual machines to
avoid buffer-overflow based attacks, and it's adopted in distros
like RHEL.

So, removing the PROT_EXEC flag seems the right thing to do.

Browsing some other code that mmaps memory for usage with
memory_region_init_ram_device_ptr, I could notice it's usual to
not have PROT_EXEC (only PROT_READ | PROT_WRITE), so it should be
no problem around this.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---
- Alexey's review is here: https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00006.html

 hw/vfio/pci-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2d348f8237..124d4f57e1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1620,7 +1620,7 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
     }
     cap = (void *) hdr;
 
-    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE,
              MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
     if (p == MAP_FAILED) {
         ret = -errno;
@@ -1680,7 +1680,7 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
 
     /* Some NVLink bridges may not have assigned ATSD */
     if (atsdreg->size) {
-        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE,
                  MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
         if (p == MAP_FAILED) {
             ret = -errno;


