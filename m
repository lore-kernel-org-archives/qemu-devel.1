Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A0F2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNv7n-0004GW-OJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv4x-0000h0-RZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv4w-0007q0-Lw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4q-0007iR-4Q; Fri, 25 Oct 2019 04:36:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjjSt-1hhgEX0pvH-00lEJL; Fri, 25 Oct 2019 10:35:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] util/async: avoid useless cast
Date: Fri, 25 Oct 2019 10:34:55 +0200
Message-Id: <20191025083511.11463-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:onD7UkbNa4WcqpkfMRXh4f2hRmOW8C3mwnPjy0VAImYEeEq4nPu
 CRId/qUyJGNBiOyQrpE42eC0YEtBLhHV1xBd2Wffq14aJN/oPhNh+kc4cvLQ+ivT9F22XXl
 lDjx0DXU8p2SPkXv76zBwuekgZvvsQRT2mR2E0LVvOujtpk898IVmzH0e5ZH4cmAVvSCXK4
 SVx9vBNb1IbomK50Es03Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tAM5+AlWd3M=:Ig6AfLJCT3dRBJ4ri7kM2+
 5Qg+vq29NwIQM0mwgZ4blaw9zON5OXQtUfOPCBRBiIUGBWmDtZWapmCZtI+r9y8bUjCgvi22O
 GJmZbY5SRFjn5tFwTdIeBODiaFKZCR+jjntsWQPPBsyTWbgY3sLbFqP3yx1hPnbpDFyCMuqPW
 qMRBCSQLzVWqckdABMgkzIDUHmYw1vw9UhfM2NFerDOnsTGR768lpFyA4MmTOt8tb4GpHTQH5
 SCokWHcLEhcfmKuK8NqjFIxaC2ZEVyqK1e0AA83co2ocC79q7cUmge4ncTbW08Buy9jmduOb3
 308dURjYoPKWZ1awRyKERjrZ0WIxI85rfIFT2gZfQFhjnFQdVzTHtXgA4CfZ2+/TpkM4J0Bwc
 RDVh0zeZtSl1rKF4F17p8ijKAT3gc1UGqxFu9RimAXf7mdCB09za8mR/z5Lnm4BevNIG5tjiP
 Bo4Y8/gb3k09fYjgf7w8gsuQkxNCQiTWHplwyYtS77XhhYSdLwTb+yi0IU1UXJK7DjkvhcDxk
 6+Z2U1OUtdP6iK3vEUStq1e19U71OdZoKml5GEfpDGg/0mjp0OqbYjuL0aMmSIsybRQ1i0U8m
 0BnG2KXsxMwza7+WdPyuE5dgZQh1jmZQP6uVPGfGdJPDZAx3+w79EckcF8wYwbXxNvEDP/oej
 QrjXL+x+K+XA04jmptHK0/XZEmQqvBuNsyxp4YJEoH6IEmwsAdskxEzYmSd1xe3tbIWwomRxh
 S9tQ74hwRsCNzMuP6wy3egTBzrCamPXTb2wV9QNH2ZaJHm1xPUvIQINZ6jJUAM3rSi/RuA2DA
 I+8+oYS/BYnYyaHQ2UzqFn2JqX2DnW5Tc5ajgScL7x15FNk4EYGErJRNk7baEJBoycPUIqloR
 60b12qJaMcJHlyLy/z8A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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

event_notifier_dummy_cb is already compatible with EventNotifierHandler.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191023122652.2999-1-fziglio@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/async.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index ca83e32c7fa1..b1fa5319e5bc 100644
--- a/util/async.c
+++ b/util/async.c
@@ -429,7 +429,6 @@ AioContext *aio_context_new(Error **errp)
 
     aio_set_event_notifier(ctx, &ctx->notifier,
                            false,
-                           (EventNotifierHandler *)
                            event_notifier_dummy_cb,
                            event_notifier_poll);
 #ifdef CONFIG_LINUX_AIO
-- 
2.21.0


