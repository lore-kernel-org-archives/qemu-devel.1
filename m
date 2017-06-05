Received: from eggs.gnu.org ([2001:4830:134:3::10]:37393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHqyg-0002GP-GF
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHqyb-0007Al-Tc
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHqyb-0007A1-KG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:19:17 -0400
References: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
	<20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b912112c-7b34-3ba8-c1d4-308b84a06007@redhat.com>
Date: Mon, 5 Jun 2017 07:19:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cRo9wQ4bFmNnXMDkpTchCe1kmd7obj6hW"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cRo9wQ4bFmNnXMDkpTchCe1kmd7obj6hW
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
 "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <b912112c-7b34-3ba8-c1d4-308b84a06007@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: vmstatify config migration for
 virtio-ccw
References: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
 <20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
In-Reply-To: <20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2017 10:09 PM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-06-02 16:05:31 +0200]:
>=20
> Hi Halil,
>=20
> Sorry for the late show up. I just found some nits, which could be
> ignored for me.
>=20
>> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
>> flexibility (extending using subsections) and for fun.
>>
>> To achieve this we need to hack the config_vector, which is VirtIODevi=
ce
>> (that is common virtio) state, in the middle of the VirtioCcwDevice st=
ate
>> representation.  This is somewhat ugly, but we have no choice because =
the
>                  ^^
> Nit:-------------++

What's wrong here?  Two spaces between sentences is a common
typographical convention (true, the codebase is inconsistent on whether
sentences are separated with one or two spaces, but that's all the more
reason to realize that since we don't have a consistent standard, it is
just churn to change from one style to the other)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cRo9wQ4bFmNnXMDkpTchCe1kmd7obj6hW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNUxCAAoJEKeha0olJ0Nqpw0H/icgUNCkcDUjClHfiQujvHrG
R9mE21mOf647jVmGFjytktkaxc4S0fnjzeXHj/ns08vT9uIkNMjr9abKKhPKULf9
EiAntZgQYlFxKxO+UvJytHCkf/DHF1lHBB1Qq1HTwyTyqHU/iO78cpis6pOij1wd
xcK7TX1Fyr/5+cE6dX/N82kDLBRDpM7v9hGGe7MIJvoBlHhtKrVbGFNvLv8w4ih+
CXD+eSeARXcSfEW2LaQ0YauCC1adebEKV5Q9nGoUV2CTc71KD9VcsqEeDPogYl2/
Il0sBvsPx1LGGCJewPvdCzWfMC0IAficKph4K65AZ91TJ3lT2pQWiytMfALCN90=
=JA30
-----END PGP SIGNATURE-----

--cRo9wQ4bFmNnXMDkpTchCe1kmd7obj6hW--
