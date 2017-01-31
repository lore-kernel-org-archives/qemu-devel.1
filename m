Received: from eggs.gnu.org ([2001:4830:134:3::10]:49562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYcth-0003kk-Lq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYcte-0005KT-Ec
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:11:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
	<w51efzjnq49.fsf@maestria.local.igalia.com>
	<b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
Date: Tue, 31 Jan 2017 19:11:11 +0100
Message-ID: <w5160kvgkw0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 31 Jan 2017 05:41:23 PM CET, Eric Blake <eblake@redhat.com> wrote:

>>> Ideally, it would be nice to fix the block layer to allow larger
>>> requests (since we already have code to auto-fragment down to device
>>> limits, we should be able to rely on that code instead of having to
>>> duplicate artificial constraints everywhere else in the tree).  But
>>> that's a bigger task, and this is a good patch in the interim.
>> 
>> Related question: what's the largest request than a guest can
>> theoretically submit?
>
> off_t supports up to 2^63 (not 2^64, because it is a signed type).
> Ideally, we should be constrained only by the disk size (as no one
> actually has 2^63 bytes of storage available), by using uint64_t
> offset AND length in all our APIs; but right now, we still have a lot
> of 32-bit length issues, and often signed length limiting us to 2^31
> depending on the API.

My question was more like: what happens if the guest submits a request
with the maximum possible size? Does QEMU handle that correctly?

Berto
