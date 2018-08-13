Received: from eggs.gnu.org ([2001:4830:134:3::10]:45747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHud-0003Xv-VG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHud-0004ee-DH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:49:56 -0400
Date: Mon, 13 Aug 2018 19:49:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180813184947.GB18429@stefanha-x1.localdomain>
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-7-stefanha@redhat.com>
	<25a63ca5-20ad-f8d9-0117-b46c31c0c6c5@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <25a63ca5-20ad-f8d9-0117-b46c31c0c6c5@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 6/6] Add QTest testcase for
 the Intel Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, ilg@livius.net, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, jusual@mail.ru


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 01:26:08AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 08/03/2018 11:47 AM, Stefan Hajnoczi wrote:
> Can you add a comment providing the .S asm source and how to
> build/generate this blob? (I think this is required to respect the GPLv2
> license in your header).

I have resolved this by using a memory test pattern instead of an actual
program.  The test case uses -qtest anyway, so no guest code is
executed.

Stefan

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbcdLLAAoJEJykq7OBq3PIu2UIAMWYI0EksP3QVfI1zRiz1t3k
cIBhI6vrbXvivDfzp5Yi0X5qHP/qMZsWcTkPqzm8+Oba2kVs60JsgbG11Le7TpBD
vjxjsOIPDPmK4gj8UfUsLyGItIAez/ZTAc1eti9LtaLaNuh12q2+2w9SurIxkyC6
/gVYFT2RZPc5jsLjgBPvrmzLhX7zrALvEYYXBIBVLgpP57Z0jesROT7dLT8yOcGo
U+Z9hLmfy7LCD1xtLSBb9ROfmWl15N6cTBJfV75E5PUo2B4fk2rmqEZ6IAMSe5RN
idZeZjX1ASFoYCh6tTBez8wM0qBCmtyC4YKRj47nPy2nFHdV4h5dJVw7qehn4qs=
=Q+bo
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
