Received: from eggs.gnu.org ([2001:4830:134:3::10]:32928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehGgI-0003Xa-6H
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehGgD-00046d-8w
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:21:42 -0500
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com
	([104.47.32.63]:31808
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ehGgC-000434-Vr
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:21:37 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
	<87r2q5vs8c.fsf@dusky.pond.sub.org>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c37ea75a-8eb0-e896-8751-96b10bce278a@amd.com>
Date: Thu, 1 Feb 2018 09:21:26 -0600
MIME-Version: 1.0
In-Reply-To: <87r2q5vs8c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 13/23] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 01/31/2018 11:43 AM, Markus Armbruster wrote:
> Brijesh Singh <brijesh.singh@amd.com> writes:
> 
>> update 'info kvm' to display the memory encryption support.
>>
>> (qemu) info kvm
>> kvm support: enabled
>> memory encryption: disabled
>>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   hmp.c            | 2 ++
>>   qapi-schema.json | 5 ++++-
>>   qmp.c            | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index 056bf70cf1e2..6ceb6b30af75 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -88,6 +88,8 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
>>       monitor_printf(mon, "kvm support: ");
>>       if (info->present) {
>>           monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
>> +        monitor_printf(mon, "memory encryption: %s\n",
>> +                       info->mem_encryption ? "enabled" : "disabled");
>>       } else {
>>           monitor_printf(mon, "not compiled\n");
>>       }
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 5c06745c7927..2046c96669bf 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -314,9 +314,12 @@
>>   #
>>   # @present: true if KVM acceleration is built into this executable
>>   #
>> +# @mem-encryption: true if Memory Encryption is active (since 2.12)
>> +#
>>   # Since: 0.14.0
>>   ##
>> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
>> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
>> +            'mem-encryption' : 'bool'} }
> 
> This extends QMP's query-kvm.  Your commit message claims the patch
> affects only HMP.  Needs fixing.  The cleanest way is to split the patch
> into its QMP part (hunks #2 and #3) and its HMP part (hunk #1).
> 


Noted, I will break this into two patches in next series. Thanks for 
feedback.
