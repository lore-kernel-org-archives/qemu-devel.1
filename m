Received: from eggs.gnu.org ([2001:4830:134:3::10]:49062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhhz-0003qw-8A
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhhy-0008Ol-AJ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:33:31 -0500
References: <20171103144113.7188-1-berrange@redhat.com>
	<9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
	<20171110172253.GH30685@redhat.com>
	<fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c31a2050-7d01-cfc5-a28b-492cf4f82ca5@redhat.com>
Date: Fri, 17 Nov 2017 08:33:22 -0600
MIME-Version: 1.0
In-Reply-To: <fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l9veilP6tVEmuJBGtnjj4gxwfn9KB89fe"
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l9veilP6tVEmuJBGtnjj4gxwfn9KB89fe
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c31a2050-7d01-cfc5-a28b-492cf4f82ca5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after committing
 qcow2 image into base
References: <20171103144113.7188-1-berrange@redhat.com>
 <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
 <20171110172253.GH30685@redhat.com>
 <fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
In-Reply-To: <fa4f8209-37ec-f8e9-eaf1-ac48453c1bff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 07:52 AM, Max Reitz wrote:

>>> Hmm - I wonder if persistent bitmaps are also corrupted in the fast p=
ath.
>>
>> I also wonder if there's anything better we can do to make us safer by=

>> default, so we default to the slow & safe path, unless we can provide
>> we *only* have the subset of features that are safe for the fast path =
?
>=20
> I have wondered the same but I can't think of any.  The only thing that=

> comes close would be to check for which header extensions there are; bu=
t
> at the same time, we could just add a comment to qcow2_read_extensions(=
)
> ("If you add a new feature to qcow2, note that you may want to adjust
> the qcow2_make_empty() fastpath conditions").

Indeed, such a comment may be helpful.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l9veilP6tVEmuJBGtnjj4gxwfn9KB89fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloO8zIACgkQp6FrSiUn
Q2p34AgAq3KeWiXfqej0B99RC2QwvrOA7WjEGlZMiPKIvqR4FqTLSnNTVHrRh2ZU
d5nPXQHabjoXKSXwOV9j0aAM05PDe7udsnCzxGD4HFXZPujFPIzIjofzrpKBkFda
Dhg0T+AiAURt5zVqQ0MpiZIOwtNUe/Ub4WgEH5AtZaWPUaWNEWHCfxop2dyI4Of/
tuKCFrA7B2402JGaWY8n1CQXmWV4FVFw1LEcTavl4dYxn+OxPh9H+DKHF1I6LR1X
nZKbx/XEQyTc3kIDyqb8g38zXty9F1FwaUNuOOWoGyF70mM75DfA5TN3o9VJSZHq
za1Na7JHwHpy2v/N3r8XOkWOTO+Hjg==
=kQE9
-----END PGP SIGNATURE-----

--l9veilP6tVEmuJBGtnjj4gxwfn9KB89fe--
