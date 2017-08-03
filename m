Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddGZV-0002VA-S9
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddGZU-00069P-Qn
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:53:53 -0400
Date: Thu, 3 Aug 2017 16:52:53 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170803135253.s2u6ut5hvrbupxao@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-8-el13635@mail.ntua.gr>
	<20170803080750.GB4456@dhcp-200-186.str.redhat.com>
	<20170803132455.bth53wkxr35imfhd@postretch>
	<20170803133258.GI4456@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aalczojz7evddsmc"
Content-Disposition: inline
In-Reply-To: <20170803133258.GI4456@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: add throttle block filter
 driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--aalczojz7evddsmc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 03:32:58PM +0200, Kevin Wolf wrote:
>Am 03.08.2017 um 15:24 hat Manos Pitsidianakis geschrieben:
>> On Thu, Aug 03, 2017 at 10:07:50AM +0200, Kevin Wolf wrote:
>> > Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
>> > > Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> >
>> > I would add at least two more cases:
>> >
>> > * Both limits and throttle-group are given in blockdev-add
>> This exists in the "property changes in ThrottleGroup" section,
>
>You're right, I missed this. The test result shows that this command
>succeeds. Do we really want to allow other nodes to be affected with a
>blockdev-add? Wouldn't it be cleaner to just forbid the combination of
>limits and throtte-group?

So basically only anonymous, immutable groups can be created through the=20
driver then. All other shared group configurations must be explicitly=20
created with an -object / object-add syntax. I think this is a neat=20
separation and compromise if we allow anonymous groups. If not, we can=20
ignore limits on the throttle driver.


>> > * limits and throttle-group are both missing
>> this creates an anonymous group with no limits. Should we fail at this c=
ase?
>
>I'm not sure, you could argue either way. But there should be a test to
>check that the semantics won't change.
>
>If we're going with Stefan's suggestion that anonymous groups shouldn't
>exist, then the question is moot anyway.
>
>> > It would also be nice to test that query-block reflects the new thrott=
le
>> > group limits correctly when they are changed after the fact.
>>
>> This belongs to the remove legacy patch, since query-block displays the
>> legacy limits.
>
>Ok, fair enough.
>
>Kevin



--aalczojz7evddsmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmDKrUACgkQc2J8L2kN
9xCd3xAAnyrhettncfep3CKcg154JI09G9fxEuFu7cAT4ytvJysbFAcQYOwYGhd1
CEZfb7lw1tYDpSV2jCN4h1cCPWI/dsGlzrIbB0lARq7N6YnoryKLTkgJtfvzBBOs
KHRIPePf6gpWPWQHd/jRCH7XJsFUKtM6cVm95xsf3mWkn3nGz87ISjm2WUiXiXzA
s4qQoLyYQQzcLTaTm+DCIWvu7YVyzV4ndkfdyKnOlFiolAEL++8YXZGOEubkZSSg
nw4dGJ2HFuHrbmn9xycyGekn6ClekOWK2FU/lx+owjwQ/nmrV2Z2C/5goMclm/yH
RbE94QQYhK3JypAw9FIeSAX2mZaGA01pYhW5ycuTU5AMvKkU5tOsgLKc8wXHdEnk
CBej7Vzm95FKMOKcMov7DwS+8Vd2r3CKNlOiBCnBjHMM+4vvwm7qzFoIZaR32QFr
QWsjrk0kWYY/tUYINDxV2z/DSAQ9TqsubEdL+8rc3SWEE7eE1mUXTmuNfMivFDZs
rVy2iwY4Gc9Oc1o6RkuWggBwzd2LBUsnGtLn4oiiwz3KSC/Vvahk9Py71kwf1UYc
xyB4LrbZbYdythcidl78hO+ienWUoB1a80ME+QuCZdT3bArHox6rHhvYG5LA1znj
vwFObi/2f54djcGnLMJMWM+PI5vT62oGa1FpLlMwEcoOYCQmSD8=
=RO9h
-----END PGP SIGNATURE-----

--aalczojz7evddsmc--
