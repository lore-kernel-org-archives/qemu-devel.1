Received: from eggs.gnu.org ([2001:4830:134:3::10]:35707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euNhC-0004RP-JG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euNhB-0005a1-H7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:28:50 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1fa1dc96-51b7-f756-f86b-54240361c440@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8b504346-8a6f-3cab-15eb-9baa80803e8a@virtuozzo.com>
Date: Fri, 9 Mar 2018 22:28:35 +0300
MIME-Version: 1.0
In-Reply-To: <1fa1dc96-51b7-f756-f86b-54240361c440@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/9] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

09.03.2018 22:08, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Here is minimal realization of base:allocation context of NBD
>> block-status extension, which allows to get block status through
>> NBD.
>>
>> Vladimir Sementsov-Ogievskiy (9):
>> =C2=A0=C2=A0 nbd/server: add nbd_opt_invalid helper
>> =C2=A0=C2=A0 nbd: change indenting in nbd.h
>> =C2=A0=C2=A0 nbd: BLOCK_STATUS for standard get_block_status function: s=
erver part
>> =C2=A0=C2=A0 block/nbd-client: save first fatal error in nbd_iter_error
>> =C2=A0=C2=A0 nbd/client: fix error messages in nbd_handle_reply_err
>> =C2=A0=C2=A0 nbd: BLOCK_STATUS for standard get_block_status function: c=
lient part
>> =C2=A0=C2=A0 iotests.py: tiny refactor: move system imports up
>> =C2=A0=C2=A0 iotests: add file_path helper
>> =C2=A0=C2=A0 iotests: new test 206 for NBD BLOCK_STATUS
>
> I'd really like to send a PULL request for NBD on Monday, in order to=20
> make the 2.12 softfreeze deadline (this is a new feature, so if we=20
> miss Tuesday, we have to wait until 2.13 or whatever the next release=20
> is called).=C2=A0 Where do you stand on rebasing this, and what help can =
I=20
> offer? (I know you have factored out some of the patches in another=20
> thread that I'm in the middle of reviewing as well; you can submit the=20
> later patches even before the earlier ones land, and use a 'Based-on:'=20
> tag in the cover letter to make it obvious the dependencies between=20
> series).
>

I'm now at start of "Re: [PATCH 6/9] nbd: BLOCK_STATUS for standard=20
get_block_status function: client part", and I think rebasing on=20
byte-based is too much for me for that moment (10:20 pm =3D). I'll do my=20
best on Monday morning as early as I can.

--=20
Best regards,
Vladimir
