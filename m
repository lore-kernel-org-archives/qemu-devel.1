Received: from eggs.gnu.org ([2001:4830:134:3::10]:56475)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eGgfn-0005Md-5Z
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eGgfk-0004NL-35
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:39:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:50165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eGgfj-0004Me-OP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:39:15 -0500
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
	<aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
	<20171116180003.GO3111@localhost.localdomain>
	<ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
	<20171119213130.GI3037@localhost.localdomain>
	<1516fc97-6b46-5a3b-3226-d89b55974cea@linux.intel.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <e4baa787-8820-be98-2b12-f5643c897fde@gmx.com>
Date: Mon, 20 Nov 2017 08:41:37 +0100
MIME-Version: 1.0
In-Reply-To: <1516fc97-6b46-5a3b-3226-d89b55974cea@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CATqQv00hvMsxq2m73kdnXKB0AVr5X928"
Subject: Re: [Qemu-devel] [PATCH] hax-interface: Add BSD license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Yu Ning <yu.ning@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CATqQv00hvMsxq2m73kdnXKB0AVr5X928
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org, Yu Ning <yu.ning@linux.intel.com>
Message-ID: <e4baa787-8820-be98-2b12-f5643c897fde@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] hax-interface: Add BSD license
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
 <aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
 <20171116180003.GO3111@localhost.localdomain>
 <ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
 <20171119213130.GI3037@localhost.localdomain>
 <1516fc97-6b46-5a3b-3226-d89b55974cea@linux.intel.com>
In-Reply-To: <1516fc97-6b46-5a3b-3226-d89b55974cea@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.11.2017 08:17, Yu Ning wrote:
>=20
>=20
> On 11/20/2017 5:31, Eduardo Habkost wrote:
>> On Fri, Nov 17, 2017 at 05:03:27PM +0800, Yu Ning wrote:
>>> On 11/17/2017 2:00, Eduardo Habkost wrote:
>>>> On Thu, Nov 16, 2017 at 07:47:44AM +0100, Stefan Weil wrote:
>>>>> Am 16.11.2017 um 07:50 schrieb yu.ning@linux.intel.com:
>>>>>> From: Yu Ning <yu.ning@intel.com>
>>>>>>
>>>>>> hax-interface.h defines the interface between the HAXM kernel
>>>>>> module and the HAXM QEMU accelerator. The same code can be found i=
n
>>>>>> the following files of the HAXM kernel module:
>>>>>>
>>>>>>    include/hax_interface.h
>>>>>>    include/vcpu_state.h
>>>>>>    core/include/vm.h
>>>>>>
>>>>>> These files are now open source under the 3-clause BSD license,
>>>>>> whereas hax-interface.h in QEMU uses GPLv2.
>>>> Why is this a problem?
>>> I know very little about licenses.  If this is not a problem, I'm
>>> happy to
>>> just abandon this patch.
>> As far as I can see, this is not a problem for the QEMU project
>> at all, as QEMU as a whole is GPLv2.
>>
>> It would make sense to update the license if we wanted to keep
>> our header file in sync with some other source tree (e.g. the one
>> from Intel), but this doesn't seem to be the case here (yet?).
>>
> I see, that makes sense.

Please keep the whole HAXM as it is (BSD-3clause) as it makes this piece
of software reusable for !Linux (and non-qemu) usage without licensing wa=
rs.

If it will be kept BSD, I might try to integrate it with the NetBSD
base-system at one point.


--CATqQv00hvMsxq2m73kdnXKB0AVr5X928
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaEoc7AAoJEEuzCOmwLnZsYooP/Aw6WD3ZsBLgSVEqNwQxSgAr
Jhlo/I0Evg8hGtnCcoTkitwuf3eeiNXnIj6tN9JCawOTA3tTZx48AeKWkjAF9od+
f5wiZ2Z5TAZv0tToQJHpSzzO20pbwC5UQDdrH0P2h2uXAsHiUbX0NB0eRd2TZ+sk
zhouM1qDWBTaq53sowstaj732YnaRlceorJ4oN9eusRNH5Jed99D4dnakyNHFBXx
SN4fC9VhhNUUywMVYssVthLbKxeV2MQ0jsxu2VccbH5+OXr0CxO1NsKZtlPE7KXd
XFz8193IiIBVpLu6dTfmJTdjcsNFtkq8KsJhtnEHuz1BjopeYElom5AMFCg7h5EB
PdoZoriQtn16+kjYBVT2N5iYztaKAiMg43Hgdw2/gB1NDOxjse64XV/f12Z3u1XQ
47arI1XWJElqJYwGkaIMMhBtu3yjElwhIL++3mF1/es8wNy09/FbF7XF1uFWH5Er
1GEPDQM5jUk1EenwGe8F/Nb7MU5HRQ8qmdALQEi88OswX1ty7aPMZZ/ujl1ca/fc
7oJ+LsTVMy4DzX5JP9dBRG1whjslCy70VOHqhufPm4P12sfmbh67C4dPqw14sYWa
BU1lyi+dcuw/hwxreMupWBBpIWtmD16OlkhwdLISUF+Sf49MItf8J1NqzKKxRtyl
XmEMMxONECJB5twugSXu
=XkQS
-----END PGP SIGNATURE-----

--CATqQv00hvMsxq2m73kdnXKB0AVr5X928--
