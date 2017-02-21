Received: from eggs.gnu.org ([2001:4830:134:3::10]:43127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1cgKCE-0000rj-8R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1cgKC9-0008RG-V1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:50:13 -0500
Received: from mail-db5eur01on0098.outbound.protection.outlook.com
	([104.47.2.98]:21818
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eyakovlev@virtuozzo.com>)
	id 1cgKC9-0008Ny-6B
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:50:09 -0500
References: <1487614915-18710-1-git-send-email-den@openvz.org>
	<1487614915-18710-3-git-send-email-den@openvz.org>
	<7e55a8e9-0a5d-5602-7626-9c7976f6a49c@redhat.com>
	<d97212a0-fa95-6614-bd5b-62225f789da9@openvz.org>
From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Message-ID: <28e2ab5f-3bfd-17a8-6fab-6a67f41e0b47@virtuozzo.com>
Date: Tue, 21 Feb 2017 11:15:08 +0300
MIME-Version: 1.0
In-Reply-To: <d97212a0-fa95-6614-bd5b-62225f789da9@openvz.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: flatten GuestPanicInformation
 union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>



On 20.02.2017 22:58, Denis V. Lunev wrote:
> On 02/20/2017 08:48 PM, Eric Blake wrote:
>> On 02/20/2017 12:21 PM, Denis V. Lunev wrote:
>>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> CC: Eric Blake <eblake@redhat.com>
>>> ---
>>>   qapi-schema.json  | 12 ++++++++++++
>>>   target/i386/cpu.c | 15 ++++++---------
>>>   vl.c              | 12 ++++++------
>>>   3 files changed, 24 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>> index e9a6364..b142e15 100644
>>> --- a/qapi-schema.json
>>> +++ b/qapi-schema.json
>>> @@ -5872,6 +5872,16 @@
>>>     'data': [ 'pause', 'poweroff' ] }
>>>   
>>>   ##
>>> +# @GuestPanicInformationType:
>>> +#
>>> +# An enumeration of the guest panic information types
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'enum': 'GuestPanicInformationType',
>>> +  'data': [ 'hyper-v'] }
>> Perhaps 'hyperv' is better? It's the difference between
>> GUEST_PANIC_INFORMATION_TYPE_HYPER_V and
>> GUEST_PANIC_INFORMATION_TYPE_HYPERV. But that's bikeshedding, so no need
>> to change it.
>>
>> Must go into 2.9, so we aren't baking in bad API.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> We can you plain 'hv', like all command line options controlling
> HyperV features.
>
> Roman, Evgeniy, do you have any opinion on that?

In vmbus we've settled on using "hyperv-" prefixes for stuff related to 
QAPI namespace and QOM objects' property names: "hyperv-synic", 
"hyperv-sint-route", etc. We might as well stick to it.

>
> Den
