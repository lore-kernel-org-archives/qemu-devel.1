Received: from eggs.gnu.org ([2001:4830:134:3::10]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTlBm-0007fw-Kb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTlBh-0001X3-NB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:10:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTlBh-0001WP-ID
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:10:49 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 11:10:43 +0100
Message-Id: <20181203101045.27976-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 v3 0/2] usb-mtp: two bugfixes (one
 security fix).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: public@hansmi.ch, Gerd Hoffmann <kraxel@redhat.com>

v3:
 - add missing RES_ prefix to response code.
v2:
 - add comment about the (preexisting) issue noted by armbru.
 - change error code as suggested by bsd.
 - update reporter email address.

Gerd Hoffmann (2):
  usb-mtp: fix utf16_to_str
  usb-mtp: outlaw slashes in filenames

 hw/usb/dev-mtp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--=20
2.9.3
