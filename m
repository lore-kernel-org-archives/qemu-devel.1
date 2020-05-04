Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF68C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E26C2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E26C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdj7-0000Jm-EC
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWF-0001ch-Ew; Mon, 04 May 2020 12:00:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWC-0005w8-Cz; Mon, 04 May 2020 12:00:34 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3KgE-1j5xlN3ix0-010IOz; Mon, 04 May 2020 18:00:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/19] hw/isa/i82378: Remove dead assignment
Date: Mon,  4 May 2020 17:59:53 +0200
Message-Id: <20200504155956.380695-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xVMDrLFB0VhoMW0HL8mgDYZL08Cqh7fNZsgy249Wylcso5la2O1
 6FC1X/ZsDPZ/vWHu9EJAbupxOGiEVBKUJZ2Ept5w+FJ4kn8bhaIsZG9sg1FTcSlTOmCLk/y
 dE24jED//RIXTInlNTgyu0YqlP5jYucqVhBfj26GWnLBZnq6RKGHelBNlMfYiEuD2SxojPe
 SAzpl6l8Fony0ievwPONQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pp1Ce/R7Pj0=:DtM91nGWvjUIOX2swW4Jo8
 iTzb6OiURnKfddDTHeOvWt0E/5CdtZV2C45PFdqqUp0Sa0JFYQOp0aVmekuczyxCEuAWaV/ZJ
 MvTRiGdZgmQ06GB+lkLtK0SfNVtB+X+i1POYc6NNH3Hu/MHM4TBiJLGBgtgy0l6z/O1uvo00d
 ZGm2/HtU6y80Yk8FVGApx4kX5GRVt9UOuadhOcpMQgnWYRmISgrn4f/x0uZzjYLzIMbKGnWpt
 9xDQBtsvIJGEGBObIJQFzqjVht1ugihJ5Edq7VVseVtXMExmX7HXPqJ3eC2rDDYSJ2U1ljEhN
 42KGzEMjS4dcAhkmMEBRLNm5XMaAc7wI0DiVuF/QaCjj9G8I8pIQXSARtoXkkfJQjRYr5yUZV
 tC7vCEJmEOXo4LxdufWddadDEawvYGVdDQk8bY7wd1ZW0+8D5QJriMEhEXV2arjf0TXDcxxLi
 4m2RMuV+HR7kClW2vJheDXn03KHhliFi1+toyIbTRocGtvr5vfSVMWjL2Dizj+2zq5fNpWezt
 Si98trQKlIVbv6nSFB80Q7pzrkaYFPulXGek4Wvb/5qieY/+0T+C1pehvmPS2mjBKXARYg72p
 Vg0th5JoG8z4kqlfHPXewwtOFudAzIQ1Qh6pGw3qdZiY+2ZujS3iBHuiCdfsGa/f1QXfZnaOD
 oX5xopksMk3tR3NHop0jmsk8iC3JPXT90I4WqvaxYrfltgy5K/RzQU0RfiJgce2AvVt7u1hhv
 ZXOmXxUQaJmxJXevdFGMdtRaHCPMJDIWl6qGuubbx8qUQ7LBQSfhZ08onjyMxmsWuaPYOcnRK
 vsluNX7w6MYYKGydKAlOtOq//g0gddv/L/LeIax7OfRwl1wrZfduV+5UO1vB19q9JFU+AXp
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Rename the unique variable assigned as 'pit' which better
represents what it holds, to fix a warning reported by the
Clang static code analyzer:

    CC      hw/isa/i82378.o
  hw/isa/i82378.c:108:5: warning: Value stored to 'isa' is never read
      isa = isa_create_simple(isabus, "i82374");
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/isa/i82378.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index dcb6b479ea0d..d9e6c7fa0096 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -67,7 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     I82378State *s = I82378(dev);
     uint8_t *pci_conf;
     ISABus *isabus;
-    ISADevice *isa;
+    ISADevice *pit;
 
     pci_conf = pci->config;
     pci_set_word(pci_conf + PCI_COMMAND,
@@ -99,13 +99,13 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     isa_bus_irqs(isabus, s->i8259);
 
     /* 1 82C54 (pit) */
-    isa = i8254_pit_init(isabus, 0x40, 0, NULL);
+    pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk_init(isabus, isa);
+    pcspk_init(isabus, pit);
 
     /* 2 82C37 (dma) */
-    isa = isa_create_simple(isabus, "i82374");
+    isa_create_simple(isabus, "i82374");
 }
 
 static void i82378_init(Object *obj)
-- 
2.26.2


