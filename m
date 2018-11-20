Received: from eggs.gnu.org ([2001:4830:134:3::10]:52014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6Oz-0005M8-V7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6Ow-0002os-MX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gP6Ow-0002o8-EN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:14 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Nov 2018 11:49:07 -0200
Message-Id: <20181120134908.8439-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] [for -rc2] pc-*-3.1 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>

Hopefully in time for -rc2.

commit 9b4cf107 ("hyperv: only add SynIC in compatible configurations") b=
reaks
compatibility on pc-*-3.0, so this is required as a bug fix.

The following changes since commit 46cabfb41e9cb269affc14c8188f0c8745f8cd=
55:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2018-11-20 12:24:09 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-for-3.1-pull-request

for you to fetch changes up to 4a93722f9c279184e95b1e1ad775c01deec05065:

  hw/i386: add pc-i440fx-3.1 & pc-q35-3.1 (2018-11-20 11:42:32 -0200)

----------------------------------------------------------------
pc-*-3.1 machine-types

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  hw/i386: add pc-i440fx-3.1 & pc-q35-3.1

 hw/i386/pc_piix.c | 15 ++++++++++++---
 hw/i386/pc_q35.c  | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
