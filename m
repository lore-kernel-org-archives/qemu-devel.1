Received: from eggs.gnu.org ([2001:4830:134:3::10]:33821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehGke-0005nl-JS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehGkb-0006MH-3E
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:26:12 -0500
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com
	([104.47.33.75]:12376
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ehGka-0006M1-Si
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:26:09 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-18-brijesh.singh@amd.com>
	<87mv0tvs6a.fsf@dusky.pond.sub.org>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <315572b0-2893-2247-c20b-717becd9661c@amd.com>
Date: Thu, 1 Feb 2018 09:25:59 -0600
MIME-Version: 1.0
In-Reply-To: <87mv0tvs6a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 17/23] qapi: add SEV_MEASUREMENT event
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



On 01/31/2018 11:45 AM, Markus Armbruster wrote:
> Brijesh Singh <brijesh.singh@amd.com> writes:
> 
>> Add SEV_MEASUREMENT event which can be used by libvirt to get the
>> measurement of the memory regions encrypted through the SEV launch
>> flow. The measurement value is base64 encoded.
>>
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   qapi-schema.json | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 2046c96669bf..e1f5d14e2e3f 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -3192,3 +3192,16 @@
>>   # Since: 2.11
>>   ##
>>   { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>> +
>> +##
>> +# @SEV_MEASUREMENT:
>> +#
>> +# Emitted when measurement is available for the SEV guest.
>> +#
>> +# @value: measurement value encoded in base64
>> +#
>> +# Since: 2.12
>> +#
>> +##
>> +{ 'event' : 'SEV_MEASUREMENT',
>> +  'data' : { 'value' : 'str' } }
> 
> New event -> automatic question: do we need a way to poll for this
> information?  Say when an event could get lost during a libvirt restart.
> 


In our initial SEV patches for libvirt we ran into similar cases where 
the event was dropped on restart, and now leaning towards dropping this 
event patch and add a new QMP command which can be used by libvirt to 
retrieve the measurement.
