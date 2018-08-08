Received: from eggs.gnu.org ([2001:4830:134:3::10]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnNy3-0008F9-9R
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnNy2-0005zP-Ev
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:53:35 -0400
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-22-kwolf@redhat.com>
	<fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
	<28f44beb-e19b-3e26-254a-4678eacf30c2@redhat.com>
	<9d74eea6-3101-3325-e561-d55f112fe68c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <030bc8d6-a085-c376-51d2-6362cc55e5b0@redhat.com>
Date: Wed, 8 Aug 2018 07:53:26 -0500
MIME-Version: 1.0
In-Reply-To: <9d74eea6-3101-3325-e561-d55f112fe68c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd
 and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/08/2018 06:40 AM, Vladimir Sementsov-Ogievskiy wrote:

>> I don't know how much the proposed NBD reconnect code will change=20
>> things in 3.1.=C2=A0 Meanwhile, we've missed any chance for 3.0 to fix=
 test=20
>> 83.
>=20
> hmm, isn't 3.0 release planned on August 14th?

Yes, but -rc4 has already been cut, and there will not be an -rc5 unless=20
there is a MAJOR regression identified in qemu proper (a failing iotest=20
is not major).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
