Received: from eggs.gnu.org ([2001:4830:134:3::10]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evoyN-000691-HY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evoyI-0003bQ-Pi
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:48:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <979d86bf-f1fa-4049-a811-94d6d8b9c667@redhat.com>
References: <cover.1520952419.git.berto@igalia.com>
	<0b8f83b4f26071753dc409645ad8c6f6e215468a.1520952419.git.berto@igalia.com>
	<979d86bf-f1fa-4049-a811-94d6d8b9c667@redhat.com>
Date: Tue, 13 Mar 2018 19:48:24 +0100
Message-ID: <w51muzb4xs7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 13 Mar 2018 07:23:36 PM CET, Eric Blake wrote:
>> +                *refcount_cache_size =
>> +                    MIN(combined_cache_size, min_refcount_cache);
>
> but here, if combined_cache_size is smaller than min_refcount_cache,
>
>> +                *l2_cache_size = combined_cache_size - *refcount_cache_size;
>
> then l2_cache_size is set to a negative value.

No, it's set to 0.

If combined == 4k and min_refcount == 256, then

   refcount_cache_size = MIN(4k, 256k) // 4k
   l2_cache_size = 4k - 4k; // 0

Then the caller ensures that it's always set to the minimum (as it did
with the previous code).

Berto
