Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399FBC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE132073F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE132073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbgcK-0000Zl-82
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 03:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbga7-000760-2S
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbga5-0004ib-U3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:25:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbga2-0004dt-Px; Fri, 14 Jun 2019 03:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B61043079B63;
 Fri, 14 Jun 2019 07:24:44 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3EE601AC;
 Fri, 14 Jun 2019 07:24:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 09:24:26 +0200
Message-Id: <20190614072432.820-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 07:24:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
 integration@gluster.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Apparently QEMU static linking is slowly bitroting. Obviously it
depends the libraries an user has installed, anyway it seems there
are not much testing done.

This series fixes few issues, enough to build QEMU on a Ubuntu
aarch64 host, but not yet on a x86_64 host:

    LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: cannot find -lgtk-3
  /usr/bin/ld: cannot find -latk-bridge-2.0
  /usr/bin/ld: cannot find -latspi
  /usr/bin/ld: cannot find -lsystemd
  /usr/bin/ld: cannot find -lgdk-3
  /usr/bin/ld: cannot find -lwayland-egl
  /usr/bin/ld: cannot find -lmirclient
  /usr/bin/ld: cannot find -lmircore
  /usr/bin/ld: cannot find -lmircookie
  /usr/bin/ld: cannot find -lepoxy
  /usr/bin/ld: cannot find -latk-1.0
  /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
  /usr/bin/ld: cannot find -lselinux
  /usr/bin/ld: cannot find -lgtk-3
  /usr/bin/ld: cannot find -latk-bridge-2.0
  /usr/bin/ld: cannot find -latspi
  /usr/bin/ld: cannot find -lsystemd
  /usr/bin/ld: cannot find -lgdk-3
  /usr/bin/ld: cannot find -lwayland-egl
  /usr/bin/ld: cannot find -lmirclient
  /usr/bin/ld: cannot find -lmircore
  /usr/bin/ld: cannot find -lmircookie
  /usr/bin/ld: cannot find -lepoxy
  /usr/bin/ld: cannot find -latk-1.0
  /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
  /usr/bin/ld: cannot find -lselinux
  /usr/bin/ld: attempted static link of dynamic object `/usr/lib/x86_64-l=
inux-gnu/libz.so'
  collect2: error: ld returned 1 exit status

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (6):
  configure: Only generate GLUSTERFS variables if glusterfs is usable
  configure: Link test before auto-enabling glusterfs libraries
  configure: Link test before auto-enabling the libusb library
  configure: Link test before auto-enabling the libusbredir library
  configure: Link test before auto-enabling the pulseaudio library
  .travis.yml: Test static linking

 .travis.yml |   5 +++
 configure   | 113 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 90 insertions(+), 28 deletions(-)

--=20
2.20.1


