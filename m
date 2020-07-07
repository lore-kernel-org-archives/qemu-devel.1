Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2EFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3247B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3247B206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslJo-0004Bc-GK
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDs-0001Zf-V9; Tue, 07 Jul 2020 06:53:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDr-0000Oe-0a; Tue, 07 Jul 2020 06:53:12 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4hex-1ksBVg0OZD-011lpN; Tue, 07 Jul 2020 12:53:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] net/tap-solaris.c: Include qemu-common.h for TFR macro
Date: Tue,  7 Jul 2020 12:52:55 +0200
Message-Id: <20200707105255.362318-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lsRt7/FDAVdg+rzVdalhBL4jkta7hx0JrP73WaU+PKuu6Nq6MBa
 u/kxnjrMocfQW8Jr5EIKb0+xxu7Cti7wwjaHClyW3QSs3Jh9pmQJmpcadhFmoqMJk9n9C2e
 Fbkgdx6LaQ8Eh9S2VgG2Br9qxrjQphEs/ERxa1OqRrSqkuUsdjn02XPG+YQXkGNPSAeqR3f
 dyApxhKO1mkH22LHENGiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:axkjWxxnXMk=:gDdfTvdCOqIur1DLuvw/4b
 F9eEd7SOfkTd0yC9W9Ivo4g6+rG2Hoz/sRAvwOTUEMpxnllrcdM6j7GEOEZ51sgDjEc8+dESD
 Y5GdGZFl9qswIwI8MK04FRCbhkwu+tR8CszlyXr6AuMubBQNYUVoE+NG6KUkXeIXf1AtqxIR6
 TQ5NI/HMt09XFcdIkHfXHhWNK8Q2GqX1AaarU2m2rPbsxGwHAmhVoOKG/3Yy1uptpDOlugCSh
 MQeFwRnTeCVQiq+ho0VzBTfhr0XGDCaQn4gC1Hfu9WSu6tHJm9nrXlHU4lEtYW1UuebAMWQ/n
 ol7DTJUW9QMCNj1/DBaZz6ffcB02T8gCNSWYtd0+nXkZVJtYSZlnBSJ0Z6sQ2+g4tyU33tNGq
 phLZ2Jvx8/8C4bstD4eGthOrfqpNc6BhFz2NOU/f3iRCF0qHW/vUj4MqmrPxz6dPv3DWtCc1W
 tOJ50P2cQUEwqPUrFsliS1p2c3Q37d5Lz/hIhg4v+JKYVnx2LFS+3NOK5lswyjDALyw82hUBh
 W6/fjtkFOFX0+ChpZO4ifDvD+p4ujpqMVIUij+A9ux6LEyIIWzV4AnQEAGK7K0r1p31Tp1eae
 QbqK0w+d1QqEZiOfvhTjR2AbKtC3Bhu0x//UAGgPIV++rb7mgC9D8e/cImcT3e8PRNBeGki1i
 UvxUugbu09Ff0RNThivwgPTxCbkWJumPVobvTEjpWoq/fYFoLWScWuTxCu2oNP2stH+PAbQ2g
 cL2SjOl1N7Td7+yTaeAvfD/qrYSas3IkbHejW+g/1whM4u6VRK8PFOpZryaWko5ay+4LWv3RH
 jzhBY3n9KuHr896f0I07DB0ogwuhAqZPXC+AEIcz554SE75YWKo4sL9qzVn4RCxo3kLCN+y
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:53:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
so that it was always included from .c files and never from other .h files.
We missed adding it to net/tap-solaris.c (which previously was pulling it
in via tap-int.h), which broke building on Solaris hosts.

Fixes: a8d2532645cf5ce4
Reported-by: Michele Denber <denber@mindspring.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Michele Denber <denber@mindspring.com>
Message-Id: <20200704092317.12943-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 net/tap-solaris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 4725d2314eef..d03165c57c9f 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -27,6 +27,7 @@
 #include "tap_int.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu-common.h"
 
 #include <sys/ethernet.h>
 #include <sys/sockio.h>
-- 
2.26.2


