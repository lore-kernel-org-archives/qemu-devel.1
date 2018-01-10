Received: from eggs.gnu.org ([2001:4830:134:3::10]:35689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHgJ-00016X-0N
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHgE-0001Kh-6T
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:48:43 -0500
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
	<6a99fa98-5e81-ffa6-22c1-240d41ecac96@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5940ab57-4fbc-17ef-25bc-6abed8ba44dd@redhat.com>
Date: Wed, 10 Jan 2018 15:48:08 +0100
MIME-Version: 1.0
In-Reply-To: <6a99fa98-5e81-ffa6-22c1-240d41ecac96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On 10/01/2018 15:43, Eric Blake wrote:
> On 01/10/2018 03:18 AM, Fam Zheng wrote:
>> This is a new protocol driver that exclusively opens a host NVMe
>> controller through VFIO. It achieves better latency than linux-aio by
>> completely bypassing host kernel vfs/block layer.
>>
>>     $rw-$bs-$iodepth  linux-aio     nvme://
>>     ----------------------------------------
>>     randread-4k-1     10.5k         21.6k
>>     randread-512k-1   745           1591
>>     randwrite-4k-1    30.7k         37.0k
>>     randwrite-512k-1  1945          1980
>>
>>     (unit: IOPS)
>>
>> The driver also integrates with the polling mechanism of iothread.
>>
>> This patch is co-authored by Paolo and me.
> 
> Then shouldn't you include Paolo's S-o-b?

If you want, it's here:

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I wrote perhaps 50-100 lines of code.

Paolo

> 
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
> 
> 
