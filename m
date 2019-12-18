Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598E92176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E92176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZA3-0003ZJ-6Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYxn-0002vZ-3E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYxl-0003En-Pd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:02:02 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYxh-0002v8-Ng; Wed, 18 Dec 2019 08:01:57 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMG6Y-1iQaKP2iuM-00JG3Q; Wed, 18 Dec 2019 14:01:11 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
Date: Wed, 18 Dec 2019 14:01:04 +0100
Message-Id: <20191218130105.125981-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mcINSF27Ad3PpojdTOFXImedKdWrSkp4lRQlQEQPRNorzg6cSVt
 PNBhvXzM2VVHOrgRr7D+hqGgkJ9f37XdGTnM+IguV7Onb9NzJ6QU+V5la56i181nxyCYE6V
 67e3ujiczjUagp6jXiJMz3fIuhQo8f0u8GcdHOqLzzwthwrKWVk1odeiddE4RxWYXdz9b6p
 OD/10IC1lYTtZmVuDi8AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMPZbsILd54=:B/PKMxEryt3tbvJqUWW60O
 Wb4kfka84dbjW5kcgQDKkP6XUrxNLx7RlaUxQUFQ93wreeEqjOdKnBxGSP4IcnFYoexbgQGxQ
 PnpMO/YNKLs/dKAKWXp1Sa7aNXmHNP0DFywYKvg3sA0eQ38N98LKTEjCAsbl5+mDh/UM17OU9
 f14mXTiE78HWHr89upTvdAzkBV//6Qry634MUTaG4KPORh+1en18DPIOfUmMCxZ2TI6TIkMlJ
 7/fZ8pzPkU8jeA4/BBPu/HIu3Io/uk+1mzkShEiMm6ZCFExqV05xYcgngHKWv525BoxBoG4aw
 fVPZig2tq708eEJJrWlZCfCZb+QCpwEsjgC3yBSDm1pbAAWN4ERqolqBz1zuf1nFv/NaQiuNj
 TFea1hpYhAFc4nsdt/4qgKJV25mF1Eb6y1WoxYEChC4D+J/5I87+pLOflq4k2AZ+Xi1b/XSu0
 Qs2e5YEcigbbI4/Vio4xPJ0FIZNourG6b830SpdzDGl0m7FbHHQlV507Jy1V3yIQ+0c/gdldg
 pB6nkgu+MCCxUq37ou02SzgMaH5DeG7dRmwUZDK5xoQmnNmwZy673W6+1CoeYuCYt7NUXNwnR
 AHyL8GtaOmEVr4mf74JQ9Ey+qCV78LCLAfNafgayLSzedZ7PraRcVAx+HmWEuBYbs2dKAD1ed
 Zj0AWJqkAG2L+6f0+nlDqGZUcw8/kMHVaLIko2r8gmUw6PDI54nUUhcNy1/HhOVY8ZJjhiH9w
 HwhwhhJ6UPeYElSDZWlxwMV0A1q/4aqKf+wVgWuyM11iuK5luMIGTZdBVJGW2WByNb3YZU++V
 M5sYhZQHSuF0nQlbzrZSJ0EfBFhvFEMF5J+Gykz9zsG/+g2nx+b3zZjUEFqyARrz2zQXr3A4F
 XGiDlMv187D9L5prwwjg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Han Han <hhan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Han Han <hhan@redhat.com>

This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.

In 20a1922032 we allowed reboot-timeout=-1 again, so update the doc
accordingly.

Signed-off-by: Han Han <hhan@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191205024821.245435-1-hhan@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c63e794b64d1..6cbbefd08169 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -327,8 +327,8 @@ format(true color). The resolution should be supported by the SVGA mode, so
 the recommended is 320x240, 640x480, 800x640.
 
 A timeout could be passed to bios, guest will pause for @var{rb_timeout} ms
-when boot failed, then reboot. If @option{reboot-timeout} is not set,
-guest will not reboot by default. Currently Seabios for X86
+when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will not
+reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
 system support it.
 
 Do strict boot via @option{strict=on} as far as firmware/BIOS
-- 
2.24.1


