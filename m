Received: from eggs.gnu.org ([2001:4830:134:3::10]:44162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx87-0006g6-Nj
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx83-0008UI-HS
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:50:35 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:39532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx82-0008Qf-PK
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:50:31 -0400
Received: by mail-ua1-x944.google.com with SMTP id g18-v6so1492230uam.6
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:50:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180810132800.38549-1-eblake@redhat.com>
	<904458f5-7eeb-649d-7aff-9d9ff6d75d64@redhat.com>
	<874lfyenvg.fsf@dusky.pond.sub.org>
	<cfded956-ccab-1070-ba1c-9a73bd61cc5d@redhat.com>
	<8736vfkb1l.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <495bbabd-17db-27e3-2cdf-11b35a8d813e@amsat.org>
Date: Wed, 15 Aug 2018 11:50:21 -0300
MIME-Version: 1.0
In-Reply-To: <8736vfkb1l.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, alex.bennee@linaro.org, rth@twiddle.net

On 08/15/2018 10:35 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 08/13/2018 02:17 AM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 08/10/2018 08:28 AM, Eric Blake wrote:
>>>>> Instead of using a raw assert, print the information in an
>>>>> easier to understand way:
>>>>>
>>>>> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>>>>
>>>> Well, it would help if my commit message actually matched...
>>>>
>>>>
>>>>> +        if (wstatus) {
>>>>> +            if (WIFEXITED(wstatus)) {
>>>>> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
>>>>> +                        "process but encountered exit status %d\n",
>>>>> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
>>>>> +            } else if (WIFSIGNALED(wstatus)) {
>>>>> +                int sig = WTERMSIG(wstatus);
>>>>> +                const char *signame = strsignal(sig) ?: "unknown ???";
>>>>> +                const char *dump = WCOREDUMP(wstatus) ? " (dumped core)" : "";
>>>>> +
>>>>> +                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
>>>>> +                        "from signal %d (%s)%s\n",
>>>>
>>>> ...the code.
>>>
>>> I got libqtest patches in my queue, and I could stick this patch in.
>>> Would you like me to touch up the commit message when I apply?  Or
>>> should I expect v5?
>>>
>>
>> If you don't mind doing the touchup (s/core dumped/dumped core/), then
>> I don't need to submit v5.
> 
> Since "core dumped" is how the shell traditionally reports this, I'd
> prefer to adjust the code to match the commit message.  Okay?
> 

Apparently your commit message betrayed you =) You are also custom to
see "core dumped" in your terminal.

I also prefer "core dumped", this is the default string I'm custom to
fgrep for, and the quoted version I expect other people to google for.

With code adjusted:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
