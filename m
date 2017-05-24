Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZ7M-0005g7-0N
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZ7L-0000Op-3i
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:26:36 -0400
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
	<w51poeytefj.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <713bf6bf-0c62-f3d7-e486-86a581689e3e@virtuozzo.com>
Date: Wed, 24 May 2017 19:26:23 +0300
MIME-Version: 1.0
In-Reply-To: <w51poeytefj.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
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



On 05/24/2017 07:20 PM, Alberto Garcia wrote:
> On Wed 24 May 2017 06:09:42 PM CEST, Anton Nefedov wrote:
> 
>> I agree; as mentioned we have similar patches and they don't conflict
>> much.  We noticed a performance regression on HDD though, for the
>> presumably optimized case (random 4k write over a large backed image);
>> so the patches were put on hold.
> 
> Interesting, I think that scenario was noticeably faster in my
> tests. What cluster size(s) and image size(s) were you using?
> 
64k cluster, 2g image, write 32m in portions of 4k at random offsets

/Anton
