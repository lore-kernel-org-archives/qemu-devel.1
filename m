Received: from eggs.gnu.org ([2001:4830:134:3::10]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXBoa-00015y-GV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXBoX-0001jx-2F
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:36:20 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXBoW-0001id-Tb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:36:16 -0400
Received: by mail-qk0-x229.google.com with SMTP id d136so16684358qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:36:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170715173050.31018-1-rth@twiddle.net>
	<CAFEAcA-mVcamZ9oxqid25ny0FJgoXNXGb054Lc6Enk6tFF6WJA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <854c3b2e-deaf-1c8d-fd84-9accd7331510@twiddle.net>
Date: Mon, 17 Jul 2017 09:36:08 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mVcamZ9oxqid25ny0FJgoXNXGb054Lc6Enk6tFF6WJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] target/s390x tcg improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/17/2017 12:46 AM, Peter Maydell wrote:
> Hi. This fails to link with clang (OSX, linux, freebsd):
> 
> Undefined symbols for architecture x86_64:
>    "_helper_atomic_cmpxchgq_be_mmu", referenced from:
>        _helper_csst in mem_helper.o
> ld: symbol(s) not found for architecture x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invocation)

What os and clang version?

Because, frankly, I can't even get this far with clang 3.9 as shipped with 
fedora 25.  As far as I can see top-of-tree doesn't build at all with that 
compiler.


r~
