Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX55U-0003gA-MB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX55T-0001kw-Oc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:25:20 -0400
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
	<7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
	<CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
	<07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
	<20170717121910.GG5301@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd8a80fe-4ac9-5f34-ce1f-d512eee7f703@redhat.com>
Date: Mon, 17 Jul 2017 07:25:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170717121910.GG5301@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AURBsBBSOVPejPbfCQxLtxG3GXrARVXfP"
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AURBsBBSOVPejPbfCQxLtxG3GXrARVXfP
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Ala Hino <ahino@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jsnow@redhat.com>
Message-ID: <cd8a80fe-4ac9-5f34-ce1f-d512eee7f703@redhat.com>
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
 <7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
 <CAMr-obtga00C5cKS63T_5RW99hK2W1nKMDba4cnTGH8dVYrXaA@mail.gmail.com>
 <07dfafaa-884c-9b86-cf37-dbdc454d2b91@redhat.com>
 <20170717121910.GG5301@noname.redhat.com>
In-Reply-To: <20170717121910.GG5301@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 07:19 AM, Kevin Wolf wrote:

> While I think adding -u today is reasonably realistic, I'm doubtful tha=
t
> we can get an introspection mechanism in place today. Perhaps we can
> declare it a bug fix, but I'd rather not rush something like that.
>=20
> How does libvirt detect qemu-img features today? Just try and then chec=
k
> the error message?

Yeah, when it comes to non-advertised feature detection, the best you
can do is try using the feature, and fall back to the older approach if
the feature was not present (this approach only works for features that
gracefully fail without side effects when attempted on older versions,
but fortunately that's the case for most true feature additions).

And note that creating an image without a backing file, then using
'qemu-img rebase -u' to give it a backing image without probing the
backing image, IS currently documented and supported (so we DO have a
safe fallback, regardless of when 'qemu-img create -u ... size' actually
lands).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AURBsBBSOVPejPbfCQxLtxG3GXrARVXfP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZbKylAAoJEKeha0olJ0Nq2dMH/2PsbnOYmWL7vZw60F7DiGOo
Lt8a9qePcxPMwSufEpYHpIlzd4OymTwF465Ez4eZ9LG0WtQCClT3jgSbsE2hhMwD
PATLVy0N5QT5BrN6negwXPCGlLev5vbHwgb5Pncth8pOEZhfQAtMQm4o7w+HAaQX
wTv3svquYMbKZtlkGaIxfbtyjh+VPp7cbW8I0/QITyrs+eEvTqRiCN69YBxXzIER
iiaHP+SZTRBjMx/7T0Vn7CaaI7xLREUeq9aGDLiD6wx9u/B8Ey+Ek3TB/xod1tXI
kQiwTgVT1oWDbE986Ic0WaKGV1Bz+H4R2F18Etj98tX/jAQZcFeQSn2Kvau/YmA=
=7v5V
-----END PGP SIGNATURE-----

--AURBsBBSOVPejPbfCQxLtxG3GXrARVXfP--
