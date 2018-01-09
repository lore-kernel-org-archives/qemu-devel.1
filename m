Received: from eggs.gnu.org ([2001:4830:134:3::10]:33371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0Fm-0003B5-2o
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0Fk-00072C-UC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:10 -0500
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
	<20180109062425.GA18346@lemon.usersys.redhat.com>
	<20180109095825.GB6063@localhost.localdomain>
	<CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c03b655-a0b5-d043-1c19-6050e1930633@redhat.com>
Date: Tue, 9 Jan 2018 14:11:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D8nKdY9nRFfrci6YGTlpo49OAsFmS2xqa"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ala Hino <ahino@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Nir Soffer <nirsof@gmail.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D8nKdY9nRFfrci6YGTlpo49OAsFmS2xqa
From: Eric Blake <eblake@redhat.com>
To: Ala Hino <ahino@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1c03b655-a0b5-d043-1c19-6050e1930633@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
References: <20180105065538.13375-1-famz@redhat.com>
 <20180108144136.GF8052@localhost.localdomain>
 <CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
 <20180108175729.GI8052@localhost.localdomain>
 <20180109062425.GA18346@lemon.usersys.redhat.com>
 <20180109095825.GB6063@localhost.localdomain>
 <CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
In-Reply-To: <CAPuOgO35suw3LN4H0PZoE3ap+xZvK3tERvCHSUfHDMKc7-5XfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2018 01:58 PM, Ala Hino wrote:

>>> I know this is debatable but I think the #1 purpose of image locking =
is
>> to
>>> prevent data corruption;
>>
>> Isn't potentially wrong output of 'qemu-img info' a form of data
>> corruption? Not data as in disk content, but metadata is data, too.
>>
>>> #2 IMO is to reduce confusion and misinformation.
>>> While inconsistent output of "qemu-img info" is misinformation, it no=
t
>> working
>>> as before is actually confusion. Though the current behavior is indee=
d
>> ideal,
>>> the proposed patch is a bit more pragmatical.
>>
>> To be clear: If we want to minimise confusing by change, we have to
>> disable locking by default, not only here but everywhere else. And
>> therefore make it completely useless.
>>
>> The whole point of locking is to change something in order to make
>> things safer. Yes, this may inconvenience users who want to do somethi=
ng
>> unsafe. Tough luck. The only other option is not making things safer.
>>
>=20
> Safer is better for sure.
> It is not about doing something unsafe, it is about breaking a released=

> version -
> RHV 4.1 is already out and when customers upgrade to RHEL 7.5, they wil=
l not
> be able to create snapshots.
> I see two options:
> 1. As mentioned by Fam, settle on warning for good

Which is a downgrade in qemu behavior, since we've already had releases
where it was an error (and if you have to worry about THOSE qemu
releases, then the warning doesn't buy you anything).

> 2. Conflict qemu with vdsm < 4.2

If I'm understanding this option correctly, you are proposing that the
distribution is set up so that you have to upgrade vdsm prior to being
able to upgrade to newer qemu that enables locking (so you can use old
vdsm, old qemu; new vdsm, old qemu; new vdsm, new qemu; but you get
rejected on attempts to use old vdsm, new qemu).  That's outside the
scope of qemu proper and falls instead into the distro's packaging
scheme, but sounds like a better alternative than trying to fix new qemu
to work around an issue that released qemu already has, all on behalf of
vdsm where old vdsm plays nice with old qemu, and where new vdsm already
knows how to play nice with both flavors of qemu.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D8nKdY9nRFfrci6YGTlpo49OAsFmS2xqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVIg8ACgkQp6FrSiUn
Q2pAUQgAqxuQniuvF/02AVBb2xFDktATa1ib2uvC4aojZJ4YIxjhtAOuhzta2nPx
6b2tqprNphakXOBfrps6Ml7ou3OY0Lv2QEUNwrpEcg3syXnVuk4WAKx5svsQDM7T
0Odb+DdF6ykPvydqQU2D9P7SnGHX801AJU9Y+Gd3+RnIaT3sXz0lDdYYqKdHH41r
KjFJ4h+7S3R5ovjckHMcrCd6f3snYbz3E+6V6ENwRWQzVSYsp73bgbrQUyWF4xAO
Fg97dWx6FXt8ETUlD7geTB7umHE+7YjTzkFJlI+Is5o525yqOZodlpWM7d7kzkRC
Tsk6X6TxIvDls03T/BZ9BLiAAVtHJQ==
=1zhV
-----END PGP SIGNATURE-----

--D8nKdY9nRFfrci6YGTlpo49OAsFmS2xqa--
