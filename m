Received: from eggs.gnu.org ([209.51.188.92]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjlgL-0007j7-Ul
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjlgK-00077A-7y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gjlgD-0006vQ-3x
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:32 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20190116135615euoutp01c1c20cd5995cce677ae1861d4ebd0170~6WLlieKRV0515305153euoutp01I
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:56:15 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <ac5d8e2b-08b4-3e1f-4bc6-151f290f009a@samsung.com>
Date: Wed, 16 Jan 2019 16:56:11 +0300
MIME-Version: 1.0
In-Reply-To: <87d0owzt2l.fsf@linaro.org>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<87d0owzt2l.fsf@linaro.org>
	<CGME20190116135613eucas1p142e90e5fdb3f7fa7c975b23e32e3b1e9@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>

On 16.01.2019 15:26, Alex Benn=C3=A9e wrote:
>=20
> Ed Maste <emaste@freefall.freebsd.org> writes:
>=20
>> From: Ed Maste <emaste@freebsd.org>
>>
>> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which support=
s
>> several platforms, including FreeBSD.  Later on we could build for oth=
er
>> hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
>> supported by other CI services.
>=20
> Do you know if there is anyway to eyeball the state of the tree? So far
> I can watch the build run at:
>=20
>   https://cirrus-ci.com/github/stsquad/qemu
>=20
> but unlike Travis and Shippable there doesn't seem to be a badge I coul=
d
> transclude into the wiki page:
>=20
>   https://wiki.qemu.org/Template:CIStatus
>=20
> which means no one will know if the build fails. Travis also makes some
> noise on the IRC channel although given it's stability it's debatable
> how much longer we shall do that.

There is a badge:
https://cirrus-ci.org/guide/writing-tasks/#embedded-badges

For your case it'll be:
https://api.cirrus-ci.com/github/stsquad/qemu.svg?branch=3Dreview/dynamic=
-tlb-v6

>=20
>>
>> Signed-off-by: Ed Maste <emaste@freebsd.org>
>> ---
>>  .cirrus.yml     | 16 ++++++++++++++++
>>  create mode 100644 .cirrus.yml
>>
>> diff --git a/.cirrus.yml b/.cirrus.yml
>> new file mode 100644
>> index 0000000000..ff4bf75ad1
>> --- /dev/null
>> +++ b/.cirrus.yml
>> @@ -0,0 +1,16 @@
>> +freebsd_12_task:
>> +  freebsd_instance:
>> +    image: freebsd-12-0-release-amd64
>> +    cpu: 8
>> +    memory: 24G
>> +  env:
>> +    CIRRUS_CLONE_DEPTH: 1
>> +  install_script: pkg install -y
>> +    bison curl cyrus-sasl fontconfig freetype2 git glib gmake gnutls
>> +    nettle perl5 pixman pkgconf png usbredir
>> +  script:
>> +    - mkdir build
>> +    - cd build
>> +    - ../configure || { cat config.log; exit 1; }
>> +    - gmake -j8
>> +    - gmake -j8 check
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
