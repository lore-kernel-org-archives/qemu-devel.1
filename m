Received: from eggs.gnu.org ([2001:4830:134:3::10]:47992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dxUB3-00007r-1F
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dxUB2-0004js-8u
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:28:13 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Thu, 28 Sep 2017 08:28:05 +0000
Message-ID: <AM5P194MB0132CA048F3B648CB0A47DCDC8790@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	, <1506512087.25036.10.camel@redhat.com> ,
	<AM5P194MB013209976BC625983F3265D3C8780@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<AM5P194MB0132260A40AD097E2F67A4B2C8790@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<1506586050.6902.0.camel@redhat.com>
In-Reply-To: <1506586050.6902.0.camel@redhat.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ppce500 usb-ehci-pci issue on last uboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>



Hi Gerd,


>How can this be reproduced?


you need to build last uboot with the ehci pci option enabled and the usb c=
ommand line enabled.

or just download my last e500 uboot build from here https://www.dropbox.com=
/s/xxlu6ivg3izlqvu/u-boot?dl=3D0


Run it as:

qemu-system-ppc64 -M ppce500 -cpu e5500 -m 512 -bios (path to the uboot ima=
ge) -device usb-ehci (or another qemulated ehci pci device)  -serial stdio

you can attach some device on it for your tests


when the machine  run and you have the uboot prompt just do "usb start" and=
 you will see the hang for some second of the machine and after the report =
from uboot of an error of the ehci.


Ciao
Luigi
