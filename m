Received: from eggs.gnu.org ([209.51.188.92]:42587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz0-0006HL-Kt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz0-0001N7-1l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1ryz-0001Mk-S8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:41 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  7 Mar 2019 12:18:36 +0000
Message-Id: <20190307121838.6345-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] docs: a few updates to spectre CPU flag
 recommendations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This corrects the note about spec-ctrl and adds info about the stibp
flag that was later added to QEMU/KVM.

Daniel P. Berrang=C3=A9 (2):
  docs: clarify that spec-ctrl is only needed for Spectre v2
  docs: add note about stibp CPU feature for spectre v2

 docs/qemu-cpu-models.texi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--=20
2.20.1
