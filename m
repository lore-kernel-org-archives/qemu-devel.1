Received: from eggs.gnu.org ([209.51.188.92]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GNT-0001v7-4k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GGT-00024s-A1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3GGR-00022L-EC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89AD93DE1C
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:26:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:26:14 +0100
Message-Id: <20190311082619.17966-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Ui 20190311 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit e2a18635a400b0e68679614132e9ef63161055=
90:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' i=
nto staging (2019-03-09 20:55:44 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20190311-v2-pull-request

for you to fetch changes up to 0143840771548e8ffece831398d745880ddfa080:

  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_remove=
 (2019-03-11 08:39:02 +0100)

----------------------------------------------------------------
curses: wide char input support.
vnc: acl update, stall fix.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (2):
  vnc: allow specifying a custom authorization object name
  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
    acl_remove

Gerd Hoffmann (1):
  vnc: fix update stalls

Samuel Thibault (2):
  Reduce curses escdelay from 1s to 25ms
  curses: support wide input

 ui/curses_keys.h     | 113 +++++++++++++++++++++++++------------------
 monitor.c            |  23 +++++++++
 ui/curses.c          |  79 ++++++++++++++++++++++++------
 ui/vnc.c             |  64 ++++++++++++++++++++----
 qemu-deprecated.texi |  11 +++++
 qemu-options.hx      |  35 ++++++++++----
 6 files changed, 243 insertions(+), 82 deletions(-)

--=20
2.18.1
