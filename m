Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1681C41514
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C948A233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C948A233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0nUs-0008BN-SC
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nRD-0006S7-Ft
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nRC-0005wo-4E
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i0nRA-0005tw-59
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B9873084212;
 Thu, 22 Aug 2019 13:47:33 +0000 (UTC)
Received: from localhost (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C72885B69A;
 Thu, 22 Aug 2019 13:47:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 17:47:19 +0400
Message-Id: <20190822134725.32479-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 13:47:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/6] Podman patches
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 810923480863c43ecb22ae1241562983854393=
39:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-08-22 13:13:35 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/podman-pull-request

for you to fetch changes up to a4eb74a66a0f34d53127e240c1eeae42073bc558:

  test: skip tests if socket_check_protocol_support() failed (2019-08-22 =
17:30:25 +0400)

----------------------------------------------------------------
tests/docker: add podman support

----------------------------------------------------------------

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
2.23.0


