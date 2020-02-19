Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB8C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C211924658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211924658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MWV-00018i-RC
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPu-0003i3-LE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPt-0005Uu-B1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:18 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPl-0005Gl-TE; Wed, 19 Feb 2020 05:17:10 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mk178-1jkK0e0YCu-00kMBz; Wed, 19 Feb 2020 11:16:48 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] hw/net/rocker: Report unimplemented feature with
 qemu_log_mask(UNIMP)
Date: Wed, 19 Feb 2020 11:16:10 +0100
Message-Id: <20200219101612.1033925-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:duAcb355ECFPnNuZgkT11wz2BIZvCxzcAZlcm39hkXWB3RYN+Lv
 1TbbRN/Dcextyh8eKlj0fCir7CJsYi4jJCFxLZd/CC41HCDKH1Xi0fuZ4NCIO5/+U9jDEal
 nLPv2L1ODWfjOK4qBrLi8uBfCBKlUMSqA3cSG4CiGIYyO5ssOxc5skVMs+bH7moZS8+AcS3
 rmM7+LpOPDntiil4qFaeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdaeES3PDsM=:b/BG0e9SXww0sJCuQ8MCTT
 QE2qVIEL0RXs+i+4U7i4jL4h/89O+KyO8qx/A6rQ5h/dQFLi7y9PFLnj2xmBfRyl35p/jNb3l
 9vD9yVvPaB1D7uqmWfl1r/WtOvekYFyKf8i45MzHqlVc7+WiSuftQFQ633w/efaU1SAYdliU+
 SzpuvRuwV0HI3BqhV8GDORTCoP/6lNsNn1IN+52LM0B0Mnhks/NBDwvHGHif2DFE4SmrTxV/h
 ZdGwHSLO0ry/aQ8qcxBQ6ok0ExT+9WoOZ53zqC4hVjqmWSN816ga2+THoye/q+St54pc83E1/
 WLfS9B7ZXWdSDgHNqtGCbTByX671QeBr3QZRrBOEOuKiDtcpNNtv1tSTfxuCQm81xBSegV08j
 a4pUE0MFRYqYc9Z3r+Hh0WtgLsIRfnsHzErw/Y662EgJO+mxyxiakpV1x4Yl2Rx5nVcXV2D2H
 yvSothDc4Y2+t+7VGS/WciPGQ6W5e6OZMFK56uJ6lchoK+KBYEYJaqXeFW40Qh71bciPFmVA8
 DEvfXicO6fGUMwNAwhMvU8yysxwz/58cNwpsY3t/oUHIO+/j0eJ4dlfN2GfEaa64+vp7HOmh2
 q2DvY/zXXc8b4bZId+8lmUcA4kMUrwyw9/djxXxGB6CFxvZP9Tr+XQb3+eFfvBmkCp5aGC4Ij
 OuRZA8ctEAr0Kc8c+an1K5++Jbm8vHCyeVjS0H8RK61NJN05sjP3+7DioMy5pPvW8yPeC9oNw
 Ov4UtfGU+YCeQQeBGk7s2JviPBDplQ6E/0EUk4kbQzAtm6uCXsZi8kzYrk+jEipn+K5gyCDn0
 54IW3HB8kmuL1fR0JNwL6XXXgVB2ee7Yglcx/gXwHmUlYSxTW//aAw+Lkylt8XfmqObunby
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warnings reported by Clang static code analyzer:

    CC      hw/net/rocker/rocker.o
  hw/net/rocker/rocker.c:213:9: warning: Value stored to 'tx_tso_mss' is never read
          tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
          ^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/net/rocker/rocker.c:217:9: warning: Value stored to 'tx_tso_hdr_len' is never read
          tx_tso_hdr_len = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]);
          ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/net/rocker/rocker.c:255:9: warning: Value stored to 'tx_l3_csum_off' is never read
          tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
          ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: dc488f888
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200217101637.27558-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/rocker/rocker.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 81dd3b5f141d..15d66f6cbcf0 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -27,6 +27,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 
 #include "rocker.h"
 #include "rocker_hw.h"
@@ -207,14 +208,22 @@ static int tx_consume(Rocker *r, DescInfo *info)
 
     if (tlvs[ROCKER_TLV_TX_L3_CSUM_OFF]) {
         tx_l3_csum_off = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_L3_CSUM_OFF]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: L3 not implemented"
+                                 " (cksum off: %u)\n",
+                      __func__, tx_l3_csum_off);
     }
 
     if (tlvs[ROCKER_TLV_TX_TSO_MSS]) {
         tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented (MSS: %u)\n",
+                      __func__, tx_tso_mss);
     }
 
     if (tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]) {
         tx_tso_hdr_len = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]);
+        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented"
+                                 " (hdr length: %u)\n",
+                      __func__, tx_tso_hdr_len);
     }
 
     rocker_tlv_for_each_nested(tlv_frag, tlvs[ROCKER_TLV_TX_FRAGS], rem) {
@@ -249,12 +258,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
         iovcnt++;
     }
 
-    if (iovcnt) {
-        /* XXX perform Tx offloads */
-        /* XXX   silence compiler for now */
-        tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
-    }
-
     err = fp_port_eg(r->fp_port[port], iov, iovcnt);
 
 err_too_many_frags:
-- 
2.24.1


