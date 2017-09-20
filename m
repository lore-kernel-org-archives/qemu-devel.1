Received: from eggs.gnu.org ([2001:4830:134:3::10]:36361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duhM5-000496-HK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duhM0-0006Xq-W6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duhM0-0006Vs-CK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:56:00 -0400
References: <0bc0c49663fafdf3b03844fe048cac3216d88c5b.1505922364.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2735dd8d-4854-0437-161e-327c00119a5a@redhat.com>
Date: Wed, 20 Sep 2017 10:55:45 -0500
MIME-Version: 1.0
In-Reply-To: <0bc0c49663fafdf3b03844fe048cac3216d88c5b.1505922364.git.tgolembi@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3VDsawmRpSEKiXot6oFM78jLv1e8Io5wF"
Subject: Re: [Qemu-devel] [PATCH] virtio_balloon: include buffers and
 chached memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VDsawmRpSEKiXot6oFM78jLv1e8Io5wF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>,
 Huang Ying <ying.huang@intel.com>
Message-ID: <2735dd8d-4854-0437-161e-327c00119a5a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio_balloon: include buffers and chached
 memory statistics
References: <0bc0c49663fafdf3b03844fe048cac3216d88c5b.1505922364.git.tgolembi@redhat.com>
In-Reply-To: <0bc0c49663fafdf3b03844fe048cac3216d88c5b.1505922364.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 10:48 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:

In the subject: s/chached/cached/

> Add a new fields, VIRTIO_BALLOON_S_BUFFERS and VIRTIO_BALLOON_S_CACHED,=

> to virtio_balloon memory statistics protocol. The values correspond to
> 'Buffers' and 'Cached' in /proc/meminfo.
>=20
> To be able to compute the value of 'Cached' memory it is necessary to
> export total_swapcache_pages() to modules.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
>  include/uapi/linux/virtio_balloon.h |  4 +++-
>  mm/swap_state.c                     |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3VDsawmRpSEKiXot6oFM78jLv1e8Io5wF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCj4EACgkQp6FrSiUn
Q2qYHQf/epFcqf51mAzcUw1TegHyasbJ/HdLsRrkNLmKP7qTQwDTybhxa98vcxqU
hajKbOh9y4bd11V+WpbZiJCusB1oLcO3vAW8VLCTF16GNDEvxUlXcBCxNgkFW6AD
f8DOwKkz3JNJVXAJOtq0LhH1To30utL+3vnYPI8x1kskXQaukL+wkbBG2Sf7hT2L
/bhBs55QZQ6MdrYeF5cEsHfReKIc4my/IKr2kuBwJzV8OHMOX/KrSFYqAo/r3aWr
MAfRYtvA3nSF9PyZyl886ArIDxhnkUzmwLG6zSPTmMrLpF1MZyYnCQXigFazm2vr
/BtmbxLCB8jEx9Zfq5EU4uQQotCWCQ==
=SZUr
-----END PGP SIGNATURE-----

--3VDsawmRpSEKiXot6oFM78jLv1e8Io5wF--
