Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF8C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28591207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28591207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58457 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqKj-0005EZ-7k
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:13:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFZ-0000ad-BJ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFY-0003uH-CQ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFV-0003op-VF; Thu, 06 Jun 2019 07:08:02 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MVMJ7-1hAGXq33Ul-00SNSl; Thu, 06 Jun 2019 13:07:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:23 +0200
Message-Id: <20190606110625.32127-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6yAVocbjKkdBthOG0ZynWAA9tjWYhTGgRctHDWFppOnRh6f2oMI
	/vBXPjYl9uytwxPm04GLkOO7j2odwptj220yrssmmYDeu0p6f+nOslYEn2YV9RLY0AFoTwk
	/Js5BQh+wgbFrluk1P3muu+XHFGrYBEikXnFBGguEjXFynE/RZr1ORbtbU3QrJfWVYTOjV3
	XxNsfe0AepBWa+PepxPEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a7UhvE8kYu0=:HOw3Hj6Z+A6PP6wACCkwe9
	h3cyl3LZAPts2BrmQ/Rcd31UoLU6jx31hJSCCGgbUC1g2CrBY3jegxvu8YVXXNBiuNwFUS+39
	+NuWw015mgPDFwXEVPEDQM0ypqp17ulEa9LOzgTXqBnGEXujsQRncbHmWAAeU9ajurvchszGa
	otlD7e9F6Wle+N/jgjgTbrdiI1FAqDjzpnVcdJFjPrUYML2gGkEpliu6/V9KKCiLsVVEjqqgG
	HzIQj1xL6bTjDp2Ln2016N8dmg1pGMcD3crtSOn0qMabF/6cBezy2Ovo4eo1Rq2/rkZJlH0Hj
	7BiMiuoDY3EAskoJj6l3nq1sHgVzkey3oEMXp4qpwCXbXbeqCouEsPouaEcVty5Wk2b/Ufoch
	csvi8lzHGBDMM/P8mLvfgzWvUS/ktbSVViNZ3c+8Fv/154D90h7Ix1pueVFBASTyqYHpsEEHe
	VPqnmuy1auUwIhcz2nFuXAFdwlS3VVPxMLRqkZKTdijfnRuXvDNPL7L5FvbAS28fCBa7d3xC2
	UQkD52h9vNZ/hY5vcpFPJYPhOfC94ptFvolcAgB3XzHEoPmb3yQ5DiSPdHivRuQLV5hrnTYgE
	MchukZicxKLDe5d3WNrliGpf2W9gCpS8SrEaGVHRJsVIQ4eMlumt80ShKfLtSaS4zUSg0+CTG
	uxORGPOE3Ltsy+SEzjGF/g/YUfVh5miWlOLPcwaDgjtJ8KzS2swqtlLTDomgZ3x+JQ1vMPrAY
	Ca/fe1I+ZmBs0B/r1hl4T7LVpC1cCcFg2yTGFNqysDvF2zW/YQ18TTOUmvY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 14/16] hw/sd: Use the QOM BUS() macro to access
 BusState.qbus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Rather than looking inside the definition of a BusState with "s->bus.qbus",
use the QOM prefered style: "BUS(&s->bus)".

This patch was generated using the following Coccinelle script:

    // Use BUS() macros to access BusState.qbus
    @use_bus_macro_to_access_qbus@
    expression obj;
    identifier bus;
    @@
    -&obj->bus.qbus
    +BUS(&obj->bus)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190528164020.32250-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/sd/milkymist-memcard.c | 2 +-
 hw/sd/ssi-sd.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index df42aa1c545b..dd1ba649d9c0 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -277,7 +277,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 623d0333e863..25e1009277ed 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -249,7 +249,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
     }
-- 
2.21.0


