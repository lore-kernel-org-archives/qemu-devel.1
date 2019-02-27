Received: from eggs.gnu.org ([209.51.188.92]:45012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0ez-0005Sj-Id
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0ex-0006yP-HC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gz0ex-0006y1-Af
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49EB27F413
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 14:58:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 14:57:53 +0000
Message-Id: <20190227145755.26556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] ui: support for authorization control on
 TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series provides the VNC parts of the authorization control series
previously posted as:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.html

The core authz framework is now merged & these patches have all had
positive review. Thus these VNC parts are ready to go into the VNC
maintainer's tree, should the maintainer consider them acceptable.

Note the 2nd patch is modifying the HMP, but I considered it part
of ui/vnc, since that's the only bit of QEMU which ever used these
HMP commands, and it has a dependancy on the first patch merging
first.

Daniel P. Berrang=C3=A9 (2):
  vnc: allow specifying a custom authorization object name
  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
    acl_remove

 monitor.c            | 23 ++++++++++++++++++
 qemu-deprecated.texi | 11 +++++++++
 qemu-options.hx      | 35 ++++++++++++++++++--------
 ui/vnc.c             | 58 +++++++++++++++++++++++++++++++++++++-------
 4 files changed, 108 insertions(+), 19 deletions(-)

--=20
2.20.1
