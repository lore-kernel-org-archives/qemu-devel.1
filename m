Received: from eggs.gnu.org ([2001:4830:134:3::10]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQvZP-00059l-QO
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQvZP-000128-2a
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:02:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170627163145.GC4792@noname.redhat.com>
References: <20170627163145.GC4792@noname.redhat.com>
Date: Fri, 30 Jun 2017 15:01:57 +0200
Message-ID: <w51shihd3y2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] QMP design: Fixing query-block
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On Tue 27 Jun 2017 06:31:45 PM CEST, Kevin Wolf wrote:
> * Speaking of recursion: ImageInfo recursively includes information
>   about all images in the backing chain. This is what makes the output
>   of query-named-block-nodes so redundant. It is also inconsistent
>   because the runtime information (BlockInfo/BlockDeviceInfo) isn't
>   recursive.

I've also been told of cases where a query-block command on a VM with a
very large amount of images in all backing chains would slow down the
guest because of this recursion.

I haven't been able to reproduce this problem myself, but being able to
see only the devices seen by the guest (as opposed to the complete
graph) seems like a good idea.

Berto
