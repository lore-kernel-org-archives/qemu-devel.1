Received: from eggs.gnu.org ([209.51.188.92]:51182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0to-000050-Bm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tn-00047E-Cv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0tn-00046k-4K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1708C007325
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-144.ams2.redhat.com [10.36.116.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5827917CC8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:47 +0100
Message-Id: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/14] Various updates to the MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I recently noticed that we missed to include many updates to the
MAINTAINERS file that have been posted to the qemu-devel mailing
list within the last weeks. This patch series is now a collection
of these patches, with some tweaks to some of them according to
the discussions that have taken place after their initial version
has been posted.

Please have especially a look at the new patch 13 ('Allow "Odd Fixes"
with sole "L:" entries, too') to see whether that makes sense.

Jeff Cody (2):
  MAINTAINERS: Replace myself with John Snow for block jobs
  MAINTAINERS: Remove myself as block maintainer

Philippe Mathieu-Daud=C3=A9 (9):
  MAINTAINERS: Add missing entries for the sun4u machines
  MAINTAINERS: Add missing entries for the PC machines
  MAINTAINERS: Add missing entries for the QObject section
  MAINTAINERS: Add missing test entries to the Cryptography section
  MAINTAINERS: Add an entry for the Dino machine
  MAINTAINERS: Add maintainer to the POSIX subsystem
  MAINTAINERS: Orphanize the 'GDB stub' subsystem
  MAINTAINERS: Add maintainers to the Linux subsystem
  MAINTAINERS: Add maintainer to the TCG/i386 subsystem

Thomas Huth (3):
  MAINTAINERS: Add some missing entries for the sun4m machine
  MAINTAINERS: Clean up the RISC-V TCG backend section
  MAINTAINERS: Allow "Odd Fixes" with sole "L:" entries, too

 MAINTAINERS | 84 +++++++++++++++++++++++++++++++++++++------------------=
------
 1 file changed, 51 insertions(+), 33 deletions(-)

--=20
1.8.3.1
