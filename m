Received: from eggs.gnu.org ([2001:4830:134:3::10]:33094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq8-00017H-Tw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq4-00078J-2t
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daIq3-00077p-Rv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 11:42:33 +0200
Message-Id: <20170726094235.14267-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [seabios PATCH for qemu 2.10 0/2] seabios: build ACPI
 1.0-compatible ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: Kevin O'Connor <kevin@koconnor.net>, qemu-devel@nongnu.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, mst@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

Old operating systems would like to have a rev1 (ACPI 1.0) FADT, but
new operating systems would like to have rev3 (ACPI 2.0).
Since old operating systems do not know about XSDTs, the
solution is to point the RSDT to a v1 FADT and the XSDT to a
rev3 FADT.


Paolo Bonzini (2):
  seabios: build RSDT from XSDT
  seabios: create rev1 FADT in compatibility RSDT

 src/fw/paravirt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/std/acpi.h    | 11 +++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.13.3
