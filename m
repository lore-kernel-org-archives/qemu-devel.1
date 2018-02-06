Received: from eggs.gnu.org ([2001:4830:134:3::10]:55222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7eU-0001N0-5S
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7eQ-0002iK-5y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:07:30 -0500
References: <20180206171642.19826-1-vsementsov@virtuozzo.com>
	<20180206172907.GL20001@redhat.com>
	<b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
	<5af79798-357a-ab77-eae8-6e2e90e69707@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b579f3c9-6700-d2ff-5fe1-f8d1707f089f@virtuozzo.com>
Date: Tue, 6 Feb 2018 21:07:15 +0300
MIME-Version: 1.0
In-Reply-To: <5af79798-357a-ab77-eae8-6e2e90e69707@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

06.02.2018 21:04, Eric Blake wrote:
> On 02/06/2018 11:57 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> +luks_default_secret_id =3D 'luks_secret_default_iotests_id'
>>> Can we just call this=C2=A0 "keysec0", so we matchh convention used by
>>> the shell script based tests.
>>
>> Here I'm trying to avoid intersection with some user-defined id.
>>
>
> You're overthinking it.=C2=A0 We are only using this in the testsuite, an=
d=20
> nothing else in the testsuite is using 'keysec0' for anything except=20
> the id of the secret to pass to encrypted disks.=C2=A0 The longer name=20
> doesn't add any protection.=C2=A0 It might be different if we were trying=
=20
> to provide a reusable library for contexts outside the testsuite, but=20
> since we are not doing that, we can rely on 'make check' failing as=20
> evidence if we have any collisions in naming choices that need long=20
> name munging as a workaround.
>

Ok

--=20
Best regards,
Vladimir
