Received: from eggs.gnu.org ([2001:4830:134:3::10]:59057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evhQD-0001Xm-EF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evhQC-0005AC-HJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:44:45 -0400
References: <20180312211156.452139-1-eblake@redhat.com>
	<1ac1ca19-8f5f-0c6e-f676-699720fba303@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <43c6dd95-21cd-2d4b-c9e1-06b51640944e@virtuozzo.com>
Date: Tue, 13 Mar 2018 13:44:32 +0300
MIME-Version: 1.0
In-Reply-To: <1ac1ca19-8f5f-0c6e-f676-699720fba303@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix stuck NBD process on 33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 13/3/2018 12:12 AM, Max Reitz wrote:
> On 2018-03-12 22:11, Eric Blake wrote:
>> Commit afe35cde6 added additional actions to test 33, but forgot
>> to reset the image between tests.  As a result, './check -nbd 33'
>> fails because the qemu-nbd process from the first half is still
>> occupying the port, preventing the second half from starting a
>> new qemu-nbd process.  Worse, the failure leaves a rogue qemu-nbd
>> process behind even after the test fails, which causes knock-on
>> failures to later tests that also want to start qemu-nbd.
>>
>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I'll take this through my NBD queue (pull request within the next 16
>> hours), as obviously I want to test that the other patches on that
>> queue can get past the iotests for NBD :)
>>
>>   tests/qemu-iotests/033 | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

ack; thanks!
