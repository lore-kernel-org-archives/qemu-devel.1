Received: from eggs.gnu.org ([2001:4830:134:3::10]:58255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiG5O-0002Re-TD
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiG5L-0000az-Ss
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:27:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fiG5L-0000aE-Mp
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8F1A81A88C7
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 09:27:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 25 Jul 2018 10:27:49 +0100
Message-Id: <20180725092751.21767-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] vnc: remove deprecated TLS related features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>



Daniel P. Berrang=C3=A9 (2):
  doc: switch to modern syntax for VNC TLS setup
  vnc: remove support for deprecated tls, x509, x509verify options

 qemu-deprecated.texi | 20 ----------
 qemu-doc.texi        | 20 +++++++---
 qemu-options.hx      | 43 ---------------------
 ui/vnc.c             | 91 --------------------------------------------
 4 files changed, 15 insertions(+), 159 deletions(-)

--=20
2.17.1
