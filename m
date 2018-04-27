Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC3o9-0000so-Nt
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC3o6-0000QI-LP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:53:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC3o6-0000Q9-F0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:53:02 -0400
References: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b4880b5-d082-b791-b520-532d13beaf05@redhat.com>
Date: Fri, 27 Apr 2018 08:52:53 -0500
MIME-Version: 1.0
In-Reply-To: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jGxEIKXFYA25Bc7WfEdbc1NTO1G5ka5al"
Subject: Re: [Qemu-devel] POD document had syntax errors at /usr/bin/pod2man
 line 68.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rahul Gusai <rgusai97@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jGxEIKXFYA25Bc7WfEdbc1NTO1G5ka5al
From: Eric Blake <eblake@redhat.com>
To: Rahul Gusai <rgusai97@gmail.com>, qemu-devel@nongnu.org
Message-ID: <9b4880b5-d082-b791-b520-532d13beaf05@redhat.com>
Subject: Re: [Qemu-devel] POD document had syntax errors at /usr/bin/pod2man
 line 68.
References: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
In-Reply-To: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 03:47 AM, Rahul Gusai wrote:
> I am getting the following error while trying to compile the binaries f=
or
> QEMU emulator.
>

Your mailer corrupted line spacing, making it difficult to read.

> *GEN   qemu.1qemu.pod around line 95: Non-ASCII character seen before
> =3Dencoding in 'Sch=EF=BF=BDtz.'. Assuming UTF-8POD document had syntax=
 errors at
> /usr/bin/pod2man line 68.Makefile:297: recipe for target 'qemu.1'
> failedmake: *** [qemu.1] Error 255make: *** Deleting file 'qemu.1'*

qemu.pod is a generated file; the version in my build tree starts out:

=3Dencoding UTF-8

and then uses proper UTF-8 encoding of line 95:

by Tibor "TS" Sch=C3=BCtz.

> What could be the issue ?

What do the following output in your setup:

$ locale
$ grep =3Dencoding qemu.pod
$ sed -n '92,98p' qemu.pod | od -tx1z

I'm wondering if somehow you have a non-UTF-8 locale such that the
generated .pod file is encoded in a different locale, to the point that
pod2man then chokes on the file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jGxEIKXFYA25Bc7WfEdbc1NTO1G5ka5al
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjKzUACgkQp6FrSiUn
Q2oczAgApv2bMYlbO8GvSYcv+2EwhzHhB3rcJpcGAtcY3nXmuCMg4JxupuXr8/c8
yYmP4J+9Sij8Yavro/yQwzksJlsRckk0G6OSQLccBDI0biyAtitJ3doMebuTFHd0
rLt9k0HoeTZ1lIaZ0TnoAhIyKajucRK6rN/qd11Gvv3KndAxbwydPTy0VegGAfh/
5znv4JyBid0noAtxpInABQIrIgGOQEPfOoIKK9kZhmBJbGZp3//AGMr1r5XiP6QE
ducjNdfqZAsosfVdYcLX/EWi0xkkvsfKGNgKibnXkNOxw7DcXFfRhzEIPmfrJ8sx
ldm2Jm5KYF08GY0nN0fA9P+rI9RK2Q==
=N+Hc
-----END PGP SIGNATURE-----

--jGxEIKXFYA25Bc7WfEdbc1NTO1G5ka5al--
