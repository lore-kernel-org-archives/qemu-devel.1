Received: from eggs.gnu.org ([2001:4830:134:3::10]:42912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKqL-0000qd-BS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKqK-0001gy-DW
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:49:01 -0500
References: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
	<1818f13c-0e9e-70da-8d39-9ff9f07c3982@redhat.com>
	<8e7db8ab-359e-8ee4-4a0b-1c6f9523f652@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74d6db7d-da96-a546-3784-3d4f2f9b2a96@redhat.com>
Date: Thu, 15 Feb 2018 08:48:37 -0600
MIME-Version: 1.0
In-Reply-To: <8e7db8ab-359e-8ee4-4a0b-1c6f9523f652@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Richard W M Jones <rjones@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 02/15/2018 08:09 AM, Murilo Opsfelder Araujo wrote:
> On 01/05/2018 02:57 PM, Eric Blake wrote:
>> On 01/05/2018 08:44 AM, Murilo Opsfelder Araujo wrote:
>>> This patch prevents a possible segmentation fault when .desc members are checked
>>> against NULL.
>>>

>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
>>> ---
>>>   block/ssh.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>
>> CC: qemu-stable@nongnu.org
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Hi, Eric.
> 
> Was this supposed to land stable-2.11 branch?

Oh well, it missed 2.11.1.  I don't think it's too much of a 
show-stopper.  If we have a 2.11.2, hopefully it gets in then; 
otherwise, waiting for 2.12 will be sufficient.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
