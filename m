Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5DBC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE52206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE52206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZsh-00079Z-K6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjp-0002y5-BK; Mon, 04 May 2020 07:58:21 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjl-0001x0-Bu; Mon, 04 May 2020 07:58:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKbwg-1jqYUg2RnI-00KuhC; Mon, 04 May 2020 13:58:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] scsi/esp-pci: add g_assert() for fix clang analyzer
 warning in esp_pci_io_write()
Date: Mon,  4 May 2020 13:57:39 +0200
Message-Id: <20200504115758.283914-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IAjXWeOvZowTWwwghDSTfo/cqLp7D2O1nyg8K9rIrOLAVnCLpvo
 j2Sku7G5E6RbBln9ywr7h8BqE2eB/ynmo/HQwFOJ3gwyMFD2o2B28T38QjpeB4HRf3wFPoY
 v2WZD366mLi+ymb8gvRFXjYwcKl5qNbD4Z1YZyfL2nue4EOEvRbd9YLRfjFGmPpgXBUmK11
 k9IVzjxMfaQ3O0JN5iv4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3MG0TqZ99jE=:f1bJ+HcIvfmH8ujY6XD+eD
 D4aNqis9rNUNUt4Oy2X9JVMFSpUPlcj3gvymKH5EEL2HNRnRfONQioOpyXJSJ6u1jWDQkjzK0
 oVTBKH3qjGtG7oF2/zn4xHanCvVrIkdQ5WEVUJYgekSOT6UsStF2YCfNm6eBWra/WtdqPVvV0
 57xlwPidxLeo1iL3h0XcYvXo7igQrI22vxAOTFBx22pmrtIsB0nhrYYK8Y64HHGozd52DucV7
 xrfNvfeRUnI8W2Ednbd+MkydvNguMUfxb8m+Tp68ocKWmWlBU56YzLlzzhVT8Q4R6QXLILhV3
 WpjW/+e8qinypO3UosYMGQmJO3mCOL+F6NS4CiUTPK1E9J7fcJQj6xpKFMp5Rm1Xyj8DmTfGK
 K6M7GA4Yi0HoH1G5hTdvraOZ7OKXZxZyRUmz0uZBBW+9jkRaMADXL4u31MbPBcjexfs/v6oK4
 ekTymBhzD5iRNugFNFWqi50HqjN3f/VAXxRGGrQpwYi9qRb7dp9TpLVAUlgexT7RhrbhAJgZo
 t8/QlauZ5c/xZphvj8r1A4DikD/K5WrbIz4zzz9t+4pG5h2PPS1T9b5uRkEndEHCilpMeSzqB
 3JxMKwcDPv4Q2E0OZyCu33LGCZ7qWo0ngPB/L7BoOLkXJQvj0PMSKAbNnfGXZhcASYmCdxJ7f
 GxjJQO7EzFelGAN5GPsz+3rI2YwrxmCT7m7PQkWRwCTD9s1AnyavMopZUs4URh3LCEwVKuSUJ
 yJ1Zc/m512g4u+NTfTO3rOL3bMPvyCi6TYlmNT64dfrzwOSlDUq93HkYYPqVGfAM1YdgdYB5/
 dznbKFzK1ic7RVn7ZAuzLPiKubQJYERG0UIvrQjL30MGwk5pvirFbEQcApupwq5cATzi1Rc
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:02
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
  hw/scsi/esp-pci.c:198:9: warning: Value stored to 'size' is never read
        size = 4;
        ^      ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200325025919.21316-2-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/esp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e01748..497a8d590190 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -197,6 +197,7 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         addr &= ~3;
         size = 4;
     }
+    g_assert(size >= 4);
 
     if (addr < 0x40) {
         /* SCSI core reg */
-- 
2.26.2


