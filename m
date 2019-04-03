Received: from eggs.gnu.org ([209.51.188.92]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hBl5K-0003mB-AQ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hBl0r-00031N-33
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hBl0q-00030d-NG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:53:29 -0400
References: <20190329202003.30988-1-chen.zhang@intel.com>
	<1910f60f-c234-f8de-ee03-970c3c3f8bce@redhat.com>
	<9CFF81C0F6B98A43A459C9EDAD400D78060B54DD@shsmsx102.ccr.corp.intel.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6450855-94fb-c18d-448c-e3ca658087c2@redhat.com>
Date: Wed, 3 Apr 2019 14:53:19 -0400
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78060B54DD@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add unmaintained bitmap file
 to related field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Chen" <chen.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-dev <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>



On 4/2/19 9:25 PM, Zhang, Chen wrote:
> 
>> -----Original Message-----
>> From: John Snow [mailto:jsnow@redhat.com]
>> Sent: Wednesday, April 3, 2019 5:07 AM
>> To: Zhang, Chen <chen.zhang@intel.com>; Laurent Vivier <laurent@vivier.eu>;
>> qemu-dev <qemu-devel@nongnu.org>; Fam Zheng <fam@euphon.net>
>> Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add unmaintained bitmap
>> file to related field
>>
>>
>>
>> On 3/29/19 4:20 PM, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> Add bitmap.h and bitops.h to Dirty Bitmaps field.
>>>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>  MAINTAINERS | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index 56139ac8ab..360af3e8ca
>>> 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1773,6 +1773,8 @@ S: Supported
>>>  F: util/hbitmap.c
>>>  F: block/dirty-bitmap.c
>>>  F: include/qemu/hbitmap.h
>>> +F: include/qemu/bitmap.h
>>> +F: include/qemu/bitops.h
>>>  F: include/block/dirty-bitmap.h
>>>  F: tests/test-hbitmap.c
>>>  F: docs/interop/bitmaps.rst
>>>
>>
>> Actually, these bitmaps aren't the same kind as is used by the block storage
>> module -- these are a more generic, primitive kind that I have no association
>> with.
> 
> OK, but these two files are lack of maintenance.
> Which maintenance area do you think these two files should belong to?
> 
> 
> Thanks
> Zhang Chen
> 
> 

Ehm, I'm not sure. Looks like Paolo and Stefan are the active developers
who have touched it the most.

Do the two of you want me to fold this into the bitmaps section so that
it has a point of contact?

--js
