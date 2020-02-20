Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B1C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E08020801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E08020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i2g-0005md-9S
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1X-00049m-RN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1W-00089M-RC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:35 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1W-00088e-IO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:34 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGA0o-1jEe9v39Tg-00GZZu; Thu, 20 Feb 2020 10:20:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] configure: Avoid compiling system tools on user build by
 default
Date: Thu, 20 Feb 2020 10:20:45 +0100
Message-Id: <20200220092053.1510215-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:780mACu1T5rRuaU6FlM80qrxH2TIB1cxn81ytQDssc/c+WkEqKy
 Ka4qkmq9yWJg57/nqePkIar1s6gp8iIizxFCt5rTj9CHH1j+a0qgy9eWJBGAnvyzNNRiLaf
 ebV76i9DO6JuDLl3TVHVBMBM+oq9e9QQhWPWT+WEz7Nrn2qJhxn1BGrJ2HfvpQKu0rsnIvC
 AemFNrMlLalh/ZRui/nzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gVu4KHjcM0=:/U0kTB0Q0FUERlPdE/ueWl
 Ubh6dWnMwQWFngIqr9vF3hR10GsYgyxVUFxNXkETe1SFkWKsC6OU/CSezDQxQCe166yFw2WsK
 iY62bWWd3P/DNS7gsuJMxUQ7+BisgHGSplB9CEmQIJHYl6AC/EHlgPaSAe2D4RpJGocMctWGF
 ooGG4/WvqfDJ/PcXPR7kp8WTIM622Ih+R8uANC1dmEA2xMvsiGsT4eYmr7QG5PblLst3meYY6
 +jGKoHqcrl2f7BwKnhxYZmBA6XlCdPA/4Lzyjp/4H3QmQodhSnkjmOGkKvQpQ9Q/kOjCB/ab2
 8KGjiI8JsT3VFsUAiFg9EDMAwBHfse9SG1/xFaE2Osg21wxyGb6TOfg4rm/R22pHDg+Ut6NHW
 LudApx/mm1I6sXbcfu9ONZO7oWFZmwS257RvLDhhAEd/tXxB5AO1NF9iNM7QC36vPzUclUHMS
 o9sDS+E54T4BpOkXUJR2Kraki3vdxp4HpneSJV1vA3oKzEOla5RLhriji3Ihozz9c+iACp1HO
 aBGYgm/+/kBP9TmJxqrPIu/4lW7EIL/Nr+Lr/mSTWkcJgZqSyFf0+MD08aSjZ58DUumPOLF+4
 MaYXF2MWBvCJwqAwylIGBiNB9UhNx8oJQRgreqvLBpxfAYoTKnl2SGx5rl/gXv1XMcShZl3+R
 VLfp298LibOOm3HUBtgh/FpdT97D44ztkNzdAhS+qxn57YKNNyrhhwD3zlK7H4iie530aLq0n
 gfu0TZ9MyS7wXppO3PNi0Se44I09/W3WsKPsZYBFNwpTzl698qTl5Z7OdHEfYEq1/C1TyTups
 l+I4vMOkuVa2TJXvDcye4cIsbTHMQTU201WhJKLfEECV+aqaCvSOg4w6f8cJ9w7joJEtT+5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

User-mode does not need the system tools. Do not build them by
default if the user specifies --disable-system.

This disables building the following binaries on a user-only build:

- elf2dmp
- qemu-edid
- qemu-ga
- qemu-img
- qemu-io
- qemu-nbd
- ivshmem-client
- ivshmem-server

The qemu-user binaries are not affected by this change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200217133327.25144-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 5f5f4befb9f6..d57261e3ad0c 100755
--- a/configure
+++ b/configure
@@ -455,7 +455,7 @@ guest_agent_ntddscsi="no"
 guest_agent_msi=""
 vss_win32_sdk=""
 win_sdk="no"
-want_tools="yes"
+want_tools=""
 libiscsi=""
 libnfs=""
 coroutine=""
@@ -2213,6 +2213,16 @@ else
     echo big/little test failed
 fi
 
+##########################################
+# system tools
+if test -z "$want_tools"; then
+    if test "$softmmu" = "no"; then
+        want_tools=no
+    else
+        want_tools=yes
+    fi
+fi
+
 ##########################################
 # cocoa implies not SDL or GTK
 # (the cocoa UI code currently assumes it is always the active UI
-- 
2.24.1


