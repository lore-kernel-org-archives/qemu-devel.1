Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CAC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5382E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5382E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn57W-0003eY-A0
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn56S-0007d1-HC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn56R-0000X6-Gb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn56P-0000KC-9d; Mon, 15 Jul 2019 13:49:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01E2130BDE49;
 Mon, 15 Jul 2019 17:49:26 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 052D55C28D;
 Mon, 15 Jul 2019 17:49:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Date: Mon, 15 Jul 2019 19:48:13 +0200
Message-Id: <20190715174817.18981-7-philmd@redhat.com>
In-Reply-To: <20190715174817.18981-1-philmd@redhat.com>
References: <20190715174817.18981-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 15 Jul 2019 17:49:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1 v2 6/9] buildsys: The NSIS Windows
 build requires the documentation installed
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes:

  $ make installer
  [...]
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=3D${i%.exe}; \
             arch=3D${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                   \
                  -DCONFIG_GTK=3D"y" \
                  -DBINDIR=3D"/tmp/qemu-nsis" \
                   \
                  -DSRCDIR=3D"/source/qemu" \
                  -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION=3D"4.0.90" \
                  /source/qemu/qemu.nsi
  File: "/tmp/qemu-nsis\qemu-doc.html" -> no files found.
  Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
     /oname=3Doutfile one_file_only)
  Error in script "/source/qemu/qemu.nsi" on line 173 -- aborting creatio=
n process
  make: *** [Makefile:1080: qemu-setup-4.0.90.exe] Error 1

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Not sure is this the only dependency missing, or this is the correct fix.=
..

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1fcbaed62c..f8dac48981 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,7 +1073,7 @@ installer: $(INSTALLER)
=20
 INSTDIR=3D/tmp/qemu-nsis
=20
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
+$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
 	$(MAKE) install prefix=3D${INSTDIR}
 ifdef SIGNCODE
 	(cd ${INSTDIR}; \
--=20
2.20.1


