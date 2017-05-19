Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBdaT-0001IB-VE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBdaP-0001kT-8P
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBdaP-0001kI-27
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 314F9C056782
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:48:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 10:48:29 +0200
Message-Id: <20170519084830.2674-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] ui: egl-headless requires dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Little single-patch pull request to fix a build issue.

please pull,
  Gerd

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-ui-20170519-1

for you to fetch changes up to 371ec54e9f8415cd74af45acdcf67b413f50cce5:

  ui: egl-headless requires dmabuf support (2017-05-19 10:46:00 +0200)

----------------------------------------------------------------
ui: egl-headless requires dmabuf support

----------------------------------------------------------------
Gerd Hoffmann (1):
      ui: egl-headless requires dmabuf support

 vl.c             | 4 ++--
 ui/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
