Received: from eggs.gnu.org ([2001:4830:134:3::10]:59499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBfkR-0004mZ-Hk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBfkO-0000aX-BP
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:11:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180426025129.621969-6-eblake@redhat.com>
References: <20180426025129.621969-1-eblake@redhat.com>
	<20180426025129.621969-6-eblake@redhat.com>
Date: Thu, 26 Apr 2018 14:10:58 +0200
Message-ID: <w51k1sumalp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 5/6] iotests: Add new test 214 for max
 compressed cluster offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

On Thu 26 Apr 2018 04:51:28 AM CEST, Eric Blake wrote:
> If you have a capable file system (tmpfs is good, ext4 not so much;
> run ./check with TEST_DIR pointing to a good location so as not
> to skip the test), it's actually possible to create a qcow2 file
> that expands to a sparse 512T image with just over 38M of content.
> The test is not the world's fastest (qemu crawling through 256M
> bits of refcount table to find the next cluster to allocate takes
> several seconds, as does qemu-img check reporting millions of
> leaked clusters); but it DOES catch the problem that the previous
> patch just fixed where writing a compressed cluster to a full
> image ended up overwriting the wrong cluster.
>
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Nice test :-)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
