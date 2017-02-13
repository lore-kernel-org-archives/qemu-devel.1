Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdBBy-0003PX-8j
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdBBv-0005Ra-5V
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:36:58 -0500
References: <4c44ad5045020be90edfdc8787002e09691db1d3.1479770377.git.sam.bobroff@au1.ibm.com>
	<20170213053340.GC25381@umbus>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <602f2661-0d45-d135-e3f8-64426329a736@redhat.com>
Date: Mon, 13 Feb 2017 08:36:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170213053340.GC25381@umbus>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="I5aJVl8HCm6CP8uuS1a7XL07xJr1qnoRQ"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/1] hw/net/spapr_llan: 6
 byte mac address device tree entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5aJVl8HCm6CP8uuS1a7XL07xJr1qnoRQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 06:33, David Gibson wrote:
> On Tue, Nov 22, 2016 at 10:19:38AM +1100, Sam Bobroff wrote:
>> The spapr-vlan device in QEMU has always presented it's MAC address in=

>> the device tree as an 8 byte value, even though PAPR requires it to be=

>> 6 bytes.  This is because, at the time, AIX required the value to be 8=

>> bytes.  However, modern versions of AIX support the (correct) 6
>> byte value so they no longer require the workaround.
>>
>> It would be neatest to always provide a 6 byte value but that would
>> cause a problem with old Linux kernel ibmveth drivers, so the old 8
>> byte value is still presented when necessary.
>>
>> Since commit 13f85203e (3.10, May 2013) the driver has been able to
>> handle 6 or 8 byte addresses so versions after that don't need to be
>> considered specially.
>>
>> Drivers from kernels before that can also handle either type of
>> address, but not always:
>> * If the first byte's lowest bits are 10, the address must be 6 bytes.=

>> * Otherwise, the address must be 8 bytes.
>> (The two bits in question are significant in a MAC address: they
>> indicate a locally-administered unicast address.)
>>
>> So to maintain compatibility the old 8 byte value is presented when
>> the lowest two bits of the first byte are not 10.
>>
>> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
> Sorry, I didn't see this one until now.
>=20
> Since we need a workaround for the workaround, is it actually worth
> going to the 6-byte property?

8-byte addresses are just wrong, all other network devices and the
standard use 6-byte MAC addresses instead. So we should use 6-byte
addresses in QEMU whenever it is possible, too. Unfortunately there are
still guests in the field that use this bad assumption with 8 byte
addresses, so I think this work-around is the best we can and should do
right now.

 Thomas



--I5aJVl8HCm6CP8uuS1a7XL07xJr1qnoRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYoWISAAoJEC7Z13T+cC21RBsP/R4HUB8yGCALqL3L49YeCq07
ezJbihsxQm+8Ovp2zs/A/NCkHqf/cXaJqXThRuoXjFpAAC8GSH7XYenPbmWLih8R
d4Y5JVn7nfEXwgmfMLT04avtPXJK+H46/0NPUYa2H31oN+cW3nUU2qFxYzCCcprk
d7fJjI2WN+3bmmks1iZB5rX/3ZWmNiwMJP9J6ruD+NX63boGYSR1I0dsDKpuTjmz
DD9LAGwWH5XWBEnNhKha7NcVmMK/00zC1oQ23836JnJz3TQn64CX6y1MVgMA48K0
+oqeSAoLLimLjjGXHhk2Wynhtg84/jH+oAfvpFfYRvyTlylS/EPyBbsRG57TIRJM
v0cNsvBwReMxRleE083ZPGlOYIUmDDwD+ppeMV4D4Fg83UZOw/jeVLSDa4OmhhWA
1l6WnU9HLdu2F5eZdTL9Kcz/TwOJDqtDSqJT3g6Q7ak9izGhH42uBo0VM3WDVtcX
YmsEqrouXCk8nC1aXiNeI9Q+Qono23d3r4MIkv4Ez2z3GsDYU1XaptSRpDqoSxGG
4Dd7pqJHyfmtfGD1lbto6cXvRhxqPe4AJWT04rpAUhQd3W7tvjYX+6V7jowVYhS7
SDB6/AFuuRHk50sPod01dENdmak6H7nCGdhlLi5Vt/3DQzXRg+iHdDV68j434G7q
sXDSwXClZ3HwL0tzblT5
=OBb/
-----END PGP SIGNATURE-----

--I5aJVl8HCm6CP8uuS1a7XL07xJr1qnoRQ--
