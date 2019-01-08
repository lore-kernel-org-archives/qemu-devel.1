Received: from eggs.gnu.org ([209.51.188.92]:49499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggw6I-0001m1-2v
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggw6H-0001ls-4z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:27:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggw6E-0001aE-Hu
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:27:39 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
	<61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
	<6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
	<f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
Date: Tue, 8 Jan 2019 19:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TFfB1KjXfFmaL0aahRtwsRHKhbT54Fcbd"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TFfB1KjXfFmaL0aahRtwsRHKhbT54Fcbd
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
 <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
 <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
 <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
 <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
In-Reply-To: <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/19 18:12, Kamil Rytarowski wrote:
> On 25.11.2018 18:14, Paolo Bonzini wrote:
>> On 25/11/18 00:50, Kamil Rytarowski wrote:
>>> On 22.11.2018 08:24, Kamil Rytarowski wrote:
>>>> On 16.11.2018 13:52, Paolo Bonzini wrote:
>>>>> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>>>>>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch =
includes
>>>>>> the corresponding userland changes.
>>>>>>
>>>>>> Since the Darwin userland backend is POSIX-compliant, the hax-darw=
in.{c,h}
>>>>>> files have been renamed to hax-posix.{c,h}. This prefix is consist=
ent with
>>>>>> the naming used in the rest of QEMU.
>>>>>
>>>>> What's the advantage of HAXM when Linux hosts can just run KVM?  I =
guess
>>>>> avoiding bitrot?
>>>>>
>>>>> Paolo
>>>>>
>>>>
>>>> This patch is also useful for NetBSD, even if it's not a Linux host.=

>>>> There is a driver in progress again (thanks to the newly added Linux=

>>>> port, it's now much easier to get done).
>>>>
>>>> I recommend to merge this patch.
>>>>
>>>
>>> For the record, I've a functional version of HAXM for NetBSD as host.=

>>> Once you will merge this patch, I will submit another one to configur=
e
>>> to enable haxm for NetBSD.
>>>
>>> I need to keep the patch by Alexandro in a local copy of qemu.
>>
>> Sure, it will be accepted for the release after 3.1.
>>
>> Paolo
>>
>>
>=20
> Ping.

It's already queued, but the pull request was pretty big and it had some
issues (quite an understatement).

Paolo


--TFfB1KjXfFmaL0aahRtwsRHKhbT54Fcbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlw0648ACgkQv/vSX3jH
roNeYQf+MckkALvX59XcXXmmJojIn7h+CMMhWwtL37Nukn+AuVISMs3f0Fpxbs9m
UdAELAncdPVil0T+OX/qcborHCFGEGe4VNdaKaxl2nEapG31bCv13kir0lsKzBSp
2nyKGACcTqud4tzwcnIJaQ3g1qskB6ehwroKPOdfrxO5pVs8CMXv5lnKvXTdrotq
3I1KKtT7rufag171HgHrYFz4TGqYPDJwsZ3US3r7Huc0D4K2PJQ5SbZUS4X6jigU
pjYxxxjeg/aXiN1OEJWUR8ESgWpRC8uMmL6+xXjDHvpVOhGe877lj40OoiOUfJw8
1DJQESALkDntzc6Y7nggeWMJJ1qh0w==
=8Kkc
-----END PGP SIGNATURE-----

--TFfB1KjXfFmaL0aahRtwsRHKhbT54Fcbd--
