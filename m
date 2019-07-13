Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68472C31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3296D2064A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmL0b-000421-Da
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 12:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmL0K-0003Ns-Gm
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmL0J-0004sN-Co
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmL0J-0004qv-7U
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80C5859467;
 Sat, 13 Jul 2019 16:36:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-24.brq.redhat.com [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B86B5D9D6;
 Sat, 13 Jul 2019 16:36:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:35:55 +0200
Message-Id: <20190713163558.13204-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 13 Jul 2019 16:36:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] tests/docker: Debian & MXE fixes
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
Cc: Fam Zheng <fam@euphon.net>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few more patches to be able to MXE-build the NSIS installers,
however it is still failing due to:
https://bugs.launchpad.net/bugs/1836453

Based-on: 20190712111849.9006-1-alex.bennee@linaro.org
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03014.html

Philippe Mathieu-Daud=C3=A9 (3):
  tests/docker: Install Sphinx in the Debian images
  tests/docker: Install the NSIS tools in the MXE images
  tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE images

 tests/docker/dockerfiles/debian-sid.docker          | 1 +
 tests/docker/dockerfiles/debian-win32-cross.docker  | 6 ++++++
 tests/docker/dockerfiles/debian-win64-cross.docker  | 6 ++++++
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian10.docker            | 1 +
 tests/docker/dockerfiles/debian9-mxe.docker         | 1 +
 tests/docker/dockerfiles/debian9.docker             | 1 +
 7 files changed, 18 insertions(+), 1 deletion(-)

--=20
2.20.1


