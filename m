Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D0C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9241D206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241D206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD77Z-0006a4-O4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zN-0005Xv-6u; Tue, 01 Sep 2020 10:10:21 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0003ov-Vw; Tue, 01 Sep 2020 10:10:20 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJm8H-1jtWrf3TKL-00KD1Y; Tue, 01 Sep 2020 16:10:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/44] qemu-options.hx: Fix typo for netdev documentation
Date: Tue,  1 Sep 2020 16:09:24 +0200
Message-Id: <20200901140954.889743-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LZ4UW4gukykKXwMApcvpEihZ/4Hd1xk4TMb5v2qEjF9n2FKeik3
 psiWqZ3UvV1dO5spmBGc8mai8x7oEmHNHsvlhpGLa6YHegtE2p87FCZYQf578FxjlReHjEO
 sVwjuZyTIjBbI8rpqkeZjqIizpq4/iha8vzQvBKcHeqB+oecQL9z+r/fKt2NJREfOmqn4+6
 0jGh/BRU0rW6uymL7TnXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ESYrRRrAvTk=:kiZilTFRpgu8PApf+h+9vh
 1hHQoesjxIxD6whd8hIGBO06jk13bfMbSofcaXbyOULbXaWPkFGb/y/6aQhQ3XQxR/Nw8yMyy
 JCKkqiRs7OmELy7KgPrlljH9+xB++G1Cb22zdnyPm0mifYPPIgCw8ZsWY7Xfz8vKgIHxly1Th
 i3/hOsYDJBJbWzjDUI1PgyvTHp9GGR8HJn9TZmBbkyGRvyCALVZ+RF2RK/1c+G2b+Wq+ffgfh
 cdqX3ykPVjcHbhwvgV8f94X4XPsCMh32GWHMdx3Nd1HA5djHYvZ3oEGqRQ2oh8ybG7LHlwTWm
 Dj9aTpponveMvoUJ6JD+vCwPnDmuRGbPviOwPH+Wx49GfmKkM5kiQfW7F620vOBmTrf0ZK9O4
 Z+tDMKrgyvh2izn2BzQdntcCotrjzZ+Wdp7JWG5w4qEcYyYDrWMip1mPEcbXEsN9HoumUcYw/
 BpomhLo+fT9Zrxny/g3wpFD1hu9eq4LIUH0E3GKBlqq1UCw0zYxES/4EmSNSYNeV7fwAxUq5w
 8T8i7mZeoXLgle+l2PhQsggrmT+3WPedoiPzIzLHOA3baTkuq3Kw0CYGN5rPM4egcxLZdNdZV
 x3Ez+4NnVhPv8urOLDc8sdaoeqhiy+sM1ku9bHD75WrxQvViuYJGtTdW850kcHe0XLfypczwZ
 cO0DdT7h33JYNUSLT0eSU2YSnRGpja35jw0r4Vh03sDdkgIeQxSwMrkO99ZSp9jp+lfrl8AHi
 Vo9Ki4ReImQlXEkeRSgkBQYFaOMTrXiyLP1dkhFmMIuj4duNs8PG+A3JC1WG8o/u6rVl+0kOY
 7T224tzp/1bH0T++RFv6tK1NXWbLC5X2cn366pLoQZ3QyMBotdN3WsmcRqf1Eb4HSXbwNlQ
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
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
Cc: Thomas Huth <thuth@redhat.com>,
 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

This patch fixes the netdev document description typo in qemu-option.hx.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 30019c4eca2f..b0f020594eab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2684,7 +2684,7 @@ SRST
     disable script execution.
 
     If running QEMU as an unprivileged user, use the network helper
-    helper to configure the TAP interface and attach it to the bridge.
+    to configure the TAP interface and attach it to the bridge.
     The default network helper executable is
     ``/path/to/qemu-bridge-helper`` and the default bridge device is
     ``br0``.
-- 
2.26.2


