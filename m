Received: from eggs.gnu.org ([2001:4830:134:3::10]:34501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bER-00080g-Vy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bEO-0003wA-Vd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:58:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9bEO-0003vq-Rm
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:58:00 -0400
Date: Fri, 20 Apr 2018 14:57:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180420185759.GA28290@flamenco>
References: <CA+ZOyaj_4my=u4-MkAbyoee5ORnRq6nyaU+HhX1K6t2+Cn5RHg@mail.gmail.com>
	<3EFD5845-5CE7-45F5-AE4C-0C86CAFAA200@sifive.com>
	<CA+ZOyajL25Gfz_NdcG+MxDAZb9qstjNo2sD_ExzX0fATaDg7HQ@mail.gmail.com>
	<CAHNT7NtJd1ZtYqdVfuiqxe60rOjyc48qyGKrQ99xY0UVH4arHQ@mail.gmail.com>
	<CAHNT7NtBzUUv4dGjLwxnMi9cOwoS5+7KVnKbrUynXkgX2C477Q@mail.gmail.com>
	<CA++6G0CNH5mzZFnsE-d6wS5jGr1YmVRc6VUhhBQYeMXKSQrqjQ@mail.gmail.com>
	<CAHNT7NshWPN-8pFzF9+PR9rcNOKmBDn5zpzvF0n6rfyzRg93tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NshWPN-8pFzF9+PR9rcNOKmBDn5zpzvF0n6rfyzRg93tQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [sw-dev] The problem of write misa on QEMU and BBL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Andrew Waterman <andrew@sifive.com>, Zong Li <zongbox@gmail.com>, Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Alistair Francis <Alistair.Francis@wdc.com>

On Fri, Apr 20, 2018 at 12:31:42 +1200, Michael Clark wrote:
(snip)
> In any case it seems we need some pretty major changes to translate.c
> before we can make misa writable in qemu-riscv. Almost every gen routine
> with the exception of RVI will need predication based on extensions. It
> makes one pause and think whether adding if statements is a good approach
> or whether having exension metadata available in the decoder so that it can
> be done generically. Adding lots of riscv_has_ext checks would be nasty.
> 
> We will need to add misa to DisasContext so that we can
> remove CPURISCVState *env from gen methods.
> 
> It also doesn't make sense to start this until we have merged Emilio's
> DisasContextBase changes.
> 
> It would be nice if Emilio's changes can be merged early in the 2.13 cycle
> so that folk are able to make progress on extension checking to
> target/riscv/translate.c

Most of those changes have been reviewed, so I'm confident they'll be
merged early in the 2.13 cycle. That said, you might want to already
work on the changes you need on top of the v3 series I just sent,
which is available at:
  https://github.com/cota/qemu/tree/trloop-conv-v3

Cheers,

		Emilio
