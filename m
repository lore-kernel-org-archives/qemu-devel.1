Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deZld-0004YX-9a
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deZlY-00081l-47
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:35:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:40346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1deZlX-00081I-Sa
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:35:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1deZlV-00039M-HJ
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 04:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 212062E80CE
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 04:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Aug 2017 04:17:22 -0000
From: Launchpad Bug Tracker <796480@bugs.launchpad.net>
Reply-To: Bug 796480 <796480@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110613084112.31847.10137.malonedeb@gac.canonical.com>
Message-Id: <150207944288.26590.17289781821181933247.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 796480] Re: Addresses with 4GB differences are
 consider as one single address in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/796480

Title:
  Addresses with 4GB differences are consider as one single address in
  QEMU

Status in QEMU:
  Expired

Bug description:
  THIS IS THE ISSUE OF USER MODE EMULATION
  Information about guest and host
  **********************************
  guest: 64 bit x86 user mode binary
  host: 32 bit Linux OS
  uname -a :Linux KICS-HPCNL-32blue 2.6.33.3-85.fc13.i686.PAE #1 SMP
  architecture: intel64
  Bug Description
  ****************
  for memory reference instructions, suppose I have two addresses in guest =
address space(64 bit)
  0x220000000
  0x320000000
  as lower 32 bit part of both addresses are same, when particular instruct=
ions are translated into host code(32 bit)
  in both above cases the value is loaded from same memory and we get same =
value. where actual behaviour was to get two different values.
  here is the program which i used to test:
  #include <stdio.h>
  #include <stdlib.h>
  #include <limits.h>
  #define SIZE 4294967297 /* 4Gib*/

  int main() {
     char *array;
     unsigned int i;

     array =3D malloc(sizeof(char) * SIZE);
     if(array =3D=3D NULL)    {
        fprintf(stderr, "Could not allocate that much memory");
        return 1;    }
      array[0] =3D 'a';
     array[SIZE-1] =3D 'z';
     printf("array[SIZE-1] =3D %c array[0] =3D %c\n",array[SIZE-1], array[0=
]);
    return 0;
  }
  I have 8 gib RAM
  I compiled this program on 64 bit linux  and run this on 32 bit linux wit=
h qemu
  QEMU command line and output
  **********************************
  $x86_64-linux-user/qemu-x86_64 ~/ar_x86 =

  output: array[SIZE-1] =3D z,array[0] =3D z =

  Release information
  ********************
  x86_64 binary is tested with latest release : qemu-0.14.1
  and with current development tree as well( live code of QEMU using git)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/796480/+subscriptions
