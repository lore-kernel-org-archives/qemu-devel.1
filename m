Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ADAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7B6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7B6206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVddI-0005z6-UH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVx-0001Nc-Hk; Mon, 04 May 2020 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVu-0005mC-KA; Mon, 04 May 2020 12:00:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvoW-1ja3O40YzY-00UpXT; Mon, 04 May 2020 18:00:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/19] display/blizzard: use extract16() for fix clang
 analyzer warning in blizzard_draw_line16_32()
Date: Mon,  4 May 2020 17:59:39 +0200
Message-Id: <20200504155956.380695-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C4Bu8a/krPIoq9y/FOF4tSxvMpaOkr1nID8+jsE3cCLyOe7/GfS
 8bL9BvXbqA2/YdCniElhEUEYlZgvpyMOEhgGwusD1bal7OQZJGSJODms3PdsI/6BPwTqA3V
 mUzA+E1a98aiSWFEQipW7cHrC4r1eb3+jobVQXXBJp82sGfIKwZskg/KJHXNO/HDkYp76J6
 IilYDiBWUs9eH4Hgpu0YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:06UROSzpzgI=:MtR1W0RDxQy0GEUzp10D4X
 09yGpidYwYTnMWOJdKpUtC3Dq8RVwxIVGovF/0MZPVOSjx9jeI3ZmxoQitEkFCswY9hbOnhQL
 ThGrzqJxC/avlGSOHF+b8JobZ9fBkuoLymeWEgNCupG8ofT/xP/pH5YFVM3IMH2rRFmueNYft
 kAlOH9B5c3GaSRE3DSIVsKbUg2qEiLrFTxnXNRm3XLWzuORENoUwMeBit5+OqBHGrPAYm4Y6D
 +e1Vjby/RLp0bV/zV2+GOTgHwvxLBwhHL1KXeaDHtWfE5jgvvAwrfbMlYcA+HB7XK/5b1wksY
 2ZTGp2YdZNJf396oxZ8zHkpMT6b9+gz/W4B7jXcBjHdA7TfK4gTxfC3PJtueZOch/pptOg8nA
 aAg7EfQMkmZccktkG9DcaOocpHmPz8CiUC3jmKIS7yBl+K/s2yzX7xi+PLrvxD9oOnynKhxnL
 3EGE2NaD8YYlNILaGr6vNlpgdvi7RlheoLq9xZDTnlR1LOyxC/oJqEz1N+BnOVGxCXcX2kNci
 SqBDJOvnOZbUAMUA0r/XtPbmMgn4B/JYR9c3mB3rnlhMIdj+DAMiYfFIDtV7KU6K09s0+Nhw/
 wW/KRf5dHLMmhzYQBmpVEbybuxfra5mkBl8wu17dgMdqntn6t7iN4oiOpDBMkfSfKPzhVLXDP
 GtDpS8QJtOXb6LeNyuGta+5lMkJTDQA/cOO/wgjBxTyZ9K82mpKJrQXNgKhzA2TPHEvpDP3S6
 9BM5mT5P8MiW4EPlio4DbNgTqwmKHkz1Dcg0mcsqc+uoSPWazEMldjWczp87n12yXe8pEl7f1
 bt9CFzIsvqA3v1gp9ziRs0SqJIUXSRxVisnChq433u4wPe6npo3YZOKRECWYOgp5UlAzTJ7
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
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
  hw/display/blizzard.c:940:9: warning: Value stored to 'data' is never read
        data >>= 5;
        ^        ~
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200325025919.21316-3-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/blizzard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 359e399c2a0b..105241577de1 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "ui/console.h"
 #include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
@@ -932,12 +933,9 @@ static void blizzard_draw_line16_32(uint32_t *dest,
     const uint16_t *end = (const void *) src + width;
     while (src < end) {
         data = *src ++;
-        b = (data & 0x1f) << 3;
-        data >>= 5;
-        g = (data & 0x3f) << 2;
-        data >>= 6;
-        r = (data & 0x1f) << 3;
-        data >>= 5;
+        b = extract16(data, 0, 5) << 3;
+        g = extract16(data, 5, 6) << 2;
+        r = extract16(data, 11, 5) << 3;
         *dest++ = rgb_to_pixel32(r, g, b);
     }
 }
-- 
2.26.2


