Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebq0V-0001yU-Mv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebq0R-00083S-S8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:52:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
	<9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
Date: Wed, 17 Jan 2018 16:30:29 +0100
Message-ID: <w51lggw1p0q.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
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

On Tue 16 Jan 2018 11:06:21 PM CET, Eric Blake wrote:

>>  typedef struct Qcow2ReopenState {
>>      Qcow2Cache *l2_table_cache;
>>      Qcow2Cache *refcount_block_cache;
>> +    int l2_slice_size;
>
> Worth a comment?
> /* Number of entries in a slice of the L2 table */

Yeah, why not? I'll add it.

Berto
