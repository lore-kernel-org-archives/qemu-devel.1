Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1et1RM-0006pg-Io
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 20:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1et1RK-0006Ix-4F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 20:30:52 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:46553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1et1RJ-0006IB-RA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 20:30:50 -0500
Received: by mail-ot0-x236.google.com with SMTP id g97so16859881otg.13
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 17:30:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
	<CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
	<CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Mar 2018 14:30:48 +1300
Message-ID: <CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Mar 6, 2018 at 12:10 PM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Sun, Mar 4, 2018 at 11:52 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 3 March 2018 at 02:46, Michael Clark <mjc@sifive.com> wrote:
>> > On Sat, Mar 3, 2018 at 3:22 AM, Peter Maydell <peter.maydell@linaro.org
>> >
>> > wrote:
>> >> Please don't send pull requests until after patches have been put
>> >> on list and been reviewed. A minor update to a pullreq is OK if
>> >> it's something like a trivial compiler fix or just dropping some
>> >> patches that had problems, but if you have this many changes that
>> >> deserves a fresh patchset to be sent to the list for review.
>> >>
>> >> (For the QEMU workflow, a pull request isn't a request for patch
>> >> review, it's a statement that patches have all had review and
>> >> are ready to go into master immediately.)
>> >
>> >
>> > My apoligies. I won't do this again.
>>
>> No worries, it's just a workflow thing (which differs a lot from
>> project to project), and we don't really have much documentation
>> on the submaintainer part of the process. (What we do have is here:
>> https://wiki.qemu.org/Contribute/SubmitAPullRequest  )
>>
>> The basic idea is that for us code review happens in the "patches
>> posted to list" phase, and then "pull request" is pretty much
>> the same as "commit to master". As the submaintainer you review,
>> test and accumulate in a branch patches from yourself and other
>> people, and then send them out in a pull request. In the ideal
>> case that goes straight into master without problems. Sometimes
>> it runs into trouble (like a compile issue on an oddball platform),
>> and then rather than going through the whole process again for
>> something as small as a messed up format string you can just fix
>> and resend the pullreq. (There are examples of this on list at
>> the moment, for instance.)
>> Bigger stuff it's usually easier to drop the relevant patches
>> from the pull, and then respin them and resend for review before
>> putting them in a later pull. The dividing line for what you
>> can get away with fixing up locally and what you can't is
>> kind of similar to what you can tweak without needing to drop
>> a reviewed-by: tag from a changed patch and get it re-reviewed.
>> When you get familiar with the process and what people do you
>> can take shortcuts sometimes (this is me posting what I'm
>> going to squash into a patch as a followup, to save reposting
>> a 20 patch series, for instance:
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg00310.html).
>> For getting started as a submaintainer, it's probably easiest
>> to follow the 'by the book' process: patches go to mailing
>> list as 'PATCH', get review, changes made, patch series resent,
>> reviewed patches go into pull requests. (The idea is to ensure
>> that anything that goes into master has been on list for at
>> least a few days so people who want to review can do so.)
>>
>> > I have some very very minor cleanups that do not affect logic, but
>> perhaps
>> > we could address this after getting approval to make a pull request for
>> v8.
>> >
>> > My qemu-devel branch holds changes against the latest rebase:
>> >
>> > - https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel
>> >
>> > Someone raised timebase frequency on the RISC-V sw-dev and after
>> looking at
>> > the code I noticed we had a hard-coded value for a few of the constants
>> we
>> > put in device tree, and i spotted a missed rename. I'm going to have to
>> > learn about the qemu-devel process for trivial fixes...
>>
>> I would probably squash in the missed rename into the relevant
>> patch, at any rate. The rest can probably go through the post
>> patch/get review/sent pull request cycle after this first lot
>> have been applied.
>>
>
> It seems I need to rebase against master based on recent changes, so I'll
> make a v9 tag, include the minimal missed rename but exluding my queued
> changes. The changes in v8 are the minimum required to allow us to keep the
> SiFive machines as we renamed them and added the SiFive cpu models. The
> essence of the v8 patch series.
>
> The trivial fixes to v8 ended up becoming non-trivial and now includes a
> lot of specification conformance issues (essentially specification related
> bug fixes) and a fix for a potential buffer overflow wrt. device-tree, that
> doesn't appear to trigger in practice. I was also able to shed some dead
> code (machines aren't objects, so empty object boilerplate was removed):
>
> - https://github.com/riscv/riscv-qemu/pull/112
>
> We'll hold off merging these changes into the v8 branch, and will send
> them as a post merge cleanup and bugfix patch series, hopefully after
> getting the port merged.
>
> I'll get back to you when I have rebased against master...
>

I've squashed the trivial spike rename fix and rebased against master as of
commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a562 Merge remote-tracking
branch 'remotes/stefanha/tags/block-pull-request' into staging. See here:

- https://github.com/riscv/riscv-qemu/releases/tag/riscv-qemu-upstream-v8.1

I've rebased my queued changes against the qemu-upstream-v8.1 branch (tag r
iscv-qemu-upstream-v8.1) and have them in my own tree:

- https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel

I have a pending pull request against the riscv.org tree for my queued
changes, which I may re-target if we get these changes upstream:

- https://github.com/riscv/riscv-qemu/pull/115

Would appreciate it some folk could add a remote for
github.com/riscv/riscv-qemu.git and pull in riscv-qemu-upstream-v8.1, and
test... It's been pretty well tested out-of-tree already. RISC-V docs are
on the wiki, which require the riscv-toolchain, building and packaging
riscv-linux inside riscv-pk/bbl.

- https://github.com/riscv/riscv-qemu/wiki

I'm currently working on some changes locally to split the firmware from
the kernel image. Currently the kernel image is embedded in the firmware (r
iscv-pk/bbl). I want to do this as I'd like to get the riscv CI to automate
some more of the "execution environment" testing (which could be spike,
qemu, FPGA, or silicon). I'm also working on cross toolchain packages to
automate some of the test image creation. I perform various local tests
manually. i.e. booting linux on the various board combinations, and running
MCU binaries on the MMU-less SiFive E-series board, which can run HiFive1
binaries (i.e. a little more than make check). I'm pretty confident that we
won't hurt any other arches. The only core code change is to add a symbol
callback function to load_elf for our HTIF (Host Target Interface).

We have some objectives with regards to the sifive_e and sifive_u machines,
> such that we may properly abstract the SOC/board and also have a
> configurable SOC as we need to model configurable soft-core IP as well as
> actual SOCs based on this IP. This will be in the future. The machines at
> this point are relatively simple.
>
> Thanks,
> Michael.
>
