Received: from eggs.gnu.org ([2001:4830:134:3::10]:59484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f07Bu-00040e-7w
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f07Bt-000321-6t
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:14 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:42091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f07Bt-00031q-0L
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:13 -0400
Received: by mail-ot0-x22b.google.com with SMTP id v23-v6so18060943oth.9
	for <qemu-devel@nongnu.org>; Sun, 25 Mar 2018 08:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Mar 2018 16:03:50 +0100
Message-ID: <CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/26] RISC-V: Fixes and cleanups for
 QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
> This is a series of bug fixes and code cleanups that we would
> like to get in before the QEMU 2.12 release. We are respinning
> v6 of this series to include two new bug fixes. These changes
> are present in the downstream riscv.org riscv-all branch:
>
> - https://github.com/riscv/riscv-qemu/commits/riscv-all
>
> This series also addresses post-merge feedback such as updating
> the cpu initialization model to conform with other architectures
> as requested by Igor Mammedov.

Hi. It looks to me like a fair number of these patches
are already reviewed, so we don't need to wait on the
rest being reviewed to get those into master.

My suggestion is that you send a pullrequest now for the
reviewed patches, and send a patchset for review for the
new ones or the ones that still need review. (If there
are patches that are reviewed but depend on earlier ones
that need to go in set 2 then they go in set 2 as well.)

26 patches is a lot to still be carrying around much
beyond rc1, so I would like to see the size of this set
reducing rather than increasing. As the release process
moves forward the bar for "can this still go in" gradually
goes up -- by about rc3 it is at about "is this a
really critical bug or regression from the previous
release".

(Also something seems to have unhelpfully decided to eat
or delay about half of your emails in this patchset :-(
Patchew only sees 14 of the 26. Our mailing list server
does seem to do that occasionally so that would be my
first guess at the culprit, but it's possible it's
something at your end.)

thanks
-- PMM
