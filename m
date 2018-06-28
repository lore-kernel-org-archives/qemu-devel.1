Received: from eggs.gnu.org ([2001:4830:134:3::10]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYc38-00065H-ON
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYc37-0007bE-LL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:53:46 -0400
References: <20180628153937.26097-1-kwolf@redhat.com>
	<20180628153937.26097-3-kwolf@redhat.com>
	<b0aa3ea2-c91e-3534-248e-b64791fb39ae@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <577ae4db-3e41-2c58-dd94-2e5790e047ea@redhat.com>
Date: Thu, 28 Jun 2018 13:53:38 -0500
MIME-Version: 1.0
In-Reply-To: <b0aa3ea2-c91e-3534-248e-b64791fb39ae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Free allocated clusters on
 write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 06/28/2018 10:49 AM, Eric Blake wrote:
> On 06/28/2018 10:39 AM, Kevin Wolf wrote:
>> If we managed to allocate the clusters, but then failed to write the
>> data, there's a good chance that we'll still be able to free the
>> clusters again in order to avoid cluster leaks (the refcounts are
>> cached, so even if we can't write them out right now, we may be able t=
o
>> do so when the VM is resumed after a werror=3Dstop/enospc pause).
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
>> =C2=A0 block/qcow2-cluster.c | 11 +++++++++++
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
>> =C2=A0 3 files changed, 14 insertions(+)
>=20
> Hmm, I wonder if this interacts poorly with my proposed test addition=20
> for HUGE images, which is still pending review:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05488.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04542.html
>=20
> (time for me to go testing...)

Phew, my test didn't change (but I will go ahead and repost a v7 to fix=20
the minor conflict in iotest numbering).

And that means I can also add for this series:

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
