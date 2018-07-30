Received: from eggs.gnu.org ([2001:4830:134:3::10]:55570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fkBuh-0002gz-2b
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fkBug-0002mw-2B
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:24:55 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fkBuf-0002mX-Q1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:24:53 -0400
Received: by mail-lf1-x144.google.com with SMTP id b22-v6so8696044lfa.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:24:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NaTDYPb_-w2mO-Y8xZ45=zkBQRA=XwHu4ioH+N8Y52g@mail.gmail.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<383842e2-9d91-ff2d-642d-c3cb003895b7@linaro.org>
	<CAFEAcA_NaTDYPb_-w2mO-Y8xZ45=zkBQRA=XwHu4ioH+N8Y52g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Jul 2018 10:24:21 -0700
Message-ID: <CAKmqyKP4AiSjBT=Lf4MWce7gOB+ufbo6HSVLoJxR2rC6ChXkJQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On Sun, Jul 29, 2018 at 4:28 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 28 July 2018 at 17:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 07/27/2018 04:49 PM, Alistair Francis wrote:
>>> Allow QEMU to be built to run on a RISC-V host.
>>>
>>> QEMU does not yet have a RISC-V TCG or user mode target port, but
>>> running other architectures on RISC-V using TCI does work.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  configure | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> This is ok as far as it goes.
>>
>> Even for TCI, you need some more.
>>
>> At minimum, see Michael Clark's branch changes to accel/tcg/user-exec.c for
>> host signal handling.  While you can run *-softmmu without this, none of
>> *-linux-user will work reliably.
>>
>> Another piece that even Michael Clark does not have is
>> linux-user/host/*/safe-syscall.S.
>
> It might be nice to complete the safe-syscall stuff for all hosts,
> and then remove the fallback that lets you build an unreliable
> linux-user binary without it...

At the moment though QEMU won't build with Linux user. So some work is
required just to get the build working.

Alistair

>
> thanks
> -- PMM
