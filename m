Received: from eggs.gnu.org ([2001:4830:134:3::10]:59763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebp80-0004MZ-0F
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebp7x-0006hz-F4
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:55:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <db1e9638-ce19-8b8e-b300-6104f8abe658@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
	<db1e9638-ce19-8b8e-b300-6104f8abe658@redhat.com>
Date: Wed, 17 Jan 2018 15:55:41 +0100
Message-ID: <w51o9ls1qmq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 14/32] qcow2: Add
 offset_to_l2_slice_index()
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

On Tue 16 Jan 2018 11:10:37 PM CET, Eric Blake wrote:

>>  static inline int64_t align_offset(int64_t offset, int n)
>>  {
>>      offset = (offset + n - 1) & ~(n - 1);
>
> Unrelated to this commit, but should we switch this to use
> QEMU_ALIGN_UP() instead of open-coding it?

Why not, we can actually use ROUND_UP() instead which is optimized for
powers of two.

I can send the patch.

Berto
