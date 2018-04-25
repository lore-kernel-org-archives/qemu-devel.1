Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPlH-00062P-FZ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPlD-00036b-7T
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPlD-00036B-1P
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:07:23 -0400
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124626.17182.89580.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42abf707-3c09-b0d1-d8a0-9e7793721a3b@redhat.com>
Date: Wed, 25 Apr 2018 14:07:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180425124626.17182.89580.stgit@pasha-VirtualBox>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1a7KlYOxpi3xpGBSnnrTVZ4deZLzlABbo"
Subject: Re: [Qemu-devel] [RFC PATCH 09/17] replay: introduce breakpoint at
 the specified step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1a7KlYOxpi3xpGBSnnrTVZ4deZLzlABbo
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org,
 dgilbert@redhat.com, rth@twiddle.net
Message-ID: <42abf707-3c09-b0d1-d8a0-9e7793721a3b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/17] replay: introduce breakpoint at
 the specified step
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
 <20180425124626.17182.89580.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124626.17182.89580.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> This patch introduces replay_break qmp and hmp commands.
> These commands allow stopping at the specified instruction.
> It may be useful for debugging when there are some known
> events that should be investigated.
> The commands have one argument - number of instructions
> executed since the start of the replay.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---

> +++ b/qapi/misc.json
> @@ -3485,3 +3485,20 @@
>  ##
>  { 'command': 'info_replay',
>    'returns': 'ReplayInfo' }
> +
> +##
> +# @replay_break:

This should be 'replay-break' (QMP commands should favor '-' over '_').

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1a7KlYOxpi3xpGBSnnrTVZ4deZLzlABbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0egACgkQp6FrSiUn
Q2qz9Af9F31mKzsTpYDJC9oRe7jYQTW4VtDwPdluqw7/lVkKuCNXpCs/4bH2ab0M
Q7wwNldVBFHBLUnoZ+AwyoNRWCQT55DJHNPtOUM61x8nFI3owxunnuT5d/77BG1D
rp+51ORhkZPueS9LfZlfDQE1pqCN7Nj+vVDJ/jVi//7WIsKk2YYBstHhlt7vHhsY
Mv3tCUmkrUOpoTjCdpFKVA5YIXJ9l6O0DjCwBQdOBz8Jxriu02tg3bwXpq32UzqY
twi/v/hDYgJ7hGJQ2fq9r8MHCFxVEhlRXFfgiY4jqNOtE2PoumrWUScOY9HL146s
n3atZSavmBCZG01IeYmxC5BvSBrwag==
=yNv2
-----END PGP SIGNATURE-----

--1a7KlYOxpi3xpGBSnnrTVZ4deZLzlABbo--
