Received: from eggs.gnu.org ([2001:4830:134:3::10]:38754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m1C-0005pw-UI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m1B-0003DK-UI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:31:54 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-8-vsementsov@virtuozzo.com>
	<f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41a1aa0d-16ae-5358-6982-bdd773d8ea95@redhat.com>
Date: Thu, 12 Oct 2017 17:31:44 -0500
MIME-Version: 1.0
In-Reply-To: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EUNe7Vm2TCMx9n0KrRtRFQGQRExOSicSM"
Subject: Re: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EUNe7Vm2TCMx9n0KrRtRFQGQRExOSicSM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <41a1aa0d-16ae-5358-6982-bdd773d8ea95@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-8-vsementsov@virtuozzo.com>
 <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
In-Reply-To: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 05:27 PM, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Send qiov via qio_channel_writev_all instead of calling nbd_write twic=
e
>> with a cork.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  nbd/server.c | 50 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 24 insertions(+), 26 deletions(-)
>>

Subject-line consistency: elsewhere you used nbd/server instead of
nbd-server. I'll make the obvious tweak.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EUNe7Vm2TCMx9n0KrRtRFQGQRExOSicSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf7VAACgkQp6FrSiUn
Q2ottgf7Bsglbl4PAZC/LUKORGThdSJzD/fNQKHaUO22eDZACX7bbv4imShgEc2v
ejZ/7BmHw30unrnRn8fOBYD8c3aG5KJh8VCEhzcyCB0GaKej/jVh91wAOLejukGs
zDM8Jsf4qdIQy8E6Kyz2jGSHNd8gOrcCWSjiP/V+wNNINLVVMpHHq6+zI2Hp2M5B
cWYhTsqcoPqako8czKea0m+ddnec8SnjB7WhGYdNGx7snS/HCupIopCB0X/D06g1
4H2UMQoWymXqdqd9dH5i4gUFu70Z2tOcwrGNsBdQlbigacZoOcn+/zt0eAx73jzb
DgRih7JGCuWpu6Mg0o1dexrQJ1opaA==
=xjMk
-----END PGP SIGNATURE-----

--EUNe7Vm2TCMx9n0KrRtRFQGQRExOSicSM--
