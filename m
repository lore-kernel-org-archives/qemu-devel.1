Received: from eggs.gnu.org ([2001:4830:134:3::10]:46672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joeyconnelly@u.boisestate.edu>) id 1cHMLj-0007Sd-0i
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 22:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joeyconnelly@u.boisestate.edu>) id 1cHMLf-0007If-S6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 22:04:51 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joeyconnelly@u.boisestate.edu>)
	id 1cHMLf-0007By-KS
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 22:04:47 -0500
Received: by mail-qt0-f169.google.com with SMTP id c47so44692746qtc.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:04:24 -0800 (PST)
MIME-Version: 1.0
From: Joey Connelly <joeyconnelly@u.boisestate.edu>
Date: Wed, 14 Dec 2016 20:03:03 -0700
Message-ID: <CAOgv841deahTvPZ3rNvuGUh7xjtvJBRLSWwmCmMU2Ei3MmTrKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Nesting QEMU Question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hey QEMU dev group,

I have a few questions related to nesting QEMU processes, but first here is
my system setup:



   - *HOST MACHINE:* GNU/Linux release 4.5.5 (KVM version follows), Distro
   Fedora 24, x86_64 arch, supports Intel VT-x, QEMU 2.6.2, libvirt 1.3.3


   - *GUEST ISO:* GNU/Linux release 2.6.13 (KVM version follows), Distro
   SliTaz 4.0, i686 32-bit arch, does not appear to support Intel VT-x, QEM=
U
   0.12.5, does not have libvirt


My question is primarily in response to this comment from your qemu-devel
threads:

"qemu-system-x86_64 does not support KVM on a 32-bit host", Daniel Berrange=
.

https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02186.html





*[QUESTION#1.]*

Since my guest OS is 32-bit, do I have to use qemu-system-i386 =E2=80=93ena=
ble-kvm
on my host so that the guest can create a QEMU process of its own
supporting KVM? Or are there additional qemu-system-i386 arguments I need
from my host: =E2=80=93cpu <???> -machine <???>





*[QUESTION#2.]*

Since my guest OS does not support Intel VT-x, can I force this with
qemu-system-i386 arguments? I=E2=80=99m not sure how exactly to do this.



Thanks,

-Joey
