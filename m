Received: from eggs.gnu.org ([2001:4830:134:3::10]:54444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejTxM-0000oq-1E
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejTxJ-0005x1-0S
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:56:28 -0500
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<20180207175810.6db572e7.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d443eec0-157c-90bf-5b8f-d974d288a37d@redhat.com>
Date: Wed, 7 Feb 2018 11:56:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180207175810.6db572e7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On 02/07/2018 10:58 AM, Cornelia Huck wrote:
> On Wed,  7 Feb 2018 12:38:33 +0000
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> This patch is the s390 implementation of guest crash information,
>> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
>> property") and the related commits. We will detect several crash
>> reasons, with the "disabled wait" being the most important one, since
>> this is used by all s390 guests as a "panic like" notification.
>>

>>
>>    {
>>      "timestamp": {
>>          "seconds": 1518004739,
>>          "microseconds": 552563
>>      },
>>      "event": "GUEST_PANICKED",
>>      "data": {
>>          "action": "pause",
>>          "info": {
>>              "core": 0,
>>              "psw-addr": 1102832,
>>              "reason": "disabledwait",
>>              "psw-mask": 562956395872256,
>>              "type": "s390"
>>          }

Looks like the QAPI part is reasonable.


>> +{ 'enum': 'S390CrashReason',
>> +  'data': [ 'unknown',
>> +            'disabledwait',
>> +            'extintloop',
>> +            'pgmintloop',
>> +            'opintloop' ] }
> 
> Would some hyphens or underscores make this a bit more readable? FWICS,
> QAPI would create something like S390_CRASH_REASON_DISABLED_WAIT for
> 'disabled-wait', which looks reasonable to me.

Yes, some legibility via word separators would help.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
