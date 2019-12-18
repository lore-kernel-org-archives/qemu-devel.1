Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC02146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZLf-0007tt-Cy
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx8-00021Y-SL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYx3-0007vT-Qz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:22 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYx1-0007ez-4G; Wed, 18 Dec 2019 08:01:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MY5wD-1iC0HB4AEH-00YQSd; Wed, 18 Dec 2019 14:01:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] monitor: Remove unused define
Date: Wed, 18 Dec 2019 14:01:00 +0100
Message-Id: <20191218130105.125981-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B6YPh6a/2Jn6QR7PRjH8XuSgK1AeJBsTvAMvlseB60rXwBbjtiq
 5SQP5rSegMUe7F31KDqjPqgFFwV4u7U9Tyy9zO8h9vI2zf3XLpK6TxogKmalpmEEA5riGGD
 wWZEzv/CSORnItLTf/D0OA32lMzT1iR0AXk2A2LFMJvmvOytyB2p+AscEM1StKlJdOH/06o
 MHAfD6oRP3cO4UuFe+QIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YTmUnv4x634=:k6CeyI2mP3DJzZbZeR2FS6
 56caXC+zSxoi8pIHEUlDP4ZLJafV8ECbqU+QSsa19+sRcmcprFNeyQrVY19dUElhMDgN29/y9
 +wGh4yhs/DlVRqnQ/LBa24kMSHRtWpiG8GRGTBNW0OmtAJmlQChdBrWgNLfvKI9Ks99T6v7At
 EySLab584XiKCrw2tzhbFf8jrOWQqDu3Pgb2xIP10H3NAni0Fnb1i+WzL6HF0c++RRk1wX9aV
 8mdnetrabIIrlJApznx/snTinlIPqMiNHoYE/fDb8hUlTMd8+PRkUOgnzr81feWlS9t2DaQ+9
 4ttxt4AXTI5h9xCrPTlJpI69UQAMZQOPVMvXw+sqweadJzHZXGqeEVeTpK8tqML1Q5awc6RxW
 iXp1F77vMvDzQy5FV90HrrCuasZ2ZBnlkC1XyUGZXU9KArsDARUzG5cftqAHuZLuelI53evLf
 3JAHJETooOQ1EEv5SvG8Lj/fi0y6jDz68BlDQFJExN35A5QS694bJ0uhIfHlFGz7AaSgTzdtK
 cZgROv5UAmaEINKpY/qV5oYRq1ZV0leeANh3ZWW2+96pEySAhDk/QVeL2u77f1ev/ZTRg396C
 KYdC5L8GRGy6dOlV4S9+AgGxAMmewpF8inDJEMj9ZCxg9O7NGWFft2J0lO0vQ0I6CYCS8LtRP
 4lDy8+Cpdu1XXDNUan/40cUoz1y8Yk8R+uPGlcJ34g1ypxZc6lTbM0M8TJnXGD3kVWCqZW2WP
 GXpeAv2ngjVC9KYxURchERGi3IJW3k17KkU0P3/Z8t0AqJL8/qfKAVGDWTMp8DVX44tSZJ4eK
 Xxu2hmNy1iKi10zdp7WKPzzbp4QM2BwyPmddEejfmK9xtcCExqxf3/O273pjPBSpK2Oh8MDzh
 BS7pu3ExuYWfnkSU85i5swb9foo/UXZKL8bGRICPg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Remove the definition of QMP_ACCEPT_UNKNOWNS as it is unused since
refactoring 5c678ee8d940

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191119110709.13827-1-yury-kotov@yandex-team.ru>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 monitor/misc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f3bfac..6680734ea150 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -106,9 +106,6 @@ struct MonFdset {
     QLIST_ENTRY(MonFdset) next;
 };
 
-/* QMP checker flags */
-#define QMP_ACCEPT_UNKNOWNS 1
-
 /* Protects mon_fdsets */
 static QemuMutex mon_fdsets_lock;
 static QLIST_HEAD(, MonFdset) mon_fdsets;
-- 
2.24.1


