Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C625C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1D22080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJ3b-000709-Qu
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpk-0007BJ-8T; Tue, 13 Oct 2020 07:51:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIph-0004yK-SR; Tue, 13 Oct 2020 07:51:11 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4Q8u-1kIusg18S6-011U5R; Tue, 13 Oct 2020 13:51:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] hw/pci: Fix typo in PCI hot-plug error message
Date: Tue, 13 Oct 2020 13:50:46 +0200
Message-Id: <20201013115052.133355-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2LBmoiDVhBuO22eEYTNANL928DYxMfV6Z2wEE7rfy2/xdIIuH8/
 oE4cRSDTU8iBZRUI7aHXb6ktk7HBI2fGLrxQuoYkex8+RjkpmdGbOedxTSNFRtZV1Z6sTyQ
 JcJ+IwvDmjTZFT4bKYZ4jFT7J+cSlbtNxjHEG0tdqg56cKpR0wiHe7vC7zaViWeX+0ATC4i
 Y5OK2a99GEjZXjV6JJLvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D5CKPOjaWmY=:8Gb9mfsb5RSJZyyr4fAAov
 e0aSkjEFSoSF60honocHW0hUgh3EAnF1jkWWeNOizWJPNdiVC2lVNM/Cd6oeIxkPapUol71ic
 /u4G54BWqvQ2JkL/HRjtHLSaP94VwFmsT87jqNDhqH6q6TNE8ZMUbEkJrbqPKr2O/EdJ3gckD
 DaulDRveRVeEERDPPw2S/UhBdLtz5l9RQzgN2hHUazzj7JAMv3Aq2CsEA2C6fU726KbpPOzR/
 asoI7mg7TpbjRN4dEPcNQhaPMlM+GvlzaS62igISOrpJtixL2rx/GxdrDLv5p22xCeu5loUBx
 sup9qOWYsSfB9NdvLEjh2HDxysg4zYlfTrXxfnr8Hi3Sq2CMyym/ZPC336KhNFbBykCPxk6+g
 Fe9lCW1X7e73rNCZI2mnsb9BRHTpXBFbEj/o0ys5ohKHpQqfsb8iS2y/rz+MKKkvgev/UAX31
 bH67kKEcdJgeoyx3tfle0Ly0a5KunE1ABeYgbr3qp60wCfp75fapHl3ByDKRDHFoJahA0lXlZ
 xm81oSZYFn++AgZ6WJg1RjYx1RjElXBVZziZFH7NDonuxatKDdvmpco+0Kh2UXk3CJblpfo/m
 WEBruzI7ZqyLmd6KNFPJ5CXbukACG++Z5Om4C3e2pGtOiDXm6/0ypq2sa8y3A0oQagh5BUdIT
 TW1sfGIR/gR7Qj3jnHvj68PP9nFoY9RWTRPlHIQorEg0iINfdXyVd9ZzK/wQ2oJUIbva1JRIA
 rAYzb3GXskAnRKIVodT5A7M+HhkXqa/lhhbGSqS76DxR7eN3nwrfn2yhu8gVdoHgipmLv2Sxl
 IysqocwwcG51ExS/1jGNhebZ72lV+qnYu8RH04/0dNybt8fZ9nJQFwScVMHr7LydmnCkuis
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:51:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


