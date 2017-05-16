Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAekt-0001VN-OR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAeks-0000Ab-Ty
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:51:23 -0400
Date: Tue, 16 May 2017 17:51:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516155102.GH4438@noname.redhat.com>
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-6-hpoussin@reactos.org>
	<20170516141602.GE4438@noname.redhat.com>
	<69fc0b47-4654-c179-f729-bfafc1f68510@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <69fc0b47-4654-c179-f729-bfafc1f68510@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/13] vvfat: introduce
 offset_to_bootsector, offset_to_fat and offset_to_root_dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.05.2017 um 17:05 hat Eric Blake geschrieben:
> On 05/16/2017 09:16 AM, Kevin Wolf wrote:
> > Am 15.05.2017 um 22:31 hat Herv=E9 Poussineau geschrieben:
> >> - offset_to_bootsector is the number of sectors up to FAT bootsector
> >> - offset_to_fat is the number of sectors up to first File Allocation T=
able
> >> - offset_to_root_dir is the number of sectors up to root directory sec=
tor
> >=20
> > Hm... These names make me think of byte offsets. Not completely opposed
> > to them, but if anyone can think of something better...?
>=20
> I _want_ us to move towards byte offsets.  Thinking in sector offsets is
> madness, especially since I already have patches posted to make
> bdrv_get_block_status() converted to a byte-wise interface.
>=20
> How hard is it to make all of the new variables be byte offsets, then
> scale them to sectors as needed?  You can assert() that the byte offsets
> are sector-aligned, so that the scaling doesn't have to worry about
> rounding effects during the divisions.

If we want to convert it to bytes internally (I'm not sure how useful it
is with vvfat), that would definitely be a separate patch or even
series.

Kevin

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZGx/mAAoJEH8JsnLIjy/WbCMP/jVE81evtYZeAYCKE3sNGz4n
Zs11KtuQZ7RUExWF0+kUFrRIoPm5ND8+4XzgO734ieV0dPRDUBF+NLgwQjg+/UvM
jqSwGpVRrvIk9s1wURtuhlzz3SriFZOJ5gkP4fO3iNFMUiHu5Bnsy7TWcq0kBHMR
N/qbhwAPNnQRRZrYtv2jVIHdKlTASN0SWl41Ni+7yj+foo4P6n2E5bYnK8Mj51CD
c+y0tpaJbgnJc9onvgdtyOorYjajWIASUyorMoR3GPfk/Z43T1QdpjmDh36UuHt2
+MRJnazCP6rMSgMDXEMOqyNz/g7oktj9Fx7462xrn4CL7N2P1UxbUKSDKZoEkf21
CKs6HUS0itBCq26cfhZiMo2IoOlgqhXMbe+C/5Q3R5Jh/a9Obtqsvap8X6lfZy3v
R3gN/gtoR5tEE9sAI38l4doAggmhOAumXIaevAjMlu9OS6sncvzEejLsqiXuRjAo
NHSUkiI1PLtdmSJrHvt6RODhX6DwcEOtcNqJpEoc+w923cbXO1MBx0qmcSISiyP+
yuPfcicSLK95ZFcraZRLMBZjPXYREHxh308/yf/nSG2lY2bv2MkyJcv3NvzenKzQ
l1fwVpvK4/E8XUfk5HUG8v8MFgGG3WPDeueLaQZZ2RBIHT5Xv0ObVyk8nB0gh/A3
rJ/wHv6cUZHzQiRFbQPe
=Usnq
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
