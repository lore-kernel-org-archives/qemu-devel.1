Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF20DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648F8206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SLG+ieV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648F8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k586P-0004hI-Ff
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nb-0000z1-Rd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:48177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nX-0008G4-1u
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065886;
 bh=2t00/wToPXdci/sCMNt4gNmLdt2OOd+Fs0qy1+SNfwk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SLG+ieV5b98ID6PwYsuB03ymhNp5Du5n3hGLdxKqA5xcTnSSa2jSy5Dw08KgnvgX5
 3t4C7JNfXaHBhd2O1eUOeHwlffTjgjlHWsy0hxdgzKO2qRGR7gk2fOCnqCqCtEupBt
 HzbRtVCKZmgwW1FkdG6dzS7M8+XFCpjwGpOyQzAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1jrye61iy0-00DFv6; Mon, 10
 Aug 2020 15:24:46 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 05/12] hw/hppa/lasi: Don't abort on invalid IMR value
Date: Mon, 10 Aug 2020 15:24:34 +0200
Message-Id: <20200810132441.16551-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4y/H68X5pNSTF0jR+J25fnloc2MwhV5zaR1Whs4duupFALiyZRC
 knYgPVCa6V20iSM43MVgiiK3UPL5aVQyutvP1FmZR4VI58G0S6q7+6W9IO83OvbxnghqP4T
 Ddx9Sa0PwiO0FtNhkiV3NZ7Lt/Lb+z/CZIBJe6M+/xw+qJb7Tt7ga1LO/loct57ammZo5yO
 LExKvvS1ftofHc7L4A2YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:94IVU7jb0Cc=:RnQuC58+AxT2mYfmg4uqsc
 ekdiGsH/xnREew1EG5U9ajEfuENMMvljExPbIOZ/YRJ1NTqcWnaGA/i7/HlyQFylFtxoTo7JQ
 /EN5AM5zzgDsOXzf3aMgy6DThh95c+gNetSPPKwIpkvaLZ3btXfdSaZy0YL9IJNZUg99ctru+
 eBjmS8Z4tsGpzq7apCwJcUYF248STctGmFZzaWNW+/S0zJc3h0RjruFRfD2SAMhHXh2tGoDiN
 fZi+Ijj/BiPRCGhzuD2ZcLqEeDnnTE/dkYbQ9SEYcmx2gbX29KcsNbaIAaEA9pxOizxoGL4ow
 6I94RKmhhQVXs7ACoTZcWMVQfLsjZ5UrcKS69K5N6Ckd59BUDiKCdPRoxaI9098gPI2/9L5dd
 /KjZgUsrLSQnfOZ7xWdXB8oM8wwsbRZHYytIRsavvKgbwUai1bMee8M7MMdITp+SjQWNPPxyW
 +geeYpg5tnMLEZCtNC0V8jVwzXPPSmPkObM8Wu8em6wiyleskkF4pBRuLJFut+eV1IbNWeCFf
 YjjuQw35mUWhXwGHUQUIiNiyq7jQsTDhFnXt6dX6sUlE/eKWasFdvMj+H0akQhlc59itXw7VM
 01+Q+upbzQVyA3peZt0p/yGib2GznmYM5p3csy4AByE0j2oyWysXDIHXH35Ttg47IdKzDYB5L
 RMbotX6eelrlV2hbwYl4pHAoCVd+jtkS+XnYwmPWXYrUomttCzYpnSqDq8RpW2WaUAV6NSK4i
 DKZjie7VIvGW3sE4/QrkdAWsn9mfTOOLZJNq+YUhssms52EqIDVAlUUz7DAxaYp+AHNpjpsXP
 sJdif+h6C4046F40mWlbG37NopZIUjs8f7/y3dTNxPylVA9b2i0Fo/l1WOXkKpu1Y6R7OctUb
 /PVJTW0yMK6muVQzW8L/ZD9J9DCmBnmySIFE7Ymu1xu2IOdaDkS6tiXvZuk3AHvwO7pxyd6rp
 ggRK/dMnS+2bmvboZHkgKoU2ObLO3PigYlVrYvX7yQbefeTZ6Oj+Z6SoVpWw7QJPOnwBJV+xR
 edWFGYU612vCZxdbQSCl9RI5ygjybpvVMp2tEN81CtWb6KRHtYk+oWjJ9fCtAs7Q9NYwNAoHR
 ajLR7qg9NP0GQtkGTBN8WbNGuvBrFEVfefjAHKduKAu3ABGTIl8DaTbIGJU0zCp3ei0aqgbLi
 LSiwGTShj4ZCAvD4RcG0CIq+hAfLRjT/LA/oTezFnUaJbu48WEJitzOu4Pfyeoclyg3yr2U6s
 ogeGVsc1w3CKyjmA/
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NetBSD initializes the LASI IMR value with 0xffffffff to disable all LASI
interrupts. This triggered an assert() and stopped the emulation.  By repl=
acing
the check with a warning in the guest log we now allow NetBSD to boot agai=
n.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/lasi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index ffcbb988b8..7b4a168468 100644
=2D-- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -11,6 +11,7 @@

 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
@@ -170,8 +171,10 @@ static MemTxResult lasi_chip_write_with_attrs(void *o=
paque, hwaddr addr,
         /* read-only.  */
         break;
     case LASI_IMR:
-        s->imr =3D val;  /* 0x20 ?? */
-        assert((val & LASI_IRQ_BITS) =3D=3D val);
+        s->imr =3D val;
+        if (((val & LASI_IRQ_BITS) !=3D val) && (val !=3D 0xffffffff))
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "LASI: tried to set invalid %lx IMR value.\n", val);
         break;
     case LASI_IPR:
         /* Any write to IPR clears the register. */
=2D-
2.21.3


