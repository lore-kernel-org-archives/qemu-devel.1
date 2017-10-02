Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JX-0005hz-RJ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JO-0004iO-7K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1JO-0004hq-1Z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1644780469
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-91.ams2.redhat.com
	[10.36.116.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D97B86F984
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:02:59 +0200
Message-Id: <20171002140307.5292-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] qemu-options: Texinfo and --help fixes
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Markus Armbruster (8):
  qemu-options: Remove stray colons from output of --help
  qemu-options: Fix markup of -netdev l2tpv3
  qemu-options qemu-doc: Move "Device URL Syntax" to qemu-doc
  qemu-options: Move -iscsi under "Block device options"
  qemu-options: Add missing -iscsi Texinfo documentation
  qemu-options: Polish section "TPM device options"
  qemu-options: Polish section "Character device options"
  qemu-options: Belatedly document --watchdog-action inject-nmi

 qemu-doc.texi          | 217 +++++++++++++++++++++++++++++++++++
 qemu-options-wrapper.h |   2 +-
 qemu-options.hx        | 306 ++++++++-----------------------------------=
------
 scripts/hxtool         |   3 +-
 4 files changed, 267 insertions(+), 261 deletions(-)

--=20
2.13.6
