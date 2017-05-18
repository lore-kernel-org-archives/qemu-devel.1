Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dBIpD-0003Oi-9q
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dBIpC-00060y-E8
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:38:31 -0400
References: <20170518100925.28682-1-vsementsov@virtuozzo.com>
	<20170518102523.GD4646@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <ec78defc-8e4f-c4fc-6efe-16d7f6d8f48f@openvz.org>
Date: Thu, 18 May 2017 13:38:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170518102523.GD4646@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: add allocated-size to image
 specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 05/18/2017 01:25 PM, Kevin Wolf wrote:
> Am 18.05.2017 um 12:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Shows, how much data qcow2 allocates in underlying file. This should
>> be helpful on non-sparse file systems, when qemu-img info "disk size"
>> doesn't provide this information.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> Hi all.
>>
>> Here is an allocated-size feature for qemu-img info.
> I'm not a fan of loading all L2 tables (can take some time) for
> 'qemu-img info' (which should be very quick). Why isn't the qemu-img
> check output good enough?
>
> Kevin
>
> $ ./qemu-img check /tmp/test.qcow2 
> No errors were found on the image.
> 16164/491520 = 3.29% allocated, 11.98% fragmented, 0.00% compressed clusters
> Image end offset: 1060044800
> $ ./qemu-img check --output=json /tmp/test.qcow2 
> {
>     "image-end-offset": 1060044800,
>     "total-clusters": 491520,
>     "check-errors": 0,
>     "allocated-clusters": 16164,
>     "filename": "/tmp/test.qcow2",
>     "format": "qcow2",
>     "fragmented-clusters": 1937
> }
this can be done, sure. Is this considered safe
for running VM too?

Den
