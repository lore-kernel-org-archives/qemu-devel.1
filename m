Received: from eggs.gnu.org ([2001:4830:134:3::10]:46730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3Xw-0008Cw-0S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3Xv-0003J6-6X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:46:36 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:32853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX3Xu-0003Io-W7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:46:35 -0400
Received: by mail-wr0-x22a.google.com with SMTP id a10so9552008wrd.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:46:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 11:46:13 +0100
Message-ID: <CAFEAcA-mVcamZ9oxqid25ny0FJgoXNXGb054Lc6Enk6tFF6WJA@mail.gmail.com>
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

On 15 July 2017 at 18:30, Richard Henderson <rth@twiddle.net> wrote:
> Instructions implementing another missing facility,
> getting us a bit closer to being able to upgrade the
> default tcg cpu.
>
> Plus one bug fix for an existing instruction that
> isn't used unless we upgrade the tcg cpu.
>
>
> r~
>
>
> The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e25:
>
>   vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-s390-20170715
>
> for you to fetch changes up to 4fb4047e74c21a3692360b9b1df473d7512d8055:
>
>   target/s390x: Fix risbg handling (2017-07-15 07:17:36 -1000)
>
> ----------------------------------------------------------------
> Queued s390x tcg patches

Hi. This fails to link with clang (OSX, linux, freebsd):

Undefined symbols for architecture x86_64:
  "_helper_atomic_cmpxchgq_be_mmu", referenced from:
      _helper_csst in mem_helper.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)

thanks
-- PMM
