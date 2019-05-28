Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F701C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B68216FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B68216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfDq-0003eZ-4A
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:45:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVfCC-0002Qv-Og
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVfC4-0001Va-1B
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hVfC3-0000uy-Mi; Tue, 28 May 2019 12:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65BF430BBE69;
	Tue, 28 May 2019 16:42:13 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A884460BDF;
	Tue, 28 May 2019 16:42:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Tue, 28 May 2019 18:40:16 +0200
Message-Id: <20190528164020.32250-7-philmd@redhat.com>
In-Reply-To: <20190528164020.32250-1-philmd@redhat.com>
References: <20190528164020.32250-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 28 May 2019 16:42:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/10] hw/audio/ac97: Use the QOM DEVICE()
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
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than looking inside the definition of a DeviceState with
"s->qdev", use the QOM prefered style: "DEVICE(s)".

This patch was generated using the following Coccinelle script
(with a bit of manual fix-up, removing an extra space to please
checkpatch.pl):

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/audio/ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2265622d44..a4e8d99e77 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1388,7 +1388,7 @@ static void ac97_realize(PCIDevice *dev, Error **er=
rp)
     pci_register_bar (&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nam)=
;
     pci_register_bar (&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nabm=
);
     AUD_register_card ("ac97", &s->card);
-    ac97_on_reset (&s->dev.qdev);
+    ac97_on_reset(DEVICE(s));
 }
=20
 static void ac97_exit(PCIDevice *dev)
--=20
2.20.1


