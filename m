Received: from eggs.gnu.org ([2001:4830:134:3::10]:59742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7xsq-0007HL-QG
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7xsl-0007aJ-Vr
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:45:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f7xsl-0007Zq-Qm
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:44:55 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Apr 2018 08:44:38 +0200
Message-Id: <1523861081-3600-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.13 0/3] net: Get rid of 'vlan'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The 'vlan' term caused a lot of confusion and misconfigurations in the
past. The parameter has been marked as deprecated since QEMU v2.9.0, so
it's now time to finally remove the parameter and use the better word "hub"
in the remaining spots that actually mean the QEMU emulated hub feature.

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
