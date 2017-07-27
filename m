Received: from eggs.gnu.org ([2001:4830:134:3::10]:49001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dahq2-00070f-Kt
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dahpz-000063-I7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:24:22 -0400
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-2-crosa@redhat.com>
	<CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
Date: Thu, 27 Jul 2017 07:24:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W8TFJp0V4wfWb40vtj4a1n2MMMKuMDquC"
Subject: Re: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single
 quotes on config.log header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W8TFJp0V4wfWb40vtj4a1n2MMMKuMDquC
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <e6978405-6492-1124-d6e4-4a6a5b124c48@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single
 quotes on config.log header
References: <20170727120210.6943-1-crosa@redhat.com>
 <20170727120210.6943-2-crosa@redhat.com>
 <CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
In-Reply-To: <CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 07:15 AM, Peter Maydell wrote:
> On 27 July 2017 at 13:02, Cleber Rosa <crosa@redhat.com> wrote:
>> The generation of the informational header on config.log contains two
>> pairs of single quotes, which seems unintentional, and looks like
>> this:
>>
>>   # QEMU configure log Thu Jul 26 08:17:15 EDT 2017
>>   # Configured with: './configure' '--target-list=3Dx86_64-softmmu'
>=20
> I think this is deliberate. The idea is that the string is a
> validly shell-quoted string that you can cut and paste
> into a shell prompt if you want to.

It IS deliberate.  If you want, you could improve the code to only emit
'' around arguments that require it rather than all arguments, but that
requires more shell code (it's easier to quote everywhere, even when it
looks strange because the quotes weren't necessary).

> ...and note in particular how the '--cc=3Dccache gcc' argument
> is printed.

Yes, that's a case where the quotes are necessary.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--W8TFJp0V4wfWb40vtj4a1n2MMMKuMDquC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll523AACgkQp6FrSiUn
Q2qYSAf/ZGJilzw3J3/3i5vjW/tyY0vUqFAg8VrkWk+Du+nn3nq17tm0dskDmzci
oh9rhWa+v9Kpzcv5nL+26Rw81HPCEK6OH76SLJSPWT7e4Zn85lHuaMTbP/DTRRyP
sJAXBkPkx+3X0USB2axi9wIqGIYCN88L/p4pHM0EAnfyDElf24LoYKx1MhRZPg35
gTVSNy4cx8zL4dFiPLrLpjOCFvQGLhF2d+eWm6OQ2q9lXpGG/TQPfBE68eEGU58m
/GXRdqQ6ICvElxOz3WBj39op/2lO3ofX+66FFu9FjkJrYZAbe51cUCynMTr+pSlW
jT3SXa1vHbVkrhXoAwMbpcC6+J7PWw==
=RJRX
-----END PGP SIGNATURE-----

--W8TFJp0V4wfWb40vtj4a1n2MMMKuMDquC--
