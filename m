Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8J-00055n-4H
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDD8F-0007bn-5M
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDD8F-0007be-0W
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:02:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Apr 2018 20:02:22 +0200
Message-Id: <1525111345-14606-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] net: Get rid of 'vlan'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

The 'vlan' term caused a lot of confusion and misconfigurations in the
past. The parameter has been marked as deprecated since QEMU v2.9.0, so
it's now time to finally remove the parameter and use the better word "hub"
in the remaining spots that actually mean the QEMU emulated hub feature.

v4:
 - Some rewordings in qemu-doc.texi and qemu-options.hx according to
   Stefan's and Paolo's suggestions

v3:
 - Some rewordings in qemu-doc and net.json according to Paolo's suggestions

v2:
 - Added first patch to actually remove the deprecated 'vlan' parameter
   (instead of only updating the wording in the sources and docs)

Thomas Huth (3):
  net: Remove the deprecated "vlan" parameter
  net: Get rid of 'vlan' terminology and use 'hub' instead in the source
    files
  net: Get rid of 'vlan' terminology and use 'hub' instead in the doc
    files

 docs/qdev-device-use.txt         |  3 --
 hw/core/qdev-properties-system.c | 80 ----------------------------------------
 include/hw/qdev-properties.h     |  3 --
 include/net/net.h                |  1 -
 net/hub.c                        |  7 ++--
 net/net.c                        | 12 ++----
 net/slirp.c                      |  8 ++--
 net/tap.c                        |  4 +-
 qapi/net.json                    | 15 ++++----
 qemu-doc.texi                    | 51 ++++++++++++-------------
 qemu-options.hx                  | 29 ++++++---------
 11 files changed, 54 insertions(+), 159 deletions(-)

-- 
1.8.3.1
