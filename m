Received: from eggs.gnu.org ([2001:4830:134:3::10]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebnES-0003PB-7z
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebnEP-0000Y1-3v
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:54:20 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <82955b47-0b64-fccf-2173-711ad86d1a6f@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
	<82955b47-0b64-fccf-2173-711ad86d1a6f@redhat.com>
Date: Wed, 17 Jan 2018 13:54:13 +0100
Message-ID: <w51shb41w96.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/32] qcow2: Add table size field to
 Qcow2Cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 16 Jan 2018 10:05:08 PM CET, Eric Blake wrote:
>> @@ -331,7 +330,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
>>      trace_qcow2_cache_get(qemu_coroutine_self(), c == s->l2_table_cache,
>>                            offset, read_from_disk);
>>  
>> -    if (offset_into_cluster(s, offset)) {
>> +    if (offset & (c->table_size - 1)) {
>
> Worth writing that as QEMU_IS_ALIGNED(offset, c->table_size) instead
> of open-coding the bit-wise math?

Oh, indeed, I very much prefer using macros/functions instead of dealing
with bits directly. I'll change it for the next revision.

Berto
