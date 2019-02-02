Received: from eggs.gnu.org ([209.51.188.92]:46898)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gpx1S-0002FU-EV
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 10:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gpwp7-0001JL-DR
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 10:03:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:57899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gpwp6-0001IC-Ux
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 10:03:13 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
	<61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
	<6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f328ad2c-f02e-b8cb-3d34-66702e8e26fa@gmx.com>
Date: Sat, 2 Feb 2019 16:03:39 +0100
MIME-Version: 1.0
In-Reply-To: <6408287c-15b5-3b44-dff8-b628c4244cd2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2H3dj9rW5kIAyheQll2krwT2tdObgfNcp"
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
--2H3dj9rW5kIAyheQll2krwT2tdObgfNcp
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <f328ad2c-f02e-b8cb-3d34-66702e8e26fa@gmx.com>
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

I've pushed the haxm patch for NetBSD through qemu-trivial.

https://lists.gnu.org/archive/html/qemu-trivial/2019-01/msg00161.html

A proof that it is usable:

http://blog.netbsd.org/tnf/entry/the_hardware_assisted_virtualization_cha=
llenge


--2H3dj9rW5kIAyheQll2krwT2tdObgfNcp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxVsUsMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsSwQQAJ58hKzcV7PSCzYOnZke9BJvzi5OIqgn+D9kqt64
wgZnwTP68aAiP+2KR7+sqRBeP9Jt23NwowDeagzMRBRqg5k81O2oKH7Sh6oylNrv
LSis7Jqg3h8oQOCDdLrTssBNOYk/ssqV3EXA3ZM5o3/Moby2TyZC/ODHlawXKKSF
MCmBMjpIlzVkT6yVT+ewT0oBWPsp8usHwS3o4ag4PTOUTX1f+xEscCLY6Gl0acry
fmn8psAmTn2yVjdOXSASU6nNbWMpz2KX/YxvKnm+XgNmevT8w5GC3wcuVb+2tr9e
gmvdx5ihfHHJZWme4JPa7eN2rCS/+EPyOCBPcr2l5NmgEOA3GTPtRtW6tY/A9l2N
fUNZFdZu/HKU5AauROlbbuT2moEoQNk8OPKsS44ZwhWNGWec853637Tyv4pzt53u
KIU2iWi9IiDZLdfXF4zQxeKp4nofvGMGO69M0Nw35uTRGXOPOHiY+/bSQvMdUajq
rP5A5eVpKWYhZgaht47pOY0z3U0utwM1Q3f5DlyQRwaIxPPSbHpIPxlrafzc6HPA
XB2o7Y9I9ibYd0FE5hYAPSSRzFkzdnPzLpPuU5XYEKxVcBJKVHcX05Fgi9Fn/u+X
0Mb/Pxl7uZqq2sn/IiK0p/aq69i8UUpV1cHM3P1njIZMJczBcqIzqCjnztJoatFa
4wyX
=xw/n
-----END PGP SIGNATURE-----

--2H3dj9rW5kIAyheQll2krwT2tdObgfNcp--
