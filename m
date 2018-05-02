Received: from eggs.gnu.org ([2001:4830:134:3::10]:44827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDtkh-0001HF-JY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDtkg-00021X-L9
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:33:07 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
	<69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
	<34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
	<4ca76bd5-4b9a-636f-aa64-4f1aa02de4cf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0428cc5f-1498-c4a0-cfe8-e8432f68dca3@redhat.com>
Date: Wed, 2 May 2018 17:33:01 +0200
MIME-Version: 1.0
In-Reply-To: <4ca76bd5-4b9a-636f-aa64-4f1aa02de4cf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="smlp9oxg32dx0pDplTXzaH53jYm8YUtFC"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--smlp9oxg32dx0pDplTXzaH53jYm8YUtFC
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Ivan Ren <renyime@gmail.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <0428cc5f-1498-c4a0-cfe8-e8432f68dca3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
 <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
 <69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
 <34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
 <4ca76bd5-4b9a-636f-aa64-4f1aa02de4cf@redhat.com>
In-Reply-To: <4ca76bd5-4b9a-636f-aa64-4f1aa02de4cf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 17:19, Eric Blake wrote:
> On 05/02/2018 10:13 AM, Max Reitz wrote:
>=20
>>> We also recently added 'qemu-img measure', which DOES report how many=

>>> clusters are in use.=C2=A0 Is any of that reusable here?
>>
>> It only tells you that information for a hypothetical new image, thoug=
h,
>> doesn't it?
>=20
> It has two uses: with just a size, estimate the overhead needed to
> create a file with the given format and exposing the given size to the
> guest (both sparse and fully allocated sizes are estimated); and with a=

> pre-existing image, compute the exact overhead needed for 'qemu-img
> convert' to create a new image with the given format and the same
> guest-visible contents.=C2=A0 The latter use, where it uses an existing=
 guest
> image as the starting point to measure, indeed only tells you what a
> hypothetical new image will occupy (the used cluster count, not the
> wr_highest_offset count) - but isn't that what you want?

As far as I can tell, it only uses allocation status of the active layer
to determine how much of the hypothetical new image would be allocated
(the man page says "as if converting an existing image file using
qemu-img convert").  But this patch tries to determine exactly how much
is allocated in the current image for everything, not just how much you
need to have allocated to represent the active layer.

That may include snapshots, but it also includes bitmaps, or allocated
zero clusters (which qemu-img measure discounts), or things like empty
L2 tables.  So, everything.

Max


--smlp9oxg32dx0pDplTXzaH53jYm8YUtFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrp2i0ACgkQ9AfbAGHV
z0DcuwgAqgpW0g7SgOIeyxaAgX03e9yX8RxLHZxpZYU4r6Z9dPqTBnZZJS37icf3
9t7QkDPATMrnQCbNqjR4+VVeiXrIdUJscFPD+YMUnFioc+kFIgbB3rKarLugzbVY
10bxqhdspUHkOgE730GOcNkCap8eLmP7KsRdlHVs0UAfQ77TVQ4ykKQMbWiHVas3
ZE4xXNDIYFmszOPDo5VmtaFp4U2g5VVB18yUKELSAVKGK48k+1mGzPmFMzv+2cgY
VGfPe4SQ/qNKcEcIdo6RTSTkPghunB99Z+nGu7mD4b8pREHvDlSen5uubmNmEDW/
4W1vTOGpgVwbQt539YNANjiy9a14Ew==
=MFeT
-----END PGP SIGNATURE-----

--smlp9oxg32dx0pDplTXzaH53jYm8YUtFC--
