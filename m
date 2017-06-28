Received: from eggs.gnu.org ([2001:4830:134:3::10]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCbq-0006kH-OE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCbk-0008GL-TJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQCbk-0008FB-K6
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:02:12 -0400
References: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
	<35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <865858b6-1e3b-b421-617e-f8656ca36b5b@redhat.com>
Date: Wed, 28 Jun 2017 08:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ARD5huPnGmXrS9wnlokfE6QbTVAwCCLM0"
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtio-dev-owner@lists.oasis-open.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARD5huPnGmXrS9wnlokfE6QbTVAwCCLM0
From: Eric Blake <eblake@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 virtio-dev-owner@lists.oasis-open.org
Message-ID: <865858b6-1e3b-b421-617e-f8656ca36b5b@redhat.com>
Subject: Re: [PATCH v1] virtio-net: code cleanup
References: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
 <35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
In-Reply-To: <35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[meta-comment, replacing virtio-dev with virtio-dev-owner in cc]

On 06/28/2017 07:22 AM, Eric Blake wrote:
> On 06/28/2017 12:53 AM, Wei Wang wrote:
>> Use is_power_of_2(), and remove trailing "." from error_setg().
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>  hw/net/virtio-net.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

I got this rejection letter:

>=20
>                    The mail system
>=20
> <virtio-dev@lists.oasis-open.org>: permission denied. Command output: S=
orry,
>     only subscribers may post. If you are a subscriber, please forward =
this
>     message to virtio-dev-owner@lists.oasis-open.org to get your new ad=
dress
>     included (#5.7.2) ERROR: postqmail-local Error #77

It's generally considered poor netiquette to cc both an open list and a
closed list that rejects emails from non-subscribers (note that you do
NOT have to subscribe to qemu-devel to post to it, although a moderation
delay may be involved).  It's not necessarily my place to tell the
virtio-dev list what to do (since I don't subscribe), but it may be
worth considereing relaxing the list posting policies there to allow
moderated posts from non-subscribers, especially if it is going to be
common-place that people want to cc virtio-dev at the same time as
another open list.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ARD5huPnGmXrS9wnlokfE6QbTVAwCCLM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU6jOAAoJEKeha0olJ0NqLVgH/jnWKmlqOFuWzpM3NJPiNpdO
6DdF+TWZ2NM+i7LnG6jSvmfIvMQL7BUXC/Vkb2MvPn6GslZu6bMQq1Pog3RsMtv7
UBIG3F5Rmbd5WOFTFv7G0T0r5DJUnEDYd8eOYTpncML44bbaUfxaBq7cyYbS/JxP
WP/ySBYJ5Nx7uIPdA0rvBb2M0bBFTgK+7PFjf1YicMLIFns9urEGnSLr8Z3H/BjT
TM3zwKrtX4zcNPaLYw0l7mHER3CtHKaF0bI4myw+olewcpydjbLHAjMEbzZtqGPR
RwQur36SCWowXhxt6YX/tVmecWjBad9rMNhMfx1APeChc+I5foAbFAHtnARubE4=
=ycOv
-----END PGP SIGNATURE-----

--ARD5huPnGmXrS9wnlokfE6QbTVAwCCLM0--
