Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebq45-00051h-Ab
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebq41-0001Gv-Eb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:55:49 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
	<a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
Date: Wed, 17 Jan 2018 16:55:43 +0100
Message-ID: <w51fu741nuo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
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

On Tue 16 Jan 2018 11:26:40 PM CET, Eric Blake wrote:
>>      /* allocate a new entry in the l2 cache */
>>  
>> +    slice_size = s->l2_slice_size * sizeof(uint64_t);
>
> Would this read any better if the earlier patch named it
> s->l2_slice_entries?

I had doubts with this. Like you, when I see size I tend to think about
bytes. However both s->l1_size and s->l2_size indicate entries, and the
documentation of the qcow2 format even describes the header field like
this:

         36 - 39:   l1_size
                    Number of entries in the active L1 table

So I decided to follow that same convention for l2_slice_size.

For the local variable I could call it slice_size_bytes or try to come
up with a different alternative, but I'm open to suggestions.

Berto
