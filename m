Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8ztP-0003XK-GD
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8ztM-0006iS-Fc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:01:19 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:34321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8ztM-0006hw-Bv
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:01:16 -0400
Received: by mail-qk0-x230.google.com with SMTP id k74so37537446qke.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 19:01:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
	<20170510235204.9657-1-f4bug@amsat.org>
	<551f0d70-acdf-1a40-6aec-00b1dd40133d@amsat.org>
	<87efvvzrwo.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cc870909-1694-73a3-db66-2d113736c7d6@amsat.org>
Date: Thu, 11 May 2017 23:01:09 -0300
MIME-Version: 1.0
In-Reply-To: <87efvvzrwo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>Eric Blake <eblake@redhat.com>

Hi Markus,

On 05/11/2017 06:03 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Ok I just understood Richard explanation, so this patch is WRONG and I
>> need to get some real rest :(
>
> Ha!  Get some sleep; we'll still be around in the morning ;)
>
>> On 05/10/2017 08:52 PM, Philippe Mathieu-Daudé wrote:
>>> Apply this script using:
>>>
>>> $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>>>     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>>>     --macro-file scripts/cocci-macro-file.h \
>>>     --dir target \
>>>     --in-place
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>
>>> This is a new version of the coccinelle script addressing Richard comments and
>>> trying to do it correctly. Also changed license to GPLv2+.
>>>
>>> The first rule matches, it calls a python2 script that basically checks the
>>> target_ulong is not overflowed: (msk << ofs) >> sizeof(target_ulong) == 0
>>
>> WRONG
> [...]
>
> Is this script likely to be rerun in the future?  If yes, keeping it in
> scripts/coccinelle/ is a good idea.  If no, I recommend to store it in
> the commit message instead.

It is unlikely to be rerun in the future, at least for this specific 
pattern. But it can be easily adapted for another TCG optimization.

I could not find much documentation about how to do a such script using 
Python, except on a thread [1]. If it is documented enough I think it is 
worth to keep it.

About putting it in each commit message, it is now 3 times bigger than 
the patch it generates!

Regards,

Phil.
