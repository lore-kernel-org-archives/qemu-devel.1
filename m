Received: from eggs.gnu.org ([2001:4830:134:3::10]:52881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUTnt-0005gV-R2
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUTno-0008OW-MX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:49:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gUTno-0008Nu-BQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:49:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id q26so12107357wmf.5
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 01:49:08 -0800 (PST)
Date: Wed, 5 Dec 2018 09:49:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181205094905.GD20933@stefanha-x1.localdomain>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
	<904316e1b1eb22d7a2d19fa00ffba17e65acda3b.1541425595.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <904316e1b1eb22d7a2d19fa00ffba17e65acda3b.1541425595.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/7] util/mmap-alloc: Switch the
 RAM_SYNC flags to OnOffAuto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, yu.c.zhang@linux.intel.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2018 at 04:29:30PM +0800, Zhang Yi wrote:
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index f411df7..fe9303f 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -111,6 +111,10 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
>      assert(align >= getpagesize());
> +    if ((flags & RAM_SYNC_ON_OFF_AUTO_ON) &&
> +        (!shared || !MAP_SYNC_FLAGS)) {
> +        return MAP_FAILED;
> +    }

Missing munmap(ptr, total)?

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcB58RAAoJEJykq7OBq3PI5f0IAJ3cFOscK/9gPDpGVO4794gU
mrr6cTyd7E9ZbPpAjmRO9vsItBKY6gBb0ic8/qw5WAnFnnfHK7XNUziW/1dm9JMa
o2hPVUT+hT51N4p1efW4A/pt96H06/NL8RQznBXCSUq7Zp3omZLiteQlik8Yr022
O3NkcmfYTZje7XnJmKguUVH+csYPXNGJucYvyCkYzgUkGC8tHbt7QR6qObytDkfA
1u5thQvq3zbht2u5zw4hgKPfthM1CPTrqSmAMVQQfE0auHfVWiSz2USTMmaC3Miv
PYlsEG3LxLj3CvJnITjG26sEqDqGNee3eGSiIqVRK2UTOfUTQwpzvydFNlyry6I=
=KbhS
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
