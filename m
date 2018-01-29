Received: from eggs.gnu.org ([2001:4830:134:3::10]:57767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egBBi-0001Ed-Pz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egBBh-00048t-QJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:17:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1egBBh-000485-Hl
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:17:37 -0500
References: <20180129033133.31288-1-famz@redhat.com>
	<f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
	<CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
	<ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15af7545-781d-5e34-e100-9ddc0f08725b@redhat.com>
Date: Mon, 29 Jan 2018 16:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wOcBJDahJqVmwkO8sZF30uGOxjalPIZg8"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wOcBJDahJqVmwkO8sZF30uGOxjalPIZg8
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15af7545-781d-5e34-e100-9ddc0f08725b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
References: <20180129033133.31288-1-famz@redhat.com>
 <f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
 <CAK1Eb9mjV4KV2N8=yOdUVeg+P0sHnqER0BUYg5kb_FjVcmzXnQ@mail.gmail.com>
 <ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
In-Reply-To: <ae6cb50d-28d8-da44-e57b-6170dd60fafc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.2018 15:36, Eric Blake wrote:
> On 01/29/2018 01:42 AM, Fam Zheng wrote:
>> On Mon, Jan 29, 2018 at 2:56 PM, Thomas Huth <thuth@redhat.com> wrote:=

>>> On 29.01.2018 04:31, Fam Zheng wrote:
>>> [...]
>>>> +1. Create a new source file. For example, ``tests/test-foo.c``.
>>> [...]
>>>> +1. Create a new source file for the test. (More than one file can b=
e added as
>>>> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write =
the test
>>>> +   code with the glib and libqtest/libqos API. See also existing te=
sts and the
>>>> +   library headers for reference.
>>>
>>> Can you please name the examples tests/foo-test.c and
>>> tests/foo-device-test.c instead? Then the binaries will be covered by=

>>> the wildcard in tests/.gitignore automatically. Otherwise the list in=

>>> that gitignore file will grow and grow... Maybe it's also worth to
>>> mention the naming scheme in this doc file?
>>
>> Yeah, I can do it. It's just I fail to find a definitive guideline on
>> test-* vs *-test for the names, and the numbers are neck-and-neck:
>>
>> fam@lemon:~/work/qemu [master]$ ls tests/*test.c | wc -l
>> 67
>> fam@lemon:~/work/qemu [master]$ ls tests/test-*.c | wc -l
>> 68
>=20
> I'm all for a mass rename to the suffix style (as it is easier to write=

> a gitignore suffix), if no one can provide a good reason for the naming=

> difference.=20

Good idea. And while we're at it, I think we should also sort the tests
into subfolders, e.g. tests/qtest/ and tests/unit/ etc.

 Thomas


--wOcBJDahJqVmwkO8sZF30uGOxjalPIZg8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJabzrFAAoJEC7Z13T+cC216oYP/i8yXaWpVk2yv7QtZcn3gYUh
tfDFWAGjNHgVFtMWC0a9ohRkSyT7jtXEob/QhEDE9WOKJoIGADaiHiSmMA13NsaJ
y/D0dAM72ZQO39f0d0puIS4MoS99YYcpiKKtY9Uu59Ydlar5B6IPikyrICYuOUv9
wg2IAlgzwkVWPRJ91eo3Q90LcbRJQfzfISt2o5fZVqVhLS270zav7V/JH3oj+0IY
32JO4kU0DAhcyrhhAj/Ullv7uYgMJNGS5MDUKvP0xLZMer0/Anwvi4TrTRRUGubH
khZlkwHzsGBzDn9R4yBGilKS820Vv7QFmHW4aLF9rVRfSNvAoedx2lLgi07aPktS
TS6zvsSJHc5nQ9mikDNxOt1pEkxdo7pvGmEXkSSf+zAVFrPcqjgIAyvcsata+XCX
p4KefIj+Z66Og//GmRafvKY31CClY7546DzDwr3YDA05HiWGZfF9ZisNUWmV/+LL
/aU0vfmiQVKdgJyOP+W7KC+1fwm47380V8vOKmH2iFZSReEVuYYzhB9UNWF4yroY
qSYMA2qJYA0+OdLnOeoAiaJ9gb7iueAS1TNAeFInpQyLQZUQpGOSNXLH/dAiQ9W6
YPsN3TmT3JTdUAxBbVok7mUek4PxYgshVqCUtec+DuWqnJxsf6Ig9E+mys8WvrLp
u+VI5oyM669Y0IF+mIu7
=9Qil
-----END PGP SIGNATURE-----

--wOcBJDahJqVmwkO8sZF30uGOxjalPIZg8--
