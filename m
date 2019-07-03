Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC4C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEFD2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEFD2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihCA-0003rA-QS
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hih8n-0000MR-Si
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hih8m-0007bJ-6H
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hih8l-0007aW-TW; Wed, 03 Jul 2019 11:25:48 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGygv-1hnySj3sYt-00E5F2; Wed, 03 Jul 2019 17:25:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:25:13 +0200
Message-Id: <20190703152513.29166-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703152513.29166-1-laurent@vivier.eu>
References: <20190703152513.29166-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CFwtnTstsssEAZxEab7dPL1/l04v+e+hSWnQdqzA7gsy6P8nMpC
 F3sq1A0e2hSp4A7W0+Qj/BUjeCkyfASVqo98aA1mpzHsvyavWuSuuq9nI+P5OzHbKeKh5QP
 qecSmGKsmUPfMcpYG1x70BWhoMU7N3qSjHVNUl/3pmmyBEmj37XtpWr/h3gP2JWIYGO0Mbd
 tH/3I9kkaC3wOj+RmrnOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vRnzmMuTWqQ=:0WC3lvtOnfNZJeWqWZrTlg
 ruPqzNnSf2KRgcwOiRf1sQscwNUanVtk76jj19RxskOPM+MMk/cE0IzIaOtqO52BDniTzx7IQ
 pFucYXZRne1r+hU6RH6zENEPD8WKBGqUNcX5mkrhYK/4n0drMqf5ZljadCLk4TTqeW5qAtYWT
 q2sZGw0EdsBQKEgFAPbuHzITCqfrVIxcWx4CaZZz3o9fCmVwn6IlimfEMufjVnqrV+jkG2O6v
 d7EU6A8uWpyt5WIL5CclL9knZDU5CpvoShAhIaBFMGBN7YQNA9GnTrP4S3R45Z7I17IMDCA5K
 XiqyIbAYAv6myJrZxJ79A6o2/+aQsDjKC1y213lVfbStvymTyjCljLaV4HNBcsb8zToyz5wKm
 e84lhGqa9/T39m1ktmDysdKX5hiHGEnMVfc83sSTvEBt1ouJ7jXsv2hoQDeoqelk667G+gqqX
 fwiH5CuosXCgU2IbthFjWLyX2B9L9TGb4SqAC6j9j45UZZLXB+7WeHbtTcgYnYkHiNUpVlO4+
 Fspf5piZfms6nI4e27Q/d+hXtazh3cKJjj/KhonvHn3wbnaEvfbamQpN7gN1Zv8QD0zsD7nj0
 9nvGGDLVNqig3uoVwvDeDqtvuVVJqmsF5itWDudLCmcOHsQwI4+5v9vrZN10i64RO8ELZLvZk
 coyKxPLGJ9576cMNRH6bpbm40hmMR397H8wBw8O7cJoamTflzfr4wNZBbQ1wPsBjOuq5RyTuq
 qbRLd0b9Yj4qnB7+ZxmvGEcNXQaZ9I6mqqTYSSMcThR6cDSlHIbhzrqFaIQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL v2 2/2] docs/devel/testing: Fix typo in
 dockerfile path
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


