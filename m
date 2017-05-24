Received: from eggs.gnu.org ([2001:4830:134:3::10]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDYrH-0003pF-1I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDYrG-0001V8-1a
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:09:59 -0400
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
Date: Wed, 24 May 2017 19:09:42 +0300
MIME-Version: 1.0
In-Reply-To: <w51shjutjz7.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>


On 05/24/2017 05:20 PM, Alberto Garcia wrote:
> On Tue 23 May 2017 04:36:52 PM CEST, Eric Blake wrote:
>
>>> here's a patch series that rewrites the copy-on-write code in the
>>> qcow2 driver to reduce the number of I/O operations.
>>
>> And it competes with Denis and Anton's patches:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04547.html
>>
>> What plan of attack should we take on merging the best parts of these
>> two series?
>
> I took a look at that series and unless I overlooked something important
> it seems that there's actually not that much overlap. Denis and Anton's
> series deals with cluster preallocation and mine reduces the number of
> I/O operations when there's a COW scenario. Most of my modifications are
> in the peform_cow() function, but they barely touch that one.
>
> I think we can review both separately, either of us can rebase our
> series on top of the other, I don't expect big changes or conflicts.
>
> Berto
>

I agree; as mentioned we have similar patches and they don't conflict much.
We noticed a performance regression on HDD though, for the presumably 
optimized case (random 4k write over a large backed image); so the 
patches were put on hold.
SSD looked fine though.

/Anton
