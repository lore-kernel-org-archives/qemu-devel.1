Received: from eggs.gnu.org ([209.51.188.92]:46158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1u0f-0004Qk-V5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1u0d-00084D-2V
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1u0c-00082c-HC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:31 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  7 Mar 2019 15:28:20 +0100
Message-Id: <20190307142822.8531-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] OpenBSD: Let QEMU 4.0 be usable from
 OpenBSD 6.0 and onwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since OpenBSD 6.0, the W^X protection is enforced by default.
TCG is incompatible with this protection, to be able to use the
QEMU binary, this protection has to be disabled.
The OpenBSD ports seens to have downstream patches to be able to
use QEMU, but these patches were never upstreamed.
This series allow to run QEMU when built from the mainstream sources.

I salvaged the minimum patches required to be able to run OpenBSD
from a previous series, which aimed at running the QEMU QTest suite
on OpenBSD. Sadly it seems there is not much interest in having this
OS covered by tests (except by Peter Maydell).

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07513.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06676.html

Philippe Mathieu-Daud=C3=A9 (2):
  oslib-posix: Ignore fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
  configure: Disable W^X on OpenBSD

 configure          | 11 +++++++++++
 util/oslib-posix.c | 12 ++++++++++++
 2 files changed, 23 insertions(+)

--=20
2.20.1
