Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E275C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C448206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C448206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZyY-0006sD-CY
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZju-0003Dy-Sb; Mon, 04 May 2020 07:58:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjt-0002Kb-TK; Mon, 04 May 2020 07:58:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1jFHsE3x3s-00s2Wc; Mon, 04 May 2020 13:58:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] hw/isa/i82378: Remove dead assignment
Date: Mon,  4 May 2020 13:57:55 +0200
Message-Id: <20200504115758.283914-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1189xm37UdNK1k0GFY7Kwh9INa2C9dyqIqZiJ5nteJeW9dspCI6
 Ug7k66AL0LbDoAPNB6xnInFIcmqEDpBgA/UC7IPzNn/bYYmMk9y3LosMRt0BqLIXj5853wI
 oqZARO+O+YgaSlAOJx2QNEAQJeysHN/JvTo9v6NJwZSOswaIeqhLPuyofZ3MKdvGGQjnBg9
 bkzn49cZCgScE55dOp6BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zao/5C13Mrw=:Blt4HTwKetOwahNbNu+5JW
 T73tXpk52G/jNRHQ4l2zcd5YyEersTe+ifNss8wVOJuHDdK+0mugrjvoQTdS63x0/0rtiAiFf
 3fdbiDZHhKtiiDedqcw53DSc2zeU7UNl2jw2Ri6dyCaVe+2xSWzjO/sxB4j7Gb/BLR2eEXbBm
 fTU6n/rEj1Q90JJukEOJMTE1+yda8Bo99w7wuWAVqpCESo7D1amuZsyg0CnKElRSaxw1ArrK2
 RSG3BWkctGcwi+A+a4vMJUUAfRSRMZR+RFcYz5X966eXPArNd+GCuEBZYyQfPpff5g2j36jEd
 TAENBZXVJfH4kmU0e70gZiL/l6TXzyXCRP6jTdfs3dyzlwR7OPXEGlayaBZPxgvjbbSMpzMvM
 oZE4qyuAYM72X7nPFdIaz/zN6PdGVzvB3zXlmwA6QUVTS4KSSpWzHU0rVgWc9WnRAR+W5nyGU
 PLaWnrCkbfBkvjQBlQrjBSY6o1pIe4YG+qiOwczG7HctTGdP5Egnk8ZHbh4vxZ1c0Lbf6adys
 79gIK4qzeaaH7bYpPsAqxSKdph4fYPSJ+Wq+HUDJpny+6mMqPNBVfjfPi9hgN7Sj915QOlx/G
 DMVmbKBAMIF1iPKREKivdrEb8AUc1rHWtcTSnZOH2XynYXmi14zTbBS3KsjJgSw8QmNDlrgG9
 CO6a/eYB0zqmcoIS0nw/mX23yz3SuI9gBaPHCOm2LTFniS/6WhhIyrGEjSnrpy8/ZfCY3Erp7
 qrS8GUkCNNQ6zZNAufVS0yp/oel2HhO23eEOCDsj7W91LIOOyEhdIe/5s6qA9WEpacKXuK/d3
 6zHTqA8aN3jS53lFIVFMDqmTbR/ohuyBNiOsjgXjRP8rAkiC0zTe6xxd1StO12IRifq8/mY
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


