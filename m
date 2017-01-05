Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPAPf-0003kb-Qs
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPAPb-0006F8-Ut
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:57:11 -0500
Received: from ignoranthack.me ([199.102.79.106]:50433
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cPAPb-0006EW-Nc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:57:07 -0500
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<CAFEAcA-dOaMYMSSUN_jrRUPRxLVQBZJX4MzZoM6KOz+o3YYBMQ@mail.gmail.com>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <fb59a0c0-394c-6149-00b9-8da5d4f575bf@freebsd.org>
Date: Thu, 5 Jan 2017 08:57:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dOaMYMSSUN_jrRUPRxLVQBZJX4MzZoM6KOz+o3YYBMQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="MKQBcgmfVQVSWqDwaopjrFLSRBbSsNhXA"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MKQBcgmfVQVSWqDwaopjrFLSRBbSsNhXA
From: Sean Bruno <sbruno@freebsd.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <fb59a0c0-394c-6149-00b9-8da5d4f575bf@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
 <CAFEAcA-dOaMYMSSUN_jrRUPRxLVQBZJX4MzZoM6KOz+o3YYBMQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-dOaMYMSSUN_jrRUPRxLVQBZJX4MzZoM6KOz+o3YYBMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/05/17 04:33, Peter Maydell wrote:
> On 3 January 2017 at 16:18, Sean Bruno <sbruno@freebsd.org> wrote:
>> I'm pondering where to start with getting FreeBSD's bsd-user code into=

>> shape so it could actually be reviewed and accepted now that its sort =
of
>> working again (signal handling fixed finally).
>>
>> I almost feel like the existing code should be purged, except that it
>> gives a good history (and this seems lazy to me).
>>
>> As a first pass, I guess, I'd like to at least make i386 user run on
>> x86_64.  What would you folks like to see in a first pass?
>=20
> So, here's my thoughts on this. I think our goals here are
>  * get the out-of-tree code into the tree, over time
>  * help you get to a point where you're maintaining and fixing
>    the FreeBSD code with us upstream, rather than deploying
>    downstream patches
>=20
> and the primary obstacle is this big pile of non-upstreamed
> code. From my end I don't think it really matters too much
> what order we try to tackle things in, as long as the chunks
> that arrive for upstream review are not too large and seem at
> least vaguely coherent. If i386-on-x86_64 seems like you can
> extract it sensibly then I think it's as good a place to start
> as anything else (though of course it's of pretty much zero
> practical utility :-)).
>=20
Its a good-enough place to draw a line.  Its just an arbitrary point
that I chose.

Let me see how gruesome the patchset would be from the branch that I
created the other day.


> Whether you want to keep the sparc support or delete it is
> I think up to you as the maintainer -- if it's broken and
> nobody cares about it I think we can happily delete it.
> On the other hand if you want to fix it up and keep it around
> then that's fine too.
>=20
I'll table this point for after we are merged up.

> At some point it would be good to get the BSDs into the set of
> things we test when merging code, so we don't regress them.
> That would ideally require hardware we can access though (the only
> real-hw setup in the gcc compile farm is an ancient NetBSD
> 5.1 install). I guess instructions-for-BSD-novices on how to
> setup a VM on a Linux box would do in a pinch.
>=20
> (We should also try to avoid breaking bsd-user on the other
> BSDs in the course of fixing up FreeBSD -- do you know how
> many of the other BSD hosts work right now?)
>=20

AFAIK, its only FreeBSD that has interest in keeping bsd-user
maintained.  OpenBSD isn't super interested in this application and
NetBSD has their own way (pkgsrc) to cross compile for other architecture=
s.

sean


--MKQBcgmfVQVSWqDwaopjrFLSRBbSsNhXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhubM1fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmS7LQgApDkj4MoooSvZtbtEsLGT+9V+M0mHoHGFCu/zwBIRP7PTZ1aMRyLAXmDV
7bGFgS5UEqeaH1ItO2XCitWdB0eun9Ne2YCWjlquEUZCVQPHyka0uprs2Svta34l
pWwdUIlGc7uvFV66JKFfHbBjsBaBWP4FDzqbRoz5uAOEXttAvbaIKVCEZeAStpfA
dR0FhugPxukRJByKKdqFl68SAdx9tAB4TOvf283ZDtC7fGVmYk2zv25ztGk/7Gz0
t8RLafw+p7+76sG6pagjXhtfh6EAMtTTv0Kimysj0LvoNIbT66j5ybyDbaYO4Spu
fJ9OH/cAT+Jo6ekc1Cy4lo3TqJxmvw==
=V+rt
-----END PGP SIGNATURE-----

--MKQBcgmfVQVSWqDwaopjrFLSRBbSsNhXA--
