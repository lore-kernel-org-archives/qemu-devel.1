Received: from eggs.gnu.org ([2001:4830:134:3::10]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQxzz-0008Ld-TN
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 12:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQxzu-0004DM-9M
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 12:15:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gQxzt-0004CC-VN
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 12:15:06 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
	<61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
Date: Sun, 25 Nov 2018 18:14:53 +0100
MIME-Version: 1.0
In-Reply-To: <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gseOaaAJsyEJV34S1kXIt2NUHKr0uA84p"
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
--gseOaaAJsyEJV34S1kXIt2NUHKr0uA84p
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
 <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
 <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
In-Reply-To: <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/11/18 00:50, Kamil Rytarowski wrote:
> On 22.11.2018 08:24, Kamil Rytarowski wrote:
>> On 16.11.2018 13:52, Paolo Bonzini wrote:
>>> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>>>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch in=
cludes
>>>> the corresponding userland changes.
>>>>
>>>> Since the Darwin userland backend is POSIX-compliant, the hax-darwin=
=2E{c,h}
>>>> files have been renamed to hax-posix.{c,h}. This prefix is consisten=
t with
>>>> the naming used in the rest of QEMU.
>>>
>>> What's the advantage of HAXM when Linux hosts can just run KVM?  I gu=
ess
>>> avoiding bitrot?
>>>
>>> Paolo
>>>
>>
>> This patch is also useful for NetBSD, even if it's not a Linux host.
>> There is a driver in progress again (thanks to the newly added Linux
>> port, it's now much easier to get done).
>>
>> I recommend to merge this patch.
>>
>=20
> For the record, I've a functional version of HAXM for NetBSD as host.
> Once you will merge this patch, I will submit another one to configure
> to enable haxm for NetBSD.
>=20
> I need to keep the patch by Alexandro in a local copy of qemu.

Sure, it will be accepted for the release after 3.1.

Paolo



--gseOaaAJsyEJV34S1kXIt2NUHKr0uA84p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlv62I8ACgkQv/vSX3jH
roOHZQf5AT9X5+Cqfj24isXZTcuXttXZS3Iq24vNYuBJL8MDkiwWRultoU+O4G8P
h13NPS4uRz7sgzqvmEvgutR3bYdNM4XXfdQcM2+ax7LcNh+qeupYgg+9HiKS7KIg
MLqXWE5d1PgbOvjZidW7Xs1Mwo1QDPJvnAEoODMbV+yZgeO0lF8vQ07xzcPk7cJF
ABY6D/2x98DJvbXRH4HPkf3ZWzqc5B9UvbRc8sOhxzC0xscLrMjw09mjQ0BIeQZH
WZA68NpRYAzfTYWBi7poBf++5r6omv76B37tVdufAC5Y7xXklD5GgO/wP8uvyatL
rtdGKxvFsgVdwjtmI3tDoA4Syq3NXw==
=iQHU
-----END PGP SIGNATURE-----

--gseOaaAJsyEJV34S1kXIt2NUHKr0uA84p--
