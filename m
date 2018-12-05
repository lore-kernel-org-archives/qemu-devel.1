Received: from eggs.gnu.org ([2001:4830:134:3::10]:49791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUThA-0007uf-NF
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUTh5-00028t-Lv
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:42:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gUTh3-000246-K0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:42:10 -0500
Received: by mail-wr1-x442.google.com with SMTP id x10so18911422wrs.8
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 01:42:04 -0800 (PST)
Date: Wed, 5 Dec 2018 09:42:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181205094201.GC20933@stefanha-x1.localdomain>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
	<dc5c1890f814da22352b08bb6ac8f7090b2f7066.1541425595.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <dc5c1890f814da22352b08bb6ac8f7090b2f7066.1541425595.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/7] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
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


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2018 at 04:29:20PM +0800, Zhang Yi wrote:
> diff --git a/include/standard-headers/linux/mman.h b/include/standard-headers/linux/mman.h
> new file mode 100644
> index 0000000..ea1fc47
> --- /dev/null
> +++ b/include/standard-headers/linux/mman.h

include/standard-headers/ contains mechanically-translated Linux kernel
headers.  You wrote your own header file from scratch and
scripts/update-linux-headers.h doesn't know about it.

Please put your changes in include/qemu/osdep.h instead of
include/standard-headers/.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcB51oAAoJEJykq7OBq3PImdgH/RSBsAauRfwJE1u+36saWCzW
sjSV+5aNM0UwOflt7X+7NNF+VQjcB+Zzv8O8qfQNPhDpsNMtMWFeRte4qvTmRXUk
txyEEwrC/bytG/fCuoULCLleyCMeE2HTEXlqe1tkBVvALAGItY8vNBV6ifHUoKyv
Mlv4a7LK2O+CozDEYN5cd75KtVEnRTC+HJrTO4Qi6CVneeRLInK5bCpIO8zjvmBS
4o9kGEPkruiDkdUuis+mMW7XhVQpa/Gopbx//gEmLuh7sh58kHYjxkT6nqq7DxqO
qMDW+7Wb0KYbewR+2lJF/yb9FmozFpPN+HAeqJ/0YYPU1bQLyTAC+x9i4rBgNNA=
=PVPK
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
