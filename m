Received: from eggs.gnu.org ([2001:4830:134:3::10]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBy5R-0004kQ-3x
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBy5M-00088K-6o
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:14:17 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:47633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBy5M-000887-1D
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:14:12 -0500
Received: by mail-it0-x243.google.com with SMTP id p138so1232565itp.2
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 23:14:12 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
Message-ID: <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
Date: Tue, 7 Nov 2017 18:14:04 +1100
MIME-Version: 1.0
In-Reply-To: <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bhslmPEERewovJwxSWdMsk977qCv180V1"
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
--bhslmPEERewovJwxSWdMsk977qCv180V1
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016052004.31397-1-aik@ozlabs.ru>
 <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
 <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
In-Reply-To: <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/10/17 11:46, Alexey Kardashevskiy wrote:
> On 19/10/17 17:24, David Gibson wrote:
>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrote:
>>> On 16/10/17 20:36, David Gibson wrote:
>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
>>> wrote:
>> [snip]
>>>> ||
>>>>
>>>> Yeah.. this is all a bit complicated, I'm really thinking about a
>>>> fdt_fsck() function for libfdt.
>>>
>>>
>>> Oh. So what now? Do as below or wait for libdtc update?
>>
>> So I started hacking on this.  It's a bit fiddlier to get right than I=

>> anticipated.  How about you make a placeholder function to "test" the
>> tree for now, with a comment that it will be updated once the libfdt
>> extensions are there.
>=20
> What would the placeholder do? Nothing or my proposed "FDT_CHK" thingy?=

>=20
> Are we in a hurry with this one at all, or I can wait till libfdt gets =
this
> fsck()?


Ping?

This is not v2.11 material, is it?


--=20
Alexey


--bhslmPEERewovJwxSWdMsk977qCv180V1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAloBXTwOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILnqFBAAqI3HMjZkdx0N1fveMyVTa8UmRrM5KvLfOUzf
V7p/GMIut4a4ERnpR/slu9jLVSl34Yf+n+pLEtHTVKkE6QY+ylFi+44R7N+5nna7
bB5gL0fSNz4JNz074iUDD+2/F9RCXgfwccG+L/AWbJ5b5KxCjFr3JpC6z/Q63Ryd
b0wE4OI4SxrGF+6YfVc8HPKqMTWXO0jXXdHWGKczZo38u5K3hTT9MypW4pqc+pqS
BcnooWNf7uE1oR7Clx3jHKeGpZxrppuh9P99pfWwRgG6VhaPvDJyb9ZxDCiKopWw
R2Y4T/2sU0+sChNsh6QFkujYfgbGLrrEONe5IgCuz8+FPQni69VpcjQrLywkOozg
Xgkm9V70QzcZIIdo1OcBsoo0dGYMZ8TE6y1lDmajeO6GrdW7e84ZSFjVmyiFL/cf
kXLKVd+2TjdpPr8Lr/cLRutb/61j7AELgGZmHYIIj27s+9n+kO4CWh0zLDJY7IKA
5QaA2hMUPHReLBvXpnHUPRa/ci3oowZ6EAsSuQVPrfpI4k6mUikelYVvV8VI58Pq
/mGGdmjqYYPmlbj0Uzfb05PbOABUKAcF/zX62f9YcCC5NVgBeoAEM94ub6J9tvM5
0/LJxt4rg0kmr135ntF+TaoGi0ROGENlP132c80zrJO3o1xFOkLA761MmUN8TDJs
OhcSAfs=
=IPIg
-----END PGP SIGNATURE-----

--bhslmPEERewovJwxSWdMsk977qCv180V1--
