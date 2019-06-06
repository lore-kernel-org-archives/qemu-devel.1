Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626AC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A54A2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A54A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqUz-0005qj-LI
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:24:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFi-0000k7-Kl
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFh-00046k-25
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFc-000418-7N; Thu, 06 Jun 2019 07:08:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M5gAG-1hSmUP1wPi-007ET8; Thu, 06 Jun 2019 13:07:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:24 +0200
Message-Id: <20190606110625.32127-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X7Pzqi/mv0dxQQiN8SxrwtJ1RIT5ZhWHO/wg8CR2AcU8Aqcjkys
	IQILE+MXIMIeW8OZvIlxp20ttU8zBKHg+OHVjimLpwVlLRzkTfABJ3EfPAqZJwvREjbWdgq
	0G8lATPj2xwT3lND3J7dZNB0+TVgmZllAOYUegn0R5SO1uKnNG/ALrTPlNsL/kpIu7DghJK
	Cv57NpSdPF3BCnxkbospg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UJwOZYeoFZE=:1naxc3Kh4Xt1rELgqCD5Bc
	jDG7R9YIyWEy448OTJSvwueso0oCcp1Wg+5dv9uljp/ODYIVIqYK3qrpoi9GrQ81eQ5e1JQ5Y
	boUwl/zJwrjii+TKWN7A3/dWo1mTH6/IMXKXRkMRwnaB4J/Lu+78m6yEa6pPlycVETr+IMCem
	T6u9ZmTGE/Y03DD3zU5XVyJA2c11ivHYZeozqFRepdC5yF+bsFPM/OLTs6L2s5AFMNksRAOx6
	GP/HXXDpGfW0mWIY53D5CUbTejUgoZGvu0IiWTIF62btz3LM3huPtP9W0q7MUbPQns1/WpNQ9
	FXnGs0gfu2EKEnsYgO3Pv78uaUnRAhSNWIn1eup0WsgqiQO+6TrQwPuPXc+mjzEelX4ZsyIbh
	IHMoMH55ERH403WeYncRip2pmilDrx4eL1y5OIjzA1IOOMq7XqzTze2es7uxv66wMEJh0HyvG
	yIb91fELUZP3Z+80NXDzbZFDv5JD665sEG6gPN6zKaKf9swcGkGotbf2zOa5kJc6XpburW5ol
	Chu8/hf2ZhTykZQcHHplN9ABAywYUaxWa8Z63MqAgCyINNbfFR9IITsdwt9xVF9WFvwVClMnB
	BeuyEtEARetrZfAVmXJkXiR2X6U897IUP9ISh8kBLqaAXT9NCpEHXBhyoG5V04ui9HfBTLZFc
	v+iZLp+lgDo1KPqmGN8O3ytdYp2FkPd8+nWadR6oXjG0snJpQonyP89VHgk2LRi7kuuqBE4FA
	bChtXKsN9soniAqqZ+lNz0Ur9RCX25vs6TVKdeD1WVdaM3ADRPG92BiIL94=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 15/16] hw/scsi: Use the QOM BUS() macro to
 access BusState.qbus
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190528164020.32250-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/lsi53c895a.c  | 2 +-
 hw/scsi/mptsas.c      | 4 ++--
 hw/scsi/virtio-scsi.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d94fcd..a8b7a199f960 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1860,7 +1860,7 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
         }
         if (val & LSI_SCNTL1_RST) {
             if (!(s->sstat0 & LSI_SSTAT0_RST)) {
-                qbus_reset_all(&s->bus.qbus);
+                qbus_reset_all(BUS(&s->bus));
                 s->sstat0 |= LSI_SSTAT0_RST;
                 lsi_script_scsi_interrupt(s, LSI_SIST0_RST, 0);
             }
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 929404fb48c8..e800683e91e9 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -540,7 +540,7 @@ reply_maybe_async:
         break;
 
     case MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS:
-        qbus_reset_all(&s->bus.qbus);
+        qbus_reset_all(BUS(&s->bus));
         break;
 
     default:
@@ -803,7 +803,7 @@ static void mptsas_soft_reset(MPTSASState *s)
     s->intr_mask = MPI_HIM_DIM | MPI_HIM_RIM;
     mptsas_update_interrupt(s);
 
-    qbus_reset_all(&s->bus.qbus);
+    qbus_reset_all(BUS(&s->bus));
     s->intr_status = 0;
     s->intr_mask = save_mask;
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 2994f0738fd8..12d21bbc613c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -696,7 +696,7 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
 
     assert(!s->dataplane_started);
     s->resetting++;
-    qbus_reset_all(&s->bus.qbus);
+    qbus_reset_all(BUS(&s->bus));
     s->resetting--;
 
     vs->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
-- 
2.21.0


