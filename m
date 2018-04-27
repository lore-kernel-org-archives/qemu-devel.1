Received: from eggs.gnu.org ([2001:4830:134:3::10]:59182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC3hh-0004Wp-6v
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC3he-0006UE-3a
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC3hd-0006U8-UK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:46:22 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
	<ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
	<136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
	<87vacexcir.fsf@dusky.pond.sub.org>
	<230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
	<8736zix8yb.fsf@dusky.pond.sub.org>
	<f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com>
	<87bme5uolc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f899ed4-231a-b3d5-c6fc-01f2d44a8f0f@redhat.com>
Date: Fri, 27 Apr 2018 08:46:15 -0500
MIME-Version: 1.0
In-Reply-To: <87bme5uolc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vF92lgVwsN7vFOAjWzf9Pgob6viMu4h5L"
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vF92lgVwsN7vFOAjWzf9Pgob6viMu4h5L
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Message-ID: <4f899ed4-231a-b3d5-c6fc-01f2d44a8f0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-7-lersek@redhat.com>
 <8736zjagg3.fsf@dusky.pond.sub.org>
 <4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
 <87sh7i4h5y.fsf@dusky.pond.sub.org>
 <ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
 <136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
 <87vacexcir.fsf@dusky.pond.sub.org>
 <230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
 <8736zix8yb.fsf@dusky.pond.sub.org>
 <f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com>
 <87bme5uolc.fsf@dusky.pond.sub.org>
In-Reply-To: <87bme5uolc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 01:53 AM, Markus Armbruster wrote:

> We could perhaps still declare *all* @arch values useless in v2.12.0,
> then fix them in v2.12.1.
>=20

Well, it's still useful to know that "s390" means the extra field is
available even in 2.12.0.  But your plan:

> Or we deprecate @arch right when we introduce @target, and drop it late=
r
> in accordance with our deprecation policy (qemu-doc.texi @appendix
> Deprecated features).  That way, the rather ridiculous code to compute
> it will be temporary.  I think that's cleaner.
>=20
>    @arch in     query-cpus      query-cpus-fast
>    before 2.6   nonexistent
>    2.6 - 2.11   CpuInfoArch
>    2.12         cmd deprecated  CpuInfoArch
>    2.13         cmd deprecated  memb deprecated
>    2.14         cmd gone        memb deprecated
>    2.15         cmd gone        memb gone

works well for me.  I don't think we can accelerate the deprecation by
backporting that to 2.12.1, or if the deprecation belongs only in 2.13,
but the overall plan is sane (libvirt has the deprecation timeframe to
start accessing 'target' instead of 'arch' when worrying about whether
the extra s390x information is present - if it doesn't already just read
the information when present without worrying about the value of 'arch'
in the first place).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vF92lgVwsN7vFOAjWzf9Pgob6viMu4h5L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjKagACgkQp6FrSiUn
Q2onhgf/XBntFh7bF+punxa9M81gbb2t+9kjmp8fhBcQ7Gt8srfZzMOtSwlScoWJ
7yzxpd5IrYHjZC2gtKC6Bpt6UqQxDk4bCxV5xb7TlUPjDGQT7FevD6wPKv3udogm
Fyt1KlPYfmk6hXBlQ4rArwr/qxwc7LVeBvUkY6LnEFIIQIrLj9lGZvrYFhuMnFhS
QpmsSD+tQm+ervOmR5mFmmNBVoIATkcpEjAYfefaIKXNZ2sF4XN+JScQ3MtNuzue
MtlWiSWXYCKMowDrH9qxrUYXvkjpqGpB64T6FQbip1J9rBVyVTNFU9Dhb5430e7G
IkWp4d0qfJl/qGFI8cofxNfbZA9o0A==
=127K
-----END PGP SIGNATURE-----

--vF92lgVwsN7vFOAjWzf9Pgob6viMu4h5L--
