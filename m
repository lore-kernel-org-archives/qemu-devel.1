Received: from eggs.gnu.org ([2001:4830:134:3::10]:60120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1dft5A-0005jC-LN
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1dft57-000109-7l
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:25:24 -0400
Received: from xspc0103.northgrum.com ([157.127.149.150]:62660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Wu@ngc.com>) id 1dft56-0000zE-S5
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:25:21 -0400
From: "Wu, Michael Y [US] (MS)" <Michael.Wu@ngc.com>
Date: Thu, 10 Aug 2017 19:25:06 +0000
Message-ID: <0d9230a2767f4ef197fc1b2c0ab2b4a0@XCGC3021.northgrum.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] CPU Interrupt for a PPC
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

I am having an issue with getting a CPU external interrupt to occur from my=
 own device model. The custom device is a set of registers than can be read=
 and written to. The plan is whenever a particular register is written into=
, an external interrupt will occur.

I tried to use the function cpu_interrupt() inside the register write callb=
ack function but QEMU crashes when that occurs. The reason I tried it this =
way is because I found a post stating the success made with using the cpu_i=
nterrupt function (https://stackoverflow.com/questions/14869317/arm-interru=
pt-handling-in-qemu).
After that attempt I added an interrupt controller in my own hardware model=
. But right now I am unclear with how to cause my external device to kick o=
ff an interrupt. Is there a certain function I can call when the register i=
s written into that will cause an external interrupt?

Any suggestions or guidance would be appreciated. Thanks!
