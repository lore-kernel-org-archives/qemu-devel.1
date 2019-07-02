Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E126C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A802054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A802054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiI59-0006Nd-Fh
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiI2d-0004NE-Vq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiI2c-00019E-Vj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hiI2c-00017Z-MV; Tue, 02 Jul 2019 08:37:46 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mk0FM-1iOFXz1Nt2-00kOCG; Tue, 02 Jul 2019 14:37:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 14:37:13 +0200
Message-Id: <20190702123713.14396-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702123713.14396-1-laurent@vivier.eu>
References: <20190702123713.14396-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9PslG9qvap87WaFplIbd2STu9GAhpSP8ANYNJ4shBWiGv+wOd4O
 STm01u3/YmHoYBJwEDo1HqxVQVrAelxIaQTWuFpAdBfvdoG8WPFR69CPXZPRwo4xPPZRB3h
 7QZwx4WarMFj0D18dsOPc/3LVc/lk/Yt1EWz/DqBgJpQe3knG5Sv5PJzq1RhKm8t+b1vUJx
 K3wmwi7U9j5puFtg7qAuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BePkrgQo824=:8Jy12W+JcWNeh1u4MElEGT
 cg4TY6KAWzJo2E7mNkrEkivBI/JDzPyiV9ClcAGL/iX9WygwGKuepG+cLDY9x0UxeqhMhZIMX
 cqgMmJfYzG0SWzLVk1XZMmUzx+iaF+ToNxaPcvc2oQY9PabHDYWzdoPUCq96SFk5yA8ebJh9i
 3DCAEp6a54NoEuxFF2QqrQ1GaXM2vZa0e+/ftsqRKSBSrCnX4ztFEgDy2WV6h7S3C2di+K8Ub
 kItfgYcAgKd27FISGWAXUnTSsviyySHWr0KdsqtPSRx2dMRKXM+l1ovVncwbJ+L+QcSQh7SJR
 ljJWYNGpL3d7h/SP1LDPkeSIOmz1X/VXkVsU8+ImlQJpLSGmOoBPK/FfRwTt5axEcqK78CyuD
 LBiVbYs07WPiO/Y2mGW3QZJBJFaFud9Fkws3sBExGFF7lCA5R+jQ9MspuEljP5EO/Ry2dWCq1
 5GlTrie3HqlSQ13MFuWNTam4KKo/nAg2bQce+SHnbfZeCLoi9naezdnPO2uX++xhkI+0Tj9+P
 0RkMEUdlQVr6f52Q/1JBVsOZoLLhrD9Pa1HqqKqke4i/Uop/cwM6PUYqV5tGmi/PQyD3FrRkS
 SFx8Lg0b5x+CvzOv8j7YVCr0bGSno2qD5R96Z1fucbjcniO8yO1MzFFLo5lm1jbUqnM+a9nBU
 uXC9I0NJ2HxjEls0edDbeS7j2cB3NhDnRI5FStERm1jROsT8n2zS+0XkVuXxyPzfYoLJXQz8H
 gHdqg9m8DdP3LY+IP+UIO7ASoBjIbDSvuROhlJUMsHkbcavGNquuDc4HU+0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 3/3] docs/devel/testing: Fix typo in dockerfile
 path
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
Cc: Li Qiang <liq3ea@gmail.com>, Amit Shah <amit@kernel.org>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liam Merwick <liam.merwick@oracle.com>

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/devel/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index da2d0fc9646f..3ef50a61db4d 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -327,7 +327,7 @@ Images
 ------
 
 Along with many other images, the ``min-glib`` image is defined in a Dockerfile
-in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make docker``
+in ``tests/docker/dockerfiles/``, called ``min-glib.docker``. ``make docker``
 command will list all the available images.
 
 To add a new image, simply create a new ``.docker`` file under the
-- 
2.21.0


