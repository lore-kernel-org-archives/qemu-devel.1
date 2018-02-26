Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLvO-0006uV-RZ
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLvL-0004JZ-NI
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:46:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <09a1d661-14ce-3fe0-e3b6-2ce6d4e34348@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
	<w51bmgbd8fh.fsf@maestria.local.igalia.com>
	<09a1d661-14ce-3fe0-e3b6-2ce6d4e34348@redhat.com>
Date: Mon, 26 Feb 2018 17:46:44 +0100
Message-ID: <w51371nd7gr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 26 Feb 2018 05:41:54 PM CET, Eric Blake wrote:
>> But refcount blocks are not addressed by L2 tables, so in principle
>> it should be possible to have refcount blocks after the first 64PB.
>
> But (if we don't make this change) that's about all you can usefully
> have (and it would be a self-referencing refcount block).

Yeah, true.

>>> +        56 - 63:    Reserved (set to 0)
>> 
>> Are we not updating REFT_OFFSET_MASK as well?
>
> We could, but that should be a separate patch from the spec change.
> We could also add some validation that any offsets in the header point
> to less than the 64PB limit.

Ok, let's leave that for another patch then.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
