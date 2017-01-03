Received: from eggs.gnu.org ([2001:4830:134:3::10]:58084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOScr-0003dM-6I
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOScm-0006v7-7B
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:11:53 -0500
Received: from ignoranthack.me ([199.102.79.106]:55519
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cOScm-0006uu-1v
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:11:48 -0500
Received: from [192.168.0.6] (67-0-226-66.albq.qwest.net [67.0.226.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 29A8F1928BA
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 17:11:45 +0000 (UTC)
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
Date: Tue, 3 Jan 2017 10:11:41 -0700
MIME-Version: 1.0
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="xX9ETQ9VgiVDNOJXGNSQdnIXMJUTiNBLF"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xX9ETQ9VgiVDNOJXGNSQdnIXMJUTiNBLF
From: Sean Bruno <sbruno@freebsd.org>
To: qemu-devel@nongnu.org
Message-ID: <5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/03/17 09:18, Sean Bruno wrote:
>=20
> I'm pondering where to start with getting FreeBSD's bsd-user code into
> shape so it could actually be reviewed and accepted now that its sort o=
f
> working again (signal handling fixed finally).
>=20
> I almost feel like the existing code should be purged, except that it
> gives a good history (and this seems lazy to me).
>=20
> As a first pass, I guess, I'd like to at least make i386 user run on
> x86_64.  What would you folks like to see in a first pass?
>=20
> sean
>=20
> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user
>=20

Primitive example of what I think I should base my patchset on.  Its
invasive and large.

https://github.com/seanbruno/qemu-bsd-user/tree/merge1

That branch, is all the bsd-user changes that are pending in one large
"splat".  It excludes the new architectures (arm, aarch64, mips, mips64)
that we are actively using.  i386-bsd-user when compiled statically on
x86_64 will run a static (rescue) sh ... so, I think that's good.
x86_64 running on x86_64 just blows up.

As for sparc/sparc64 ... I'm tempted to delete them as nobody in freebsd
is actively maintaining them nor do we have any expectation that they
will work someday.

sean


--xX9ETQ9VgiVDNOJXGNSQdnIXMJUTiNBLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhr205fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmSkIgf8D27k7e8B25l1murCoxQ4F7x/Hh41AAXiv5+Z0oFL5EfEBArxac/RxzMJ
D7NI9d5PseS7BfvrrXf4bm4hseTbI6A7ndtPheBY74JKF7qYZLw7QN4IIDkxuDM2
glhWU4DRafYOua7bOctSWWt06lbAKKSK4zjpo0KoqD8sZeWdLD+GleL/rZd92cDV
OH8FHRlb9p4It2XvkbjbweFs2zXW/1XZAcLFPhJT6zved6g4g4VXQY4waGJB+42h
qhGrq13m66PjIEjzDRjPM/dldcgDyUKDDfh2tSbkIKz0peSezbxaQ8/P10AbxuqX
9E5dyfyDVM6WiRvXiXLCcrMu0LJFwQ==
=711k
-----END PGP SIGNATURE-----

--xX9ETQ9VgiVDNOJXGNSQdnIXMJUTiNBLF--
