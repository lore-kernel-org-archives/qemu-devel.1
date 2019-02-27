Received: from eggs.gnu.org ([209.51.188.92]:44038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0aX-0001bn-MD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0aW-0004Rm-Sn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:53:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gz0aW-0004Mw-LU
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:53:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91BD730BADBA
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 14:53:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 14:53:23 +0000
Message-Id: <20190227145324.26188-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] migration: support for authorization
 control on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series provides the migration part of the authorization control seri=
es
previously posted as:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.html

The core authz framework is now merged & this patch has had
positive review. Thus this migration part is ready to go into the
migration maintainer's tree, should the maintainer consider them
acceptable.

Daniel P. Berrang=C3=A9 (1):
  migration: add support for a "tls-authz" migration parameter

 hmp.c                 |  9 +++++++++
 migration/migration.c |  8 ++++++++
 migration/tls.c       |  2 +-
 qapi/migration.json   | 14 +++++++++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

--=20
2.20.1
