Received: from eggs.gnu.org ([2001:4830:134:3::10]:47296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOHS6-0007ai-PE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOHS3-0007bw-JM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:20:34 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eOHS3-0007b4-2f
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:20:31 -0500
Received: by mail-it0-x242.google.com with SMTP id d137so13243921itc.2
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 22:20:30 -0800 (PST)
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
Date: Mon, 11 Dec 2017 17:20:23 +1100
MIME-Version: 1.0
In-Reply-To: <20171109063822.GD7732@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bvNQtl13DglTu4rB81VbsnDwDVm9BGKAg"
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvNQtl13DglTu4rB81VbsnDwDVm9BGKAg
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016052004.31397-1-aik@ozlabs.ru>
 <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
 <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
 <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
 <20171109063822.GD7732@umbus.fritz.box>
In-Reply-To: <20171109063822.GD7732@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/11/17 17:38, David Gibson wrote:
> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wrote:
>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
>>> On 19/10/17 17:24, David Gibson wrote:
>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrote=
:
>>>>> On 16/10/17 20:36, David Gibson wrote:
>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
>>>>> wrote:
>>>> [snip]
>>>>>> ||
>>>>>>
>>>>>> Yeah.. this is all a bit complicated, I'm really thinking about a
>>>>>> fdt_fsck() function for libfdt.
>>>>>
>>>>>
>>>>> Oh. So what now? Do as below or wait for libdtc update?
>>>>
>>>> So I started hacking on this.  It's a bit fiddlier to get right than=
 I
>>>> anticipated.  How about you make a placeholder function to "test" th=
e
>>>> tree for now, with a comment that it will be updated once the libfdt=

>>>> extensions are there.
>>>
>>> What would the placeholder do? Nothing or my proposed "FDT_CHK" thing=
y?
>>>
>>> Are we in a hurry with this one at all, or I can wait till libfdt get=
s this
>>> fsck()?
>>
>>
>> Ping?
>>
>> This is not v2.11 material, is it?
>=20
> Not at this stage, no.
>=20
> I've started looking at writing the fdt_fsck() thing, but got
> sidetracked by a bunch of related fixes to safety of handling
> corrupted blobs in libfdt.

Please let me know when I can repost the "
ppc/spapr: Receive and store device tree blob from SLOF" again. Thanks.


--=20
Alexey


--bvNQtl13DglTu4rB81VbsnDwDVm9BGKAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlouI6cOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILlk/g/6A6FkWIDFWz/SfQBXzS0qP6SRlphSW/k1U4D+
PeyUbG902Effeyeov5Rq/Jy1erMO48MdmiUTBgX/0WyIyroWK1fjxb9DX8bDgWj0
I7zSKu/uK6nKuyH9NHF/q5Gt4fB2EfWFwgpWkwOjIya74WfTdotUEVXHJxzTkIuf
MMCpPLUXqoU7a0CTxygwlJxRBURiV1PKqQh4ncj+RbLiIYtpq3rJLaHGGZjtyFDj
OyAHjD0nRBTAmD8svbAx+u8duBUlweHnHgpP6zWyi2oc3kWP/YLe0m98KTP9Pn8z
JI2UJtNSEJjGy3GG172PSe1tUEL9meJTkNwP39lGwmzG2gLfOK0J9LJuQCuqjO7Z
kOKcBzNwGaNO59Z/MK5JKo9UUZ1A4/LUO7+p50sSsiVmgE0MycKOSpaGxfg2+MWM
ABZYauUkIia1vbvxAJ1cYtN5rXHrN8t+IPC06F26SO2JYyBBLK1+P0VX7WQk2+ZO
bUIM0Ess8pzTFzA+uWF1RU39EezWAfr2Pb7lEeTyxfj/5ufvTFYN6dkwdroU7JgG
hO2c7xUp5FFLWK1DuJPG05+QOl9cjcYOsTC380UfBlT3Spig+bgKhtShQjNKqzpx
oOKc50c00XYb7bNJqJsLyW6jZK+awsf2QigKLq3/fBBEjmzWHjsQaPir7EbfKxQJ
Sqt0ZUQ=
=q044
-----END PGP SIGNATURE-----

--bvNQtl13DglTu4rB81VbsnDwDVm9BGKAg--
