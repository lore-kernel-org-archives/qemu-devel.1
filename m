Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD4C73C56
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A5F2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A5F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkw9X-0006IC-BR
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkw8E-0005Lu-DZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkw8D-0002Eh-4r
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:50:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkw8C-0002Ci-UB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:50:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDEF830860B4;
 Tue,  9 Jul 2019 19:43:42 +0000 (UTC)
Received: from localhost (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F7D85DD6D;
 Tue,  9 Jul 2019 19:43:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 23:43:25 +0400
Message-Id: <20190709194330.837-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 09 Jul 2019 19:43:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

podman allows to run containers in a similar fashion as docker, but
without daemon or root privileges. Thank you podman!

There is a weird issue with getaddrinfo(), that I reported upstream
https://github.com/containers/libpod/issues/3535. For now, it is
worked around with extra socket_check_protocol_support() checks.

thanks

v2:
- add socket_check_protocol_support() to test-char
- keep TAP harness happy when socket_check_protocol_support() fails
- removed bad AI_ADDRCONFIG patch
- rebased

Marc-Andr=C3=A9 Lureau (5):
  docker.py: add podman support
  tests/docker: add podman support
  tests: specify the address family when checking bind
  test-char: skip tcp tests if ipv4 check failed
  test: skip tests if socket_check_protocol_support() failed

 Makefile                       |  2 +-
 tests/Makefile.include         |  2 +-
 tests/docker/Makefile.include  | 17 +++++++++++---
 tests/docker/docker.py         | 43 ++++++++++++++++++++++++++++++----
 tests/socket-helpers.c         | 17 ++++++++++----
 tests/socket-helpers.h         | 11 ---------
 tests/test-char.c              | 19 +++++++++++----
 tests/test-io-channel-socket.c |  4 +++-
 tests/test-util-sockets.c      |  4 +++-
 9 files changed, 88 insertions(+), 31 deletions(-)

--=20
2.22.0.214.g8dca754b1e


