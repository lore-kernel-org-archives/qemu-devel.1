Received: from eggs.gnu.org ([2001:4830:134:3::10]:54863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0tVK-0005rK-AC
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0tVI-0000GH-D0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:39:30 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0tVI-0000Fq-3s
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:39:28 -0400
Received: by mail-ot0-x230.google.com with SMTP id m22-v6so25603988otf.10
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 11:39:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9k2e76o+DXEu0NN770o5ZDwY4g2UKnSxA2VhwRBq6F=Q@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
	<CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
	<CAFEAcA9k2e76o+DXEu0NN770o5ZDwY4g2UKnSxA2VhwRBq6F=Q@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 11:39:26 -0700
Message-ID: <CAHNT7Nux9v-iDZbm6bXs8LG3WF4fF+5b_5E+z-QHmG=FiB7N1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v6 00/26] RISC-V: Fixes and
 cleanups for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: RISC-V Patches <patches@groups.riscv.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Mar 27, 2018 at 2:42 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 26 March 2018 at 19:07, Michael Clark <mjc@sifive.com> wrote:
> > On Sun, Mar 25, 2018 at 8:03 AM, Peter Maydell <peter.maydell@linaro.org
> >
> > wrote:
> >> Hi. It looks to me like a fair number of these patches
> >> are already reviewed, so we don't need to wait on the
> >> rest being reviewed to get those into master.
> >>
> >> My suggestion is that you send a pullrequest now for the
> >> reviewed patches, and send a patchset for review for the
> >> new ones or the ones that still need review. (If there
> >> are patches that are reviewed but depend on earlier ones
> >> that need to go in set 2 then they go in set 2 as well.)
> >>
> >
> > Unfortunately the reviewed patches are mostly just minor cleanups. It's
> > almost not worth making a PR for them as *none* of the reviewed patches
> are
> > actually bug fixes. They are things like removing unused definitions or
> > replacing hardcoded constants with enums, removing unnesscary braces,
> etc,
> > etc
>
> No, what I'm saying is that it is very much worth it. You
> want to shorten the size of your set of uncommitted patches.
> Large pull requests increase the chances that some
> random thing in there hits a compile issue or other minor
> problem that means I have to bounce the whole thing and
> you need to respin it. Smaller ones are more likely to
> go in. This is especially true during the freeze part
> of the release cycle, when we do an RC every week -- having
> patches in earlier RCs reduces the risk. I do not want
> to still see a 26 patch set unapplied by the time we get
> to RC3 or RC4.
>
> Or if you don't think the minor cleanups are worth putting
> into 2.12, that's fine too (it's a submaintainer judgement
> you can make). In that case you can put those to one side
> and trim down the size of the patchset you're sending out
> (ie make it an 01/11...11/11 patchset or whatever).


I'm not sure whether maintainer or submaintainer is really that relavant.
Active maintainership is probably more relevant. i.e. responding to RISC-V
related emails, PRs, issues on the riscv.org qemu repo, testing PRs before
merging them, etc, etc.

I'm going to focus on getting the critical bug fixes in for QEMU 2.12 i.e.
the ones that break RISC-V Linux in QEMU 2.12 e.g. the mstatus.FS fix. User
visible bugs like the disassembler bug and the -cpu list bug. I'm going to
make a 3 patch series... possibly a 2 patch series... we can leave the
disassembler bug there and just include Igor's change and the mstatus.FS
workaround. I don't think writable ROM is really that critical, and bounds
checks for potential device-tree truncation are just nice-to-haves. Spec
conformance is nice-to-have if we are triaging against critical issues.

Once we can ensure we have a working RISC-V port for QEMU 2.12 we can then
worry about spec conformance bug fixes and tidy ups, perhaps for QEMU 2.13.

My pesonal opinion is that Tested-by: should carry more weight than
Reviewed-by: assuming Reviewed-by: only means someone has reviewed the code
versus checking out and testing that a critical bug has been resolved by
said patch. That said, if all QEMU patches need Reviewed-by: then there is
not much we can do. In GCC and Linux, subsystem maintainers are allowed to
make judgements over the inclusion of critical bug fixes. i.e. Reviewed-by:
is not mandatory if the change is a critical fix.

I will divide the series up into 3 branches, and move through them in order
of priority, with correctness ahead of tidyness:

1). riscv-qemu-2.12-critical-fixes
2). riscv-qemu-2.13-bug-fixes
3). riscv-qemu-2.13-tidy-ups

Expect to see riscv-qemu-2.12-critical-fixes very soon...

> 26 patches is a lot to still be carrying around much
> >> beyond rc1, so I would like to see the size of this set
> >> reducing rather than increasing. As the release process
> >> moves forward the bar for "can this still go in" gradually
> >> goes up -- by about rc3 it is at about "is this a
> >> really critical bug or regression from the previous
> >> release".
> >>
> >> (Also something seems to have unhelpfully decided to eat
> >> or delay about half of your emails in this patchset :-(
> >> Patchew only sees 14 of the 26. Our mailing list server
> >> does seem to do that occasionally so that would be my
> >> first guess at the culprit, but it's possible it's
> >> something at your end.)
> >>
> >
> > Phil asked that I send out only the patches that don't have review, so
> > that's what I did.
>
> I think that was a miscommunication. You should always
> send out entire patchsets, not just parts of one.
> Philippe said:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06038.html
> "You could have sent a PR of the reviewed patches, and
> respin the unreviewed patches separately.", which is the
> same thing I'm suggesting here.


My mistake.
