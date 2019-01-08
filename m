Received: from eggs.gnu.org ([209.51.188.92]:37642)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gguuw-00036C-Pz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gguut-0006LX-6D
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:11:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gguus-0006Dj-S0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:11:51 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
	<61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
	<6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
Date: Tue, 8 Jan 2019 18:12:31 +0100
MIME-Version: 1.0
In-Reply-To: <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="09ExMgzsUdpvVmgkxF8rIBBRpEbqm3QY3"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--09ExMgzsUdpvVmgkxF8rIBBRpEbqm3QY3
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <f5c6f0cc-1e45-c47d-724f-c50b27765f0f@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
 <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
 <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
 <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
In-Reply-To: <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.11.2018 18:14, Paolo Bonzini wrote:
> On 25/11/18 00:50, Kamil Rytarowski wrote:
>> On 22.11.2018 08:24, Kamil Rytarowski wrote:
>>> On 16.11.2018 13:52, Paolo Bonzini wrote:
>>>> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>>>>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch i=
ncludes
>>>>> the corresponding userland changes.
>>>>>
>>>>> Since the Darwin userland backend is POSIX-compliant, the hax-darwi=
n.{c,h}
>>>>> files have been renamed to hax-posix.{c,h}. This prefix is consiste=
nt with
>>>>> the naming used in the rest of QEMU.
>>>>
>>>> What's the advantage of HAXM when Linux hosts can just run KVM?  I g=
uess
>>>> avoiding bitrot?
>>>>
>>>> Paolo
>>>>
>>>
>>> This patch is also useful for NetBSD, even if it's not a Linux host.
>>> There is a driver in progress again (thanks to the newly added Linux
>>> port, it's now much easier to get done).
>>>
>>> I recommend to merge this patch.
>>>
>>
>> For the record, I've a functional version of HAXM for NetBSD as host.
>> Once you will merge this patch, I will submit another one to configure=

>> to enable haxm for NetBSD.
>>
>> I need to keep the patch by Alexandro in a local copy of qemu.
>=20
> Sure, it will be accepted for the release after 3.1.
>=20
> Paolo
>=20
>=20

Ping.


--09ExMgzsUdpvVmgkxF8rIBBRpEbqm3QY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlw02gAMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs6awQAJVn+QzHnRXaIesg5LFMAL2F/mcy6QhEGiAQbKMj
aZfMwp2hKmFP+aaipyi/Rr9dZck65Kj2uLhvfO/WlvPRqAs4X0RM8/sUkCiVJBHe
h4Vilt5b/7DOgyeiDSaHBaNegTti7uF0atOdQIbq6OqaWwYEYqx1OWpqlIWSzVu4
fWsBamXWOLDBfxTfT6D0wXK/L/x6aWe2EMHqjpAcS/0J39h3Ym9D07uE1+QA062I
XYDt7M6Avg22zLpmvZwba980mFTL7XK/fYzY34tLrja99dYZAe8MMcQpFX1oVL30
hmQm98GKffehTvPoy3UQs82ojvtifmzRNeAdJQ0pCUITn2mehgpGAwMr53dQhh6k
IrDmRbjViaofDil6GzlxdfLs06CoSqS/ujPNYxukwXqX8k6qdcGU+6gIpDlJtBbf
R3nFDREib3wzslzpwyZwkBIQ3tjYXOFaOD1JmNqeaVuz0GItdIxwV2/7Fbv8Tr13
pgV4Dq3nkL/930KWxSbtfIBosvXRHrIQSXeNTZZ/Z3Vc2HRJhRwUChxZYt5ps1uD
GMrbZEHLJBYzh/ePgrugtsVUPsfMSUqMJ8EEbEg5z9wt1gGn5SgJ0p1AWJ5HKcDY
qBhp3TWa57+2KDTCCvlKG5c71SGkoc8+eWZ8724+s1OsVYbuHgOG2/A8qenoPcjs
e32g
=fXHB
-----END PGP SIGNATURE-----

--09ExMgzsUdpvVmgkxF8rIBBRpEbqm3QY3--
