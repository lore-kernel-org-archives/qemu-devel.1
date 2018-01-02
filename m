Received: from eggs.gnu.org ([2001:4830:134:3::10]:46251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWFpB-0001ov-7J
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWFp7-0001I2-Vz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:13:21 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eWFp7-0001Hm-PW
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:13:17 -0500
Received: by mail-io0-x244.google.com with SMTP id n14so24716161iob.4
	for <qemu-devel@nongnu.org>; Mon, 01 Jan 2018 22:13:17 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
	<d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
Message-ID: <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
Date: Tue, 2 Jan 2018 17:13:09 +1100
MIME-Version: 1.0
In-Reply-To: <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T1O2CXFfT7v8NWoHT3Bp0shr5P7Stp9VT"
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
--T1O2CXFfT7v8NWoHT3Bp0shr5P7Stp9VT
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
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
In-Reply-To: <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/12/17 17:20, Alexey Kardashevskiy wrote:
> On 09/11/17 17:38, David Gibson wrote:
>> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wrote:
>>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
>>>> On 19/10/17 17:24, David Gibson wrote:
>>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrot=
e:
>>>>>> On 16/10/17 20:36, David Gibson wrote:
>>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
>>>>>> wrote:
>>>>> [snip]
>>>>>>> ||
>>>>>>>
>>>>>>> Yeah.. this is all a bit complicated, I'm really thinking about a=

>>>>>>> fdt_fsck() function for libfdt.
>>>>>>
>>>>>>
>>>>>> Oh. So what now? Do as below or wait for libdtc update?
>>>>>
>>>>> So I started hacking on this.  It's a bit fiddlier to get right tha=
n I
>>>>> anticipated.  How about you make a placeholder function to "test" t=
he
>>>>> tree for now, with a comment that it will be updated once the libfd=
t
>>>>> extensions are there.
>>>>
>>>> What would the placeholder do? Nothing or my proposed "FDT_CHK" thin=
gy?
>>>>
>>>> Are we in a hurry with this one at all, or I can wait till libfdt ge=
ts this
>>>> fsck()?
>>>
>>>
>>> Ping?
>>>
>>> This is not v2.11 material, is it?
>>
>> Not at this stage, no.
>>
>> I've started looking at writing the fdt_fsck() thing, but got
>> sidetracked by a bunch of related fixes to safety of handling
>> corrupted blobs in libfdt.
>=20
> Please let me know when I can repost the "
> ppc/spapr: Receive and store device tree blob from SLOF" again. Thanks.=



Still to early to repost?


--=20
Alexey


--T1O2CXFfT7v8NWoHT3Bp0shr5P7Stp9VT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpLIvYOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILmBqBAAnEPgmtY0D/zzUpXT583dqDTzFcJmfBBPl7Z2
WmEChgB2caJnPtBW4BktD0tU/OYIcIGm3/JlLj1zZ6Wmdbd12dvwpSt6/X7vkmw6
iPQDKIeyEgTuIW4Cz9zzkSLfNhCBVCSQeRL1B6bNjh/+EQTKTS4/lKEJz94s3VuO
PGqMmRdo4cAIP3lyLQVKN2/VxVC7driv13ysjPCIJSpWH3v+jCkULO+32Z5IKcjt
1b48dNn68YS9n5Op90YZcaeM/6GJqXX21FLwy+7IxRM4EZeHE3WASoJRfpVXtjJZ
ztHGkz9d698mwkstoa31s9ogXphhCFuPXX/lYQQQoVoO9+i+YsqsahLKHf/ngXMV
NbVtQUrmuC3S8WbZSuPLKrNVrpZ8W/XpKSgE3evSlgR7cMbZW247UDS0/gfvdln/
7I+e6hBy/nkc6UdnodMtGa6NMIGp3tMZ1GTAXuEeuGRLKJNexYrvQFDZqBJkWHD3
5zg4FBlYBo7j4ZI1A1BNM9nId3+RPKPy3NB/Y/3TBzqkq8e46p3rxuhnJpFRLKlh
gdzupESefLt3KInF3R/QpGStlfCmUYZZPLCjK8mYrBqgfUcu5qNofLAv0c8ErkWm
hchcbyvnqVKmyZN9J0roKeZaYn2h2DYrQIvTIjT/hgDDf2XxWQM7d2tfhCNnMudu
uaMCkHo=
=oswB
-----END PGP SIGNATURE-----

--T1O2CXFfT7v8NWoHT3Bp0shr5P7Stp9VT--
