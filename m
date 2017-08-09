Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfS0s-0000e7-Mc
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfS0p-0002Xu-DL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:31:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-47-f4bug@amsat.org>
	<20170728062426.GQ5117@lemon.lan>
	<c3c6b7df-6629-982a-3135-a739979c36e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68e8b9be-17e0-479f-3ec1-84fad488dbc0@amsat.org>
Date: Wed, 9 Aug 2017 11:31:01 -0300
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

Hi Paolo,

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
> 
> Just don't add it to the file.  It doesn't have a specific owner
I thought an entry with F: but no M: was incorrect but apparently 
get_maintainer.pl works and report it as "unknown" status, as for the 
"Coroutines" section:

$ ./scripts/get_maintainer.pl -f util/coroutine-ucontext.c
Stefan Hajnoczi <stefanha@redhat.com> (unknown:Coroutines)
Kevin Wolf <kwolf@redhat.com> (unknown:Coroutines)
qemu-devel@nongnu.org (open list:All patches CC here)

So to enjoy the R-tag I'll remove the S-tag in v2 and see if Eric is ok 
with it :)

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
