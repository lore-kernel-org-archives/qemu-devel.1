Received: from eggs.gnu.org ([2001:4830:134:3::10]:52051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daQyw-0007tL-UF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daQyw-0004KU-18
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:24:26 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
	<20170726175808.GD3600@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ecbf4c6b-64e0-7878-380a-262753068cb0@redhat.com>
Date: Wed, 26 Jul 2017 14:24:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170726175808.GD3600@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ktAWILw7ksMO86x0D1qG0AmLLkl7iuk4f"
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktAWILw7ksMO86x0D1qG0AmLLkl7iuk4f
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <ecbf4c6b-64e0-7878-380a-262753068cb0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721123325.GC18014@stefanha-x1.localdomain>
 <20170721140155.GQ17693@redhat.com>
 <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
 <20170725154921.GS23343@stefanha-x1.localdomain>
 <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
 <20170726175808.GD3600@stefanha-x1.localdomain>
In-Reply-To: <20170726175808.GD3600@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/26/2017 01:58 PM, Stefan Hajnoczi wrote:
> On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
>> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
>>> On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
>>>> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
>>>>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
>>>>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>>>> Without the static capabilities defined, the dynamic check would be
>>>> influenced by the run time environment.  It would really mean "qemu-=
io
>>>> running on this environment (filesystem?) can do native aio".  Again=
,
>>>> that's not the best type of information to depend on when writing te=
sts.
>>>
>>> Can you explain this more?
>>>
>>> It seems logical to me that if qemu-io in this environment cannot do
>>> aio=3Dnative then we must skip those tests.
>>>
>>> Stefan
>>>
>>
>> OK, let's abstract a bit more.  Let's take this part of your statement=
:
>>
>>  "if qemu-io in this environment cannot do aio=3Dnative"
>>
>> Let's call that a feature check.  Depending on how the *feature check*=

>> is written, a negative result may hide a test failure, because it woul=
d
>> now be skipped.
>=20
> You are saying a pass->skip transition can hide a failure but ./check
> tracks skipped tests.  See tests/qemu-iotests/check.log for a
> pass/fail/skip history.
>=20

You're not focusing on the problem here.  The problem is that a test
that *was not* supposed to be skipped, would be skipped.

Let me reinforce my point, and you can address it directly:  feature
checks like you proposed can easily produce false negatives.  Not
something hypothetical or far fetched, I gave very reasonable examples
on this same thread.

Do you think that's OK because the skip count will get an increment?
That's exactly one of the main concerns raised in the original thread (
and break room conversations) that motivated this experiment.

> It is the job of the CI system to flag up pass/fail/skip transitions.
> You're no worse off using feature tests.
>=20
> Stefan
>=20

What I'm trying to help us achieve here is a reliable and predictable
way for the same test job execution to be comparable across
environments.  From the individual developer workstation, CI, QA etc.

Please let me know If you really believe this should *not* be done here
(upstream QEMU).

Regards!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--ktAWILw7ksMO86x0D1qG0AmLLkl7iuk4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZeN5CAAoJEGV+jTOl8gnz1VYQALVsnkFvgqT69occwlGp2sqZ
NznefO6vX0n/JSQb3RoyrqFpItlutPpYc7iKOsxTn8kRl6BMrzuw5XNfeSjQnRm8
fJ/65oc+sgOvhpfu7/pSNGgvoWW4Nw+KMTOErKYzBLuha0gkPjURtbIrUFfkikp4
6glhD//Pe1z7MFwOdAWdXrZk0q6neKuagfUMEh+W+dx9XfNdLQn2N95WD4po2jAz
dUbAgpzQ/GKOA2u0mlbSfDu4hzFHCaHw9IVgDHoY447QImYJda4vutC4GC1zApOf
XI7w35IB99BWQ/uiq3nvnss1wIXoGga6kwp2cKDZQpgwybM9Wn5IUNLia58gspGs
inj4pZ5qsMo5e9HX2e9qpIdrLjcQrqUjRKN0YrSC0AKzddzgq5QaEz1WWKvUzV9i
X1BbUhcU+hzhiKNPyC1+kHsx28mBmKfYS+0bOC4F9F9H6xO2Ig1jk1+BFwFsVRT5
MwMVSjxZpl7KQHTrYzhPCdP/b7dVr/cJR8UqYekwwlWbXQXPNeT1ReJjo7HjDe+g
rAFt3H/t4LYh+bz1+WxBsuVuJZ9BhAhaTjnpOOgT3c9mUad0I1Is7hpinMpeDhR1
E4/75NGeHyxcyqq5hnNHIDfw/7POiHHRYB6Vj741h3v5SxxstbkxVsSBMi+l+yny
KvTkyZcmURbMHnreIdMc
=u1E6
-----END PGP SIGNATURE-----

--ktAWILw7ksMO86x0D1qG0AmLLkl7iuk4f--
