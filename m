Received: from eggs.gnu.org ([2001:4830:134:3::10]:36541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCq-0001R8-VI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCp-0003BT-Rj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKCp-0003AS-LR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F608C0467D8
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 580F05D6A3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Jul 2017 18:09:33 +0200
Message-Id: <1499875776-12688-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-07-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit aa916e409c04cb614ec2fee8b6b33836bf5998=
bb:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-2017071=
1' into staging (2017-07-11 16:34:09 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-12

for you to fetch changes up to 086ee7a6200fa5ad795b12110b5b3d5a93dcac3e:

  scripts: use build_ prefix for string not piped through cgen() (2017-07=
-12 17:51:54 +0200)

----------------------------------------------------------------
QAPI patches for 2017-07-12

----------------------------------------------------------------
Eric Blake (2):
      qobject: Catch another straggler for use of qdict_put_str()
      qobject: Update coccinelle script to catch Q{INC, DEC}REF

Marc-Andr=C3=A9 Lureau (1):
      scripts: use build_ prefix for string not piped through cgen()

 monitor.c                        |  2 +-
 qemu-img.c                       |  2 +-
 scripts/coccinelle/qobject.cocci |  6 ++++++
 scripts/qapi-commands.py         |  8 ++++----
 scripts/qapi-event.py            | 12 ++++++------
 scripts/qapi.py                  |  2 +-
 6 files changed, 19 insertions(+), 13 deletions(-)

--=20
2.7.5
