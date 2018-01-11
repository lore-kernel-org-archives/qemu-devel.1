Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZisS-0003Ne-SH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZisP-0006NI-0u
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:51:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZisO-0006Mh-O7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:51:00 -0500
References: <20171208173321.GR2403@work-vm>
	<20180109192802.17167-1-eblake@redhat.com>
	<20180111175934.GB13384@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b198a35a-b69e-37f9-8024-bc98b2e80e3c@redhat.com>
Date: Thu, 11 Jan 2018 13:50:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180111175934.GB13384@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="saTPwvPqM5V3y7s9dwGO1UIKWJoFcU7d7"
Subject: Re: [Qemu-devel] [PATCH v2 2.5/6] hmp: Add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--saTPwvPqM5V3y7s9dwGO1UIKWJoFcU7d7
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com
Message-ID: <b198a35a-b69e-37f9-8024-bc98b2e80e3c@redhat.com>
Subject: Re: [PATCH v2 2.5/6] hmp: Add name parameter to nbd_server_add
References: <20171208173321.GR2403@work-vm>
 <20180109192802.17167-1-eblake@redhat.com> <20180111175934.GB13384@work-vm>
In-Reply-To: <20180111175934.GB13384@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 11:59 AM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> Extend the flexibility of the previous QMP patch to also work
>> in HMP.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks, that looks good to me from the HMP side; let me
> know which way you want to take it; I can take it via
> HMP once the code that uses it is in; whichever is easiest.
>=20
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I'll take it through the NBD tree, along with the rest of the series,
once I get more answers on my open questions on the second half of the
series.

>=20
>> ---
>>
>> In response to Dave's request.
>> I could also squash this into Vladimir's 2/6 if desired.

At this point, I'm thinking it's better to leave it separate from
Vladimir's QMP patch, since you've only reviewed this one.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--saTPwvPqM5V3y7s9dwGO1UIKWJoFcU7d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXwB8ACgkQp6FrSiUn
Q2pf5gf+MsCw8ML8804frfEyV35/oUzMXifo5YAqx/a6L8fmDl69tD0/aMcINIIy
EgnvwxCHdPkL7PMMVmDcmyI5qFpq+WZTlUS7XHxGzzBkJ2rve8kTD6xceELEASy6
qfauXiUj9WNqomwr7M0DXbOd0pZDbzvkM3N45euJz1uFIhMc2iy/TUUVM1x/9UOr
H6mDRiZ2W1BA1VxrKnizOOHRWvWB+DT0lKvl+e1klK0pawREQo911leONU3tmYSE
45tK1HhqwBtCLyKV9pSop+ajY3N7Qq7VjRt+RBsvY+ccv7IURnK42+Q8tjQ8xNEO
aPGKLCzA7sjRqCwXx+DweNljt7PhRg==
=lczL
-----END PGP SIGNATURE-----

--saTPwvPqM5V3y7s9dwGO1UIKWJoFcU7d7--
