Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daROS-0003ZN-Ho
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daROR-00055m-L1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1daROR-000554-CX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C079C04B92A
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:50:46 +0000 (UTC)
References: <20170725141041.1195-1-berrange@redhat.com>
	<be2523ce-7505-b3dd-d359-e91ac25f3cc4@redhat.com>
	<20170726080754.GB28914@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <86a659a9-b9e1-7f0c-ee53-399e168dd1f7@redhat.com>
Date: Wed, 26 Jul 2017 14:50:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170726080754.GB28914@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: document existance of
 versioned machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 07/26/2017 04:07 AM, Daniel P. Berrange wrote:
> On Tue, Jul 25, 2017 at 01:46:23PM -0400, John Snow wrote:
>>
>>
>> On 07/25/2017 10:10 AM, Daniel P. Berrange wrote:
>>> The -machine docs did not explain what the versioned machine
>>> types are for, nor that they'll be maintained across
>>> releases.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>    qemu-options.hx | 15 ++++++++++++++-
>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 746b5fa75d..9f6e2adfff 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -49,7 +49,20 @@ STEXI
>>>    @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
>>>    @findex -machine
>>>    Select the emulated machine by @var{name}. Use @code{-machine help} to list
>>> -available machines. Supported machine properties are:
>>> +available machines.
>>> +
>>> +For architectures which aim to support live migration compatibility
>>> +across releases, each release will introduce a new versioned machine
>>> +type. For example, the 2.8.0 release introduced machine types
>>> +``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
>>> +
>>> +To allow live migration of guests from QEMU version 2.8.0, to QEMU
>>> +version 2.9.0, the 2.9.0 version must support the ``pc-i440fx-2.8''
>>> +and ``pc-q35-2.8'' machines too. To allow users live migrating VMs
>>> +to skip multiple intermediate releases when upgrading, new releases
>>> +of QEMU will support machine types from many previous versions.
>>> +
>>> +Supported machine properties are:
>>>    @table @option
>>>    @item accel=@var{accels1}[:@var{accels2}[:...]]
>>>    This is used to enable an accelerator. Depending on the target architecture,
>>>
>>
>> Seems like an improvement to me, but do we have any formal policy on how
>> long we support said machine types? The new wording prompts that question.
> 
> I wasn't going to mention that in this patch, to avoid delay on getting it
> merged. I was going to send a further patch that makes it explicit that we
> will never delete machine types for as long as any active QEMU contributor
> has need for them in downstream version they maintain
> 
>> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Regards,
> Daniel
> 

OK, just asking. I agree we don't need to delay this patch if you want 
it in for 2.10, which is a worthwhile and good thing.

Thanks!

--js
