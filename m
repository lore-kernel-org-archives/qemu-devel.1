Received: from eggs.gnu.org ([2001:4830:134:3::10]:35812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbB-0001NE-Kz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZb8-0002Z0-RG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRZb8-0002Xz-L7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C343E806A4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 902DB190C4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 09:19:17 +0100
Message-Id: <20171220081927.8761-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/10] Command line patches for 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit af352675efb7e92a1f5f6461a042a12015ab3d=
12:

  Merge remote-tracking branch 'remotes/aurel/tags/pull-target-sh4-201712=
18' into staging (2017-12-19 19:11:11 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-cmdline-2017-12-18-v2

for you to fetch changes up to 3e05349de8bd6744d23a26beac9ed6fb2e286f80:

  option: Drop unused get_param_value(), get_next_param_value() (2017-12-=
20 09:11:50 +0100)

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
 qemu-doc.texi          | 216 ++++++++++++++++++++++++++++++++++
 qemu-options-wrapper.h |   2 +-
 qemu-options.hx        | 306 ++++++++-----------------------------------=
------
 scripts/hxtool         |   3 +-
 util/qemu-option.c     |  36 +-----
 6 files changed, 267 insertions(+), 301 deletions(-)

--=20
2.13.6
