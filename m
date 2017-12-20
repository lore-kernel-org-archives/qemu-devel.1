Received: from eggs.gnu.org ([2001:4830:134:3::10]:38522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1eRen3-0001po-EC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1eRemy-0005aX-72
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:52:09 -0500
Received: from xspc0103.northgrum.com ([157.127.149.150]:58630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Wu@ngc.com>) id 1eRemx-0005UZ-QP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:52:04 -0500
From: "Wu, Michael Y [US] (MS)" <Michael.Wu@ngc.com>
Date: Wed, 20 Dec 2017 13:51:49 +0000
Message-ID: <11b2dc716bf343cc9e93cc46693ab93f@XCGC3021.northgrum.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Generating external interrupt on PPC bare metal code
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

I am attempting to generate an external interrupt from bare metal code I've=
 written. The system I am emulating is something I've developed on my own f=
or experimentation. The system has a very simple interrupt controller that =
I've written which would call qemu_set_irq() when a certain memory address =
is written into. The program running on the system simply writes into that =
memory address to set off the interrupt.

The program running performs as expected and qemu_set_irq() is called. I tu=
rned on the interrupt log messages to see what I was getting:
ppc6xx_set_irq: env 0x7f93319cc290 pin 5 level 1
ppc6xx_set_irq: set the external IRQ state to 1
ppc_set_irq: 0x7f93319cc290 n_IRQ 3 level 1 =3D> pending 00000008req 000000=
02

It seems like the internal QEMU interrupt handler is being called but the i=
nterrupt is not jumping to the desired external interrupt address. I am cur=
rently using GDB to determine if the interrupt is set off or not. I've also=
 made sure that my bare metal program enables external interrupt bit in the=
 machine state register. Any suggestions or advice would be great.

Thanks!
