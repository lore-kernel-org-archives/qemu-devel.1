Received: from eggs.gnu.org ([2001:4830:134:3::10]:33090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e5LSb-000300-Qt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e5LSY-0003s6-Nw
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:46:49 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e5LSY-0003r3-Eu
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:46:46 -0400
Received: by mail-pf0-x243.google.com with SMTP id a8so8495546pfc.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 17:46:45 -0700 (PDT)
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
Date: Fri, 20 Oct 2017 11:46:38 +1100
MIME-Version: 1.0
In-Reply-To: <20171019062440.GY2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iK1Om1lVXWcFpulX8lGTDORK0tgbF2K6f"
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
--iK1Om1lVXWcFpulX8lGTDORK0tgbF2K6f
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016052004.31397-1-aik@ozlabs.ru>
 <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
In-Reply-To: <20171019062440.GY2776@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/10/17 17:24, David Gibson wrote:
> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrote:
>> On 16/10/17 20:36, David Gibson wrote:
>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
>> wrote:
> [snip]
>>> ||
>>>
>>> Yeah.. this is all a bit complicated, I'm really thinking about a
>>> fdt_fsck() function for libfdt.
>>
>>
>> Oh. So what now? Do as below or wait for libdtc update?
>=20
> So I started hacking on this.  It's a bit fiddlier to get right than I
> anticipated.  How about you make a placeholder function to "test" the
> tree for now, with a comment that it will be updated once the libfdt
> extensions are there.

What would the placeholder do? Nothing or my proposed "FDT_CHK" thingy?

Are we in a hurry with this one at all, or I can wait till libfdt gets th=
is
fsck()?


--=20
Alexey


--iK1Om1lVXWcFpulX8lGTDORK0tgbF2K6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlnpR24OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkJcg/8C/s086Ux2vWbk3RxTOHwjXLlr7GGn3sqUqOd
6hO0s6aBCzwFMV18yOVrf/KlKOLZiDX0uSyfsdFQw8m/5eWDoCcqrSIZLruP/Htt
AyX3X1TXNKR4I1ZmjB9iZI0bg6zVcq9BG03gxfsoZNbBg/RXhRs7wfZllhJNJzWQ
85kdICZ3KqD/0UMDRv/RNA8HqoBupZpyzoamehLd3U4imQ7EMJlhH0Ol4fuKtxK6
86UuL4qCiyl3kE3MQI6J4n/6McjwhAjTJbKkFi3P4C7JbqARjN90z0xzg8TOh5bu
ea8rkJhR6aEHsreRR1Y3AgOnWhBXlmuoawINVztn45JjOnHCo2bpG2vAx2ZW4JnL
IhVzbtBOmnqQwtvVzh69TdbS8bdKXY4XrL0llpkRHeFgA1AAzs5fkPnjS96Vvi7Y
xXIKwBjmF2KJtPIz5t4tGzexHaxjwI6dV8KA9eccMbgjlaIpLlf7AYRxd0sAYc1R
f6cf7T1qxtYRna7TxyiT5YTO4aua6OC0mtGsf3yFaF4UUXVCeegZZ/KhRPpjEvhk
KOrLUhL9a4jcwwdL1yBXJusmFJ5zfrTwqSvnyrEigGe7rhK719NkLHTghxxAv8bg
5FSminlnXfbZI+IlH6e2pmOdzYt7HtXaLdNkZ9tmaxmaV0oCSzdS3MwFb/Tp6AFY
LZRRckw=
=EsBd
-----END PGP SIGNATURE-----

--iK1Om1lVXWcFpulX8lGTDORK0tgbF2K6f--
