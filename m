Received: from eggs.gnu.org ([2001:4830:134:3::10]:44814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNg7O-0000St-6s
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNg7J-00044f-KR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:00:58 -0400
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180528111930.GG4580@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af6da90a-87f2-60b5-78a0-9578b2d9b2fa@redhat.com>
Date: Tue, 29 May 2018 10:00:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180528111930.GG4580@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] block: more byte-based cleanups:
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 05/28/2018 06:19 AM, Kevin Wolf wrote:
> Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
>> Based-on: <20180424192506.149089-1-eblake@redhat.com>
>> ([PATCH v2 0/6] block: byte-based AIO read/write)
>> Based-on: <20180424220157.177385-1-eblake@redhat.com>
>> ([PATCH] block: Merge .bdrv_co_writev{, _flags} in drivers)
>>
>> My quest continues.  I spent some time pruning qcow down as far
>> as possible (and was dismayed at how long it took to prove no
>> iotests regressions); so for the other drivers, I did the bare
>> minimum to get rid of an interface, but will leave it to those
>> file owners if they want to get rid of further pointless sector
>> manipulations in their files.
>>
>> Next on the chopping block: bdrv_read/bdrv_write.
> 
> Nice series, looks good apart from a few minor comments on the qcow1
> conversion.

For qcow1, I kept things at 512-byte alignment throughout; as the format 
is not for new users, I find it easier to assert that things are aligned 
than to worry about sub-sector requests.  But yes, I can improve things 
according to your comments for v2.

> 
> For v2, can you please make sure to have proper CCs also on the cover
> letter?

Does git-publish do this automatically?  (If so, it's time for me to 
start using it...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
