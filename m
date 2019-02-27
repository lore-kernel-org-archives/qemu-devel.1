Received: from eggs.gnu.org ([209.51.188.92]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz13t-0003XG-2Z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz13p-0007ja-WF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:23:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gz13o-0007dN-WB
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:23:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id e74so6195377wmg.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 07:23:49 -0800 (PST)
Date: Wed, 27 Feb 2019 15:23:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227152347.GF22539@stefanha-x1.localdomain>
References: <MN2PR02MB580680857B3390A2447B512DB67B0@MN2PR02MB5806.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <MN2PR02MB580680857B3390A2447B512DB67B0@MN2PR02MB5806.namprd02.prod.outlook.com>
Subject: Re: [Qemu-devel] Virtio-net control queue handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikhil Agarwal <nagarwal@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jasowang@redhat.com, libvir-list@redhat.com


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 02:13:43PM +0000, Nikhil Agarwal wrote:
> Is there any option in QEMU to offload virtio device control queue handling to backend instead of deciphering and passing to libvirt via QMP? if not, is there any interface in libvirt which passes on these message to application or i directly use QMP interface from QEMU?

I'm not sure I understand your question.  It could be because of
terminology:

"virtio device control queue" == virtio-net control virtqueue?

"backend" == vhost-user-net device backend?

"message" == QMP event?

I have CCed Jason Wang, QEMU network subsystem maintainer, and the
libvirt mailing list.

Stefan

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdquDAAoJEJykq7OBq3PIkoIIAIt69iVdkyEGaM72Wb88WTYY
k5aNWwKhH1eFZxzZs6sBTj+f7NzowF51YCyPyLuWLDrqgcXiZWY6lzQISsSdj62P
RpqmJ8avx1zULyRFniktx+jmBwavJGZDxSvo1l4fk9rmOoV/TwyHBLMhgP5r6rXX
2qCpFTuJOILuYFsrdWODQcwxsP5X6t8k+GnlhTPQs5Ti2GC/L77Dd5JJBnXKX0NO
u5gYoazrpy6rBmb5tFzkejc+SQIfRsN1U/7HJ3VvtyYxOy3ls8wSRS++nJcNy+B9
dsxb3tYG9xMtiOXtjSU7s7nnHwfUtsI1KFFri5sJ7HCbrlyFUUwPLmD6vhT4RFs=
=C9R3
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
