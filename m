Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpvxN-0000kg-AD
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpvxJ-0007KU-OX
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:35:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpvxJ-0007K4-H2
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:35:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180810132800.38549-1-eblake@redhat.com>
	<904458f5-7eeb-649d-7aff-9d9ff6d75d64@redhat.com>
	<874lfyenvg.fsf@dusky.pond.sub.org>
	<cfded956-ccab-1070-ba1c-9a73bd61cc5d@redhat.com>
Date: Wed, 15 Aug 2018 15:35:18 +0200
In-Reply-To: <cfded956-ccab-1070-ba1c-9a73bd61cc5d@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 10:00:29 -0500")
Message-ID: <8736vfkb1l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, rth@twiddle.net

Eric Blake <eblake@redhat.com> writes:

> On 08/13/2018 02:17 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 08/10/2018 08:28 AM, Eric Blake wrote:
>>>> Instead of using a raw assert, print the information in an
>>>> easier to understand way:
>>>>
>>>> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>>>
>>> Well, it would help if my commit message actually matched...
>>>
>>>
>>>> +        if (wstatus) {
>>>> +            if (WIFEXITED(wstatus)) {
>>>> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
>>>> +                        "process but encountered exit status %d\n",
>>>> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
>>>> +            } else if (WIFSIGNALED(wstatus)) {
>>>> +                int sig = WTERMSIG(wstatus);
>>>> +                const char *signame = strsignal(sig) ?: "unknown ???";
>>>> +                const char *dump = WCOREDUMP(wstatus) ? " (dumped core)" : "";
>>>> +
>>>> +                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
>>>> +                        "from signal %d (%s)%s\n",
>>>
>>> ...the code.
>>
>> I got libqtest patches in my queue, and I could stick this patch in.
>> Would you like me to touch up the commit message when I apply?  Or
>> should I expect v5?
>>
>
> If you don't mind doing the touchup (s/core dumped/dumped core/), then
> I don't need to submit v5.

Since "core dumped" is how the shell traditionally reports this, I'd
prefer to adjust the code to match the commit message.  Okay?
