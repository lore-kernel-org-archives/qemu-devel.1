Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIahd-0004ow-UX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIaha-0005A5-OL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:08:49 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIaha-00059B-IA
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:08:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR6007LSHUISX60@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:08:42 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <9c4a0e17-0e6c-89ba-0224-a9aa30cbfc61@samsung.com>
Date: Wed, 07 Jun 2017 16:08:39 +0300
MIME-version: 1.0
In-reply-to: <87mv9kez9k.fsf@secure.mitica>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094732eucas1p199fb11b4189929a105515f6079415ebe@eucas1p1.samsung.com>
	<1496828798-27548-12-git-send-email-a.perevalov@samsung.com>
	<87mv9kez9k.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v8 11/11] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

On 06/07/2017 03:52 PM, Juan Quintela wrote:
> Alexey Perevalov <a.perevalov@samsung.com> wrote:
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   docs/migration.txt | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/docs/migration.txt b/docs/migration.txt
>> index 1b940a8..4b625ca 100644
>> --- a/docs/migration.txt
>> +++ b/docs/migration.txt
>> @@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
>>   It can be issued immediately after migration is started or any
>>   time later on.  Issuing it after the end of a migration is harmless.
>>   
>> +Blocktime is a postcopy live migration metric, intended to show
>> +how long the vCPU was in state of interruptable sleep due to pagefault.
>> +This value is calculated on destination side.
>> +To enable postcopy blocktime calculation, enter following command on destination
>> +monitor:
>> +
>> +migrate_set_capability postcopy-blocktime on
>> +
>> +Postcopy blocktime can be retrieved by query-migrate qmp command.
>> +
>>   Note: During the postcopy phase, the bandwidth limits set using
>>   migrate_set_speed is ignored (to avoid delaying requested pages that
>>   the destination is waiting for).
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> If you have to respin, I think that put the units would be a good idea.
> Even you can put the units in the patch where you define the value.
do you mean to extend tests/postcopy-test.c?
>
>
>
>

-- 
Best regards,
Alexey Perevalov
