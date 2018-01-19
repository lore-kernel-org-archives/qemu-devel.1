Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecY6E-0001cb-Pa
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecY6D-0003Ar-PC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecY6D-0003AZ-FI
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:57 -0500
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
	<CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6792063-8f5d-6be9-ed25-00de4e99000e@redhat.com>
Date: Fri, 19 Jan 2018 08:56:47 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gUpbDzkItOLu5qaSO5eqfglzuRj7IOSWe"
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gUpbDzkItOLu5qaSO5eqfglzuRj7IOSWe
From: Eric Blake <eblake@redhat.com>
To: Marc-Andre Lureau <mlureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c6792063-8f5d-6be9-ed25-00de4e99000e@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
 <595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
 <CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
 <CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
In-Reply-To: <CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 08:35 AM, Marc-Andre Lureau wrote:

>>>>   dump-guest-memory.py: fix python 2 support (2018-01-17 15:47:14 +0=
100)
>>>>
>>>
>>> The commit says it works with python 2.7, but we still require suppor=
t
>>> for python 2.6.  Is this pull request premature?
>>
>> So should I apply this, or not?
>=20
> I have not found how to translate a python 'buffer' to a bytes string
> in 2.6. For now, I think we should go with this patch, it's already an
> improvement..

Argument in favor of applying: dump-guest-memory.py is not run as part
of the build process, nor during 'make check'; rather, it is an add-on
script for developer convenience after installation.  If we apply the
patch, we break developers on machines using python 2.6, but fix things
for developers on machines with python 3 - and as time (and Fedora
rawhide) march on, the balance swings in favor of the latter.

I personally am not enough of a python expert to propose a fix that
works across all versions supported by configure, but it was Marc-Andre
reminding me on IRC that this is not a build script, so it can have
different standards than our build when it comes to portability.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gUpbDzkItOLu5qaSO5eqfglzuRj7IOSWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiBzAACgkQp6FrSiUn
Q2rDlwf/fBbIFQ2DnIuo4yZLMGNe5Q6RXs0QUW2jHOBq1yIIeRUOZCevMDtjAZYr
IYcuJV+iroR6Jkb5fLc6JtoIxLLI2f88BV3CcK7N0ylP6/TSfL9bLEAkDN0n4umL
RXlRHFDtiP8PIqh5wVR8WdH289z+prD7wzkssmuOxAv7Gpf3bk+VmvR8EPtC5BpM
+qGZgJJ8W7/SMPMDvIH0mQ+MVxXC3TLoMZGd7+FeTv8hQOenxbpy+Zfwpz8i1W06
PHKs480nYXyWGRmzw3t2t1H9eGEc/K41rdlZ8CfAIY8fc+GjPo1VWCS5TWmLPyzZ
dCtV8Lobkf77ysjmE5CUK+KYjx6k4A==
=q99/
-----END PGP SIGNATURE-----

--gUpbDzkItOLu5qaSO5eqfglzuRj7IOSWe--
