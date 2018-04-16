Received: from eggs.gnu.org ([2001:4830:134:3::10]:60101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f86jl-0003RX-El
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f86jh-000651-D2
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:12:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f86jh-00064A-8Y
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:12:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<CAFEAcA8VxyrDVMija0C219E5cPtKLC13YHcLFbB+VMRw9uCA_A@mail.gmail.com>
	<871sffp7fv.fsf@dusky.pond.sub.org>
	<CAFEAcA8Q+0CGW6YR5kuvq090E8Q1YO_Fm9L8RVgJ8nFByHF1qA@mail.gmail.com>
Date: Mon, 16 Apr 2018 18:11:52 +0200
In-Reply-To: <CAFEAcA8Q+0CGW6YR5kuvq090E8Q1YO_Fm9L8RVgJ8nFByHF1qA@mail.gmail.com>
	(Peter Maydell's message of "Mon, 16 Apr 2018 15:28:14 +0100")
Message-ID: <87zi23m8qf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 April 2018 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 12 March 2018 at 13:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>> Warn if files are added/renamed/deleted without MAINTAINERS file
>>>> changes.  This has helped me in Linux and we could benefit from this
>>>> check in QEMU.
>>>>
>>>> This patch is a manual cherry-pick of Linux commit
>>>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
>>>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>>>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> ---
>>>
>>> Unfortunately the patch doesn't magically cause maintainers
>>> to appear for the new files :-)
>>
>> Fortunately, the patch can get new files non-magically rejected unless a
>> maintainers appears :)
>
> I think that "author of code lists themselves in MAINTAINERS
> but then doesn't in practice do anything" is not really much
> better (and arguably worse) than "code has no listed maintainer".

Having our tooling flag new and moved files for a possible MAINTAINERS
update need not mean adding J. Random Codeslinger to MAINTAINERS.  It
should make us stop and think.

If the kernel guys can do that, why can't we?
