Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDDC28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08A9207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08A9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqJx-0004V2-63
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:12:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFR-0000Sj-6C
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFQ-0003fy-10
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFM-0003W7-7N; Thu, 06 Jun 2019 07:07:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N3KDM-1gZYHX0OdG-010LEk; Thu, 06 Jun 2019 13:06:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:18 +0200
Message-Id: <20190606110625.32127-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8FmYLJqd6nXvaOA8F8eP5aRFDi4xgKrj8Ckn7so07AqnFefxKJf
	bufSPAvf+aYwQgR9cG5GMvWhk1VEnOVUWd0r0yy8RSAQEFd+XSPDnGH2YOHjoODZstbDNBP
	hfir2+Nxzizz1I6FPy4HeD4KhyTRzZQpBeTn7NODDPVZ6v91buO68l2eGYdtrRQKQARrDoj
	ZwU3gVtBTmY/hY52GKerQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TXGh83A+BFc=:ZlfeUp7i3lWhZ1IXQbS3vy
	U2Bk0DiMUdTX8F+CvMczxQV8EQC+3NNdMMqRxki0S8iDZUb7knNsz+RY0/MWSRcL3sFAH2Qgs
	iTMU5zsY/fRk++iZpKBsLf/77weaz/JLdHmuebICDCZr88+/f1h7z4njGpe2gMQQkbBXxDmiD
	43VVnlr0AYXNUYcFubTEJHg1W+eBnaupuHDVbH5pKKfiKVZzYNukgrCyPJZHBSyC+o9dZMyh6
	oZwo60W8Fh6nQ8NjKCYhVZq00OE9wAjuDOwxZbhrIMqBl4EfQ9e5XWXjBKIEP1erub0XdDOuq
	PtMRlIP+O4osYQ0btM/Enw+jNZreHIjHP1MOfomcLVY0rzBra3aRUmEAuxmN2ziLaarW5pBQ1
	HnQYhQQ77S9QPuHVM/wHaeSQwgcWhW16lSy069RS9SHri6NHt4zNg21Xr+OSCuQo1YbbYjrnV
	BLXvD3MY2J3kPBmm+2lhDvjrxhKQajcLpQvHm72Ej49J7OXGtmD6UqPrlGxEM/Ny4hdVCZnSW
	9NJULwNw9yPSrmCbPtK9Lvzxl/pstrBQ/0FRU3QxVF0kDCbQwTl8ORd5+gjT5lNq2s64yejtt
	AWDONfS94OE1iPefipkTyvEtgQ/CCP3exZKiMuGSWVsaj/iMrHAJWqSU89Jiez3PyUzEOu+GC
	ld7sutLLk9ni1LAGO0pUVF3YimlAScZs5LEFeM0miGuK+hAI3DPbw6/8Od+kPeNuTsuoTcjUn
	UegRD73Qo5OO0CgaqpZPVkLwc1zfqhKugZUSxEQK5r2x0aqrFOI8d/4r0c8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 09/16] hw/s390x/event-facility: Use the QOM
 BUS() macro to access BusState.qbus
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190528164020.32250-5-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/s390x/event-facility.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index ee5b83448b11..e574223a226b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -466,12 +466,12 @@ static void init_event_facility(Object *obj)
     new = object_new(TYPE_SCLP_QUIESCE);
     object_property_add_child(obj, TYPE_SCLP_QUIESCE, new, NULL);
     object_unref(new);
-    qdev_set_parent_bus(DEVICE(new), &event_facility->sbus.qbus);
+    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
 
     new = object_new(TYPE_SCLP_CPU_HOTPLUG);
     object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new, NULL);
     object_unref(new);
-    qdev_set_parent_bus(DEVICE(new), &event_facility->sbus.qbus);
+    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
     /* the facility will automatically realize the devices via the bus */
 }
 
-- 
2.21.0


