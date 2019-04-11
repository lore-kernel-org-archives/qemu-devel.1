Received: from eggs.gnu.org ([209.51.188.92]:57467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEWzd-0001rK-3o
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEWza-00019q-6t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:31:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
References: <20190410152429.8076-1-berto@igalia.com>
	<bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
Date: Thu, 11 Apr 2019 12:31:33 +0200
Message-ID: <w51bm1cvnne.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if
 there is an early failure
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

On Wed 10 Apr 2019 05:32:47 PM CEST, Eric Blake wrote:
> On 4/10/19 10:24 AM, Alberto Garcia wrote:
>> You can reproduce this by passing an invalid filter-node-name (like
>> "1234") to block-commit. In this case the base image is put in
>> read-write mode but is never reset back to read-only.
>
> Is it worth iotest coverage?

I couldn't think of any way to reproduce this that would trigger an
error on an iotest, but I think I have one now, I'll try to write
something.

Berto
