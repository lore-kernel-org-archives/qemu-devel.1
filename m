Received: from eggs.gnu.org ([2001:4830:134:3::10]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzIae-0006YO-7X
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzIab-0001MQ-49
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:34:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180910083420.GC4901@dhcp-200-186.str.redhat.com>
References: <20180906142541.8238-1-berto@igalia.com>
	<20180910083420.GC4901@dhcp-200-186.str.redhat.com>
Date: Mon, 10 Sep 2018 11:34:35 +0200
Message-ID: <w51pnxlu250.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Fix use after free error in
 bdrv_open_inherit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

On Mon 10 Sep 2018 10:34:20 AM CEST, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 06.09.2018 um 16:25 hat Alberto Garcia geschrieben:
>> When a block device is opened with BDRV_O_SNAPSHOT and the
>> bdrv_append_temp_snapshot() call fails then the error code path tries
>> to unref the already destroyed 'options' QDict.
>> 
>> This can be reproduced easily by setting TMPDIR to a location where
>> the QEMU process can't write:
>> 
>>    $ TMPDIR=/nonexistent $QEMU -drive driver=null-co,snapshot=on
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Thanks, applied to the block branch.
>
> But can we add the reproducer to some iotests case?

Yup, I just sent it.

Berto
