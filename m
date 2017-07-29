Received: from eggs.gnu.org ([2001:4830:134:3::10]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbFr4-0004vT-2s
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbFr0-0001jj-VI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 20:43:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-47-f4bug@amsat.org>
	<20170728062426.GQ5117@lemon.lan>
	<c3c6b7df-6629-982a-3135-a739979c36e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d534366-8c19-5cdc-aeff-21800dde5dfb@amsat.org>
Date: Fri, 28 Jul 2017 21:43:31 -0300
MIME-Version: 1.0
In-Reply-To: <c3c6b7df-6629-982a-3135-a739979c36e7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 46/47] MAINTAINERS: add missing entries
 for Coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 07/28/2017 08:50 AM, Paolo Bonzini wrote:
> On 28/07/2017 08:24, Fam Zheng wrote:
>> On Fri, 07/28 02:36, Philippe Mathieu-Daudé wrote:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 224890643d..7854792765 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1537,6 +1537,12 @@ Checkpatch
>>>   S: Odd Fixes
>>>   F: scripts/checkpatch.pl
>>>   
>>> +Coccinelle scripts
>>> +R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> +S: Orphan
>>
>> "Orphan" sounds like we don't care much anymore but I suppose this is not the
>> case. But I don't have any better idea either.

         M: Mail patches to: FullName <address@domain>
         R: Designated reviewer: FullName <address@domain>

M: is mail of maintainer
R: is mail of reviewer

         S: Status, one of the following:

            Maintained:  Someone actually looks after it.
            Odd Fixes:   It has a maintainer but they don't have time
                         to do much other than throw the odd patch in.
->         Orphan:      No current maintainer

"Orphan" sounds the best fit... Do you want to raise it to "Odd Fixes"? 
This implies having a maintainer... I don't feel confident enough to Ack 
cocci scripts but an incorrect cocci script will not break QEMU so maybe 
I cat take M: for Odd Fixes, and lowering it back to Orphan without 
maintainer is 1 commit easy :)

> 
> Just don't add it to the file.  It doesn't have a specific owner.

Paolo you mean don't add the "S: Status" to the MAINTAINERS file, or the 
"F: *cocci*" entries?

Regards,

Phil.

> 
> Paolo
> 
>>
>> Fam
>>
>>> +F: scripts/cocci-macro-file.h
>>> +F: scripts/coccinelle/
>>> +
>>>   Migration
>>>   M: Juan Quintela <quintela@redhat.com>
>>>   M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> @@ -1970,4 +1976,3 @@ Build system architecture
>>>   M: Daniel P. Berrange <berrange@redhat.com>
>>>   S: Odd Fixes
>>>   F: docs/devel/build-system.txt
> 
