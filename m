Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejWVs-0005Vo-2Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejWVr-0003nZ-54
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:40:16 -0500
References: <20180206182507.21753-1-vsementsov@virtuozzo.com>
	<20180206182629.GQ20001@redhat.com>
	<55cf676e-eae0-e694-c89b-778b0225730b@redhat.com>
	<3c0e7de4-5f59-f905-840f-63f7261f5af7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41ec94bf-478e-a500-f6ca-e4e86923954e@redhat.com>
Date: Wed, 7 Feb 2018 14:40:08 -0600
MIME-Version: 1.0
In-Reply-To: <3c0e7de4-5f59-f905-840f-63f7261f5af7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 02/07/2018 02:37 PM, Eric Blake wrote:
> On 02/06/2018 12:57 PM, Eric Blake wrote:
>> On 02/06/2018 12:26 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Feb 06, 2018 at 09:25:07PM +0300, Vladimir=20
>>> Sementsov-Ogievskiy wrote:
>>>> Support default luks options in VM.add_drive and in new library
>>>> function qemu_img_create. Use it in 205 iotests.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>
>>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>>
>> Thanks. I'll take this through my NBD queue.
>>
>> git git://repo.or.cz/qemu/ericb.git nbd
>>
>=20
> I'm seeing this failure now :(
>=20
> $ ./check -luks 205
> QEMU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- "/home/eb=
lake/qemu/x86_64-softmmu/qemu-system-x86_64"=20
> -nodefaults -machine accel=3Dqtest
> QEMU_IMG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- "/home/eblake/qemu/qemu-img"
> QEMU_IO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- "/home/eblake/qemu/qemu-=
io"=C2=A0 --cache writeback
> QEMU_NBD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- "/home/eblake/qemu/qemu-nbd"
> IMGFMT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- luks (iter-time=3D1=
0)
> IMGPROTO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- file
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 red 4.14.16-300.=
fc27.x86_64
> TEST_DIR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- /home/eblake/qemu/tests/qemu-=
iotests/scratch
> SOCKET_SCM_HELPER -- /home/eblake/qemu/tests/qemu-iotests/socket_scm_he=
lper
>=20
> 205=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [failed, exit statu=
s 1] - output mismatch (see 205.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/205.out=C2=A0=C2=A0=C2=A0 2018=
-02-07=20
> 09:48:13.346107367 -0600
> +++ /home/eblake/qemu/tests/qemu-iotests/205.out.bad=C2=A0=C2=A0=C2=A0 =
2018-02-07=20
> 14:35:21.859890826 -0600
> @@ -1,5 +1,159 @@
> -.......
> +qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=
=20
> get "write" lock
> +Is another process using the image?

Perhaps a false alarm due to a stale qemu-system-x86 process left over=20
from an earlier aborted test run.  When I retried on a fresh system, the=20
test passed for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
