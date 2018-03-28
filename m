Received: from eggs.gnu.org ([2001:4830:134:3::10]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1FLL-0001ge-HE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1FLK-0005jE-JG
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:58:39 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:35767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1FLK-0005iv-DJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:58:38 -0400
Received: by mail-oi0-x233.google.com with SMTP id z8-v6so2909367oix.2
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 10:58:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180328022233.13400-1-richard.henderson@linaro.org>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Mar 2018 10:58:36 -0700
Message-ID: <CAHNT7NtpueOqap9BcYuzVWT4eGmLiycOo+33DyyUQGbmwfZsJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/2] RISC-V: Mark FP status dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On Tue, Mar 27, 2018 at 7:22 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> Since it was my patch that broke FP state tracking in the
> first place, I feel obligated to fix it again.
>
> Mark mstatus[fs] as dirty whenever we write to the file.
> This can be optimized by only doing so once within a TB
> which initially began with a clean file.
>
> I have not yet put together an environment that can test
> this, so I'll need someone else to give it a go.
>

I have tested it with the simple test case running SMP Linux and it appears
okay (Note it must be compiled with -O2):

 http://oirase.annexia.org/tmp/sched.c

It is clearly broken without your two patches.
