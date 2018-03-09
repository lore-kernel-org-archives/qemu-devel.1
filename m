Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euLKu-0000Oh-GL
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euLKt-0007sO-IH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:57:40 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<ca5bbf03-a506-b10b-2db9-cb6a7aad3075@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7138bc8a-10ff-f557-8d14-853b80458a4b@virtuozzo.com>
Date: Fri, 9 Mar 2018 19:57:18 +0300
MIME-Version: 1.0
In-Reply-To: <ca5bbf03-a506-b10b-2db9-cb6a7aad3075@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5] nbd server fixing and refactoring
 before BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

09.03.2018 19:41, Eric Blake wrote:
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 01 and 02 are splitted and updated "[PATCH] nbd/server: fix space read",
>> others are new.
>>
>> Vladimir Sementsov-Ogievskiy (5):
>> =C2=A0=C2=A0 nbd/server: move nbd_co_send_structured_error up
>> =C2=A0=C2=A0 nbd/server: fix sparse read
>> =C2=A0=C2=A0 nbd/server: fix: check client->closing before reply sending
>> =C2=A0=C2=A0 nbd/server: refactor nbd_trip: cmd_read and generic reply
>> =C2=A0=C2=A0 nbd/server: refactor nbd_trip: split out nbd_handle_request
>
> I had a tough time applying this one:
>
> Applying: nbd/server: move nbd_co_send_structured_error up
> Applying: nbd/server: fix: check client->closing before reply sending
> Applying: nbd/server: refactor nbd_trip: cmd_read and generic reply
> error: sha1 information is lacking or useless (nbd/server.c).
> error: could not build fake ancestor
> Patch failed at 0004 nbd/server: refactor nbd_trip: cmd_read and=20
> generic reply
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> I think I've resolved the conflicts correctly, but if I get through=20
> reviewing this series and posting it to my NBD queue, you may want to=20
> double-check things.
>

Oh, sorry for this. I should have to rebase it(

--=20
Best regards,
Vladimir
