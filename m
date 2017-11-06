Received: from eggs.gnu.org ([2001:4830:134:3::10]:43330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1eBdpg-0007ts-Nb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1eBdpc-0006wY-Lv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:36:40 -0500
Date: Mon, 6 Nov 2017 11:35:28 +0200
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20171106093528.7wwyxff5psaabc4a@postretch>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuanjfop.fsf@maestria.local.igalia.com>
	<515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="447segmtxkt4plwn"
Content-Disposition: inline
In-Reply-To: <515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>


--447segmtxkt4plwn
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2017 at 09:26:17AM -0500, Eric Blake wrote:
>[adding Markus, and block list]
>
>On 10/13/2017 09:16 AM, Alberto Garcia wrote:
>> On Mon 02 Oct 2017 04:33:28 PM CEST, Pradeep Jagadeesh wrote:
>>> This patch factors out code to use the ThrottleLimits
>>> structure.
>>
>>>  { 'struct': 'BlockIOThrottle',
>>> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'i=
nt',
>>> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
>>> -            '*bps_max': 'int', '*bps_rd_max': 'int',
>>> -            '*bps_wr_max': 'int', '*iops_max': 'int',
>>> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>>> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>>> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>>> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>>> -            '*iops_size': 'int', '*group': 'str' } }
>>> +  'base': 'ThrottleLimits',
>>> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
>>
>> So BlockIOThrottle used to have parameters named bps_rd and iops_wr, and
>> after this patch they become bps-read and iops-write. This breaks the
>> API completely, as you can see if you run e.g. iotest 129:
>>
>> AssertionError: failed path traversal for "return" in "{u'error': {u'cla=
ss': u'GenericError', u'desc': u"Parameter 'iops_rd' is unexpected"}}"
>>
>> I just checked previous versions of the series and I see that Manos
>> already warned you of this in v11:
>>
>>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04698.html
>
>On the bright side, ThrottleLimits is marked 'since 2.11' (added in
>commit 432d889e), meaning it has not yet been released, so we CAN fix
>the naming in ThrottleLimits to be compatible with BlockIOThrottle if we
>want to share the type, as long as we get it done before the 2.11
>release.

We decided to keep BlockIOThrottle separate from ThrottleLimits because=20
that would break the old I/O throttling API, just like is done in this=20
patch series.  BlockIOThrottle is the one using old naming conventions=20
so I think it should be the one to go, if that has to be done.

But this all boils down to whether the legacy throttling API has to=20
break in 2.11 or not, which probably is the maintainer's decision.


>It does mean tweaking Manos' code to use compatible names
>everywhere, but that may be a wise course of action (we tend to favor
>'-' in new API names unless there is a strong reason to use '_'; but
>sharing code for maximum back-compat would be a reason to use '_').
>
>--=20
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>




--447segmtxkt4plwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAloALOAACgkQc2J8L2kN
9xB11hAAnnaSjeCG3pc+JW3QsIiPFQB02l9AfJlCyazY7rNKRQJMzV55DGxoYOUL
IozOBGRzWPgTJfenYr7oojmgyporxKAEeFJQgGiK8Od+d+3uPmdvjXlZAj5sH5co
TMtYrFBmNdahsIWw9f4hAC6AnQIbx87M1nztR5NhrHWzfHHcAzD9Sbp10FTDqPLX
NxmDd2y0k/8TgLmZccMGNEC2zav2Kx1IS5WIcwgZIYRb2jmQ8hxwYSrWbLL7VT2M
EeLcgamI3X3Nt8jVGfWlRMj3OWBAJrnF54Da7a2uis4zfiyOT7YGa62EXp3OWoKj
giNup121es7CJMh8ACIvdBQB3bjRZj0YqQvEPqofTpFGmhHK0+O6TobAtBDpu7mM
G2tEAjX8KDsGIY1eRuF0kCvJ8Cnzs0Yy+QjxVwZW7ju4loD/eEdxu5BcKc23uEpY
nVnGxhWOA8BJCL4kONy9rkvdznmRPnPAg/rNH6f/8/Sg9fHQ4zxyRxDGHVLWe17L
E91KTZ+d3VzHeBT5V+FylxhxG0xXSzprCYTTwSF6OxwfzPIQkcfweYyKBq50R9BJ
qsFYZ5qGtI1SGKXbyxkBdgtC2410kMbHXnJdovWMX0p/0wOyCmthbZ8DWkIfD6jk
H425yKI0Ob92oP6J4RYQWLZkNiZDN0b1w4Q6zqqLz6oJf2qrZL8=
=WwyQ
-----END PGP SIGNATURE-----

--447segmtxkt4plwn--
