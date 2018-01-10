Received: from eggs.gnu.org ([2001:4830:134:3::10]:57183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eZEAb-00070Z-L8
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eZEAZ-0007iD-2T
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:03:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1eZEAY-0007gz-Tk
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:03:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0602780F7
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:03:41 +0000 (UTC)
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-3-quintela@redhat.com>
	<20180110062545.GB5984@xz-mi> <87incayua8.fsf@secure.laptop>
	<82a94975-e040-298d-7d10-7448a4a0af48@redhat.com>
	<a037b7b8-2e5c-c800-da49-e0edfcb6eed0@redhat.com>
	<878td6yoxx.fsf@secure.laptop>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <09459af5-76d3-5a8d-1e18-dd96525f9460@redhat.com>
Date: Wed, 10 Jan 2018 12:03:37 +0100
MIME-Version: 1.0
In-Reply-To: <878td6yoxx.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/11] tests: Migration ppc test was
 missing arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

On 10/01/2018 11:43, Juan Quintela wrote:
> Laurent Vivier <lvivier@redhat.com> wrote:
>> On 10/01/2018 10:21, Laurent Vivier wrote:
>>> On 10/01/2018 09:47, Juan Quintela wrote:
>>>> Peter Xu <peterx@redhat.com> wrote:
>>>>> On Fri, Jan 05, 2018 at 10:52:37PM +0100, Juan Quintela wrote:
>>>>>> Argument file is also needed there.
>>>>>>
>>>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>>>
>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>
>>>>> Does it also mean this?
>>>>>
>>>>> Fixes: aaf89c8a49a8c ("test: port postcopy test to ppc64")
>>>>
>>>> Dunno.  I was trying to consolidate the command line options for ppc and
>>>> x86 when I found this problem.  I haven't tested of ppc.
>>>
>>> I don't think it is needed. I think the content of the nvram is migrated
>>> (otherwise the test wouldn't work at all).
>>>
>>> The nvram is created by default, we need the command line parameter only
>>> to populate it from a file.
>>
>> A better change would be to use "-prom-env" instead of "-driver
>> if=pflash". I can send the patch if you want to add it in your series.
> 
> Told the command line and I will add to the line.
> 
> And using the same command in both sides makes easier to see that it is
> correct.
> 
> Later, Juan.
> 

("-machine accel=%s -m 256M"
 " -name pcsource,debug-threads=on"
 " -serial file:%s/src_serial"
 " -prom-env '"
 "boot-command=hex .\" _\" begin %x %x "
 "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
 "until'",  accel, tmpfs, end_address, start_address);

Don't forget to remove include of "hw/nvram/chrp_nvram.h",
MIN_NVRAM_SIZE and init_bootfile_ppc().

Thanks,
Laurent
