Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF11C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B869206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B869206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZtU-0008Fn-FS
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjs-00038T-SD; Mon, 04 May 2020 07:58:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjq-0002ID-EY; Mon, 04 May 2020 07:58:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mna0x-1ip83G3zJl-00jcTf; Mon, 04 May 2020 13:58:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] hw/i2c/pm_smbus: Remove dead assignment
Date: Mon,  4 May 2020 13:57:52 +0200
Message-Id: <20200504115758.283914-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lAdcSX0kajxnl05WjULUUsCSNLGK9FItQz984ooxQyMQ3F2VPXe
 tP2kTCLf1i7xGJL6rHvLRWjRV0vrBeoYerXrvt+t0jxSbV05ACXHngJrc9qQRkXtiHw4o6d
 nFW4ITSXkFBpj7hBZqJBRz31vumaMsKWJhm6VqXRQxT/7DQ/V6laMHNRbun9f4+JHcEb849
 M7D2l/ulhZwt0yjCVoxrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GbPX6t2rIxs=:a6/vmlwAKH50bZFZYh7e8+
 UCnVb5hrzq9WKE1jsF3wEgP/pZv0hruh9jX33wgSKGxDO6sb145St1c0DCejA3Wq61IKiyuoz
 BvBxlK5/ItUi6NcGirc0wv891RKFRgkIr4gMWyOEP+1XxeObA0mnUdwq4qGvIBFRz3bfsVg8Y
 prFvK0F08fZVti82dQ+M/YpRCo5Gk0q2HvM2PKMkUE2AQz2aPrx69Jy1ph8c9va3grWtAjC+V
 eOkwuM3nxt7t4udiqBIG0u5nzM1EGJZGfznDVXgJgUx2DfpOSRM2srpUMRMRu9rc+2NO3sGry
 L5ffMB0Cv2fg4505aE7kWu/Uze+fWyL43TRMf8lUFYLwaqjYq100J/wIfDL/kfDVvOvDsnA2H
 xSRMcAzQ5iEarkruRlxYup3/Pf+WkdLy2faTsxBcy12CutEDkqVJxwfpsEwT0PWA+zd72GShe
 +tvCzn5yPL7EzlbF8/nowJYiJy6ShQXj8BitXgX8xWBwXBbBrB4wBlEKpS6zOHOeiKvanc7Qv
 Uc499rhCPlD59wNlqqnhR2pSwYrTi+X8xJh5kJGEeVbPMNkydKB6m3tAB1qC0ehsvHQQs6N9x
 ohDhNtxUQUDLvn0eHa3UCuX2L6b+n5ldGN/PG8I1fBm8HP8RnSdw5CDBrz7Npaz9tsvG7Qpi5
 CHFXxUvVMSPzOu0AhUM7x9CuFo+WnKpCBP3D/gClbhKC8RmGcY6SGpyXsU3LBmDf9Zt/ADcnG
 Q++cGg35BeERxm73PP+YtgvUaNSYcugQPNANAV31720DAmO1S2FJ4clQCgn9ELEIOr4mS9YfM
 srNMe0BkFPfqsgsL7mK/ymhagRPQUXRZB0ATXvwxs0zfFgH9kjkxMbGgcHxJcuBiHlPEa+i
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

Fix warning reported by Clang static code analyzer:

    CC      hw/i2c/pm_smbus.o
  hw/i2c/pm_smbus.c:187:17: warning: Value stored to 'ret' is never read
                  ret = 0;
                  ^     ~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-4-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i2c/pm_smbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 36994ff5857c..4728540c37e6 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -184,7 +184,6 @@ static void smb_transaction(PMSMBus *s)
                 s->smb_stat |= STS_HOST_BUSY | STS_BYTE_DONE;
                 s->smb_data[0] = s->smb_blkdata;
                 s->smb_index = 0;
-                ret = 0;
             }
             goto out;
         }
-- 
2.26.2


