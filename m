Received: from eggs.gnu.org ([2001:4830:134:3::10]:47211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eUPYB-0005S7-IA
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eUPYA-0000Wt-5S
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:12:11 -0500
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<f16023f8456fc137647cd6c60d5e2138d8a9afa2.1511731946.git.mdavidsaver@gmail.com>
	<20171130051315.GF3023@umbus.fritz.box>
	<b0ded63a-f654-94c4-4fef-3cdbf7764a97@gmail.com>
	<20171206111449.GF3057@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <5ecfd943-d0af-03cc-3945-772fd4de3e8d@gmail.com>
Date: Wed, 27 Dec 2017 22:11:55 -0600
MIME-Version: 1.0
In-Reply-To: <20171206111449.GF3057@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1o8p4Lie8mkVl0VREEP2wqeTXTHe5X31f"
Subject: Re: [Qemu-devel] [PATCH 05/17] timer: generalize Dallas/Maxim RTC
 i2c devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1o8p4Lie8mkVl0VREEP2wqeTXTHe5X31f
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <5ecfd943-d0af-03cc-3945-772fd4de3e8d@gmail.com>
Subject: Re: [PATCH 05/17] timer: generalize Dallas/Maxim RTC i2c devices
References: <cover.1511731946.git.mdavidsaver@gmail.com>
 <f16023f8456fc137647cd6c60d5e2138d8a9afa2.1511731946.git.mdavidsaver@gmail.com>
 <20171130051315.GF3023@umbus.fritz.box>
 <b0ded63a-f654-94c4-4fef-3cdbf7764a97@gmail.com>
 <20171206111449.GF3057@umbus.fritz.box>
In-Reply-To: <20171206111449.GF3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 05:14 AM, David Gibson wrote:
> On Sun, Dec 03, 2017 at 03:15:10PM -0600, Michael Davidsaver wrote:
>> On 11/29/2017 11:13 PM, David Gibson wrote:
>>> On Sun, Nov 26, 2017 at 03:59:03PM -0600, Michael Davidsaver wrote:
>>>> Support for: ds1307, ds1337, ds1338, ds1339,
>>>> ds1340, ds1375, ds1388, and ds3231.
>>>>
>>>> Tested with ds1338 and ds1375.
>>>>
>>>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>>>
>>> I certainly like the idea of consolidating this code, but reviewing t=
o
>>> see that the new code really is a generalization of the old is
>>> something I won't have time for for a while.
>>>
>>> Also, hw/timer is not within my purview so it'll probably need to go
>>> another path to merge.
>>
>> Could you be a bit more explicit about what, if anything, I need to do=

>> to move this forward?
>=20
> Ugh.. that's pretty tough, since ds1338 doesn't have an activate
> maintainer.  You can look at the git history for some possible
> candidates of people to ask about it, but it hasn't been touched much
> in quite a while.
>=20
> One approach that could help is to re-order so that your testing
> rework goes before the change to ds1338.  If your new generalization
> can pass the same set of tests as the original ds1338 code, that's at
> least a good start on being convincing that it's a true superset of
> the previous functionality.

A slight wrinkle is that my testing found two bugs with the original
ds1338 model (also one in my new code).  The two don't seem
significant practically.  It actually isn't possible to switch to
12-hour mode.  And there is an obscure off by one situation possible
with wday_offset and timezones.  Of course most guests use 24-hour mode
and ignore the RTC day-of-week.

The upshot of this is that several test cases now fail when run against d=
s1338.c.

My recommendation would be to start by looking at the test code.
This could be compared against guest code.  When I send the next
iteration I'll include some links.

> The other approach is to do the rework in a rather longer series of
> patches.  Start by simply moving ds1338.c, then do a mechanical
> replacement of the names within it, then start generalizing and
> altering.  That's a lot of work for you, but it makes it much easier
> to review each step

I know from my first foray into QEMU land that this is preferable for rev=
iew.
Unfortunately, I expanded from my previous ds1375 model instead of the ds=
1338.


--1o8p4Lie8mkVl0VREEP2wqeTXTHe5X31f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAlpEbwsACgkQlAHmyz1/
GOq3mA//X6atXidZEUaJBr/s2L38r+x8j3aY246gIIGfFN1K7RB+cfipHds+cAuJ
et7eSTu7Yf3QCA2R0bJdtUuokMO240ZS+1zn/a9qvfDDBoZdjZhM64LcYqQwL29E
FdDO/x/XN5+A8e4sBUs+TpYNENGEoqLBqVZbsPdshulUXTBXS51XODfI+78NCesO
KD+cUV4qGLclPsW0Ws/181vfW4yFXTUq1af2YlNEWzKTDToxSLVpuxRKYynNw9n3
PR69oZuwXO8HZxTn2EbGyItBH+uAjeKVfb0vTjdbFPHyK5g510oOv6uTynjsS/9s
XNLCiwST53+4P3adF0CjL7v5iOj/WTSd2L6i9EfNPDikY0WIvTQgFV+sJpAzPpkF
oOABI0hwV/5JZbBYy268kdAy9MGIJVEu6EazYRhB87Cwkmx3bndIANirvgEWO/TG
233g6/D1NtUQv+aHqhrBxpFbL5FRJ/dclGgVby418IW8EULOjGSs3iEbR52nQupv
6Txp/j/JWJ3QuOatYjwG5mu/EUE0vtkIDFmUwvvXZDMKFG+j1E7gVo0zC/AfSONO
oa/Bl8V85POo7qgHsktPKwEpTOPo3g+Jsz9Zfcvhg1du17CL4AdDzQYmIvHKphNr
xWKYMV+1IpPkGzVs6NKcqFcnd9w2ZmszuU10n3ngQeBpjIz/9K0=
=3uje
-----END PGP SIGNATURE-----

--1o8p4Lie8mkVl0VREEP2wqeTXTHe5X31f--
