Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76359C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482D42073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482D42073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQDu-00053F-HX
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1icQ5r-0001fw-QO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1icQ5f-0003zx-KH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:33:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:28810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1icQ5b-0003cu-Ul
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:32:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 00:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,276,1571727600"; d="scan'208";a="208772559"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.255.28.109])
 ([10.255.28.109])
 by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2019 00:32:39 -0800
Subject: Re: Network connection with COLO VM
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Daniel Cho <danielcho@qnap.com>
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
 <20191202095806.GA2904@work-vm>
 <CA+XQNE6pmj=-tMxCUamY3U4jNuBNR7=rjeFwhbps7a6YNAsYog@mail.gmail.com>
 <20191203132504.GH3078@work-vm>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <f6bf1e64-a66e-9df8-04f6-b543753eda79@intel.com>
Date: Wed, 4 Dec 2019 16:32:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203132504.GH3078@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "lukasstraub2@web.de" <lukasstraub2@web.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/3/2019 9:25 PM, Dr. David Alan Gilbert wrote:
> * Daniel Cho (danielcho@qnap.com) wrote:
>> Hi Dave,
>>
>> We could use the exist interface to add netfilter and chardev, it might not
>> have the problem you said.
>>
>> However, the netfilter and chardev on the primary at the start, that means
>> we could not dynamic set COLO
>> feature to VM?
> I wasn't expecting that to be possible - I'd expect you to be able
> to start in a state that looks the same as a primary+failed secondary;
> but I'm not sure.

Current COLO (with Lukas's patch) can support dynamic set COLO system.

This status is same like the secondary has triggered failover, the 
primary node need to find new secondary

node to combine new COLO system.


>> We try to change this chardev to prevent primary VM will stuck to wait
>> secondary VM.
>>
>> -chardev socket,id=compare1,host=127.0.0.1,port=9004,server,wait \
>>
>> to
>>
>> -chardev socket,id=compare1,host=127.0.0.1,port=9004,server,nowait \
>>
>> But it will make primary VM's network not works. (Can't get ip), until
>> starting connect with secondary VM.

I think you need to check the port 9004 if already connect to the pair node.

> I'm not sure of the answer to this; I've not tried doing it - I'm not
> sure anyone has!
> But, the colo components do track the state of tcp connections, so I'm
> expecting that they have to already exist to have the state of those
> connections available for when you start the secondary.

Yes, you are right.

For this status, we don't need to sync the state of tcp connections, 
because after failover

(or just solo COLO primary node), we have empty all the tcp connections 
state in COLO module.

In the processing of build new COLO pair, we will sync all the VM state 
to secondary node and re-build

new track things in COLO module.


>
>
>> Otherwise, the primary VM with netfileter / chardev and without netfilter /
>> chardev , they takes very different
>> booting time.
>> Without  netfilter / chardev : about 1 mins
>> With   netfilter / chardev : about 5 mins
>> Is this an issue?
> that sounds like it needs investigating.
>
> Dave

Yes, In previous COLO use cases, we need make primary node and secondary 
node boot in the same time.

I did't expect such a big difference on netfilter/chardev.

I think you can try without netfilter/chardev, after VM boot, re-build 
the netfilter/chardev related work with chardev server nowait.


Thanks

Zhang Chen

>
>> Best regards,
>> Daniel Cho
>>
>>
>> Dr. David Alan Gilbert <dgilbert@redhat.com> 於 2019年12月2日 週一 下午5:58寫道：
>>
>>> * Daniel Cho (danielcho@qnap.com) wrote:
>>>> Hi Zhang,
>>>>
>>>> We use qemu-4.1.0 release on this case.
>>>>
>>>> I think we need use block mirror to sync the disk to secondary node
>>> first,
>>>> then stop the primary VM and build COLO system.
>>>>
>>>> In the stop moment, you need add some netfilter and chardev socket node
>>> for
>>>> COLO, maybe you need re-check this part.
>>>>
>>>>
>>>> Our test was already follow those step. Maybe I could describe the detail
>>>> of the test flow and issues.
>>>>
>>>>
>>>> Step 1:
>>>>
>>>> Create primary VM without any netfilter and chardev for COLO, and using
>>>> other host ping primary VM continually.
>>>>
>>>>
>>>> Step 2:
>>>>
>>>> Create secondary VM (the same device/drive with primary VM), and do block
>>>> mirror sync ( ping to primary VM normally )
>>>>
>>>>
>>>> Step 3:
>>>>
>>>> After block mirror sync finish, add those netfilter and chardev to
>>> primary
>>>> VM and secondary VM for COLO ( *Can't* ping to primary VM but those
>>> packets
>>>> will be received later )
>>>>
>>>>
>>>> Step 4:
>>>>
>>>> Start migrate primary VM to secondary VM, and primary VM & secondary VM
>>> are
>>>> running ( ping to primary VM works and receive those packets on step 3
>>>> status )
>>>>
>>>>
>>>>
>>>>
>>>> Between Step 3 to Step 4, it will take 10~20 seconds in our environment.
>>>>
>>>> I could image this issue (delay reply packets) is because of setting COLO
>>>> proxy for temporary status,
>>>>
>>>> but we thought 10~20 seconds might a little long. (If primary VM is
>>> already
>>>> doing some jobs, it might lose the data.)
>>>>
>>>>
>>>> Could we reduce those time? or those delay is depends on different VM?
>>> I think you need to set up the netfilter and chardev on the primary at
>>> the start;  the filter contains the state of the TCP connections working
>>> with the VM, so adding it later can't gain that state for existing
>>> connections.
>>>
>>> Dave
>>>
>>>> Best Regard,
>>>>
>>>> Daniel Cho.
>>>>
>>>>
>>>>
>>>> Zhang, Chen <chen.zhang@intel.com> 於 2019年11月30日 週六 上午2:04寫道：
>>>>
>>>>>
>>>>>
>>>>>
>>>>> *From:* Daniel Cho <danielcho@qnap.com>
>>>>> *Sent:* Friday, November 29, 2019 10:43 AM
>>>>> *To:* Zhang, Chen <chen.zhang@intel.com>
>>>>> *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
>>> lukasstraub2@web.de;
>>>>> qemu-devel@nongnu.org
>>>>> *Subject:* Re: Network connection with COLO VM
>>>>>
>>>>>
>>>>>
>>>>> Hi David,  Zhang,
>>>>>
>>>>>
>>>>>
>>>>> Thanks for replying my question.
>>>>>
>>>>> We know why will occur this issue.
>>>>>
>>>>> As you said, the COLO VM's network needs
>>>>>
>>>>> colo-proxy to control packets, so the guest's
>>>>>
>>>>> interface should set the filter to solve the problem.
>>>>>
>>>>>
>>>>>
>>>>> But we found another question, when we set the
>>>>>
>>>>> fault-tolerance feature to guest (primary VM is running,
>>>>>
>>>>> secondary VM is pausing), the guest's network would not
>>>>>
>>>>> responds any request for a while (in our environment
>>>>>
>>>>> about 20~30 secs) after secondary VM runs.
>>>>>
>>>>>
>>>>>
>>>>> Does it be a normal situation, or a known issue?
>>>>>
>>>>>
>>>>>
>>>>> Our test is creating primary VM for a while, then creating
>>>>>
>>>>> secondary VM to make it with COLO feature.
>>>>>
>>>>>
>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>>
>>>>>
>>>>> Happy to hear you have solved ssh disconnection issue.
>>>>>
>>>>>
>>>>>
>>>>> Do you use Lukas’s patch on this case?
>>>>>
>>>>> I think we need use block mirror to sync the disk to secondary node
>>> first,
>>>>> then stop the primary VM and build COLO system.
>>>>>
>>>>> In the stop moment, you need add some netfilter and chardev socket node
>>>>> for COLO, maybe you need re-check this part.
>>>>>
>>>>>
>>>>>
>>>>> Best Regard,
>>>>>
>>>>> Daniel Cho
>>>>>
>>>>>
>>>>>
>>>>> Zhang, Chen <chen.zhang@intel.com> 於 2019年11月28日 週四 上午9:26寫道：
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>> Sent: Wednesday, November 27, 2019 6:51 PM
>>>>>> To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
>>>>>> <chen.zhang@intel.com>; lukasstraub2@web.de
>>>>>> Cc: qemu-devel@nongnu.org
>>>>>> Subject: Re: Network connection with COLO VM
>>>>>>
>>>>>> * Daniel Cho (danielcho@qnap.com) wrote:
>>>>>>> Hello everyone,
>>>>>>>
>>>>>>> Could we ssh to colo VM (means PVM & SVM are starting)?
>>>>>>>
>>>>>> Lets cc in Zhang Chen and Lukas Straub.
>>>>> Thanks Dave.
>>>>>
>>>>>>> SSH will connect to colo VM for a while, but it will disconnect
>>> with
>>>>>>> error
>>>>>>> *client_loop: send disconnect: Broken pipe*
>>>>>>>
>>>>>>> It seems to colo VM could not keep network session.
>>>>>>>
>>>>>>> Does it be a known issue?
>>>>>> That sounds like the COLO proxy is getting upset; it's supposed to
>>>>> compare
>>>>>> packets sent by the primary and secondary and only send one to the
>>>>> outside
>>>>>> - you shouldn't be talking directly to the guest, but always via the
>>>>> proxy.  See
>>>>>> docs/colo-proxy.txt
>>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>> I have try ssh to COLO guest with 8 hours, not occurred this issue.
>>>>> Please check your network/qemu configuration.
>>>>> But I found another problem maybe related this issue, if no network
>>>>> communication for a period of time(maybe 10min), the first message
>>> send to
>>>>> guest have a chance with delay(maybe 1-5 sec), I will try to fix it
>>> when I
>>>>> have time.
>>>>>
>>>>> Thanks
>>>>> Zhang Chen
>>>>>
>>>>>> Dave
>>>>>>
>>>>>>> Best Regard,
>>>>>>> Daniel Cho
>>>>>> --
>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

