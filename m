Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evmaH-0007Pz-Dp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evmaG-0002Xx-B8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:15:29 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<5ed5cfa6-4869-45aa-6a34-7167f2f5afa6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3203038f-67b1-b1f2-e420-c9a18102f3e6@virtuozzo.com>
Date: Tue, 13 Mar 2018 19:15:15 +0300
MIME-Version: 1.0
In-Reply-To: <5ed5cfa6-4869-45aa-6a34-7167f2f5afa6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
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

13.03.2018 18:55, Eric Blake wrote:
> On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Here is minimal realization of base:allocation context of NBD
>> block-status extension, which allows to get block status through
>> NBD.
>>
>> v2 changes are in each patch after "---" line.
>>
>> Vladimir Sementsov-Ogievskiy (8):
>> =C2=A0=C2=A0 nbd/server: add nbd_opt_invalid helper
>> =C2=A0=C2=A0 nbd/server: add nbd_read_opt_name helper
>> =C2=A0=C2=A0 nbd: BLOCK_STATUS for standard get_block_status function: s=
erver part
>> =C2=A0=C2=A0 block/nbd-client: save first fatal error in nbd_iter_error
>> =C2=A0=C2=A0 nbd: BLOCK_STATUS for standard get_block_status function: c=
lient part
>> =C2=A0=C2=A0 iotests.py: tiny refactor: move system imports up
>> =C2=A0=C2=A0 iotests: add file_path helper
>> =C2=A0=C2=A0 iotests: new test 209 for NBD BLOCK_STATUS
>
> I've staged this on my NBD queue, pull request to come later today=20
> (still this morning for me) so that it makes 2.12 softfreeze.
>

So, I'm happy, thank you!

--=20
Best regards,
Vladimir
