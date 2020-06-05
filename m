Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E443B20659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E443B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAxT-0000kx-6r
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAop-0008QG-LW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoo-0006n3-P3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwPjf-1irxjw3h4v-00sOFW; Fri, 05 Jun 2020 13:47:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] arch_init: Remove unused 'qapi-commands-misc.h' include
Date: Fri,  5 Jun 2020 13:46:56 +0200
Message-Id: <20200605114700.1052050-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q7m76VL6Z1ABHzLX5U2AnBtPkTr5HEvLjtuX/ahHDj7T70wcjvc
 Va4A10cEFQxtWFsZKFx7ZmsdjOw7/EcRKBQLPPs9Ll+a554whW/mmyCVyNhlxGM1jjS4uRV
 IegJnzXQ+vRdysYBPmPZ9/fCcoSIzTc/NfVRl11rb3k9Muj61QG9jKQdcset7kcmtqvVJPM
 lRqpuPAQ73UORNFytC4Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YxWxEstQVpc=:J3CVIuToeBPHcQ5lDXBDVz
 g3tKoDiC31FUa0WIbwp35coh6tkQmySQAk/E/e6pcGxpB4djf8E+MDnvaLVsygN0UZu4HQyBK
 SXY3WMBM+Ow+FMz6OtmTwdWRQfpA1zg7S+UIo+pDRWSpK6JYmX/yUSeEwXz45/WKv0L4P37b5
 +Be1/Bkom/oRWfLiqZzhL0m5I/q8glZeYd0eOD2fozDrPg6GAhWI4xMWD01BthHfTWnHLKcx9
 k6eVdskmdrNgGn3ZVK40VXTNr0uk5P4dxuU4obHP6zAS7FLaUFQFS5TVIhPGVppjZHutle3kL
 BSJN/QtIo5oiZG5K/gpzG9iAovw0FVY2xVayRTcbIpdbfynwWN+h1mCglwgwRw5utEfW3rA+V
 kH7FZAOB9tRdovoJiRfsvZ2VDv+9ZTQAWeLlKPOtZE2MEZ+Ra5UJbX9Ofmva9THFNh9wwBgQ3
 M+swiwtqSu4/tLY23k3E7yCoDUTHRu4V8eYMhkJev7qmwCVtsTgP9hcGmpv40DPeZZpAK/cjY
 AXixCHb0lSpq8oSxgJkH3ww2FU+EyecjFTWJbzzaSMOrOR0c1HuX4RQsF6cM7/sD1AevpWC8l
 QJk+Fsqo2ZvyFZVF3o6qNN554dJrTyfNHvfuqLHdHuxK5cOto9hTjAvL9onkzKRzQtTiEEwpv
 q4r9ed5YR9Fb3W/WP0xITncGECpPkLZMNswV3JLJK+t/l73S4cC5DaG1wtLRVYHedPnteKPR1
 c2xHsqKgLQ/Zt6E9B5YaiyfNlxkZ7BkDjat2hbHAC7+ttHyQO53/z8z+ZmMOfj6g5cC+nSODh
 K9OsCy0j9RatiJmLsro9qSpfPA+xfDLzBOsJe4zK+MMUw4SC9T/YTyjI2TiFx9B+Xk0bBCd
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:27:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
this include.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-10-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch_init.c b/arch_init.c
index d9eb0ec1dd03..8afea4748bad 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -27,7 +27,6 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-- 
2.26.2


