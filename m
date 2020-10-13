Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58383207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58383207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEI2-0005eu-9f
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBf-0005BI-3T; Tue, 13 Oct 2020 02:53:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBc-0000GF-BQ; Tue, 13 Oct 2020 02:53:30 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mo6zD-1k8snY3oT5-00pgC8; Tue, 13 Oct 2020 08:53:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] hw/pci: Fix typo in PCI hot-plug error message
Date: Tue, 13 Oct 2020 08:53:07 +0200
Message-Id: <20201013065313.7349-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KxIJdSNteaPV8erMZYKlw57B9VUtVuVDrRmaSNOn0Fv0Zhno1F9
 APUA9GE304aZTJBW+ojwPJf1EJjALba2qgVFHeL+YCZipEW6hxP7DxUNmmcg3FoNXy16Uix
 WCd/ApVc7TeWPEC7nhC7YMdKDQ5/iieMLu85zeZIEfl4XUxuZbBi1PLwqDqiI0SBoWJTD48
 8z7sU5tfu9jBDzljsw6qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CCXGgor1zGw=:dmmujSXj26jJkvg2xjVgsT
 UdjZCN4jLx9sJYfAUGkogCbZb9UJjw/aYqK2R8wRaQiPkXhFSIzxDjDBksNxuObULVpp/Mhj0
 Izosn/G33ZhBnVqeWl68fS/hh9HwJ8VJLPYAC2qxitK3pt0hp8uwPlTMln8lbl6zMRlz1adij
 HAiumBdms9u17GOP2y+vpODr1HJJxWpxq5KKfRBVelyLYUQILePJVgu/6VeWHaqHKFErvjGoc
 1fd7dBk3lxrbeVxEMLkm7m00CCQ2DASsEFbvC7k+Xyxbl3rOii4ZyscwuBbZQziqJAZ7zOMWi
 PNSO5HH1NFet1wzZPWKOmykVTyUTsUthv9f+wfKcgdhftoy9kPcvM+t0e8qRnLaRJMduP+ay1
 +fsCsO9hL8OWnoAd7dQKwvKVmxdoWJSf3bcy6/SI9NnwoeTufhMRAeMns2JERnx9GOpWPc29K
 WRJzE+SiWrir8VdYOtbbE+2vq6++jqo/0qYdqlSzk2bkvEA9ZC7R8/Wf0CFIT+x3pMCG4UV1h
 tUZIyO6kgSdgn4CM20mszP9rf6xrHQJWfN/lSZ6OfB7k9QfM9ckaKCdP11Jh591AWW1QJpvbr
 83Ua2LBqAB9uHWDzkewpBB7X/ssYz5JTwTnX0WFU5KNSSTGmFJ24TxbH1b/8ExVKkm9cfh1b+
 a+i9D1y1L4Eqy7CuQhONhhc3jP1rjuuDQhVy3X8N4uEg0QGWDBGeCPNJJhLOPOzlZbGifYVnF
 jnilVJX1QwyakozBKaCsA/DpHuozjrVuim3lBdgMVCATni5T4ictAHNjYlUhpvDYVqZuGhVFw
 q3dqJeMewlMRXBkuqcHw/PMbi6quga5WjCICzCYO0fWTH7mlUiCWEsfPPeadE3QMZOQmHpR
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

'occupied' is spelled like 'ocuppied' in the message.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201006133958.600932-1-jusual@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/pci/pci.c       | 2 +-
 hw/ppc/spapr_pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3c8f10b4618a..100c9381c2f1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1036,7 +1036,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
         return NULL;
     } else if (dev->hotplugged &&
                pci_get_function_0(pci_dev)) {
-        error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
+        error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
                    pci_get_function_0(pci_dev)->name,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3999392b32c6..88ce87f130a5 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1571,7 +1571,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
      */
     if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
-        error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
+        error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",
                    slotnr, bus->devices[PCI_DEVFN(slotnr, 0)]->name);
         return;
-- 
2.26.2


