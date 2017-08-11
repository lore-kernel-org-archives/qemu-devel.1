Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg0i4-0003kE-Dv
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg0i1-0007rH-5n
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:34:04 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg0i1-0007qV-0O
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:34:01 -0400
Received: by mail-qk0-x243.google.com with SMTP id d145so2538838qkc.0
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 20:33:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-2-git-send-email-armbru@redhat.com>
	<1837a5c7-92a2-a40a-5f96-21bd448790bd@redhat.com>
	<87o9rn8k1b.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <14873f69-6858-01e0-984c-1f2abc52f6f3@amsat.org>
Date: Fri, 11 Aug 2017 00:33:54 -0300
MIME-Version: 1.0
In-Reply-To: <87o9rn8k1b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Factor object_create() out of
 main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, el13635@mail.ntua.gr

On 08/10/2017 01:28 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 08/10/2017 07:25 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

for the refactor:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>> ---
>>>   vl.c | 21 ++++++++++-----------
>>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>
>>> +++ b/vl.c
>>> @@ -2845,7 +2845,6 @@ static bool object_create_initial(const char *type)
>>>       return true;
>>>   }
>>>   
>>> -
>>>   /*
>>
>> Spurious whitespace change? I can live with it because it adds
>> consistency, but it's not on a function directly touched by this patch.
> 
> Not intentional (alternatively: I've since forgotten).  I'll drop it.

If you ever send the whitespace change as another patch with at least 
some funny message:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Thanks!
> 
