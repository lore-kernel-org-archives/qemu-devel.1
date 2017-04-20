Received: from eggs.gnu.org ([2001:4830:134:3::10]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d18pR-0004iK-TH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d18pO-0000kg-Li
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:56:45 -0400
Received: from smtp4.epfl.ch ([2001:620:618:1e0:1:80b2:e059:1]:48824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1d18pO-0000jh-CE
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:56:42 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Thu, 20 Apr 2017 09:29:54 +0000
Message-ID: <1492680594151.52017@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>,
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
In-Reply-To: <583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks for getting back to me so quickly.=0A=
=0A=
I can boot Sparc64  -- ONLY when using the qemu from package manager. suppo=
sedly version 2.5=0A=
=0A=
but when building it myself (as i have some additions) - im getting this ke=
rnel error:=0A=
=0A=
https://pastebin.com/9XjdrUat=0A=
=0A=
=0A=
I am compiling qemu by myself and am using the following cmd to run it:=0A=
=0A=
=0A=
/Downloads/qemu-2.9.0-rc4/sparc64-softmmu$ ./qemu-system-sparc64 -M sun4u -=
m 196 -kernel /home/nihosa/Downloads/kernel4.10.11.sparc64 -hda /home/nihos=
a/Downloads/debian-9.0-sparc64-NETINST-1.qcow2 -nographic -L pc-bios=0A=
=0A=
=0A=
If you have it running, could you please send me your kernel/image for test=
ing?=0A=
=0A=
Thanks a lot=0A=
Hoss=0A=
________________________________________=0A=
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=0A=
Sent: Thursday, April 20, 2017 9:26 AM=0A=
To: Ajallooiean Hossein; qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic=0A=
=0A=
On 20/04/17 06:25, Ajallooiean Hossein wrote:=0A=
=0A=
> Hi All=0A=
>=0A=
> Has anyone experienced any kernel panics with the Sparc64 in 2.9-rc4? I d=
ont seem to be able to run it right out of the box.=0A=
>=0A=
> Ill appreciate any kind of help=0A=
>=0A=
> Regards=0A=
> -H=0A=
=0A=
I have a range of test images that I boot on a regular basis for=0A=
qemu-system-sparc64 with success. Can you provide the full command line,=0A=
QEMU version, and the output of the panic?=0A=
=0A=
=0A=
ATB,=0A=
=0A=
Mark.=0A=
=0A=
