Received: from eggs.gnu.org ([209.51.188.92]:37261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQeR-0008IV-UZ
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQbg-00074B-WE
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQbe-000729-RL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:55:20 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 18:55:02 +0200
Message-Id: <20190427165504.29846-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] hw/acpi: Improve build modularity
 (targeting MIPS/PPC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Samuel Ortiz <sameo@linux.intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series is not related to the previous one I just send:
hw/i386/acpi: Improve build modularity (isapc/q35/...)
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04678.html

While the first only concern X86 (changes within the architecture),
this one allow the core ACPI feature to be used by the MIPS and
PPC archs (specific series will follow).

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/acpi: Simplify the Makefile logic
  hw/acpi: Always build the acpi/core.o file

 hw/acpi/Makefile.objs | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--=20
2.20.1
