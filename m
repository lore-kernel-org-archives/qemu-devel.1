Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F28C742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D329D20838
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJ5n-0007gc-Rk
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46441)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ5d-0007IE-C1
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ5b-0006TT-Ap
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hmJ5a-0006Oi-Mr
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B38630C318C;
 Sat, 13 Jul 2019 14:33:23 +0000 (UTC)
Received: from localhost (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 273625F724;
 Sat, 13 Jul 2019 14:33:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:33:05 +0400
Message-Id: <20190713143311.17620-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Sat, 13 Jul 2019 14:33:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/6] tests/docker: add podman support
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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

v3:
- add --run-as-current-user, suggest by Paolo
- move podman user tweaks to docker.py
- rebasing

v2:
- add socket_check_protocol_support() to test-char
- keep TAP harness happy when socket_check_protocol_support() fails
- removed bad AI_ADDRCONFIG patch
- rebased

Marc-Andr=C3=A9 Lureau (6):
  docker.py: add --run-as-current-user
  docker.py: add podman support
  tests/docker: add podman support
  tests: specify the address family when checking bind
  test-char: skip tcp tests if ipv4 check failed
  test: skip tests if socket_check_protocol_support() failed

 Makefile                       |  2 +-
 tests/Makefile.include         |  2 +-
 tests/docker/Makefile.include  | 10 +++++--
 tests/docker/docker.py         | 53 ++++++++++++++++++++++++++++++----
 tests/socket-helpers.c         | 17 ++++++++---
 tests/socket-helpers.h         | 11 -------
 tests/test-char.c              | 19 +++++++++---
 tests/test-io-channel-socket.c |  4 ++-
 tests/test-util-sockets.c      |  4 ++-
 9 files changed, 91 insertions(+), 31 deletions(-)

--=20
2.22.0.428.g6d5b264208


