Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459EC28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1E5207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1E5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqPM-00014T-Ap
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:18:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFT-0000V3-BG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFS-0003ks-90
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:59 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFM-0003Oe-0o; Thu, 06 Jun 2019 07:07:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N2VGj-1gYjrl13Wh-013vCt; Thu, 06 Jun 2019 13:06:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:14 +0200
Message-Id: <20190606110625.32127-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mdZyVMDlhLtgzFVkGMKPwhd1vTCTlJ2n6UQbcL+A7mXIwzLbgVv
	rdWaTvkzh9+ZGkjpPIEnoHOJoofHKJj03PiJSnWzmZUzqRXpOBY3jmF4C+vJZl5cnICB7cQ
	L7j1xb5jAz4it73StJCFXFaTOJbwctRdg49ymr5t30LvpGOdZYXf6TUgWyYtZ4NUA3WF/i3
	PFB3LNVa1ATntBhgNggXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lGxVdu6POuc=:c8Pj8N5H0zrV72OzuTHYjr
	HvEThxZQTS39G9ir4HCYdnA/11jd7NfU2ekUEFMs2LPH87iAK/aQcoxTPBaVuvBRA2e7xbn+M
	A+Dhz9E9JjU8Ly+u8D7P9CesJcnFPStUgdvdhFZWm4HITMM1gXddx3RLjRGo3eqv30Nh8hAOE
	AQevROoOUgr53j5+TZv/2e425A0rT4KjV+RLjBGlB5L36Nq5bp/9+km5UAw4HtJvYAw2uvfYy
	6Eb1QcFpWXBx3fosHlLdbiJpki7xj0CdfudtCd9f4wKfFnwIQyyISNeUB38zCmTfDlL89YoRo
	72xZeDkiDORNcx/rW6EoHNAlkLZqEC7czmmo+ah/1ksqBYf69uuwgautN0at4fJtu8CI9/dAP
	qfApkM4XCf0s+qJ8514u4xAGK0k1taB6cFBViwyVW997GnTVXg+TGEfWHJbWyqP6eVB6HsQ6i
	MGzvxhkmrSLcmfGO4WNefexyU4sEabxATw+6LImE1Ff7/2a0eQGpAeKqM2lxxy1ICBWDe/tRN
	htjEx1O/AhrsL1Qmf35pqRERYdZPlYJRLFz43WIpaDzObwEiB4x2j36HmAt6UdcE8RzeVIqk6
	/7mkNzzk+aEgQ9a7k1G4YnRaGsV7068KeylLJFPzWAyy1RSUqe+MhLdRV+BEf9XDGukK99tPW
	PrhGBgfsD9zRLt2wqcxudQvNaOmWVI+UU8TmCtGhf/gVMfqEY6NYvMihUaqPd9mKHbtHgC5I0
	9xE614xtHBAUHPL7256GZLupxYmcWXuUR5ZkeXI1Qze5RIgg6WGIFD0YI4Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 05/16] test: Fix make target check-report.tap
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
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

From: Markus Armbruster <armbru@redhat.com>

Fix a fat-fingered invocation of tap-merge.pl in the recipe of target
check-report.tap.

Fixes: 9df43317b82 "test: replace gtester with a TAP driver"
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190604080010.23186-1-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 46a36c2c9527..34df040583dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -904,7 +904,7 @@ check-report-unit.tap: $(check-unit-y)
 # Reports and overall runs
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
+	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
 
 # FPU Emulation tests (aka softfloat)
 #
-- 
2.21.0


