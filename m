Received: from eggs.gnu.org ([2001:4830:134:3::10]:56189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erSs3-0005Yc-W8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erSs2-00084b-Sc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:23:59 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-10-git-send-email-vsementsov@virtuozzo.com>
	<8e580b8b-1614-9c83-4ac9-48f5d3cff3dc@redhat.com>
	<b17a3d26-5f55-da0a-f083-159ebdf749b7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14411a5e-5970-4f2a-2d75-cd86e8a8197f@redhat.com>
Date: Thu, 1 Mar 2018 12:23:43 -0600
MIME-Version: 1.0
In-Reply-To: <b17a3d26-5f55-da0a-f083-159ebdf749b7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: new test 206 for NBD
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/01/2018 05:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 17.02.2018 00:02, Eric Blake wrote:
>> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 tests/qemu-iotests/206=C2=A0=C2=A0=C2=A0=C2=A0 | 34 ++++++++++=
++++++++++++++++++++++++
>>> =C2=A0 tests/qemu-iotests/206.out |=C2=A0 2 ++
>>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 3 files changed, 37 insertions(+)
>>> =C2=A0 create mode 100644 tests/qemu-iotests/206
>>> =C2=A0 create mode 100644 tests/qemu-iotests/206.out
>>
>> It's a race! Kevin already has test 206 and 207 claimed in his pending=
=20
>> series:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02363.html
>> Whoever loses gets to rebase and renumber (or the maintainer on their=20
>> behalf) ;)
>=20
>=20
> is there any simple method to get a number for new test? Any way to=20
> avoid such situations?

Short of searching the mailing list for what numbers have already been=20
mentioned, not really.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
