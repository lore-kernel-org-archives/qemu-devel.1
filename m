Received: from eggs.gnu.org ([2001:4830:134:3::10]:44476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fjjsR-00074w-AG
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fjjsQ-0003fp-G9
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:28:43 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fjjsQ-0003fA-AO
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:28:42 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so16502515ois.1
	for <qemu-devel@nongnu.org>; Sun, 29 Jul 2018 04:28:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <383842e2-9d91-ff2d-642d-c3cb003895b7@linaro.org>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<383842e2-9d91-ff2d-642d-c3cb003895b7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Jul 2018 12:28:20 +0100
Message-ID: <CAFEAcA_NaTDYPb_-w2mO-Y8xZ45=zkBQRA=XwHu4ioH+N8Y52g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair23@gmail.com>

On 28 July 2018 at 17:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/27/2018 04:49 PM, Alistair Francis wrote:
>> Allow QEMU to be built to run on a RISC-V host.
>>
>> QEMU does not yet have a RISC-V TCG or user mode target port, but
>> running other architectures on RISC-V using TCI does work.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  configure | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> This is ok as far as it goes.
>
> Even for TCI, you need some more.
>
> At minimum, see Michael Clark's branch changes to accel/tcg/user-exec.c for
> host signal handling.  While you can run *-softmmu without this, none of
> *-linux-user will work reliably.
>
> Another piece that even Michael Clark does not have is
> linux-user/host/*/safe-syscall.S.

It might be nice to complete the safe-syscall stuff for all hosts,
and then remove the fallback that lets you build an unreliable
linux-user binary without it...

thanks
-- PMM
