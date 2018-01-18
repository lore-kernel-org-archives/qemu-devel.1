Received: from eggs.gnu.org ([2001:4830:134:3::10]:38231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecCLx-00069k-9y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecCLu-0003tC-7u
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:43:45 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <fab2e9e4-50a0-1f21-9d06-969a90d0644a@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
	<fab2e9e4-50a0-1f21-9d06-969a90d0644a@redhat.com>
Date: Thu, 18 Jan 2018 16:43:39 +0100
Message-ID: <w51zi5bp3ys.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 24/32] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
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

On Wed 17 Jan 2018 12:00:59 AM CET, Eric Blake wrote:
>> -    l2_table = NULL;
>> +    l2_slice = NULL;
>>      l1_table = NULL;
>>      l1_size2 = l1_size * sizeof(uint64_t);
>>  
>> +    slice_size = s->l2_slice_size * sizeof(uint64_t);
>
> Again, better naming on s->l2_slice_size in an earlier patch may make
> this more readable, at a cost of slight rebase churn.

Another approach would be to use _size2 to refer to size in bytes, after
checking the code a bit that seems to be the convention in other places
where we're dealing with both table lenghts and sizes in bytes.

> The diff looks hideous, but that's thanks to indentation changes.

Right, that's why I suggested to use 'diff -w' in the cover letter to
help see the changes better.

Berto
