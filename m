Received: from eggs.gnu.org ([209.51.188.92]:56155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyzgW-0007Mh-8z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyzgU-0005Gz-Su
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:55:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyzgU-0005G1-LU
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9D182DB72B
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:55:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 13:55:22 +0000
Message-Id: <20190227135523.16952-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] chardev: support for authorization control
 on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series provides the chardev part of the authorization control series
previously posted as:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.html

The core authz framework is now merged & this patch has previously
had positive review, but I removed the r-b due to need for changes
to resolve merge conflicts with current chardev code. I expect this
is none the less ready for the chardev tree, should the maintainer
consider it acceptable.

Daniel P. Berrang=C3=A9 (1):
  chardev: add support for authorization for TLS clients

 chardev/char-socket.c | 12 +++++++++++-
 chardev/char.c        |  3 +++
 qapi/char.json        |  6 ++++++
 qemu-options.hx       |  9 +++++++--
 4 files changed, 27 insertions(+), 3 deletions(-)

--=20
2.20.1
