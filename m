Received: from eggs.gnu.org ([209.51.188.92]:44344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBah-0000EL-SB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghBag-0002Y0-R1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:00:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghBag-0002Xc-Jk
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:00:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so7184637wrx.9
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:00:06 -0800 (PST)
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
	<61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
	<6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
	<f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
	<075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af8e1f23-27e2-3a7e-b911-0abda449dbf2@redhat.com>
Date: Wed, 9 Jan 2019 12:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whP5HsqlOf2rJ8UXxYYeY3zVgRExIPHoS"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whP5HsqlOf2rJ8UXxYYeY3zVgRExIPHoS
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <af8e1f23-27e2-3a7e-b911-0abda449dbf2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
 <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
 <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
 <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
 <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
 <075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
In-Reply-To: <075402ba-b1f1-b7d1-3a6a-47b6dd959133@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 7:27 PM, Paolo Bonzini wrote:
> On 08/01/19 18:12, Kamil Rytarowski wrote:
>> On 25.11.2018 18:14, Paolo Bonzini wrote:
>>> On 25/11/18 00:50, Kamil Rytarowski wrote:
>>>> On 22.11.2018 08:24, Kamil Rytarowski wrote:
>>>>> On 16.11.2018 13:52, Paolo Bonzini wrote:
>>>>>> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>>>>>>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch=
 includes
>>>>>>> the corresponding userland changes.
>>>>>>>
>>>>>>> Since the Darwin userland backend is POSIX-compliant, the hax-dar=
win.{c,h}
>>>>>>> files have been renamed to hax-posix.{c,h}. This prefix is consis=
tent with
>>>>>>> the naming used in the rest of QEMU.
>>>>>>
>>>>>> What's the advantage of HAXM when Linux hosts can just run KVM?  I=
 guess
>>>>>> avoiding bitrot?
>>>>>>
>>>>>> Paolo
>>>>>>
>>>>>
>>>>> This patch is also useful for NetBSD, even if it's not a Linux host=
=2E
>>>>> There is a driver in progress again (thanks to the newly added Linu=
x
>>>>> port, it's now much easier to get done).
>>>>>
>>>>> I recommend to merge this patch.
>>>>>
>>>>
>>>> For the record, I've a functional version of HAXM for NetBSD as host=
=2E
>>>> Once you will merge this patch, I will submit another one to configu=
re
>>>> to enable haxm for NetBSD.
>>>>
>>>> I need to keep the patch by Alexandro in a local copy of qemu.
>>>
>>> Sure, it will be accepted for the release after 3.1.
>>>
>>> Paolo
>>>
>>>
>>
>> Ping.
>=20
> It's already queued, but the pull request was pretty big and it had som=
e
> issues (quite an understatement).

Hopefully you queued Alexandro's v2 (which isn't named v2) with Alex
comments fixed, thanks!

Phil.


--whP5HsqlOf2rJ8UXxYYeY3zVgRExIPHoS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlw11DMACgkQoqP9bt6t
wN4iKRAAlxxpMjhjrdcWXkqIrx/F9WfYDuMfn0X/D6Np6G9EmyuxhjO+ByhqQjyh
nx6wzISoSkVX34gC29seoiD+MeP0uVS7sGEaMiCCOCTzGqN4hrRszHrvEzwa5vQH
B27kHgJiXiIZ+2bOP/5jVQzAWmQ4kUPQooSSS5OCVUESYA9TZNdo4MoWY67Wwewz
q8oZG8CptwgwEv65MHfPMRvBfO5vqoRHMABTSV1LZIsZ3yIVq/1d6IZ68j0LvbvI
znfP4xeYrls8/ST7wVXErAEVGukjLbIVJRNl5qMpmyFXgsnUuDRZCS2T4y9NtRHY
Z50aHhS+Z0gq3XM4sgxJc6VN7s++/XeuR8m/xipg9DGk+kPK7q7cshBYLN49vACJ
Sas7L2x9bhoST8BrBHDh30JpaEqi484KypTNaJKJWAubD/DziubSbzUrvrIG1Lzf
eaBpsQyaizUUog2vAKyrDl/UlI3ZCoJixADusnvKSkJnjitrZecaOSDUpoE3YmGy
/6B0kJVpGlIP5kwcn7T161BiX5T0uCMhiYq6SLGIvjl9DH2P9wcL01RpvWttD33c
PcdxLJQ+iXxgyWCEPeeks5Pu7cM02gOBpYOBUBjHZNBeWuVjZvx56v4sAczKQL4b
rgRuoCMeOVBcZHUn0u8nyZNg8+9U/BEm4Ybg/TTlgalbmbH3IvY=
=/G2y
-----END PGP SIGNATURE-----

--whP5HsqlOf2rJ8UXxYYeY3zVgRExIPHoS--
