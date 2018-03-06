Received: from eggs.gnu.org ([2001:4830:134:3::10]:48353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etATQ-0005Fq-5g
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etATM-0005pZ-2u
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:36 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etATL-0005pO-Tl
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:32 -0500
Received: by mail-oi0-x22e.google.com with SMTP id a207so14495063oii.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:09:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
	<CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
	<CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
	<CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 11:09:10 +0000
Message-ID: <CAFEAcA86NXTeMdp3tsvJXYNZtqCX5zGeSd05U=hso6f=UaCOjQ@mail.gmail.com>
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

On 6 March 2018 at 01:30, Michael Clark <mjc@sifive.com> wrote:
> I've squashed the trivial spike rename fix and rebased against master as of
> commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a562 Merge remote-tracking branch
> 'remotes/stefanha/tags/block-pull-request' into staging. See here:
>
> - https://github.com/riscv/riscv-qemu/releases/tag/riscv-qemu-upstream-v8.1

OK. In the interests of getting the RISC-V port into upstream before
the upcoming softfreeze deadline (which is next Tuesday)[*], please
can you:
 * make sure you have a signed tag and send it as a proper pull request email
 * send your other queued changes to the mailing list as a patch series
   so they can be reviewed
 * work with Igor to identify the changes you need to make for the
   CPU type registering issue he's raised, and then send a patch for that

?

[*] For us, 'softfreeze' means that any new features must be in a pull
request on the mailing list by that date; after that only bugfixes.
Hardfreeze and the first rc candidate build is a week after that.
See https://wiki.qemu.org/Planning/2.12 for other dates.

thanks
-- PMM
