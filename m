Received: from eggs.gnu.org ([209.51.188.92]:43345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvI-0004io-F6
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvH-0002U6-Ja
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNPvH-0002T0-DM
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:47:55 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:47:36 +0200
Message-Id: <20190505224737.1028-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] MAINTAINERS: Step in as maintainer for the
 parallel NOR flash devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michael Walle <michael@walle.cc>, Jordan Justen <jordan.l.justen@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Roy Franz <roy.franz@linaro.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, David Engraf <david.engraf@sysgo.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnoij@jcrosoft.com>, Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The parallel NOR flash models don't have a specific maintainer and
default to the 'Block layer core' section.
Step in to maintain them.
The section still get covered by the Block layer team, but the idea
is to offload them.

The two devices are very similar (same technology), the difference
is mostly the protocol to access them.

Amusingly, between the two devices, the 'CFI01' which is used in
enterprise grade products on ARM/X86 archs is the one that received
the less care, while the 'CFI02' used by hobbyist boards is the
more reliable.

To some extent I plan to re-unify the models, and improve testing.

I'm looking for co-maintainers or designated reviewers.
(I asked Stephen Checkoway for help but unfortunately he can't).

Any volunteer?

Regards,

Phil.

PD: I Cc'ed all the people who made sinificant modification in the
    devices the last few years.

Philippe Mathieu-Daud=C3=A9 (1):
  MAINTAINERS: Add an entry for the Parallel NOR Flash devices

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

--=20
2.20.1
