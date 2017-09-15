Received: from eggs.gnu.org ([2001:4830:134:3::10]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsmMG-0003LV-BY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsmMD-0004cf-9R
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:52:20 -0400
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
	<19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
	<20170915104320.3d88e231@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <340b1c62-1dba-3823-cdc6-3b9f3cb1cbb7@redhat.com>
Date: Fri, 15 Sep 2017 10:52:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170915104320.3d88e231@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="efAhknn29v8A2I7fX8cFhWx7iQviuGkuX"
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--efAhknn29v8A2I7fX8cFhWx7iQviuGkuX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.2017 10:43, Greg Kurz wrote:
> On Fri, 15 Sep 2017 07:15:41 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 14.09.2017 21:25, Greg Kurz wrote:
>>> The following capabilities are VM specific:
>>> - KVM_CAP_PPC_SMT_POSSIBLE
>>> - KVM_CAP_PPC_HTAB_FD =20
>>
>> BTW, looks like kvmppc_has_cap_htab_fd() is dead code ... should we
>> either remove it or check it somewhere?
>>
>=20
> Heh you're right :)
>=20
> The only user for cap_htab_fd is kvmppc_get_htab_fd(), in order to prov=
ide a
> sensible error message that KVM doesn't allow saving HPTEs (ie, migrati=
on isn't
> supported with some older KVM HV). It doesn't need kvmppc_has_cap_htab_=
fd() for
> that since all the code sits in target/ppc/kvm.c.
>=20
> I can't think of any other use, so I guess we can drop it.

OK. If you've got some spare minutes, could you maybe send a patch?

[...]
>>> @@ -2353,7 +2353,7 @@ int kvmppc_reset_htab(int shift_hint)
>>>          /* Full emulation, tell caller to allocate htab itself */
>>>          return 0;
>>>      }
>>> -    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
>>> +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {=

>>>          int ret;
>>>          ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shif=
t);
>>>          if (ret =3D=3D -ENOTTY) { =20
>>
>> Looking at the comment in the code after the "if (ret =3D=3D -ENOTTY)"=
 line,
>> it sounds like there is a bug in the kernel and the
>> KVM_CAP_PPC_ALLOC_HTAB should depend on the hv_enabled variable, too?
>=20
> It already does :)
>=20
> commit a8acaece5d88db234d0b82b8692dea15d602f622

Oh, right, seems like I was looking at an older kernel branch :-/ So
never mind, we're fine here.

 Thomas


--efAhknn29v8A2I7fX8cFhWx7iQviuGkuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZu5S8AAoJEC7Z13T+cC21Km4P/3GxqM4vp4HTHu18r1Ti3tr2
dq6nuIvknN1rrDuJbhBiVk3T2AhiS5pevhnP7RhMiOmBu9XcB21VJlae49eZdVF/
tbk+ysBuyPRr4Lfj+KqsdAd+pLSVfw14bW6aXPrbKsazXkaog8Eh2ziFeEkCIAgo
i4WptA+Tse2tqFRGLDuwrijIKsBEebvlB6/uZav+FpntA2u3cJqkFOIrAHvbRogh
EJCCbmWVzkE+fA9OSkrlzk6nWJ8KclxoqdexayAtDXB0iLE7ne26GybQu/AJcBfz
oTvJP1lGDOzgatRLtpI7xJ1UHh59BfG4cGkUH1rwzgxCvORPusp/Ar55B51tvIhc
f/AWLW0AuC7um+ShCXvPPq6hK+ozDTyiTh8lzw6VqtuznLVrVaVGb+ck1X6Bduau
izyItA7eaT2VyuRJX2tXYvseFkpWfO9i5+lwC5tdNYyioTCraCWGswY592zkEj0t
iSaLQRxtk8GV2TE7Tgz5gc38yrUnrBCF3rGEM7izsmClkXku89lFyoMOlK7Mj3wj
5kUZapFiOlMmape6UsskFBjkfirVIXvg4kVAfROvL6mjc2gpikntpEuPzYd5f6fR
HdPHLAzvfsFcmwkP9/8fZ/GMssh1humXFpx4ycSSxa9BHU6/UQGzpl8kbTqvAvZS
NJcB03YUNS9oSZRL4dfp
=1Dju
-----END PGP SIGNATURE-----

--efAhknn29v8A2I7fX8cFhWx7iQviuGkuX--
