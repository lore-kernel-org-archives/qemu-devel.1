Received: from eggs.gnu.org ([2001:4830:134:3::10]:57096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fV98e-0002SA-TP
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fV98b-0007Ur-OL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:25:08 -0400
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ec75487b-ea7c-32c2-4b9e-654d4bc1018e@redhat.com>
Date: Tue, 19 Jun 2018 07:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180618235557.GB25461@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="C93Lxq1ztHMhDhZ4bA7wxNDsdbAcFCOSL"
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C93Lxq1ztHMhDhZ4bA7wxNDsdbAcFCOSL
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-ppc@nongnu.org
Message-ID: <ec75487b-ea7c-32c2-4b9e-654d4bc1018e@redhat.com>
Subject: Re: [PATCH] ppc: Include vga cirrus card into the compiling process
References: <20180618215601.8974-1-mail@sebastianbauer.info>
 <20180618235557.GB25461@umbus.fritz.box>
In-Reply-To: <20180618235557.GB25461@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.06.2018 01:55, David Gibson wrote:
> On Mon, Jun 18, 2018 at 11:56:01PM +0200, Sebastian Bauer wrote:
>> Drivers for this card exists on PPC-based AmigaOS guests so it is usef=
ul to
>> allow users to emulate the graphics card for PPC machines.
>>
>> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>=20
> Have you checked the Cirrus VGA actually works on a ppc machine?

FWIW: It actually even works with SLOF on the pseries machine:

https://github.com/aik/SLOF/blob/master/board-qemu/slof/pci-device_1013_0=
0b8.fs#L252

 Thomas


--C93Lxq1ztHMhDhZ4bA7wxNDsdbAcFCOSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbKJOsAAoJEC7Z13T+cC21b6QP/2OmxIU6KgN64lvEibKo9398
JoxN7FnT+P7ObTAMBtN6/neqON7AklKmqpO4MdWYcvODMIaIMdg7vjO1cYyJejDR
qhiMr6lg+ZdA52yCN/EMPFv/AcqUZSSjVYHyTCJ4eAy/dL0FZlwmP8kFTl/ViORf
258O0L31uDbWu4R4rRsBD/oWCuWIjPuxOa6y5n8G5HMouG1sm3qhO1PXr4TynvjM
TsCTj49JJnLtNF+bcyhpQc/G8pG75fO1psMNbYshiu0WF+qkcl1JULjIdrskqMSs
pWdWvB558ZjR1y1+Q+5q2cN2AqEEz//D0LkOqjaSYE7voJxfjNSzC2eYVRx/f7FZ
Q+Bjei7NOypNBAm35YOP40NTtlFXRm2+pL355WqRzAAZOlR25i0Db87DE67g0Zdl
OgAXePgJWldV3o57CKi+TuoMYJBw3jhJcvOi1fcGMsC3WqQTelOMnJuDgBDrMR12
oNe+zAKwCeZn9eDvq53OVMZIi2wAX8a4QW8rx1XipJ9OmYUR7ZIoIjRxKsEZgN3i
ohl72XJzkA1FGQoMytr3NQnZQ0Xo/RAw7vWEx7mctwZB4cpBXqkn9vPPp6pnJqor
Qzx3zqH8gC/ROEv6aNKPrFvlt0ZiFJTXXbeFZXmAxQDfFoa1PV7yt/wCAApXW4QG
bd8gnL8ICxkuQLEK52dN
=VXtv
-----END PGP SIGNATURE-----

--C93Lxq1ztHMhDhZ4bA7wxNDsdbAcFCOSL--
