Received: from eggs.gnu.org ([2001:4830:134:3::10]:34906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dUUn7-0002l2-2f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dUUn3-0005Kl-Sy
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:15:41 -0400
Received: from ikerlan-12.ikerlan.es ([193.145.247.1]:20647)
	by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dUUn3-0005Ir-Fe
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:15:37 -0400
From: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Date: Mon, 10 Jul 2017 09:14:58 +0000
Message-ID: <B1DA44315104F94D9F3F23C74275EA9D729B34@Ikerlan-12.ikerlan.es>
Content-Language: es-ES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Code source modifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello!

I need  to modify the source code of QEMU to apply a little change. My fina=
l idea is to prove the utility of a virtual platform as a way of reusing so=
ftware designed for an obsolete hardware. For that I've created a "real tim=
er", connected to my board. Now... the problem:

My standalone program writes "0xffffffff" in the position 0x95000000 when t=
he timer should start, and "0x00000000" when it have to finish. I want to m=
odify the code so every single (standalone) program step reads the virtual =
0x95000000 and changes the value of a gpio. But I can't find how I can read=
 from the source code the virtual memory, and I can't find neither where/ho=
w does the program process (step by step) the standalone program.

I don't know if I have explained well my doubts...

Thankyou in advance!

Xabi
