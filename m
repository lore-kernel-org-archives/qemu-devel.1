Received: from eggs.gnu.org ([2001:4830:134:3::10]:51853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctb2d-0002Z5-On
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctb2a-0006c5-Ga
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:27:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ctb2a-0006bW-A1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:27:08 -0400
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
	<9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
	<20170328123105.GA4418@thinpad.lan.raisama.net>
	<5d929569-8deb-2de0-4894-ec50ef98c8b9@suse.de>
	<20170330142240.GH3709@thinpad.lan.raisama.net>
	<67d1d8fe-0f0d-3c68-bcf7-6889727b8927@suse.de>
	<20170330142550.GJ3709@thinpad.lan.raisama.net>
From: Alexander Graf <agraf@suse.de>
Message-ID: <3785871c-907b-faa9-8164-7581e9c5e696@suse.de>
Date: Thu, 30 Mar 2017 16:27:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170330142550.GJ3709@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 03/30/2017 04:25 PM, Eduardo Habkost wrote:
> On Thu, Mar 30, 2017 at 04:23:34PM +0200, Alexander Graf wrote:
>> On 03/30/2017 04:22 PM, Eduardo Habkost wrote:
>>> On Tue, Mar 28, 2017 at 02:35:57PM +0200, Alexander Graf wrote:
>>>> On 03/28/2017 02:31 PM, Eduardo Habkost wrote:
>>>>> On Tue, Mar 28, 2017 at 01:26:04PM +0200, Alexander Graf wrote:
>>> [...]
>>>>>> Putting it into a special enum sounds much more fragile than the current
>>>>>> solution to me. We need to bool fallback either way, so I fail to see any
>>>>>> benefit from having the enum.
>>>>> I don't see why the enum would be more fragile. With the QAPI
>>>>> enum, we:
>>>>> * Have a meaningful value for the QOM property 'type' field,
>>>>>      and have some hope to make type information for QOM properties
>>>>>      really useful one day;
>>>>> * Have the possible values for the property well-documented in
>>>>>      the QAPI schema;
>>>>> * Have the string<->enum translation code automatically generated
>>>>>      for us;
>>>>> * Can easily add other values later (I have been planning to
>>>>>      support "feat=host" so "-cpu host/max" aren't special cases in
>>>>>      the code.
>>>>>
>>>> Ok, can you create the boilerplate for an OnOff enum type for me and I'll
>>>> plug =force into that? All that visitor stuff scares me :).
>>> I can do it, if you don't mind waiting for a few days. :)
>>
>> As long as we still manage to hit 2.9 with this I'm all happy :).
> We won't, as this is not a bug fix and we are past hard freeze. :(


Fair point. Then timing isn't critical either way :)


Alex
