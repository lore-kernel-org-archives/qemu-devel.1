Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47213C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8F121907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8F121907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuH0-0000Bo-86
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuA5-0001vp-0e
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuA2-0005O6-RX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuA2-0005NN-MJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0BB2116D7D0;
 Thu, 19 Sep 2019 10:59:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-74.brq.redhat.com [10.40.204.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ABE960606;
 Thu, 19 Sep 2019 10:59:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 12:59:29 +0200
Message-Id: <20190919105932.19412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 10:59:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] testing: Build WHPX enabled binaries
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Justin Terry <juterry@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to cross-build QEMU with WHPX enabled.

Use the Win10SDK headers from the Android Project, as commented
in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.html

Based-on: <20190918121101.30690-1-philmd@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html

Philippe Mathieu-Daud=C3=A9 (2):
  tests/docker: Add fedora-win10sdk-cross image
  .shippable.yml: Build WHPX enabled binaries

 .shippable.yml                                |  2 ++
 tests/docker/Makefile.include                 |  1 +
 .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker

--=20
2.20.1


