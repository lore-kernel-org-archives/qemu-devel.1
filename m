Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5717C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E55020868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E55020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqH1-0001Wu-Lf
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:09:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF8-0000BW-Lr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF6-0003G2-8Z
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:38 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqF3-00037Y-JN; Thu, 06 Jun 2019 07:07:33 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N3KDM-1gZYHa2AiY-010LEk; Thu, 06 Jun 2019 13:06:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:20 +0200
Message-Id: <20190606110625.32127-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sJX7kOEASuUqzKMQ0rklS29mfRE7eUYEEoU/Bn7KIEsOMKwqJ2X
	YWBGxkVKP21No4MYqZEreaKD3SKmNr0IVXBWh40+U/9wjURMbjPqw8xeygGtw6C5ruUhURw
	5PTP2d1ArFFy1tfPiZ2v60S3hEqYzBDPMVDYHsP6/bOT7MTQFtMBMFBnNyiu2k8qqxW4zGN
	d5/gMCNINInwKR1/la0Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wzw5+xshbZk=:eOln+xl+YM9UAHFJYpiARo
	kMAa5EWoxeJf34xxDTgqQC7fOaimZY1Apa9qaRK20b2mH5uttdGv5MT0xv8KkiEvQwmXTKOrI
	G2w9K0lP2YVN4PKXr3HXSK0hfP1ilcrHsjdI9FfPWdj40yGFwONc+PLcvGlkcsaqIextT69My
	rWsilrh0PqEV/gOa+bSvsZmd2o6oXtWzcINnTA2TM2kyejnf5FaobVGleekLnqui3iiB3KDdm
	+mrthPjiRiF+4ZoRmeNyHoQJadUmb1D9jXvzXFpkSk2FIaa3V+e4pEwGFocsoa+5Qziid1dXL
	G/hSg2quGyzbJoQizY0Is1jXorDCvkW1jORInWTjiYN+eXsJ0JSH0xCf9bGlS4niFydQTqsRu
	NfNWtaSO09TbKrjupcwPheqsAkmieZoeh7OtLq0lvDQSWXVObbQbzxUQTOsB0u5F0tCEnNQ+x
	KnarwqmnqkOCRTaNrbJJ/iGOaFAaWo/Ok/3OcNTC30q6TnYKqgV5pzyP814fkUGLUVJ9AczkQ
	wMRWKKLAifJ1iX+FYEu5sfFCAM5mw6I8j6qsXaHiYS+WDrO28oOUmtqwZ1r+Ced6EkQhr9Tah
	7OKszfHeqfKOaG7tEXrqVWN9gnCjLP1Lcr2AQ1KhdtQpCPZ437d1npzmQju6AyY11X2l4RDT2
	lOZtGC96V3nZOncQEtpZptxJsmP4A3jVp0PxHXvfVRwUadEL9507lG4oScg+uHRfOhJQxiupc
	+21hzqQAGybZD2uXCflfJLXdq9D7qS8WmCZrFi5lKSxFoCg+NiVzEQWCFi8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 11/16] hw/usb-storage: Use the QOM DEVICE()
 macro to access DeviceState.qdev
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

Rather than looking inside the definition of a DeviceState with
"s->qdev", use the QOM prefered style: "DEVICE(s)".

This patch was generated using the following Coccinelle script:

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20190528164020.32250-9-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index cd5551d94f35..0e4e93ef1673 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -616,7 +616,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
      * The hack is probably a bad idea.
      */
     blk_ref(blk);
-    blk_detach_dev(blk, &s->dev.qdev);
+    blk_detach_dev(blk, DEVICE(s));
     s->conf.blk = NULL;
 
     usb_desc_create_serial(dev);
-- 
2.21.0


