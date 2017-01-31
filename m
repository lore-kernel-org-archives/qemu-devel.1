Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYddH-0005hW-Mf
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYddE-0005SJ-Fj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:58:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYddE-0005SF-6b
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:58:20 -0500
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<20170131165052.GD20303@redhat.com> <87k29boyss.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a6c4106-aa38-1f23-fa79-e0081e170d38@redhat.com>
Date: Tue, 31 Jan 2017 12:58:15 -0600
MIME-Version: 1.0
In-Reply-To: <87k29boyss.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eGna8J0eqfIvQKAfuiVLeGAL9clVPUeCg"
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eGna8J0eqfIvQKAfuiVLeGAL9clVPUeCg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <3a6c4106-aa38-1f23-fa79-e0081e170d38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
 <20170131165052.GD20303@redhat.com> <87k29boyss.fsf@dusky.pond.sub.org>
In-Reply-To: <87k29boyss.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:43 PM, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
>=20
>> On Tue, Jan 31, 2017 at 04:43:52PM +0200, Michael S. Tsirkin wrote:
>>> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>>> if the C file including that header happens to have
>>> QEMU_BUILD_BUG_ON at the same line number.
>>
>> Do we actually hit this problem in practice ?  Even if we do hit the
>> problem, it surely has a trivial workaround of just inserting/removing=

>> a blank line somewhere in the file before the QEMU_BUILD_BUG_ON.
>>
>> IOW, is it really a benefit to change to use COUNTER, given that it is=

>> less portable that what we have today ?
>=20
> __COUNTER__ is the best solution I've seen so far.
>=20
> The proposed fallback for compilers lacking __COUNTER__ is not quite
> correct, but it's relatively unlikely to break, and I'm vanishingly
> unlikely to compile with such an old compiler ever again, so I'm okay
> with it.  I'd also be okay with making __COUNTER__ support a hard
> requirement.

Making it a hard requirement is as simple as:

#if !defined __COUNTER__ || __COUNTER__ =3D=3D __COUNTER__
#error Upgrade your compiler
#endif

>=20
> I guess that means:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Since the v4 pull request was botched, if you'd like to add R-b for the
v5 pull request, you can also add

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eGna8J0eqfIvQKAfuiVLeGAL9clVPUeCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkN5HAAoJEKeha0olJ0NqT84H/2bLANVG3lFN6O6XrcptxOfp
y4bm5wtkDGNht9M8MjJvU58nJs1osqMYzM/JEuUxJgncnvlCm245LdzqtMEB1Qej
N3+g/mBSLIpGx6UFZR/v85+Y1oXC7Xw2Jnt0bIo4x+js1LOWrgEXY2LnzqHiG1S7
B8UUCF7ffQJFNkPQZ5+QahwNCy4jUTuaPvhPNgRXt2/30n/BsOX111O2uFgY4D93
mRJERaqmUYF0UHt+1f4Md0/BASWgLudx3B8fhigRrJM8ds6EzP8j1iTq3CLCh/sv
t4SyaGeO95m2A+Z9hTMIjUwvfBzKPfdVRb65HO7y52RgsRCeUsdrAIauLhMeLR0=
=w8Jj
-----END PGP SIGNATURE-----

--eGna8J0eqfIvQKAfuiVLeGAL9clVPUeCg--
