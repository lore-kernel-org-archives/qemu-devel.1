Received: from eggs.gnu.org ([2001:4830:134:3::10]:58232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv2z-0005M8-92
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv2y-0008Tq-Cu
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:48:37 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180803073836.GC4380@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <51195db7-90c6-c05f-a7d9-04c5c3e5e83c@janustech.com>
Date: Sat, 4 Aug 2018 14:48:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180803073836.GC4380@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] qcow2: Make the L2 cache cover the
 whole image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/03/2018 10:38 AM, Kevin Wolf wrote:
> Am 29.07.2018 um 23:27 hat Leonid Bloch geschrieben:
>> This series makes the qcow2 L2 cache cover the entire image by default.
>> The importance of this change is in noticeable performance improvement,
>> especially with heavy random I/O. The memory overhead is very small:
>> only 1 MB of cache for every 8 GB of image size. On systems with very
>> limited RAM the maximal cache size can be limited by the existing
>> cache-size and l2-cache-size options.
>>
>> The L2 cache is also resized accordingly, by default, if the image is
>> resized.
> 
> Are you going to send a new version that makes the changes we agreed on?

Yes, sure. Was somewhat busy. Will send today or tomorrow.

Thanks for reminding.
Leonid.

> 
> Kevin
> 
