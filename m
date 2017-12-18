Received: from eggs.gnu.org ([2001:4830:134:3::10]:44184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFG-0002YS-7s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFC-0004Yb-RV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQzFC-0004X4-Jp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91D40C04577E
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FF0C80950
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:13 +0100
Message-Id: <20171218173023.21417-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] Command line patches for 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe2=
59:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-1=
2-15-1' into staging (2017-12-17 15:27:41 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-cmdline-2017-12-18

for you to fetch changes up to aa088732820dc26f8881fb7c82bfd75724d18594:

  option: Drop unused get_param_value(), get_next_param_value() (2017-12-=
18 18:16:28 +0100)

----------------------------------------------------------------
Command line patches for 2017-12-18

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      option: Remove shadowing opt decl from qemu_opt_print()

Markus Armbruster (9):
      qemu-options: Remove stray colons from output of --help
      qemu-options: Fix markup of -netdev l2tpv3
      qemu-options qemu-doc: Move "Device URL Syntax" to qemu-doc
      qemu-options: Move -iscsi under "Block device options"
      qemu-options: Add missing -iscsi Texinfo documentation
      qemu-options: Polish section "TPM device options"
      qemu-options: Polish section "Character device options"
      qemu-options: Belatedly document --watchdog-action inject-nmi
      option: Drop unused get_param_value(), get_next_param_value()

 include/qemu/option.h  |   5 -
 qemu-doc.texi          | 217 +++++++++++++++++++++++++++++++++++
 qemu-options-wrapper.h |   2 +-
 qemu-options.hx        | 306 ++++++++-----------------------------------=
------
 scripts/hxtool         |   3 +-
 util/qemu-option.c     |  36 +-----
 6 files changed, 268 insertions(+), 301 deletions(-)

--=20
2.13.6
