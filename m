Received: from eggs.gnu.org ([209.51.188.92]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJx8f-0002hR-SG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJwym-00082T-K4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:17:13 -0400
Date: Fri, 26 Apr 2019 10:17:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190426091702.GA2071@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 1/4/19 4:16 PM, Peter Maydell wrote:
> > On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >>
> >> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
> >>
> >> The generic loader device (-device loader,file=3Dkernel.bin) can be us=
ed
> >> to load a kernel instead of the -kernel option.  Some boards have flash
> >> memory (pflash) that is set via the -pflash or -drive options.
> >>
> >> Allow starting QEMU without the -kernel option to accommodate these
> >> scenarios.
> >>
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Previous to this commit (v3.1), we have:
>=20
> $ qemu-system-aarch64 -M netduino2
> qemu-system-aarch64: Guest image must be specified (using -kernel)
>=20
> Now (v4.0) we get:
>=20
> $ qemu-system-aarch64 -M netduino2
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

A user-friendly error message is needed here.  The check for -kernel was
too specific and is not desirable for microbit where we use -device
loader.

Old boards probably want to continue using -kernel.  New boards like
microbit may use just -device loader.  Perhaps there is even a group
that wants both options.

A solution is to introduce explicit checks so that we can tell the user
the appropriate option for the machine type.  I can work on this if you
like, but probably won't be able to send a patch until Tuesday.

Stefan

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwsyOAAoJEJykq7OBq3PIxrQH/RvZOjp//Ku7wHbPSH6LRX1g
z7Fhi7/66tL7IDgjvybqRnwV+cH3hIU7bDyOPLK5ec/GHsDrqUlt0FPRXCQZksuo
AeazNW0YoqO+zI+M/JDZ6JXHMUSjnybtCDkC2ZbYpEKAJ0miSlrjIiKKjbKFPGc0
WHNsdPz5/KHvxPyD0lmI+7/MHE6B5YpanYr7V+2kDYW+/WhXT6AU99Ge3LxO4VNn
qC8FP0yRuC5FKHDlhaXw+GldH8sQvv+TUyqODXuBJZY4PF+3DFLhPI7tMizNBERs
yEgn6jGdtxXveA3RCbVkCfmUi9q9RjOY3n7ubxgCM/49EAztdzxNpT73OYr6od0=
=WxRV
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
