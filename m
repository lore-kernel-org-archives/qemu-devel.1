Received: from eggs.gnu.org ([2001:4830:134:3::10]:55277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfAF2-0007oZ-Dr
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfAF1-0005o7-FO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:32:36 -0400
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-3-jsnow@redhat.com>
	<fb086d6f-262b-e29e-8276-56502c492846@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <482dca36-86ff-1e7f-96c6-2e3ee65bd836@redhat.com>
Date: Tue, 8 Aug 2017 15:32:09 -0400
MIME-Version: 1.0
In-Reply-To: <fb086d6f-262b-e29e-8276-56502c492846@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] IDE: test flush on empty CDROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com



On 08/08/2017 03:20 PM, Eric Blake wrote:
> On 08/08/2017 12:57 PM, John Snow wrote:
>> From: Kevin Wolf <kwolf@redhat.com>
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/ide-test.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
> 
>> +static void test_flush_empty_drive(void)
>> +{
>> +    QPCIDevice *dev;
>> +    QPCIBar bmdma_bar, ide_bar;
>> +
>> +    ide_test_start("-device ide-cd,bus=ide.0");
>> +    dev = get_pci_device(&bmdma_bar, &ide_bar);
>> +
>> +    /* FLUSH CACHE command on device 0*/
> 
> Space before */
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I agree with your assessment of 1 and 2 being 2.10 material.
> 

Yep, thanks. I just wanted to include Kevin's attempt at fixing the root
problem to make it clear that:

(A) The root problem is known and being worked on, but
(B) Is evidently not ready for prime time.

I'll stage 1 & 2 with your minor typo edit here, thank you.

--js
