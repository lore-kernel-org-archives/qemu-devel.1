Received: from eggs.gnu.org ([2001:4830:134:3::10]:54165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej7bY-0006uu-Ph
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej7bY-0001PH-4K
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:04:28 -0500
References: <20180206171642.19826-1-vsementsov@virtuozzo.com>
	<20180206172907.GL20001@redhat.com>
	<b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5af79798-357a-ab77-eae8-6e2e90e69707@redhat.com>
Date: Tue, 6 Feb 2018 12:04:19 -0600
MIME-Version: 1.0
In-Reply-To: <b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 02/06/2018 11:57 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +luks_default_secret_id =3D 'luks_secret_default_iotests_id'
>> Can we just call this=C2=A0 "keysec0", so we matchh convention used by
>> the shell script based tests.
>=20
> Here I'm trying to avoid intersection with some user-defined id.
>=20

You're overthinking it.  We are only using this in the testsuite, and=20
nothing else in the testsuite is using 'keysec0' for anything except the=20
id of the secret to pass to encrypted disks.  The longer name doesn't=20
add any protection.  It might be different if we were trying to provide=20
a reusable library for contexts outside the testsuite, but since we are=20
not doing that, we can rely on 'make check' failing as evidence if we=20
have any collisions in naming choices that need long name munging as a=20
workaround.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
