Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FB921D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FB921D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvKo-0004Sf-Ew
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv59-00010n-3Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv58-00081G-1F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4z-0007sV-Mm; Fri, 25 Oct 2019 04:36:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUGyh-1iWTVR1uV9-00REYB; Fri, 25 Oct 2019 10:35:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
Date: Fri, 25 Oct 2019 10:34:57 +0200
Message-Id: <20191025083511.11463-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uBpOxXMuLPxHKWK6/kD7EFF3c9UQZLvuAXfyn9fhAoa/clsGmUA
 K55b5ayMJJ4ds1bIRDXooVDF9dB2H3+0+zqjNy3OBx07di4AlLlQ4J9st0OPM0Re+ss4RYy
 zrw7Lr9je/Sz9awOZYYkQu1X8HLdZAeYIrHK1GbcqFZ/kJCbEvEtJMkbil2t0W/wPpHx8UX
 4+U0vZbfLQjurmXs6scJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yW8U9yc4Kh0=:7oXwoqjFFLnDYPJG07KtHS
 /JMkSNQJF/7qCculq4xK7/PBaJEU+4LbJKTn5tyBsqpBp/OkqYrK9424puhfi66VTB+0uFZM3
 cO0DpIWNnErxZhh9FSxDXgRLzWvSS4e2tUFltxN/aER8he/Y6O9giH8DhmjiPwV7W/NiORlPN
 0mjhkWI4qaQezpvL+1ssS5cSggm/fqmnUnP4QzEgUKnotLRU+QUabDFgftn+RRPQKFeKONAPh
 ISX7koluDhGcz7hGx2yAOJw+erchTBJ3OX2s1Lg0BAsYczkQ88p9Lw0DLmwRce8EQkhrsT0B9
 AOB9Ju6Q6fSKiWOFW5m4qoq+kQ+12uK6JXgBGTZGQyWrmgQ6/Y+ww6MYG/dSrjAjtqvjn3Xg8
 01nfLN8ODwih56jbeesczywVMzi3VXyYPZQYlpT1Fm2TzdBfAnvCIQI8c4GoJFaVaPw0XoGuJ
 +z6Kdm6RC+kAgtG5ZT04tObCNPSEF6YSGmJ1thCKvPzvf0T+n11Ss6lrjCeSY5nG9Afda8mKp
 KHxz3RtRg5JX9GhMkuDMU61QHaOIqYqs2nB0p4hcPKCoLe9UvscQPSs97YH0LfeHp3/aDs60j
 KNfYHs4ZKOC3+aU3bjpo42HGAfuVE7qKaz/x5O6RyYsjudt3Qiwt4ubWmlBP+q+yDVekSrucy
 QGP1nvkdyRTAhRm3224vQdDvyDpJBeoJEIff0gqs1EKNtCz3R8Xl+69KmOPVkDC2mp0aOjcY5
 TKioR2/aO2T7xu14TJWK8ebe7DkhYPNmZuWAAKLu4JqAqXU11gVDidnwyQ0TkXwm3VNprJGw3
 Gu+6mQSTIB2Pl+XsVFbL6NT2gi6lwUVjj8mn4I10G+TODDIzl1321zkULQKWRNRWK05sxD3PH
 b/TLPtdOomhaZSPmIk0Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frediano Ziglio <fziglio@redhat.com>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191023122652.2999-3-fziglio@redhat.com>
[lv: removed the two useless casts]
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/qemu-timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index d428fec56772..ef52d28d3753 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -322,11 +322,7 @@ int qemu_timeout_ns_to_ms(int64_t ns)
     ms = DIV_ROUND_UP(ns, SCALE_MS);
 
     /* To avoid overflow problems, limit this to 2^31, i.e. approx 25 days */
-    if (ms > (int64_t) INT32_MAX) {
-        ms = INT32_MAX;
-    }
-
-    return (int) ms;
+    return MIN(ms, INT32_MAX);
 }
 
 
-- 
2.21.0


