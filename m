Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCzj-00049Y-7s
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCzi-0004ko-DL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:34:11 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCzi-0004jx-6y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:34:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so23097727oic.12
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:34:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP4AiSjBT=Lf4MWce7gOB+ufbo6HSVLoJxR2rC6ChXkJQ@mail.gmail.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<383842e2-9d91-ff2d-642d-c3cb003895b7@linaro.org>
	<CAFEAcA_NaTDYPb_-w2mO-Y8xZ45=zkBQRA=XwHu4ioH+N8Y52g@mail.gmail.com>
	<CAKmqyKP4AiSjBT=Lf4MWce7gOB+ufbo6HSVLoJxR2rC6ChXkJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 19:33:48 +0100
Message-ID: <CAFEAcA-KingiYddWjr8n8O4uJy2a+65_Xas+ybWgiNx_4xWhqQ@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On 30 July 2018 at 18:24, Alistair Francis <alistair23@gmail.com> wrote:
> On Sun, Jul 29, 2018 at 4:28 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Another piece that even Michael Clark does not have is
>>> linux-user/host/*/safe-syscall.S.
>>
>> It might be nice to complete the safe-syscall stuff for all hosts,
>> and then remove the fallback that lets you build an unreliable
>> linux-user binary without it...
>
> At the moment though QEMU won't build with Linux user. So some work is
> required just to get the build working.

Right -- it's not really sufficient to just change configure.
I'd rather see:
 (a) a proper backend for any host CPU type we actually care about,
 which is what Michael's work is doing
 (b) support for the various per-host-arch things that are needed
     like the safe-syscall shim
 (c) QEMU's build infrastructure guiding the process of implementing
     both of those, by making it a build failure to not provide
     all the set of things, rather than producing a configuration
     that will build but not work reliably

thanks
-- PMM
