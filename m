Received: from eggs.gnu.org ([2001:4830:134:3::10]:36657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdGR-0000gj-30
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdGN-0000iq-37
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:31 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdGM-0000iU-PA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id d127so23618204wmf.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:16:26 -0700 (PDT)
Date: Tue, 30 May 2017 10:16:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530091624.GE11362@stefanha-x1.localdomain>
References: <20170526022438.17478-1-haozhong.zhang@intel.com>
	<20170526022438.17478-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20170526022438.17478-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hostmem-file: add an attribute 'align'
 to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:24:38AM +0800, Haozhong Zhang wrote:
> file_ram_alloc() currently maps the backend file via mmap to a virtual
> address aligned to the value returned by qemu_fd_getpagesize(). When a
> DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
> mmap implementation may require an alignment larger than what
> qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.
>=20
> This commit adds an attribute 'align' to hostmem-file, so that users
> can specify a proper alignment that satisfies the kernel requirement.
>=20
> If 'align' is not specified or is 0, the value returned by
> qemu_fd_get_pagesize() will be used as before.

How are users supposed to determine alignment requirements?

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLThoAAoJEJykq7OBq3PIbokH/3tQKv1hLWa47x7hrd6lgTMu
sEjYtOhRPZLsJG0rHDKKL/1DxwQIEqkIDVRL+yTa+fkMXeOXMPZ8FDwQxqhLssNC
5A05SGN6HdvqY9NYP8WDqaELNNiaIxvYeK9yZHvK6+n+CRkhi+5JEslv+f52ISws
SLSkuoJ+qd5bJa6DrDp2yB3KVoWxjmQC2GRnom5QG+JMa/KUh9hYaikz/FOA9vQA
A+Cgu27j7CMrrT4SZ5HRSE0hSpI6OA/1bA6DHofQRJ3No1qJ0ko/3hwug0C96XU3
+km81D6DVGYwYPu7ibjcFqGUMgdsJtDiwaHqBjC5CmdgBrNcUaGImK+4o2duTfI=
=3f5y
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
