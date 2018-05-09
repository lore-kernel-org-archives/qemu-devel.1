Received: from eggs.gnu.org ([2001:4830:134:3::10]:51141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGQDS-0006Xg-9T
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGQDQ-0007gh-Om
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:37:14 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:42805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGQDQ-0007fA-I4
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:37:12 -0400
Received: by mail-oi0-x231.google.com with SMTP id t27-v6so31667045oij.9
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 07:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <1525810060-36690-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_iD-ub8obNp-7B27oFE_12T6iDDiAMuXcKX_TqHesofQ@mail.gmail.com>
	<CAHNT7NtpucYDZEpCu89ztbwd+sKhR+cE7ZZxMAhEoMY37cEKEw@mail.gmail.com>
	<CAFEAcA_X3HLQyRUYJ4WYmLL0aYagfkN9PssHqOw6bTCwiL3kcg@mail.gmail.com>
In-Reply-To: <CAFEAcA_X3HLQyRUYJ4WYmLL0aYagfkN9PssHqOw6bTCwiL3kcg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 09 May 2018 14:37:01 +0000
Message-ID: <CAHNT7NtWB90aOkmwhL=NmMe0PyJ61Deyd-JWZ=NiOkPnDdTFCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] RISC-V: QEMU 2.13 Minor Fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, KONRAD Frederic <frederic.konrad@adacore.com>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-stable <qemu-stable@nongnu.org>

On Wed, 9 May 2018 at 11:14 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 8 May 2018 at 23:05, Michael Clark <mjc@sifive.com> wrote:
> >
> >
> > On Wed, May 9, 2018 at 8:49 AM, Peter Maydell <peter.maydell@linaro.org=
>
> > wrote:
> >>
> >> On 8 May 2018 at 21:07, Michael Clark <mjc@sifive.com> wrote:
> >> > The following changes since commit
> >> > c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
> >> >
> >> >   Merge remote-tracking branch
> 'remotes/ericb/tags/pull-nbd-2018-05-04'
> >> > into staging (2018-05-04 14:42:46 +0100)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   https://github.com/riscv/riscv-qemu.git
> >> > tags/riscv-qemu-2.13-minor-fixes-2
> >> >
> >> > for you to fetch changes up to
> fc28db142ea9331d24d08a6418efa93e258a6876:
> >> >
> >> >   riscv: requires libfdt (2018-05-09 07:57:57 +1200)
> >> >
> >> > ----------------------------------------------------------------
> >> > RISC-V: QEMU 2.13 Minor Fixes
> >> >
> >> > * Require libfdt when configuring for 'riscv*-softmmu'
> >> > * Increase HTIF priority and allow zero base address
> >> >
> >> > Consider backporting to stable branch for 2.12.1
> >>
> >> Ah, if you want something flagged to be backported to
> >> the stable branch, the way to do that is to include
> >> the line "Cc: qemu-stable@nongnu.org" in the commit
> >> message. We use the same approach for flagging things
> >> for stable as the Linux kernel. (Individual submaintainers
> >> are generally in the best position to decide whether
> >> something should go into stable, and this system leaves
> >> that choice up to them. A patch submitter can also suggest
> >> something for stable when you submit the initial patch for
> >> review by adding the Cc: line and cc'ing qemu-stable on the
> >> patchmail.)
> >
> >
> > Okay. Given the 'Cc is missing in the commit (only on the cover) I coul=
d
> > send a separate patch.
> >
> > Or I can respin with the 'Cc on the configure libfdt dependency fix
> commit
> > and remove the backport message from the tag...
>
> Tag messages are just informational (we use them to help
> in writing up the changelog for releases), mostly. So I
> would recommend respinning the pullreq with the Cc: line
> in the relevant commit(s).


I respun the PR with a Cc: qemu-stable in the configure libfdt dependency
patch. You should have received a PR with the tag
=E2=80=98riscv-qemu-2.13-minor-fixes-3=E2=80=99

Thanks,
Michael

>
>
