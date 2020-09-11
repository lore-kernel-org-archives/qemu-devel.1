Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BBCC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1DC206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1DC206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGozE-0006GP-Sx
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo8-0003H8-II; Fri, 11 Sep 2020 15:34:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo6-0000re-FN; Fri, 11 Sep 2020 15:34:04 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqZE0-1kuIQL1PM0-00mcfC; Fri, 11 Sep 2020 21:33:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] meson.build: tweak sdl-image error message
Date: Fri, 11 Sep 2020 21:33:22 +0200
Message-Id: <20200911193330.1148942-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VNrmQrRzyrOXhlp05PCPfiNOyfd2vzwDSlBEpdOlNI1dydqOlPX
 NVXd40ouFNz+WYole/4+GAPQtghb+bJRBbjatVj4fKl6rJcx26/mRQteMOBFnfKBWj34ekP
 i5W93fharJ76/2OgKd/b/RK3695FrRDhxKCYNJD77fTt8d0uqFt2C+keq2zpNEpJ+DXwzy4
 UfzpeTzRRdYK6xkYYO4Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eLeDbJgHpts=:wphjyO+wZA5BmfIA2ZDyEE
 TSScBPnYBgu4w7pcPCR+OzqiP91VM0sxBFaxASPx84FuKLZ61uLsffjbiuvM+lUxT9fKXPu7t
 QCZAlzcu2zvrS4R5o8ymYRkIoFgbRRpH+VVvFoRNel7uygetpAeYSlzIlEfUtk1V15wZRQFtw
 Qnd1ug9CSLOEpEwBuUB981tWwVJ6TSrLpt3ygfrbAitN9uJ0TE/OnF62wJJ7rP7grzZhcIEzx
 eZG4pGjRsSelmXfemnTa8GJ62UTgxJbSHYAAxkDL56/63AQVgJGcZbwZzQ1YjsNAkbMFIwH2l
 RfbzvHr879MjscOJz3lDKyc1do4p//+XOvpmOfd721m3MnIHZAJuCr501bWlnxLTiuLruKGdP
 5GG1rMAabpw3pvEIFbx3Yatq1bGIvzPzjIWL6Da38RDEfdQvK0vsFtfXQtwwMIX/6MQeF6lNM
 MBuFpLqsI+c4Pifaq12CYlcdtHn2pZPAU9mNYdDSHTbIbVy6CxhoUZ/lUTL7y0Xkf1LK+TWU1
 kM/GWtFiRWbutakk5v2tFWq5ozUQlXaCBolExh2pTzXdIjlmzH1621veM/KdZNlZMvrcdBsIo
 Upf9J5roIt4pyyJD8br2OefEMUFJlsYg0kr5IPQm7tEBL8w73FgoAWIdYXvNRmTRBTUvbYVDw
 W11jserIkr/zJFRRpg2Jtq7OX5UReKdC2Cg1APZPWuns6xqMqz2nXPO2ysOYTSi0XTaT5CTwL
 lK1Zh5tnjSHugX0vT3gBshtzGv+pp0SLPJ7UJIwdJuj2NZ04l2axqnw+WRRAJcnlhPxWLaOut
 U2XWzVFDEiB8+3dDrZ0OHPXOKz58KqWijacJptdbrB4RWzySxHM8FeUnpff8HJDqOtJFJyv
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Rafael Kitover <rkitover@gmail.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Sergei Trofimovich <slyfox@gentoo.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

Before the change missing SDL was reported as:

    ../meson.build:253:4: ERROR: Expected 1 arguments, got 2.

After the error as:

    ../meson.build:258:4: ERROR: Problem encountered: sdl-image required, but SDL was not found

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
CC: Rafael Kitover <rkitover@gmail.com>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908074016.2593596-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5421eca66a02..9dec3f5b2d4f 100644
--- a/meson.build
+++ b/meson.build
@@ -273,8 +273,8 @@ if sdl.found()
                          method: 'pkg-config', static: enable_static)
 else
   if get_option('sdl_image').enabled()
-    error('sdl-image required, but SDL was @0@',
-          get_option('sdl').disabled() ? 'disabled' : 'not found')
+    error('sdl-image required, but SDL was @0@'.format(
+          get_option('sdl').disabled() ? 'disabled' : 'not found'))
   endif
   sdl_image = not_found
 endif
-- 
2.26.2


