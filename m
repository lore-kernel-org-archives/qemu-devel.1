Received: from eggs.gnu.org ([2001:4830:134:3::10]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fVbxb-0006Op-CH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fVbxW-0005xd-I3
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:11:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3f211a15-a7e6-c062-8ac8-4aaeedcd7715@redhat.com>
References: <20180426025129.621969-1-eblake@redhat.com>
	<20180426025129.621969-6-eblake@redhat.com>
	<w51k1sumalp.fsf@maestria.local.igalia.com>
	<3f211a15-a7e6-c062-8ac8-4aaeedcd7715@redhat.com>
Date: Wed, 20 Jun 2018 14:10:55 +0200
Message-ID: <w51y3f9r73k.fsf@maestria.local.igalia.com>
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

On Tue 19 Jun 2018 08:51:36 PM CEST, Eric Blake wrote:
> On 04/26/2018 07:10 AM, Alberto Garcia wrote:
>> On Thu 26 Apr 2018 04:51:28 AM CEST, Eric Blake wrote:
>>> If you have a capable file system (tmpfs is good, ext4 not so much;
>>> run ./check with TEST_DIR pointing to a good location so as not
>>> to skip the test), it's actually possible to create a qcow2 file
>>> that expands to a sparse 512T image with just over 38M of content.
>>> The test is not the world's fastest (qemu crawling through 256M
>>> bits of refcount table to find the next cluster to allocate takes
>>> several seconds, as does qemu-img check reporting millions of
>>> leaked clusters); but it DOES catch the problem that the previous
>>> patch just fixed where writing a compressed cluster to a full
>>> image ended up overwriting the wrong cluster.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> 
>> Nice test :-)
>> 
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> 214 is already in the tree in the meantime; this will need a rebase to
> pick the next available test number (220 might be claimed, so 222?)

You can also take 220 if you want, I suspect that it will take a bit
longer to merge the blockdev-reopen patches. Whatever is easier for you.

Berto
