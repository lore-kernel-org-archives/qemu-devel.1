Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37EC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B669D20E65
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lBWnwpxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669D20E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYaf-0008Cq-EI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXK-000604-Kx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:51587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXF-0002lw-38
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=WA3W6eKxwf38HVLnDXvoFo7dYyUUcLm5A0v5cXNG0m8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lBWnwpxgnRv54LJvPhSveyYUub+1yXZefUGSb55/wzeN2742BRBwKz94iJwjU8dtP
 sbbm+c+Oic9PXhMU417LCzDyrCJDhIzuZ1E9ClLDodtuZ3OEB3/p3d2EU4GrsmOt4t
 e6o2zlHnml4PpLnHYHre6MrTM/yGpp6Ew6WNixFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1kxq6d427T-00oXwL; Wed, 02
 Sep 2020 21:35:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] hw/hppa: Change fw_cfg port address
Date: Wed,  2 Sep 2020 21:34:52 +0200
Message-Id: <20200902193456.29844-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mf1z7W/g49/kes2kEb4E2JlNpGr3vXZxlgZ8NtJUldXE5usrpOd
 PrjWaB8sUeUQKPeEBV9fZOQ12Fubk4JafkZvbq/es9t2PLFF3StcNDbV4a8EWxs5ZL+mNJ8
 tJWTMiAjU20D3JSEho+HsHGLwaiDwBiotcGyCBXfffyKAOQ8hzTw6b1PlXZNx0ohKmPWqu1
 5NjSrHS6q/J58YjHZ1yvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uWWbXhelCu8=:YZ3IFewHSN0Qpp4nWQP3P6
 DHrBP7oVVcV5A0vkKoU1m1nJyiYZoFhSq0WuUkiGE5O04Fqz14sSzQY8Axsc+SO97Tn09Kx7w
 sjcmOLQtnF7RvFRDqx4J3L/ez3HMjBNIvHAs4A3BsCR2jQ59d48QxgS8Lhys5GPmrkiDV6k+N
 kB6q+OhkyRkwFHCRMpGm+RM/t4CJpLs4S0hEOlKNRP9Y+PJoPfi7IPi7CtU/6FbvemlZwXOMq
 z0wP/YUqoUCAG6GInAOQd7hxo1IWKYSxssxerJI/eft1SXol0Fe9r5kxWVKieaXjctMdF+64p
 cwZr6dj7uVNMQfKtRzcBEw04n7IpdsYOlq7ULEXtYO1BzL9gZOb32xQrI3Cii867vctWo6HDb
 zV7HPdkne2fq2J/cZgBS/2F63r5RxZSARxbJemcWyX6RERKnKuZq61d4Q6VID+dM1WzCeHs4x
 gH+7yBZIKK2qvpWKpgU8F0E8kcTY/0GIj7f516lnBfsdS7+hT8yKCijJgvmLJOGOXKdLboQBs
 6JrYts241rpB0dbrEV+vELov5Tq7h1BrQq0I0zLtH0fcMNByQ4tF0T6EaWdl20Hnb1VDVCheY
 LAl40dy5DAYzcV+KXbK7dr7vPWrwqn8fF6FFz/oQbj0NuqdkDpsaWB7JcU+N3YzDiOigMP63k
 9p7wJaLVfWkcYslyi3+ymvQCDfzxgTMd5BpAdo21kAf9FhM/VDz6vYZ4h1CF8dia+1kCu3nIY
 UCpNMqr5qvPbguHJosQCH/wLLXjwRrh8WMnYBGwj6pnXCRePAE/LVTiYLK0ROCqDq3/9CRTpG
 mbE0U7/5JJYPmkuFOKRINRdrafYy3Vij40e5MSMjc4xA4hFya4Gz8jAFSqtDxgefH11L18ljB
 2Q6a5FJiFkk53kBeVfR7hrI/XzQU0WcWGf/FtkMVebbuSaRP2/Ng28skdXL+phhnq/+jXn3zv
 9eZtw4RtJLxz+yEbfhfSAnSV9S0oLloLtIZ3Xd7P4g2nC687Sj1O68fOBB8w+KVDqvWF/Pcz1
 qUSTEM/icSa1cljxRI34HNqs5bsg5rVxQeZidWbnOiL9MylX9fIDB6aQ6F6elvoXITOjFf+ui
 5Esidc88Q/JrAt4ImOw4ZHPRQM78uunWOqf7CYZpBBaGtxMP2EKRxBiiumDJxYBcUzwA9uRI7
 ZEDPTnjWeMNnpNZHkDFiyRD+QOxCDt0CDQCq3Q9qGfK1oENs9qx3915RxXehgJVnvxAPiMvQD
 cWhrz+sVGAXg6hZ9j
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices on hppa occupy at least 4k starting at the HPA, so MEMORY_HPA+4k i=
s
blocked (by Linux) for the memory module.  I noticed this when testing the=
 new
Linux kernel patch to let the fw_cfg entries show up in Linux under /proc.
The Linux kernel driver could not allocate the region for fw_cfg.
This new base address seems to not conflict.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/hppa_hardware.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index cdb7fa6240..b2fbbc2eec 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -38,8 +38,7 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

-/* QEMU fw_cfg interface port */
-#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
+#define QEMU_FW_CFG_IO_BASE     0xfffa0000

 #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
 #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
=2D-
2.21.3


