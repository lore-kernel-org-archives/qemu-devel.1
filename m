Received: from eggs.gnu.org ([2001:4830:134:3::10]:34163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSnO0-00025I-QB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSnO0-00062Q-6B
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:42:44 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
	<2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
	<e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
	<1661217396.47274977.1499270778716.JavaMail.zimbra@redhat.com>
	<97758bb8-cdd1-8318-e8a0-13a3607c849f@redhat.com>
	<1043373876.47277851.1499272836038.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d10cf345-25af-2150-57d7-e244840747f0@redhat.com>
Date: Wed, 5 Jul 2017 18:42:28 +0200
MIME-Version: 1.0
In-Reply-To: <1043373876.47277851.1499272836038.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 05/07/2017 18:40, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>>
>>
>> On 05/07/2017 18:06, Marc-Andr=C3=A9 Lureau wrote:
>>>>> coroutine_fn too)
>>>> It's not controversial, I would not have expected the functions to c=
all
>>>> coroutine_fn. :)  How do they do that?
>>>>
>>> For example,  null_co_readv() calls  null_co_common() which calls
>>> co_aio_sleep_ns()
>>
>> But these are bdrv_co_*, not bdrv_aio_*.
>=20
> Oops, right.
>=20
> Indeed, it's not needed, but to avoid coroutine annotation mismatch, we=
 would have to remove a few:
>=20
> static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
>=20
> static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,
>=20
> Only those 2, it seems.

Good!  If it's just those two, they are wrong indeed.  I'd be surprised
to see more (and even more surprised to see that the annotations were
right :)).

Paolo
