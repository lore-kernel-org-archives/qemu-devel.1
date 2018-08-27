Received: from eggs.gnu.org ([2001:4830:134:3::10]:51925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuO-0007zN-N6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuK-0001oB-KZ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuIuK-0001ny-F0
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:20 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 27 Aug 2018 16:54:08 +0200
Message-Id: <1535381652-19870-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Remove more deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, libvir-list@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

These options are deprecated since at least two releases, and nobody
complained. Time to remove them now.

(I'm sending these patches as a series since Paolo asked me to send a PUL=
L
request on my own for them ... but if one of the subsystems maintainers
prefers to take the patches through their own tree instead, just let me
know)

Thomas Huth (4):
  Remove the deprecated -balloon option
  Remove the deprecated -nodefconfig option
  Remove the deprecated options -startdate, -localtime and -rtc-td-hack
  net: Remove the deprecated -tftp, -bootp, -redir and -smb options

 docs/interop/live-block-operations.rst |   4 +-
 docs/virtio-balloon-stats.txt          |   6 +-
 include/net/net.h                      |   3 -
 include/net/slirp.h                    |   4 -
 net/slirp.c                            | 132 ++++++++-------------------=
------
 os-posix.c                             |   8 --
 qemu-deprecated.texi                   |  56 --------------
 qemu-options.hx                        |  36 +--------
 vl.c                                   | 132 ++++++---------------------=
------
 9 files changed, 58 insertions(+), 323 deletions(-)

--=20
1.8.3.1
