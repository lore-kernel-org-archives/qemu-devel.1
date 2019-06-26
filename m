Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3822CC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC40208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC40208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgEAZ-0000jX-WE
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgE8e-0007n6-GP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgE8d-0000z3-BV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgE8d-0000yS-2T; Wed, 26 Jun 2019 16:03:27 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MStKq-1i9KEJ1Vvi-00UM6S; Wed, 26 Jun 2019 22:02:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 22:02:49 +0200
Message-Id: <20190626200252.30220-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626200252.30220-1-laurent@vivier.eu>
References: <20190626200252.30220-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VjQsvc3d06qk9A6m95K7upSTC3nFZciaQBjZZHSxsd0tChHc7DE
 oJNZCMn7zyS+gmIwOYnMjvpFnb8FdxY1/FmDVxmqE/kXPEEoZBc/lDkhBzpkTCdzPPVqSWL
 QV5l7Ck5eTblDtEXAH+E9tN61aZT1VmxQStVq/86GsvlJTu4dRt/Tczq+K2nzIQIAtOrF8a
 T1zgFrzMoU/ucERCixpYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6hxK8KwUclA=:Jy4o4P0WB88lpsBLkqddS5
 59+OVsrcy2ea0ODCcoaSQvsLz+6KFbgKL3EH/GcX9dk1tjYaSwQMYCwYsyH0MmdjEsswoR/Wt
 eFEBPbp27XtBhhmrvmAIDabW0f4DY9TiFWyQUgKPt+xoRrgEZsRhkZUn26O6W3P7coD9g4yD2
 zihb1Xt6i3XGK9jTud0hp0wAiChKJJU3/4jkHy9ouGQlE9uUSZqH9CME/pxaOvpU9riR3Ngjl
 +WFAHy77DA7KNpFUWNdgXncttTFiJUkzAAK+IcAUWKDIXWDjpq/O8IuI/7qXhcBzcsonovnb6
 JQg0gCTzMuzionTqNo8DVRWP570RuzJJyShdvRawSg0oabWlAHO3Qg5nLUckokCuOBUSE61rW
 uFVyVi/I3sXI48s+0JbB4Q7IIvPHfFHV78CFSYmE4N+o+M6h+Xsq5TCQKC3p28OA4ANONKBkn
 06EeofKpPKaoRQPmSGGCzlwt+N16dW7G8h2yPoZJqO7U7OxP8WF1VB8TFHU+e9yfLAkm77bsW
 t/ag3oe56Ydw9gsFMiv0I1CZHxSE3dFFNy4ZcJifIEnxiCwciXX2QRdXI20ZSJ5A1UWCtETvi
 mvIb+xnm9gdd5X5IzX0L2PBApMukUclyblHvosE/Z8t9vmBxuD7xFqMoA582BloHjmEIV+RG5
 6d0AcqgHB7yXNpBNALfbvN81DVqD631IPMz0izHWIEB/9UzW9Hk+zo6SmUkV/gzauMcbGKcM9
 zDJ6AGBKv88+CY5rxQwrYnqWqaZlGNmQi2eeew==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 1/4] configure: set source_path only once and
 make its definition more robust
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
Cc: qemu-trivial@nongnu.org, Antonio Ospite <antonio.ospite@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antonio Ospite <antonio.ospite@collabora.com>

Since commit 79d77bcd36 (configure: Remove --source-path option,
2019-04-29) source_path cannot be overridden anymore, move it out of the
"default parameters" block since the word "default" may suggest that the
value can change, while in fact it does not.

While at it, only set source_path once and separate the positional
argument of basename with "--" to more robustly cover the case of path
names starting with a dash.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
Message-Id: <20190526144747.30019-2-ao2@ao2.it>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index b091b82cb371..b6962d1381a5 100755
--- a/configure
+++ b/configure
@@ -276,10 +276,10 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-# default parameters
-source_path=$(dirname "$0")
 # make source path absolute
-source_path=$(cd "$source_path"; pwd)
+source_path=$(cd "$(dirname -- "$0")"; pwd)
+
+# default parameters
 cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
-- 
2.21.0


