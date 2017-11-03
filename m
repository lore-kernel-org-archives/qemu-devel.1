Received: from eggs.gnu.org ([2001:4830:134:3::10]:43523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAXCQ-0002RS-JW
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAXCP-0003gE-S1
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAXCP-0003fx-Jt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:19:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AF217E421
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 08:19:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-41.ams2.redhat.com
	[10.36.116.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F78560BEC
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 08:19:32 +0000 (UTC)
Received: from localhost (localhost [IPv6:::1])
	by sirius.home.kraxel.org (Postfix) with ESMTP id 73B7E40BF3
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 09:19:31 +0100 (CET)
Message-ID: <1509697171.31823.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 09:19:31 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

see $subject

make: Entering directory `/home/kraxel/projects/qemu/build-win64'
mkdir -p dtc/libfdt
mkdir -p dtc/tests
make[1]: `/home/kraxel/projects/qemu/build-win64/capstone/capstone.lib'=20
is up to date.
=C2=A0 LINK=C2=A0=C2=A0=C2=A0=C2=A0qemu-ga.exe
=C2=A0 LINK=C2=A0=C2=A0=C2=A0=C2=A0qemu-img.exe
/home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
adding symbols: Archive has no index; run ranlib to add one
collect2: error: ld returned 1 exit status
=C2=A0 LINK=C2=A0=C2=A0=C2=A0=C2=A0qemu-io.exe
make: *** [qemu-img.exe] Error 1
make: *** Waiting for unfinished jobs....
/home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
adding symbols: Archive has no index; run ranlib to add one
collect2: error: ld returned 1 exit status
make: *** [qemu-io.exe] Error 1
make: Leaving directory `/home/kraxel/projects/qemu/build-win64'

cheers,
  Gerd
