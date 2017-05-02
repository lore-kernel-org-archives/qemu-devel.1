Received: from eggs.gnu.org ([2001:4830:134:3::10]:58157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XwQ-0000LE-9r
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XwN-00018A-7U
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:34:10 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5XwN-00017q-0P
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:34:07 -0400
Received: by mail-wr0-x229.google.com with SMTP id l50so80458899wrc.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:34:06 -0700 (PDT)
Date: Tue, 2 May 2017 14:34:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502133403.GE22502@stefanha-x1.localdomain>
References: <CAKAYmMJC=pTKSrLQBaU_3m33gKNoeSTxqjGFAQXC6--ZOY9JPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <CAKAYmMJC=pTKSrLQBaU_3m33gKNoeSTxqjGFAQXC6--ZOY9JPQ@mail.gmail.com>
Subject: Re: [Qemu-devel] AccelClass initialization order question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: qemu-devel@nongnu.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 08:18:51PM -0700, Chuck Tuffli wrote:
> While debugging an issue, I ran across something in the initialization
> sequence of hardware accelerators. Being a noobie qemu developer, it's
> hard to tell if I simply don't understand how AccelClass works or if
> this is a bug.
>=20
> The init_machine function for hardware accelerators is passed a
> MachineState pointer via configure_accelerator(), but several elements
> of the structure (e.g. ram_size, maxram_size, etc.) are not
> initialized until well after this call. Should hardware accelerator
> modules not look at MachineState and instead grab the global versions
> of variables like ram_size? TIA.

Machine init isn't finished when configure_accelerator() is executed.
Perhaps existing accelerators just don't need these variables at
configure_accelerator() time.

What exactly are you trying to do?

Stefan

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCIrLAAoJEJykq7OBq3PItF0H/1+HHwOTPiK9Me9UuvvVh+TO
YmK0VNUZu409I7ZDjr1t4teWPySME4/F2+mHPJHOiV1zl7KF3X090qupvR97Tz+l
o3OYtZaib9SoTiVEBY6jKIuBMI9PkGfEpaqSa6eQcH2s+IH2z/boT0VsNX+OxQsJ
9hqSSl92AESKSfvv9j0NmyIkYeB2Hcl3Y6PZSDdO9EWa8qOGnDlt85Wv1ooEK+rO
wl8hwz9kfjZo9O4H203fyTFjtvRQ+Nr2Jo2Et1zOWj+isHyF/oq+JlcFWXqf97Y6
geWDb0kfBjb2lyiBRZH5u3PRO0hXhyoM0lxJC7CWzAho5yte6fjhfxoJYx3qXYg=
=/nT3
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
