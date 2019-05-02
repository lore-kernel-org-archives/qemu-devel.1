Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6827C04AA9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898C820645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898C820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57365 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGxK-0004nr-P7
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:01:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvU-0003Y9-B8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvT-0002xz-DY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:24 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvT-0002xl-4y; Thu, 02 May 2019 14:59:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MCJzI-1hUUNc0Puk-009TeR; Thu, 02 May 2019 20:58:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:30 +0200
Message-Id: <20190502185835.15185-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/E9PJ8wbSag3h+mggOHhfRYm3tDrSS9uN8E8fxK4PJ8y8ov7hkq
	pz6L43/G7pw9ScQ4R824iVA9mGysIYRlFXQPNaGymqb83wGbDrBRRlwxno0+Ml+HAGxot/h
	3FPenIk+eEoI8tg6Rt7fc4Tt8c9WAdNVRzoDcZwRoEHbHY2QuzjoyHdDj6SMzVIHAz/RS4Q
	nOEtHLCS5qipvZffAW29Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xASIYm1eMQk=:77XxnSLJxTNgLzGbLODGDD
	zLW8dCp11d5R93/sdrFMriQ4M/IynBcyKeO/TitxQAF+qzybjBQo1F8UXdStALaCWPDt0dLh7
	O5/yO8JhErQqSOzTtBjPknbXdxNab173drG2PQtPnYh45v88gwOEUaM5DDzLjUrWMXL4rKJxr
	Tn6/ef2bez261jeggziznHOHqD5r6dUrbRky8DRE61RyMPzBN9+Vu15dIjDpbjJ8xrmUl4ukU
	8QPm6wJLT6CdD0/aF5Kq6MHkMI0+jCA5SGmuNivFJAxFUJ4tHPKkS1du8dP92xAmQkatUUe8U
	ukaSRioYcNY2+Nfus/4Z2MW+gAHttsnPPFHSbpH2bxY/rrR4njE0tFKcQjgaUx3/7Qm2Sm4mH
	KR6oOPyylW3DcXTnMULNrcigo6jIdHZ0AZEF6A8/n1iXJH0MzaTh1087w8v8Ugar+eeB80S3M
	6QqzwhNx5MvkzGVNDgrtHsSF2uIpU2aRqN6YuTGKb0J+Im46RfxEv1pt+rJvylgXli2T2XgfX
	c7tcI4LW2y6Db4Hox7Dq1bRv+k82VVdTfMqKQAvoI+EVyxtyeLyWyNIpwi1yv1qt/v9y6Kcso
	XlnHDeQ4bUp1gUgF+QoLo8gPz3Sb+DmGDgUfdSbxUq42INPR7W+P3cxu8DtQBdtzxUmWuKJvR
	AfO6YI75GR8BSYjyHw5D57pK6QZgC06iVYCg4Nvo/UwRX931JyHey4mvwV6W0bcE6fwIeK4O3
	c+AtwgXfZtpmK4CshcVVDBW3U3KfjwcYaj0nvpugupROI4aBQn4RLwYarRY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 08/13] Update configure
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185830.2q_RiF-4yDMXHb-fjb8ga7KSx-8RCOJbKa5B_uQikDs@z>

From: Stefan Weil <sw@weilnetz.de>

The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409053320.14612-1-sw@weilnetz.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index a2607afb3408..14f02452f9d4 100755
--- a/configure
+++ b/configure
@@ -7880,7 +7880,6 @@ LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
-    $source_path/pc-bios/*.aml \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
     $source_path/pc-bios/*.img \
-- 
2.20.1


