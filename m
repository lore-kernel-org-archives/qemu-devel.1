Received: from eggs.gnu.org ([2001:4830:134:3::10]:48741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciR7I-0000i4-EX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciR7D-000201-I9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:37:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciR7D-0001zE-9N
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:37:47 -0500
References: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
	<20170227110106.GE28403@stefanha-x1.localdomain>
	<20170227123356.tgmtbiwcoswdb256@eukaryote>
	<20170227131757.vkf6twqdkzbwnsqc@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e3033ab-9cc9-8673-f13c-2dd658677fc9@redhat.com>
Date: Mon, 27 Feb 2017 13:37:44 -0600
MIME-Version: 1.0
In-Reply-To: <20170227131757.vkf6twqdkzbwnsqc@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s7QSddNjm1g1HUb2VdmVUQEnKB3Crbiql"
Subject: Re: [Qemu-devel] [libvirt] Question regarding Snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: libvir-list@redhat.com, Tim Cusack <thagrasshoppa@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s7QSddNjm1g1HUb2VdmVUQEnKB3Crbiql
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: libvir-list@redhat.com, Tim Cusack <thagrasshoppa@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <3e3033ab-9cc9-8673-f13c-2dd658677fc9@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] Question regarding Snapshots
References: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
 <20170227110106.GE28403@stefanha-x1.localdomain>
 <20170227123356.tgmtbiwcoswdb256@eukaryote>
 <20170227131757.vkf6twqdkzbwnsqc@eukaryote>
In-Reply-To: <20170227131757.vkf6twqdkzbwnsqc@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 07:17 AM, Kashyap Chamarthy wrote:
> On Mon, Feb 27, 2017 at 01:33:56PM +0100, Kashyap Chamarthy wrote:
>=20
> [...]
>=20
>>>> Can you make a snapshot, then go back to the base and ignore that sn=
apshot
>>>> like a closed branch, make another snapshot, and then go back and fo=
rth
>>>> from each to each?

Yes.  Or graphically, you can have:

       -- A ... B ... C
      /
base <
      \
       -- D ... E ... F

and toggle between any of the named snapshots at will.  As Kashyap and
others pointed out, libvirt support for reverting to a particular
external snapshot is not fully present, so there are some manual steps
involved, but the task is still doable.

>=20
>> For the long answer to the complications involved in reverting to
>> external snapshots, refer this (long read):
>>
>> https://wiki.libvirt.org/page/I_created_an_external_snapshot,_but_libv=
irt_will_not_let_me_delete_or_revert_to_it
>=20
> [...]
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--s7QSddNjm1g1HUb2VdmVUQEnKB3Crbiql
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtIAIAAoJEKeha0olJ0NqeQMH/ipSiDDC1/qtrtN0R25MJq3l
TF01SALetmZ2RbInyJNQWbC+q8dMmeboxbZLNeHHQ/nIgfw2N4KOZbhOjLCwj2q4
JkJA0A20DYMzA3fC73f0NMVpqNkB6trxyTXaNaUWCDAXHp1lPUco8ExqhbRMxuER
FM7dE2RCpZfs2z/8TfN3DyNcFi6jRsjL2YUhIa9SrfqMEQdTAEIcgoBdjSBeLPxB
xq7Kvz+eWn5XzKbWfngcOuQUE4teoo4l/FSqJgh2K7weKmiaZ1Ycq5TvglKQqOCj
Uz5hRlwphi7XzHe2OaAawscaIrWOpE7ODwX0bbzeTYr+pFLY1FhQWdU7yefo36k=
=eR6/
-----END PGP SIGNATURE-----

--s7QSddNjm1g1HUb2VdmVUQEnKB3Crbiql--
