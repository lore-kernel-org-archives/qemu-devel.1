Received: from eggs.gnu.org ([2001:4830:134:3::10]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fxqqm-0003vj-E0
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fxqqj-0006qZ-12
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:45:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1fxqqi-0006mm-Dh
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:45:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1-v6so1586546wrt.3
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 02:45:15 -0700 (PDT)
Date: Thu, 06 Sep 2018 02:45:13 -0700 (PDT)
In-Reply-To: <20180831222249.GA28489@flamenco>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-56cc4fab-15c5-415d-a54e-c17ae5ccef26@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/riscv: use
 tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, alistair.francis@wdc.com

On Fri, 31 Aug 2018 15:22:49 PDT (-0700), cota@braap.org wrote:
> On Fri, Aug 10, 2018 at 13:39:38 -0400, Emilio G. Cota wrote:
>> Changes wrt v1: changed patch 3 as suggested by Richard. Also
>> added his R-b's.
>>
>> You can fetch this series from:
>>   https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2
>
> RISC-V maintainers: any plans of picking this up for 3.1?

Michael has a better handle on the QEMU patch queue than I do, but I'm starting 
to free up some time to actually work on this stuff.  He'll be in town next 
week so we'll try to figure out our story for QEMU 3.1.

Sorry for being a bit out of it, we've been super busy with some internal 
projects.

> (Cc'ing Alistair since he recently submitted some riscv-related
> pull requests; BTW Alistair, should you be listed as a RISC-V
> maintainer?)

I'm not opposed to Alistair being a maintainer, I'll talk it over with the 
other guys.  It'd be great to have someone active and not at SiFive on QEMU, as 
when we get busy we tend to all get busy :).
