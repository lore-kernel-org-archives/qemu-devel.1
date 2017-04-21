Received: from eggs.gnu.org ([2001:4830:134:3::10]:57245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1aqe-00050I-Q2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1aqZ-0007PI-3c
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:51:52 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d1aqY-0007P0-U2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:51:47 -0400
Received: by mail-wr0-x243.google.com with SMTP id v42so4103990wrc.3
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 08:51:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
	<a8eb495d-7c03-2d6f-c8df-3970f08bc05d@twiddle.net>
	<20170420100301.51a7f10c@t450s.home>
	<07d71898-c392-c14a-9901-87ad4287bd5d@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <06d0870c-2b1e-0c41-63d3-128e642f78c1@twiddle.net>
Date: Fri, 21 Apr 2017 08:51:42 -0700
MIME-Version: 1.0
In-Reply-To: <07d71898-c392-c14a-9901-87ad4287bd5d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] VFIO: Make 8-byte accesses atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com

On 04/21/2017 03:06 AM, Paolo Bonzini wrote:
>
>
> On 20/04/2017 18:03, Alex Williamson wrote:
>> On Thu, 20 Apr 2017 00:19:23 -0700
>> Richard Henderson <rth@twiddle.net> wrote:
>>
>>> On 04/19/2017 12:44 PM, Jose Ricardo Ziviani wrote:
>>>> This patchset has two patches:
>>>> [1] 8-byte writes to non-mapped MMIO are broken into pairs of 4-byte writes, this patch makes such pairs atomic.
>>>>
>>>> [2] Enable 8-byte accesses in vfio_region_write and vfio_region_read.
>>>>
>>>> Patches based on master.
>>>>
>>>> Jose Ricardo Ziviani (2):
>>>>   vfio: Set MemoryRegionOps:max_access_size and min_access_size
>>>>   vfio: enable 8-byte reads/writes to vfio
>>>>
>>>>  hw/vfio/common.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>
>>> I think these patches need to be squashed to be bisectable.
>>
>> No, I think it's fine.  The point of patch 1/2 is to indicate that the
>> hardware supports 8-byte accesses, which will still be broken into 2
>> 4-byte accesses because we don't yet set the implemented width beyond
>> the default.  The important part is that the mutex will now group the 4
>> byte access pair together rather than letting them get re-ordered.
>> Patch 2/2 then implements native 8-byte access.  I appreciate them
>> being separate for this subtle nuance, but maybe I'm not seeing the
>> same issue as you.  Thanks,
> '
> I agree, the patches looks fine as is.

Sorry, I misread the first patch, thinking that indicating hw support for 8 
byte required implementation of 8 byte.


r~
