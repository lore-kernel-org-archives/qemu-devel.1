Received: from eggs.gnu.org ([209.51.188.92]:54925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtweB-0007bX-5I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtweA-0002Xr-12
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gtwe8-0002Iw-67
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:40:25 -0500
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
	<20190213065357.16076-9-yuval.shaia@oracle.com>
	<d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5804c51-312d-4fe7-1c27-9aecbc8085e3@redhat.com>
Date: Wed, 13 Feb 2019 09:40:01 -0600
MIME-Version: 1.0
In-Reply-To: <d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T3TkUpbAuElgtiz62YYEDMfwccI4ssXem"
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/pvrdma: Delete unneeded function
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T3TkUpbAuElgtiz62YYEDMfwccI4ssXem
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com,
 armbru@redhat.com
Message-ID: <b5804c51-312d-4fe7-1c27-9aecbc8085e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/pvrdma: Delete unneeded function
 argument
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
 <20190213065357.16076-9-yuval.shaia@oracle.com>
 <d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
In-Reply-To: <d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 6:40 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/13/19 7:53 AM, Yuval Shaia wrote:
>> The function argument rdma_dev_res is not needed as it is stored in th=
e
>> backend_dev object at init.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
>=20
> Should we teach checkpatch.pl to check name/space/email?

I already have a proposed patch to teach it to recognize typos such as
'Reveiwed-by:'; it would be easy to expand that to also force
'name/space/email'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--T3TkUpbAuElgtiz62YYEDMfwccI4ssXem
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxkOlEACgkQp6FrSiUn
Q2rOaAgApkOV6o3ZmXkuvIzW8hFng3zH03Vep3uyQRvxuNKdFvUM2nyPN2SM+3kP
wY5+tdxZmUzMVBs4wG05Cr6aLWfSV+SGI/qMwsSoq2J2wfdne9OHVUakHLVIegHb
0tctfVymAKbz9JxZ+wDm9RsplwWSMcoqVACakcwTcNZuH0BEosu+6WY1d6H9Bk9N
XSBCT6mVwn/PLCMz2uSJOBUnBAISAzBNc/iqx9lc1lBpDzl/88KHG9N1kz8D/vau
UFqSBDUdvnDC0zReUBy8msHYcWJ+nK69wJl71qxZBiqNF17OGXz1fNdWh91a1Drq
iqhKJ6BQBuDWCE4TdaQrsG/C09iuWg==
=3B3L
-----END PGP SIGNATURE-----

--T3TkUpbAuElgtiz62YYEDMfwccI4ssXem--
