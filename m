Received: from eggs.gnu.org ([2001:4830:134:3::10]:39232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTsly-0005xN-H0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTslr-0000U9-HI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:07:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTslr-0000T2-CE
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:07:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7527A7B9F6
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:07:35 +0000 (UTC)
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170118160219.GR30347@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34e28383-7a3b-1437-62a0-67cbf2d8e338@redhat.com>
Date: Wed, 18 Jan 2017 17:07:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170118160219.GR30347@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F0dSPOdDrhXTRtm72C7RNSfH1EltcNGHK"
Subject: Re: [Qemu-devel] [PATCH 00/16] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F0dSPOdDrhXTRtm72C7RNSfH1EltcNGHK
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <34e28383-7a3b-1437-62a0-67cbf2d8e338@redhat.com>
Subject: Re: [PATCH 00/16] aio_context_acquire/release pushdown, part 2
References: <20170113131731.1246-1-pbonzini@redhat.com>
 <20170118160219.GR30347@stefanha-x1.localdomain>
In-Reply-To: <20170118160219.GR30347@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/01/2017 17:02, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 02:17:15PM +0100, Paolo Bonzini wrote:
>>  hw/block/virtio-blk.c          |  19 +++-
>>  hw/scsi/scsi-bus.c             |   2 +
>>  hw/scsi/scsi-disk.c            |  15 +++
>>  hw/scsi/scsi-generic.c         |  20 +++-
>>  hw/scsi/virtio-scsi.c          |   6 ++
>=20
> Are all the other device models safe because they don't support
> IOThread?

Yes.

Paolo


--F0dSPOdDrhXTRtm72C7RNSfH1EltcNGHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYf5LBAAoJEL/70l94x66DR7IH/jTyD32CD+bHwJAjjOuUVDM1
HYF2cSMF3+URl0X68X5NdJEvBYOPsDIzWBFYEktoLDXCUDIogdWownn9vrEOmXJv
o8C9WTI7xspb09/+iHCT48UbgMeLogHuQIXV3ZDZt5XOdx746qBmTCFCOnqPSlLc
v+A0WMMECukjx2fxePjuPyctf2FST8LQC3CLEg2WxvxirYHY6Txh5bsxD6/ZFKBo
xdpaUv8PJHSdlV6yW/kXL/EaneRsvZWTfFxx3mEqNZaFsVkjw7l2lSL1BMdUQ4Xt
t0mCy1Sg3wKq89GP9VfKpIrL3H1l0Ig93/E2J+ZoqNfgOWf93DrnF7K1sSxJiaE=
=WSN6
-----END PGP SIGNATURE-----

--F0dSPOdDrhXTRtm72C7RNSfH1EltcNGHK--
