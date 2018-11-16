Received: from eggs.gnu.org ([2001:4830:134:3::10]:34748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNlti-0006T5-A0
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNltd-0007i2-MW
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:43:27 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
	<abec84f9-d5c2-9488-3c1b-ca3c9b7df89f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2183d0b1-2b88-a9eb-abb7-ea2fdf3f4388@redhat.com>
Date: Fri, 16 Nov 2018 15:43:16 -0600
MIME-Version: 1.0
In-Reply-To: <abec84f9-d5c2-9488-3c1b-ca3c9b7df89f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers
 into common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 3:41 PM, Eric Blake wrote:

>> +#!/bin/bash
>=20
> I know we're using bash,
>=20
>> +
>> +function nbd_server_stop()
>> +{
>=20
>> +function nbd_server_wait_for_unix_socket()
>=20
> and bash supports 'function', but it is an obsolete syntactic sugar=20
> thing that I don't recommend using.=C2=A0 (In ksh, it actually makes a=20
> difference in behavior whether you use 'function' or not, and using it=20
> in 'bash' makes it harder to port code over to 'ksh' - and hence in bas=
h=20
> it is obsolete because here it does NOT cause the change in behavior=20
> that ksh users expect)
>=20

Of course, I hit send too soon, before getting to my punchline:

Since we already have so many existing iotests that use 'function', it's=20
better to clean that up as a separate patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
