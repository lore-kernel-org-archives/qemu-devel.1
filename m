Received: from eggs.gnu.org ([2001:4830:134:3::10]:60344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fu9Hn-0002oH-A3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fu9Dv-0008JW-1w
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:33:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:54624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fu9Du-0008Ih-RD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:33:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fu9Dr-0005nC-Ds
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:33:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D12B02E8442
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:33:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Aug 2018 04:17:54 -0000
From: Launchpad Bug Tracker <1129571@bugs.launchpad.net>
Reply-To: Bug 1129571 <1129571@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130218230633.21029.10708.malonedeb@wampee.canonical.com>
Message-Id: <153534347499.22848.16602564378591538711.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1129571] Re: libreoffice armhf FTBFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1129571

Title:
  libreoffice armhf FTBFS

Status in QEMU:
  Won't Fix
Status in qemu package in Ubuntu:
  Expired

Bug description:
  We have been experiencing FTBFS of LibreOffice 3.5.7, 12.04, armhf in
  the launchpad buildds. We believe this is likely due to an error in
  qemu.

  While we do not have a small test case yet, we do have a build log
  (attaching here).

  The relevant snippet from the build log is:

  3.5.7/solver/unxlngr.pro/bin/jaxp.jar:/build/buildd/libreoffice-3.5.7/sol=
ver/unxlngr.pro/bin/juh.jar:/build/buildd/libreoffice-3.5.7/solver/unxlngr.=
pro/bin/parser.jar:/build/buildd/libreoffice-3.5.7/solver/unxlngr.pro/bin/x=
t.jar:/build/buildd/libreoffice-3.5.7/solver/unxlngr.pro/bin/unoil.jar:/bui=
ld/buildd/libreoffice-3.5.7/solver/unxlngr.pro/bin/ridl.jar:/build/buildd/l=
ibreoffice-3.5.7/solver/unxlngr.pro/bin/jurt.jar:/build/buildd/libreoffice-=
3.5.7/solver/unxlngr.pro/bin/xmlsearch.jar:/build/buildd/libreoffice-3.5.7/=
solver/unxlngr.pro/bin/LuceneHelpWrapper.jar:/build/buildd/libreoffice-3.5.=
7/solver/unxlngr.pro/bin/HelpIndexerTool.jar:/build/buildd/libreoffice-3.5.=
7/solver/unxlngr.pro/bin/lucene-core-2.3.jar:/build/buildd/libreoffice-3.5.=
7/solver/unxlngr.pro/bin/lucene-analyzers-2.3.jar" com.sun.star.help.HelpIn=
dexerTool -lang cs -mod swriter -zipdir ../../unxlngr.pro/misc/ziptmpswrite=
r_cs -o ../../unxlngr.pro/bin/swriter_cs.zip.unxlngr.pro
  dmake:  Error code 132, while making '../../unxlngr.pro/bin/swriter_cs.zi=
p'

  We believe this is from bash error code 128 + 4, where 4 is illegal
  instruction, thus leading us to suspect qemu.

  Any help in tracking this down would be appreciated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1129571/+subscriptions
