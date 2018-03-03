Received: from eggs.gnu.org ([2001:4830:134:3::10]:55938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esG1v-0004Il-Pi
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 17:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esG1l-00048s-UM
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 17:53:27 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esG1l-00048R-BU
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 17:53:17 -0500
Received: by mail-ot0-x244.google.com with SMTP id y11so11912083otg.0
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 14:53:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Mar 2018 22:52:55 +0000
Message-ID: <CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 3 March 2018 at 02:46, Michael Clark <mjc@sifive.com> wrote:
> On Sat, Mar 3, 2018 at 3:22 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> Please don't send pull requests until after patches have been put
>> on list and been reviewed. A minor update to a pullreq is OK if
>> it's something like a trivial compiler fix or just dropping some
>> patches that had problems, but if you have this many changes that
>> deserves a fresh patchset to be sent to the list for review.
>>
>> (For the QEMU workflow, a pull request isn't a request for patch
>> review, it's a statement that patches have all had review and
>> are ready to go into master immediately.)
>
>
> My apoligies. I won't do this again.

No worries, it's just a workflow thing (which differs a lot from
project to project), and we don't really have much documentation
on the submaintainer part of the process. (What we do have is here:
https://wiki.qemu.org/Contribute/SubmitAPullRequest  )

The basic idea is that for us code review happens in the "patches
posted to list" phase, and then "pull request" is pretty much
the same as "commit to master". As the submaintainer you review,
test and accumulate in a branch patches from yourself and other
people, and then send them out in a pull request. In the ideal
case that goes straight into master without problems. Sometimes
it runs into trouble (like a compile issue on an oddball platform),
and then rather than going through the whole process again for
something as small as a messed up format string you can just fix
and resend the pullreq. (There are examples of this on list at
the moment, for instance.)
Bigger stuff it's usually easier to drop the relevant patches
from the pull, and then respin them and resend for review before
putting them in a later pull. The dividing line for what you
can get away with fixing up locally and what you can't is
kind of similar to what you can tweak without needing to drop
a reviewed-by: tag from a changed patch and get it re-reviewed.
When you get familiar with the process and what people do you
can take shortcuts sometimes (this is me posting what I'm
going to squash into a patch as a followup, to save reposting
a 20 patch series, for instance:
http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg00310.html).
For getting started as a submaintainer, it's probably easiest
to follow the 'by the book' process: patches go to mailing
list as 'PATCH', get review, changes made, patch series resent,
reviewed patches go into pull requests. (The idea is to ensure
that anything that goes into master has been on list for at
least a few days so people who want to review can do so.)

> I have some very very minor cleanups that do not affect logic, but perhaps
> we could address this after getting approval to make a pull request for v8.
>
> My qemu-devel branch holds changes against the latest rebase:
>
> - https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel
>
> Someone raised timebase frequency on the RISC-V sw-dev and after looking at
> the code I noticed we had a hard-coded value for a few of the constants we
> put in device tree, and i spotted a missed rename. I'm going to have to
> learn about the qemu-devel process for trivial fixes...

I would probably squash in the missed rename into the relevant
patch, at any rate. The rest can probably go through the post
patch/get review/sent pull request cycle after this first lot
have been applied.

thanks
-- PMM
