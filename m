Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dXraf-0008Ao-Lx
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dXrab-0001QY-5E
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dXraa-0001Py-Rd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:12:41 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
	<ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
	<ed31f3b8-a754-deca-beae-55e98ce2e9f3@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <76fa400d-aa84-9d3d-477c-46f8d92aa254@redhat.com>
Date: Wed, 19 Jul 2017 12:12:32 -0400
MIME-Version: 1.0
In-Reply-To: <ed31f3b8-a754-deca-beae-55e98ce2e9f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KvXHAiQUNt52MB7WA1ccaf85wXhgCeEpf"
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KvXHAiQUNt52MB7WA1ccaf85wXhgCeEpf
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>
Message-ID: <76fa400d-aa84-9d3d-477c-46f8d92aa254@redhat.com>
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
 <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
 <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
 <ed31f3b8-a754-deca-beae-55e98ce2e9f3@redhat.com>
In-Reply-To: <ed31f3b8-a754-deca-beae-55e98ce2e9f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/18/2017 05:47 PM, John Snow wrote:
>=20
>=20
> On 07/18/2017 05:22 PM, Cleber Rosa wrote:
>>
>>
>> On 07/18/2017 02:07 PM, John Snow wrote:
>>>
>>>
>>> On 07/17/2017 11:01 PM, Jing Liu wrote:
>>>> Hi all,
>>>>
>>>> Do you anybody have iotests failure: 188, 189 and 087 of the latest =
qemu
>>>> upsteam?
>>>>
>>>> I just wondered if it has something wrong with my test machines beca=
use
>>>> I have different results with two machines.
>>>>
>>>>
>>>> Thanks.
>>>>
>>>> Jing
>>>>
>>>>
>>>
>>> Presumably you are missing aio=3Dnative support for 087,
>>>
>>
>> I see 6 different "tests" as part of 087, and only one them requires A=
IO
>> support ("aio=3Dnative without O_DIRECT"), which can fail like this:
>>
>> --- /home/cleber/src/qemu/tests/qemu-iotests/087.out    2017-07-17
>> 19:33:26.409758360 -0400
>> +++ 087.out.bad 2017-07-18 17:01:37.736038689 -0400
>> @@ -27,7 +27,7 @@
>>  Testing:
>>  QMP_VERSION
>>  {"return": {}}
>> -{"error": {"class": "GenericError", "desc": "aio=3Dnative was specifi=
ed,
>> but it requires cache.direct=3Don, which was not specified."}}
>> +{"error": {"class": "GenericError", "desc": "aio=3Dnative was specifi=
ed,
>> but is not supported in this build."}}
>>  {"return": {}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "SHUTDOWN", "data": {"guest": false}}
>>
>> Failures: 087
>> Failed 1 of 1 tests
>>
>> When either "--disable-linux-aio" is given or when libaio headers are
>> missing, which in the end means that CONFIG_LINUX_AIO won't be set in
>> config-host.mak or config-host.h.
>>
>>> and 188/189 I believe require compression and/or LUKS libraries.
>>>
>>
>> I did not check if/which optional configure time option would end up
>> disabling LUKS support and affecting those tests, but it's possible th=
at
>> something similar exists.
>>
>>> These are false positives caused by missing libraries. We should
>>> probably work out a proper solution to meaningfully skipping tests we=

>>> didn't compile support for.
>>>
>>> --js
>>>
>>
>> I see issues here:
>>
>> 1) The qemu-iotests "runner", that is, "./check", understands that a
>> file number is a test.  No further granularity is (currently?)
>> achievable here.
>>
>=20
> Yes.
>=20
>> The easy solution would be to split tests which depend on optional
>> features to separate test files.  In the 087 test given as example,
>> the "=3D=3D=3D aio=3Dnative without O_DIRECT =3D=3D=3D" block would be=
come, say, 190.
>>
>=20
> Are we married to the numbers? Can we do 087a, 087b? Or even start
> naming them so we can organize them in some meaningful sense?
>=20

Yes, check only understands numbered tests.  Naming a test "087a"
currently makes it run "087" instead.  And asking it run "abc" results
in "000 - unknown test, ignored".

Of course the limitation could be lifted, but there's at least one
feature that I'm aware that would be impacted: running test ranges (say,
012-021).  With test being sequentially added, and with the existence of
groups, I really wonder if ranges still make any sense.

>> 2) Skip tests based on features more easily.  There's already support
>> for skipping tests on various situations.  From 087:
>>
>> ...
>> _supported_fmt qcow2
>> _supported_proto file
>> _supported_os Linux
>> ...
>>
>> It's trivial to also have access to other compile time settings.  I di=
d
>> a quick experiment that would add a "_required_feature" function to
>> "common.rc".  For 087 (or 190?) it would look like:
>>
>> ...
>> _supported_fmt qcow2
>> _supported_proto file
>> _supported_os Linux
>> _required_feature CONFIG_LINUX_AIO
>> ...
>>
>> Does it make sense?  Would a patch series along those lines would be
>> welcomed by reviews?
>>
>> Thanks!
>>
>=20
> Makes a lot of sense to me, but it would be nice to differentiate the
> output from the ./check script into some broad categories:
>=20
> (1) We ran the test(s), and it/they passed!
> (2) We ran the test(s), and it/they failed.
> (3) We didn't run the test, but that's OK (e.g. ./check -v -raw for a
> test that only supports qcow2; that is, it's normal/expected for this
> test to have been skipped in this way)
> (4) We didn't run the test, and this is a coverage gap (e.g. libaio
> support missing, so we cannot meaningfully test.)
>=20
>=20

I understand how you see #3 and #4 differently when a "test coverage"
policy is applied to the scene.  Writing tests that can adapt to
different policies is possible, but the policy itself should really live
elsewhere.  This simplifies the test itself, and makes #3 and #4
basically the same thing.

For instance, let's suppose "./check" gets a "-skip-features=3D" option,
which, to implement the default policy of complete coverage, defaults to
an empty list.  The test itself could contain something like:

  skipIf("libaio" in skip_features)

The default policy on a platform that lacks libaio, would be one with
'-skip-features=3Dlibaio'.

On scenarios where complete coverage is *expected* ("skip_features" is
empty), the lack of libaio on such a test *demands* an ERROR.  On test
frameworks that distinguish between ERRORs and FAILures, this means that
the test code itself could not be run successfully and this demands an
action from whoever is running the test (installing libaio and/or
running configure with --enable-linux-aio).

> Importantly, 3 and 4 are very different and we only support 1-3 today.
> Most people run ./check -qcow2 or ./check -raw (if they run iotests at
> all) but that still leaves some protocols and formats in the lurch, but=

> they're fairly regularly skipped regardless.
>=20

Right.  Combining different parameters and thus expanding test coverage
(leaving nothing, or as little as possible, in the lurch) is a very
interesting topic.  My quick words about it is that it's possible to use
tools to combine protocols, formats and what else automatically, while
still making obvious exclusions.

> We have no "run EVERYTHING!" invocation that does raw, qcow2, luks (and=

> everything!!) all at once, so "SKIPS" currently have the semantic meani=
ng:
>=20

Using a tools I'm familiar with, I create a
"$QEMU_SRC/tests/qemu-io-tests/complete-coverate.yaml" with the
following content (really a copy and paste from ./check --help):

---
format: !mux
  raw:
  boochs:
  cloop:
  parallels:
  qcow:
  qcow2:
  qed:
  vdi:
  vpc:
  vhdx:
  vmdk:
  luks:

protocol: !mux
  file:
  rbd:
  sheepdog:
    !filter-out : /run/format/cloop
  nbd:
  ssh:
  nfs:
  vxhs:
---

This "policy" combines all formats with all protocols, but excludes
cloop+sheepdog, which (let's suppose), are known to be incompatible.
Again, using the tool I'm familiar with, I'd run my "complete coverage" j=
ob:

 $ avocado run 001 002 -m complete-coverage.yaml
 ...
 (001/166) 001;raw-file-4e7c:  PASS (0.01 s)
 (002/166) 001;raw-rbd-c698:  PASS (0.01 s)
 (003/166) 001;raw-sheepdog-9705:  PASS (0.01 s)
 (004/166) 001;raw-nbd-1420:  PASS (0.01 s)
 (005/166) 001;raw-ssh-ed68:  PASS (0.01 s)
 (006/166) 001;raw-nfs-ce6b:  PASS (0.01 s)
 (007/166) 001;raw-vxhs-7003:  PASS (0.01 s)
 (008/166) 001;boochs-file-efcb:  PASS (0.01 s)
 ...
 (166/166) 002;luks-vxhs-e2cf:  PASS (0.02 s)
 ...

Rest assured that neither "001;cloop-sheepdog-XXXX" or
"002;cloop-sheepdog-XXXX" are in the resulting test list.

> "I didn't run this, but it's not a big deal, really."
>=20

Again, IMO, SKIPs should be OK if they are intentional.  Otherwise,
there should be test ERRORs.  And, using the example given above, it'd
be possible to not even attempt to run tests that are *known* to not be
compatible with a given environment.

> If we start skipping tests because of missing libraries or compile
> options, some skips take on the meaning:
>=20
> "We didn't run this, but that means you didn't test some stuff that you=

> really ought to have."
>=20
> I guess the key difference here is:
>=20
> (1) The first skip mode doesn't change depending on what your
> environment is, it only changes based on what you ask it to run, but
>=20
> (2) These skips are environmentally dependent, and should be visually
> identified as failures of the test runner to even attempt the test,
> which is semantically rather distinct from (1) above
>=20

Again, I think what's missing is:

1) a layer above the test itself to determine what should be run
2) a better differentiation between a test SKIP/ERROR/FAIL.

> Clear as mud?
>=20

A lot clearer... now I hand the same question back to you!

- Cleber.

> Great!
>=20
> --js
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--KvXHAiQUNt52MB7WA1ccaf85wXhgCeEpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZb4TzAAoJEGV+jTOl8gnz7eQP/1Mf8hX9ghYwUzfvMrLTPlsc
Q+odcJ0jPzaDnsqm73HuSc0mw5yrOFgfOVZo+Jt8lZN7xT5oRak0h1QJkw1lEYeR
m2j00+2Wz34YLqikk4Gf8X/Dl2YVnfUMKVhLhVPepINIpGLBNAVx3qb3qRJcT0ke
4n+mWyyGp+ES7BlGvFESnAdVyw1B2b+OwDrZV+XQchXN4gqibtR1uBe6WKliKxcA
Kyp/1XaNef7G5BrwzdKL7PSbigwjxBXWAWpWZvJXkfCVRL7rDsLTDusQnpr4+sgn
qk6Km57QF2WRNL+/0WeVC0hk6MY3mLzYMtaMAIpQhyjHp7ZGKc2WZKZIW2liCzLg
3SbUIBUEBmuxbzXgWhVvN4O4BVHSRXGm9rMnf0BCnFyewGtC9nnf5y5yHYPClFBz
87WKFmXzUK5DBuWHGjpvrsysmJoM3I+iEhe8d6rpL7EcvKyJj2QWYL9cavMvbI4I
c03OFri6WHjNQPcSELHV4sm+09KMWnhNwlL+L64pCF4pQ1ebBQjHui7eeLXNHwQn
UPnHF4x/WuHpP4Zmz3enOQDmLdkQjy6W7W6560maxL7PCHH30qC2/omITbNeRiWm
H+vNGRreq8j2r0vAq0wcj8/HgDtybJXmpZOGbNo0i3MH2O6LSP5mkBXfSUd1m7HE
Ogh+lEl5v+sp6pweqYpU
=YUv1
-----END PGP SIGNATURE-----

--KvXHAiQUNt52MB7WA1ccaf85wXhgCeEpf--
