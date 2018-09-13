Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0XUZ-00070N-I0
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 15:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0XUT-0004bW-Rn
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 15:41:27 -0400
From: Max Reitz <mreitz@redhat.com>
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
Message-ID: <81bba910-3e33-376d-f490-151fcccd4322@redhat.com>
Date: Thu, 13 Sep 2018 21:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <56133002-7a79-bf6a-8835-fba043638224@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RxZvUWGtvP522kv9v2AklVoMMc8Ed3Rbi"
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RxZvUWGtvP522kv9v2AklVoMMc8Ed3Rbi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, lampahome <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <81bba910-3e33-376d-f490-151fcccd4322@redhat.com>
Subject: Re: [Qemu-devel] Can I only commit from active image to corresponding
 range of its backing file by qemu cmd?
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
 <ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
 <f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
 <56133002-7a79-bf6a-8835-fba043638224@redhat.com>
In-Reply-To: <56133002-7a79-bf6a-8835-fba043638224@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 20:37, Max Reitz wrote:

[...]

> Or, we would have to use backing=3Dnull, but for some reason that doesn=
't
> work.  I'll have to investigate.

Turns out this was fixed in e59a0cf17b1b9932b65e6fc25d6856976f5e4831.

(Why does Fedora still have only qemu 2.11?)

> So rebase will need to do:
>=20
> $ qemu-img rebase -u -b '' img.003
>=20
> $ qemu-img convert -O qcow2 \
>     "json:{'driver':'raw','offset':0,'size':1048576,\
>            'file':{'driver':'qcow2',\
>                    'file':{'driver':'file','filename':'img.003'}}}" \
>     "json:{'driver':'null-co','size':2097152}" \
>     img.003.commit.000
>=20
> $ qemu-img convert -O qcow2 \
>     "json:{'driver':'null-co','size':1048576}" \
>     "json:{'driver':'raw','offset':1048576,'size':2097152,\
>            'file':{'driver':'qcow2',\
>                    'file':{'driver':'file','filename':'img.003'}}}" \
>     img.003.nocommit

So starting with 2.12, putting a "'backing':null" behind
"'driver':'qcow2," will work just as well as rebasing img.003.

Max


--RxZvUWGtvP522kv9v2AklVoMMc8Ed3Rbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluavVEACgkQ9AfbAGHV
z0BS0QgAlvef2mOTrreyyva0GJI5LHhJQBRFKwOl/xmeWM9ScRr+sHBSW0NswXAi
aVOhkC+Dchte1baWBUzPcraNUI+FwwZ/8+ozIVk6N13y6KtOQdGw9yHp3TY7Hfzh
LrFxLQbsy0OcjMQHuVkt8Qpw8T/2qPfuKzSO9H1TSS+E0i6BKuG/Z7Rq6uzhaCGV
i+SNYxJzju0boE7Cg+GBakz9AcNBudSFydUe87FBkOgzm5LfB1xtWC0986HaM1EI
fdm0ZUCZ03E9V4MFSEjOsaSwrfbTsRdng+arqFBaThHEtG0SGHc0T90ALE6ssSSp
BQnnCCuJtN4pj3X1hIJ5IJe8It8n/A==
=meu5
-----END PGP SIGNATURE-----

--RxZvUWGtvP522kv9v2AklVoMMc8Ed3Rbi--
