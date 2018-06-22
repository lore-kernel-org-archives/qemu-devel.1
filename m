Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLT9-00079h-5M
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLT7-0006rX-V8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:47:15 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:37669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWLT7-0006qq-OO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:47:13 -0400
Received: by mail-ot0-x22e.google.com with SMTP id 101-v6so7357970oth.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 05:47:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dGUOLhxHr+AYHCfTvStM+M7DLVBiHEmnDzpX38aggBw@mail.gmail.com>
References: <20180621143715.27176-1-richard.henderson@linaro.org>
	<CAFEAcA9dGUOLhxHr+AYHCfTvStM+M7DLVBiHEmnDzpX38aggBw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:46:52 +0100
Message-ID: <CAFEAcA8jUTAZmYrkvrS60PSqiiWc2sw20GvQnY+-bbXjvvMz7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2.5 00/19] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 09:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 June 2018 at 15:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The following changes since commit 42747d6abb5035473e5585fa17620c1e8983a70b:
>>
>>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-06-15.for-upstream' into staging (2018-06-15 17:28:37 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180615
>>
>> for you to fetch changes up to 9f754620651d3432114f4bb89c7f12cbea814b3e:
>>
>>   tcg: Reduce max TB opcode count (2018-06-15 09:39:53 -1000)
>>
>> ----------------------------------------------------------------
>> TCG patch queue:
>>
>> Workaround macos assembler lossage.
>> Eliminate tb_lock.
>> Fix TB code generation overflow.
>>
> Applied, thanks.

...looks like it's broken builds with --disable-tcg, though.
Travis builds with that config fail:

/home/travis/build/qemu/qemu/accel/stubs/tcg-stub.c:24:6: error: no
previous prototype for "tb_unlock" [-Werror=missing-prototypes]
 void tb_unlock(void)
      ^
cc1: all warnings being treated as errors

(sample failing job log: https://api.travis-ci.org/v3/job/395399220/log.txt)

Should just be a matter of deleting the stub function, I guess.

thanks
-- PMM
