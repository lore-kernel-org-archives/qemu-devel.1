Received: from eggs.gnu.org ([2001:4830:134:3::10]:56810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fUw5A-0004hB-3J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fUw55-0002Wl-9h
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:28:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180618141507.GB4667@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<4a1c8fb9816de2115d08284c36d7a718b5e48de6.1528991017.git.berto@igalia.com>
	<20180618141507.GB4667@localhost.localdomain>
Date: Mon, 18 Jun 2018 17:28:32 +0200
Message-ID: <w51fu1kp10f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] block: Add 'keep_old_opts'
 parameter to bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon 18 Jun 2018 04:15:07 PM CEST, Kevin Wolf wrote:

>> @@ -2850,7 +2850,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>>                                                   int flags,
>>                                                   const BdrvChildRole *role,
>>                                                   QDict *parent_options,
>> -                                                 int parent_flags)
>> +                                                 int parent_flags,
>> +                                                 bool keep_old_opts)
>
> Can we change the semantics of keep_old_opts so that flags is completely
> ignored for keep_old_opts=false?
>
> Flags are one of the reasons why the behaviour of bdrv_reopen() is
> rather complex and I'd prefer not having that complexity in a public
> interface. To be honest, I wouldn't be sure that I could write a
> correct documentation with it.

I think so. In this series if keep_old_opts is false the only possible
flags are either 0 or BDRV_O_RDWR | BDRV_O_ALLOW_RDWR, depending on the
value of "read-only" option.

Berto
