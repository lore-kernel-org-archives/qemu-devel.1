Received: from eggs.gnu.org ([2001:4830:134:3::10]:41406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LLC-0006Li-Bf
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LL6-0006Zc-Q2
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:47:10 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3LL6-0006ZE-HP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:47:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id 80so18648937wrb.2
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 05:47:04 -0700 (PDT)
Date: Tue, 3 Apr 2018 13:47:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403124701.GD4467@stefanha-x1.localdomain>
References: <CAEZT4ROV4k_3qokwB_JmK5NcmWW5nBwN24i_8JjreU++WVoTOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <CAEZT4ROV4k_3qokwB_JmK5NcmWW5nBwN24i_8JjreU++WVoTOw@mail.gmail.com>
Subject: Re: [Qemu-devel] Regarding qemu console?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arun raj <krarun88@gmail.com>
Cc: qemu-devel@nongnu.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 25, 2018 at 06:46:50PM +0530, Arun raj wrote:
> I'm new to qemu.i'm using qemu 2.11 version in my laptop.In qemu system i
> have two serial port.If i type the any information on the minicom serial
> port, this message are redirected into QEMU console. How you are
> redirecting all message onto qemu console. Are you using any virtual
> console driver. Which file and whilch driver it does? Can anyone tell me
> how qemu redirecting messages from serial port?

Hi Arun,
I have a hard time understanding what exactly you are asking.

Please post the QEMU command-line you used so we can see how the guest
is configured.

If you are running minicom inside the guest, then the guest operating
system's serial device driver transfers the data to the hardware just
like on a real machine, except that QEMU traps hardware register
accesses and emulates a serial device instead of a real hardware device.

Stefan

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw3fFAAoJEJykq7OBq3PIAakH/3jngJv3Sc4zQ0Dz9LUaZ/gw
6NMIZO816w/1Izr6oyLpqNKgAChBLqsALbM47+6Q17IT11Ee4KiWFf29TjDEJgc3
ps5p0uIcihKG+++ePhhwpbQ81Mywy51dhTqvfH30k8jNaQbfp0V8tBu5PbHfueXe
AIJE02F0K6y5b8MRI7r2nH/oCiBUSn7/3kiB+JbxIBMIxWxiWCOImU7CCl/RZris
exoAh8wnToVQRre15iowTR5kNfeVlNqbI3CVgA4cP3Xs1MQKfwBPh5GSKhuIFuah
Qtc5IW7nx4ZFZLn+kySrWAxEMiL0adt/q86VXI+C4NkNew0sscwO6z/o+6wvZEY=
=WQfU
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
