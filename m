Received: from eggs.gnu.org ([209.51.188.92]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugg-0007jM-Ah
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugf-000364-I9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1ugf-00035e-B5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FCCD307E042
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 15:11:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 16:11:34 +0100
Message-Id: <20190307151141.6483-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Ui 20190307 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65=
e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20190307-pull-request

for you to fetch changes up to 9b3c34835094760732c65a829bf0c07512126496:

  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_remove=
 (2019-03-07 14:23:22 +0100)

----------------------------------------------------------------
curses: better wide char support.
vnc: acl update, stall fix.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (2):
  vnc: allow specifying a custom authorization object name
  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
    acl_remove

Gerd Hoffmann (1):
  vnc: fix update stalls

Samuel Thibault (4):
  Reduce curses escdelay from 1s to 25ms
  curses: support wide input
  iconv: detect and make curses depend on it
  curses: add option to specify VGA font encoding

 configure            |  45 ++++-
 ui/curses_keys.h     | 113 +++++++------
 monitor.c            |  23 +++
 ui/curses.c          | 394 ++++++++++++++++++++++++++++++++++++-------
 ui/vnc.c             |  64 ++++++-
 vl.c                 |   2 +-
 qapi/ui.json         |  14 ++
 qemu-deprecated.texi |  11 ++
 qemu-options.hx      |  40 +++--
 9 files changed, 574 insertions(+), 132 deletions(-)

--=20
2.18.1
