Received: from eggs.gnu.org ([2001:4830:134:3::10]:46915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eYSuR-0003qd-Pc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eYSuM-0002lV-RK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:55 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eYSuM-0002l1-IW
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:50 -0500
Received: by mail-it0-x22e.google.com with SMTP id r6so8439450itr.3
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 00:35:50 -0800 (PST)
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
	<d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
	<9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
	<20180103000947.GE24581@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
Date: Mon, 8 Jan 2018 19:35:43 +1100
MIME-Version: 1.0
In-Reply-To: <20180103000947.GE24581@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EcvOscvJC1OXN360p56kZHskGxFuQF43t"
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
--EcvOscvJC1OXN360p56kZHskGxFuQF43t
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016052004.31397-1-aik@ozlabs.ru>
 <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
 <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
 <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
 <20171109063822.GD7732@umbus.fritz.box>
 <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
 <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
 <20180103000947.GE24581@umbus.fritz.box>
In-Reply-To: <20180103000947.GE24581@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/18 11:09, David Gibson wrote:
> On Tue, Jan 02, 2018 at 05:13:09PM +1100, Alexey Kardashevskiy wrote:
>> On 11/12/17 17:20, Alexey Kardashevskiy wrote:
>>> On 09/11/17 17:38, David Gibson wrote:
>>>> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wrote=
:
>>>>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
>>>>>> On 19/10/17 17:24, David Gibson wrote:
>>>>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wr=
ote:
>>>>>>>> On 16/10/17 20:36, David Gibson wrote:
>>>>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
>>>>>>>> wrote:
>>>>>>> [snip]
>>>>>>>>> ||
>>>>>>>>>
>>>>>>>>> Yeah.. this is all a bit complicated, I'm really thinking about=
 a
>>>>>>>>> fdt_fsck() function for libfdt.
>>>>>>>>
>>>>>>>>
>>>>>>>> Oh. So what now? Do as below or wait for libdtc update?
>>>>>>>
>>>>>>> So I started hacking on this.  It's a bit fiddlier to get right t=
han I
>>>>>>> anticipated.  How about you make a placeholder function to "test"=
 the
>>>>>>> tree for now, with a comment that it will be updated once the lib=
fdt
>>>>>>> extensions are there.
>>>>>>
>>>>>> What would the placeholder do? Nothing or my proposed "FDT_CHK" th=
ingy?
>>>>>>
>>>>>> Are we in a hurry with this one at all, or I can wait till libfdt =
gets this
>>>>>> fsck()?
>>>>>
>>>>>
>>>>> Ping?
>>>>>
>>>>> This is not v2.11 material, is it?
>>>>
>>>> Not at this stage, no.
>>>>
>>>> I've started looking at writing the fdt_fsck() thing, but got
>>>> sidetracked by a bunch of related fixes to safety of handling
>>>> corrupted blobs in libfdt.
>>>
>>> Please let me know when I can repost the "
>>> ppc/spapr: Receive and store device tree blob from SLOF" again. Thank=
s.
>>
>>
>> Still to early to repost?
>=20
> No.


I looked at the recent libfdt (from qemu tree, sha1  e543880, v1.4.6) and=

could not find fdt_fsck() or similar, and I was waiting for this really,
have I missed something?


--=20
Alexey


--EcvOscvJC1OXN360p56kZHskGxFuQF43t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpTLV8OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILnFKQ/+OcPdLQEsgM6FsRGi8kl13VyxYM0T3blWj7wf
eteezEIyyth9dSyTeRypXuaYdyGE6+mXb3SFQlYdGHpfUDYQHsreOd19t9NXmKuz
AU/K89CQ/jnHe7xK2Lr1GWShfGgS37N7FJ8zCUIP/CiZsmX4w21zudbzSghJ+wU+
PoC/rmDTm+CTnMj8AhQDbpx6EUx0A5oUq/m2wBmuqAKEzXwxgXW/pMJR8knWP5Nk
zQFdsnQ6+fQ77b3CQdsW/SvVDLdoRjUV1KLwmThMExIbLc3m0GMrFbo8KhGv0VGM
4fPzD1dGLAkbO6qRlvsJGzdYltW7wZlvlgXXvifAwu4LgWCIDVR/sv3LnH/vwpPU
CpbC50a+f5DshXuXjNSE7ixPNQ7GMwMjcDfG+Wt6r+OOntShw3Fiw7ZbpqUlrnOm
hoE0aBVR2CzH5QALptciMDAjrz0Ip6lwexjFzESk6mRH4yj6FXAW6ufQm66DIznH
lL3meilPN9q8yaqEUKKO64K5h1c/f/IdGttax0tMCknQPfE91dS5H64+meDZsRFd
UVOz7asl2B3olkHc+FAIN0JWeA9O5hS1RSWGtlgu13XWSk2eKmsANWJ9SSKH8qrc
7JNniuLHSE/NNyYM0xJHHrtbvXBbql1X6Fu7MD9hil/HaMXN61g5RkzEJycNGAJs
PL/TJCI=
=V5K+
-----END PGP SIGNATURE-----

--EcvOscvJC1OXN360p56kZHskGxFuQF43t--
