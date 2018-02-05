Received: from eggs.gnu.org ([2001:4830:134:3::10]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHV-00048B-29
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHQ-0008Co-12
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eifHP-0008CV-RB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5382A81DE4
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 11:49:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 11:49:34 +0000
Message-Id: <20180205114938.15784-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Misc VNC fixes / sanity checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

A few VNC changes suggested by Laszlo when reviewing my recent VNC patche=
s

Daniel P. Berrang=C3=A9 (4):
  ui: avoid risk of 32-bit int overflow in VNC buffer check
  ui: avoid 'local_err' variable shadowing in VNC SASL auth
  ui: check VNC audio frequency limit at time of reading from client
  ui: extend VNC trottling tracing to SASL codepaths

 ui/vnc-auth-sasl.c | 13 +++++++++++--
 ui/vnc.c           | 26 +++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

--=20
2.14.3
