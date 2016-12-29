Received: from eggs.gnu.org ([2001:4830:134:3::10]:53711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cMXZW-0000HV-4r
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cMXZT-00077D-2g
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:04:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cMXZS-000772-Td
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:04:27 -0500
Date: Thu, 29 Dec 2016 11:04:20 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161229100420.i66zeaxc4qbp3p3p@hawk.localdomain>
References: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1653063] [NEW] qemu-system-arm hangs with
 -icount and -nodefaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hansni Bu <1653063@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Thu, Dec 29, 2016 at 08:02:16AM -0000, Hansni Bu wrote:
> Public bug reported:
...
> https://bugs.launchpad.net/bugs/1653063
...
>   After console prints the message below:
>   "Uncompressing Linux.................................................=
......................... done, booting the kernel."
>   there's no further action noticed.
>=20
>   If "-icount" is not set, namely run as:
>   qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -i=
nitrd arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Do=
n,id=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"
>=20
>   or if "-nodefaults" is not set, namely run as:
>   qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -i=
nitrd arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyA=
MA0"
>=20
>   The Linux boot procedure can finish successfully.

Hi Hansni,

The fact things work when you remove -nodefaults is a sign that with it
your single cpu may just not be getting scheduled again. Does the patch
from Alex Benn=E9e here[*] help?

drew

[*] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01743.html
