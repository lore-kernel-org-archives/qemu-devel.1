Received: from eggs.gnu.org ([2001:4830:134:3::10]:44754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1emCKp-0005SF-4S
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 00:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1emCKm-00083a-Un
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 00:43:55 -0500
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:52872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1emCKm-00082Z-OW
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 00:43:52 -0500
Received: by mail-it0-x22f.google.com with SMTP id o13so17956123ito.2
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 21:43:50 -0800 (PST)
References: <20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
	<d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
	<9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
	<20180103000947.GE24581@umbus.fritz.box>
	<9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
	<20180110085958.GJ19773@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
Date: Thu, 15 Feb 2018 16:43:42 +1100
MIME-Version: 1.0
In-Reply-To: <20180110085958.GJ19773@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Y6ADZgaQbT7AAseWEMOukSOz01oOpZqY7"
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
--Y6ADZgaQbT7AAseWEMOukSOz01oOpZqY7
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
 <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
 <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
 <20171109063822.GD7732@umbus.fritz.box>
 <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
 <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
 <20180103000947.GE24581@umbus.fritz.box>
 <9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
 <20180110085958.GJ19773@umbus.fritz.box>
In-Reply-To: <20180110085958.GJ19773@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/01/18 19:59, David Gibson wrote:
> On Mon, Jan 08, 2018 at 07:35:43PM +1100, Alexey Kardashevskiy wrote:
>> On 03/01/18 11:09, David Gibson wrote:
>>> On Tue, Jan 02, 2018 at 05:13:09PM +1100, Alexey Kardashevskiy wrote:=

>>>> On 11/12/17 17:20, Alexey Kardashevskiy wrote:
>>>>> On 09/11/17 17:38, David Gibson wrote:
>>>>>> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wro=
te:
>>>>>>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
>>>>>>>> On 19/10/17 17:24, David Gibson wrote:
>>>>>>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy =
wrote:
>>>>>>>>>> On 16/10/17 20:36, David Gibson wrote:
>>>>>>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevski=
y
>>>>>>>>>> wrote:
>>>>>>>>> [snip]
>>>>>>>>>>> ||
>>>>>>>>>>>
>>>>>>>>>>> Yeah.. this is all a bit complicated, I'm really thinking abo=
ut a
>>>>>>>>>>> fdt_fsck() function for libfdt.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Oh. So what now? Do as below or wait for libdtc update?
>>>>>>>>>
>>>>>>>>> So I started hacking on this.  It's a bit fiddlier to get right=
 than I
>>>>>>>>> anticipated.  How about you make a placeholder function to "tes=
t" the
>>>>>>>>> tree for now, with a comment that it will be updated once the l=
ibfdt
>>>>>>>>> extensions are there.
>>>>>>>>
>>>>>>>> What would the placeholder do? Nothing or my proposed "FDT_CHK" =
thingy?
>>>>>>>>
>>>>>>>> Are we in a hurry with this one at all, or I can wait till libfd=
t gets this
>>>>>>>> fsck()?
>>>>>>>
>>>>>>>
>>>>>>> Ping?
>>>>>>>
>>>>>>> This is not v2.11 material, is it?
>>>>>>
>>>>>> Not at this stage, no.
>>>>>>
>>>>>> I've started looking at writing the fdt_fsck() thing, but got
>>>>>> sidetracked by a bunch of related fixes to safety of handling
>>>>>> corrupted blobs in libfdt.
>>>>>
>>>>> Please let me know when I can repost the "
>>>>> ppc/spapr: Receive and store device tree blob from SLOF" again. Tha=
nks.
>>>>
>>>>
>>>> Still to early to repost?
>>>
>>> No.
>>
>>
>> I looked at the recent libfdt (from qemu tree, sha1  e543880, v1.4.6) =
and
>> could not find fdt_fsck() or similar, and I was waiting for this reall=
y,
>> have I missed something?
>=20
> Oh, right, yeah, I haven't had time to look at that again.


Any progress with fdt_fsck()? Thanks,


--=20
Alexey


--Y6ADZgaQbT7AAseWEMOukSOz01oOpZqY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqFHg8OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkqZA/8DGzHhH5kvTZNo5Jo57HzU+fDZmiiLRejGUGy
Sb7Ee4R5h7xddFr/XN4tZlTnQVfST5o+gZx3Fh6K6QhPU0rKF46IWD9OQNjNjUfp
OuBCcv/V/x6eVMGKrqxa5jYzIrAiNt+ZQ1hrAX7/WKgQtjT76pPxv7XbtfhTn6CE
D/sfLhLLyR8AaOcaYYJRITWIruv6XD/DSGOliVcAjAaFvjl4o+FVyGq9SmW+f5MA
suJwvRiFKtH4ogC/0v3yZut/DNRXiJVUn5XxtQ3qg8R9dsseS5fJisKMPFrp2sXC
IQB02O+em5AIJtCir2Wd3PpQicuvNmrtlT2ufJo3jP6dzbWeEYlihw0xvpKkgrn4
c9xHlD/1gqVkrEMjjNy4IfSEOIcAiOsqt7evFc6w7Hu92oBlKenSfZlyG0JXeqYV
/eor12g53B9F/qkVrTdOiU9HOruoMct3SgbBJtvGZv+bdHDeEkV1gt4TllCB06K4
rRO24h/hMf5tfxMcAMtf3RTEqCJcUqmdJO5BwMC/xgarsPkpej535Qh66nJ6hzJg
XlWRdmLNlBU/JcDdG6Z1OkqBDeThI+/VjGxi+kLo+Epdw42RtQCmZvF+jWz7+UKr
bmyJP/c9SU5djaKeUmBspdcGXy8uzEN6BOpEZZe1qw3a4xb1roq+fFEelIGRQ1wD
P5SvKb4=
=ksYm
-----END PGP SIGNATURE-----

--Y6ADZgaQbT7AAseWEMOukSOz01oOpZqY7--
