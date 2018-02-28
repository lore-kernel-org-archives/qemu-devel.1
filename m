Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erABP-0003YK-JT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erABD-0000xQ-8E
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:26:43 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1erABC-0000tw-Ra
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:26:31 -0500
Date: Wed, 28 Feb 2018 17:26:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180228222627.GA3575@flamenco>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
Subject: Re: [Qemu-devel] [patches] Re:  [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Feb 28, 2018 at 13:09:11 +1300, Michael Clark wrote:
> BTW somewhat coincidentally, the binary translator I wrote; RV8, which is
> practicaly twice as fast as QEMU only supports privileged ISA v1.9.1 and I
> personally want to keep binary compatiblity with it.
(snip)
> - https://rv8.io/
> - https://rv8.io/bench
> - https://anarch128.org/~mclark/rv8-carrv.pdf
> - https://anarch128.org/~mclark/rv8-slides.pdf

What QEMU versions did you use for those comparisons? I wonder if
the recent indirect branch handling improvements were included in those
(this work was merged in 2.10 for aarch64). Also, 2.7 is quite a bit
faster than previous versions for user-mode due to the use of QHT,
although you probably used a later version.

BTW after the merge you might want to look into optimizing indirect
branches (and cross-page direct jumps in softmmu) for riscv in qemu.
See examples with
	$ git log -Stcg_gen_lookup_and_goto_ptr

Cheers,

		Emilio
