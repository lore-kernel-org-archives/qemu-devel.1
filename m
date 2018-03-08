Received: from eggs.gnu.org ([2001:4830:134:3::10]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzPU-0003u2-7x
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzPT-00046F-Fl
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:32:56 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <206d96f6-08a8-d890-aeda-d3144038b043@redhat.com>
Date: Thu, 8 Mar 2018 11:32:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180306160017.GM31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

On 03/06/2018 10:00 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 07, 2018 at 03:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> v2:
>>
>> 01: add block_latency_histogram_clear()
>> 02: fix spelling (sorry =()
>>      some rewordings
>>      remove histogram if latency parameter unspecified
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    block/accounting: introduce latency histogram
>>    qapi: add block latency histogram interface
>>
>>   qapi/block-core.json       | 73 +++++++++++++++++++++++++++++++++-
>>   include/block/accounting.h |  9 +++++
>>   block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qapi.c               | 31 +++++++++++++++
>>   blockdev.c                 | 19 +++++++++
>>   5 files changed, 228 insertions(+), 1 deletion(-)
> 
> The feature looks good.  I posted documentation and code readability
> suggestions.
> 

I also think it makes sense; if a v3 hits the list in time, I will 
probably include it in my last QAPI pull before softfreeze.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
