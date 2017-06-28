Received: from eggs.gnu.org ([2001:4830:134:3::10]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQFFX-0007Bk-DY
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQFFW-0007pU-M9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:51:27 -0400
Date: Wed, 28 Jun 2017 18:50:43 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628155043.ig363hyuzta2jxoz@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170628144012.GH5378@noname.redhat.com>
	<20170628152209.hf6iqosa24b3nocc@postretch>
	<20170628153654.GI5378@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyv3z7pjvs32q3pl"
Content-Disposition: inline
In-Reply-To: <20170628153654.GI5378@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/8] block: add throttle block
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--lyv3z7pjvs32q3pl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 05:36:54PM +0200, Kevin Wolf wrote:
>Am 28.06.2017 um 17:22 hat Manos Pitsidianakis geschrieben:
>> Since we're moving groups to QOM we will need ids for each group.
>> Can objects be anonymous?
>
>Hm, that's a good question. But object_new() doesn't take an ID, so I
>think they can be anonymous.
>
>Looking a bit closer, strcut Object doesn't even have a field for the
>ID. It seems that what the ID really is is the name of a property in a
>parent object that points to the new object. So as long as you don't
>want to have another QOM object point to it, there is no such thing as
>an ID.
>
>Anyway, I followed the call chain from throttle_group_register_tgm() and
>it ends in throttle_group_incref() where we simply have this:
>
>    tg =3D g_new0(ThrottleGroup, 1);
>    tg->name =3D g_strdup(name);
>
>Shouldn't this be using something a little more QOMy now?

Yes, like it was mentioned in the QOM patch's thread=20
block/throttle-groups.c should use QOM internally. I will change this=20
for the next revision and also look into anonymity.

--lyv3z7pjvs32q3pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllT0FMACgkQc2J8L2kN
9xAQvBAAl1Lp99bchAX2IVPy1xU3abZ7tq17+KTT/vcppdXMy8lcmrbJpgLPK42w
ctXJcCKxxccWkp+kZU2DbkSdmvc3AiZV73eDdlpe2LNpuAiXc751LlNK56i33OOI
EExtWbVwVkobMIjY4uXLCUMaBPHy4t6eA4pMZnZCW8+8Fx10xpDNc09t65R0/AMy
rhLLyoTH1XwLrzTpUj60W11C54xkTA5xHS6spXbI7AIFnDcIyyTFmyCRu4/47myU
sJufkBIOLx56SpiALZXmOqvkQUFeNcTwQJUUJIY1OiRRTC4T2Y+d1T9933SZ9OMN
jis7r4blbcqYiUYmCNEbifK8rkzXo4X6g8LaMuWXv/ngE1ZM5Dv86LrgcmaVy1NZ
NS/2Q0sVp+2pz4q+UjiDrptdzoN6K6ABUzLG73n/fZ6N+8I3dS6Od1DtnrWpdciY
JlXmFfWp6z4gnxLCZeoGLaI7srUa9HtuuJJNR4mHyPxjYsFAjtcq+jZhhYV8/anm
pEnzHKgdMPkqpP8S9HemRzsA7olf0vDEzPeUqn5B04ZTiB9ODoDWAjqf3jBctRkx
RZlcmmDZ0l+/0EQOwUwewtUidoIaVBv01uT6ZRF+D52oo4zoSraq9o53/E+zeeT3
zth26dHqP0DJbyqqVKEb0VwPQOxdhKAz/9tDEr1JU5YIGm5H/Qs=
=Fe0N
-----END PGP SIGNATURE-----

--lyv3z7pjvs32q3pl--
