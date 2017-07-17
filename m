Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXCg1-00042O-2w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXCg0-000294-2C
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:31:33 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXCfz-00028W-RK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:31:31 -0400
Received: by mail-wr0-x235.google.com with SMTP id y43so276291wrd.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:31:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <854c3b2e-deaf-1c8d-fd84-9accd7331510@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
	<CAFEAcA-mVcamZ9oxqid25ny0FJgoXNXGb054Lc6Enk6tFF6WJA@mail.gmail.com>
	<854c3b2e-deaf-1c8d-fd84-9accd7331510@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 21:31:10 +0100
Message-ID: <CAFEAcA_BDhF6EnQgLr52AL63T7xhs8cqMadhiEerK0HfS26brQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/s390x tcg improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 20:36, Richard Henderson <rth@twiddle.net> wrote:
> On 07/17/2017 12:46 AM, Peter Maydell wrote:
>>
>> Hi. This fails to link with clang (OSX, linux, freebsd):
>>
>> Undefined symbols for architecture x86_64:
>>    "_helper_atomic_cmpxchgq_be_mmu", referenced from:
>>        _helper_csst in mem_helper.o
>> ld: symbol(s) not found for architecture x86_64
>> clang: error: linker command failed with exit code 1 (use -v to see
>> invocation)
>
>
> What os and clang version?
>
> Because, frankly, I can't even get this far with clang 3.9 as shipped with
> fedora 25.  As far as I can see top-of-tree doesn't build at all with that
> compiler.

This was OSX 10.12.5 (Sierra) running
Apple LLVM version 7.0.0 (clang-700.1.76)
(running strings on the binary suggests this is based
on upstream clang 3.7.0)

and Linux Ubuntu x86_64 Xenial running
clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)

and FreeBSD 11.0 running
FreeBSD clang version 3.8.0 (tags/RELEASE_380/final 262564) (based on
LLVM 3.8.0)

If we don't build with clang 3.9 that's worth fixing;
it's not in my test set, which will be why the
breakage has slipped through.

thanks
-- PMM
