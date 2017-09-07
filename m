Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpn0f-0003kh-Ok
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 22:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpn0e-0003ER-TF
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 22:57:41 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-30-eblake@redhat.com>
	<3e70c2c4-3266-6cc7-3682-2cf3c2c61d42@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2d81388-50e2-c38c-3e90-609a392bdb06@redhat.com>
Date: Wed, 6 Sep 2017 21:57:20 -0500
MIME-Version: 1.0
In-Reply-To: <3e70c2c4-3266-6cc7-3682-2cf3c2c61d42@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V0GHL4LVMSHcA3iPH0tuQ04sFMF0Bh9PP"
Subject: Re: [Qemu-devel] [PATCH v6 29/29] libqtest: Rename qtest_init() to
 qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:Floppy" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V0GHL4LVMSHcA3iPH0tuQ04sFMF0Bh9PP
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:Floppy" <qemu-block@nongnu.org>,
 Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>,
 armbru@redhat.com, Alexander Graf <agraf@suse.de>,
 Keith Busch <keith.busch@intel.com>, "open list:sPAPR"
 <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <c2d81388-50e2-c38c-3e90-609a392bdb06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 29/29] libqtest: Rename qtest_init() to
 qtest_start()
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-30-eblake@redhat.com>
 <3e70c2c4-3266-6cc7-3682-2cf3c2c61d42@redhat.com>
In-Reply-To: <3e70c2c4-3266-6cc7-3682-2cf3c2c61d42@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 08:10 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> We already have another qtest_init() in the tree, for the
>> top-level qtest.c device; having two functions with different
>> signatures is confusing.  Rename the libqtest version to
>> qtest_start() to eliminate the duplication.
>=20
> This is too much code churn for my taste, and I also do not like the
> idea of naming the function qtest_start() - since this was a function
> with different semantics before your patch 28/29, so this will cause
> confusion for all the people who are used to the old qtest_start()
> function or who want to backport patches that have done after this
> change to a code level before this change.
>=20
> If you are really bugged by the qtest_init() name clash, I think it's
> way easier if you rename the qtest_init() in the qtest.c file instead.

Except the qtest_init() in qtest.c really is our normal pattern of
*_init for devices, so that one's named correctly.  Our testsuite is the
one that is using a name different from its normal usage in the rest of
the tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V0GHL4LVMSHcA3iPH0tuQ04sFMF0Bh9PP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwtZAACgkQp6FrSiUn
Q2p3tAgAmh2k8LnIPHitLYtblJRtu4AV5ZIVYTsBmOUem7ad5C2biLS428y1+jqJ
N7v+TIeSvBYoWPhS/2poyO3y3PDSyJdAxQ1oM1bodV+tZTSy9o5tec/U7kohQCOq
z8bEuN07pV46UC+DDikt3Bkw+hXjCh+mo1MOQIE3ZXD2GhnyCFhij1d4WQR3fq3r
3AWIzbJ2MXa66Fgn1/uQz1AcCCJBSByS08gSdDklPaZmoME4mZU6RMVyww9IQFpK
DZPXt3bi5MuBqBoDNUEq9aXkNAyy2QcDACKgAYFt4do64Sty/2+9sE6d/EMpHMDb
l9jPikYLzJ/gjYwJiFKPIHxFiAVMSw==
=0HAI
-----END PGP SIGNATURE-----

--V0GHL4LVMSHcA3iPH0tuQ04sFMF0Bh9PP--
