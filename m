Received: from eggs.gnu.org ([208.118.235.92]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfR9E-0002z2-5R
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfR9C-0003Gm-UJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:12:32 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfR9C-00031p-QP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:12:30 -0500
Received: by mail-ot1-x336.google.com with SMTP id v23so32312554otk.9
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20181207090135.7651-1-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:12:10 +0000
Message-ID: <CAFEAcA9F2q6fQV13EDWFzuPYiFTDvqSCx_4P9aD=zP2RR5Kp0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/16] gdbstub: support for the
 multiprocess extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Mark Burton <mark.burton@greensocs.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 7 Dec 2018 at 09:01, Luc Michel <luc.michel@greensocs.com> wrote:
> This series adds support for the multiprocess extension of the GDB
> remote protocol in the QEMU GDB stub.
>
> This extension is useful to split QEMU emulated CPUs in different
> processes from the point of view of the GDB client. It adds the
> possibility to debug different kind of processors (e.g. an AArch64 and
> an ARMv7 CPU) at the same time (it is not possible otherwise since GDB
> expects an SMP view at the thread granularity.

I've applied this patchset to target-arm.next, thanks.
(I fixed up a few checkpatch nits about block comment style.)

> To test this patchset, you can use the following commands:
>
> (Note that this requires a recent enough GDB, I think GDB 7.2 is OK.
> Also, it must be compiled to support both ARM and AArch64 architectures)
>
> Run QEMU: (-smp 6 in xlnx-zcu102 enables both cortex-a53 and cortex-r5
> CPUs)
>
> qemu-system-aarch64 -M xlnx-zcu102 -gdb tcp::1234 -S -smp 6
>
> Run the following commands in GDB:
>
> target extended :1234
> add-inferior
> inferior 2
> attach 2
> info threads

This seems a bit clumsy -- is it just the limitations of
gdb here? I was expecting that just connecting to the
remote would cause gdb to interrogate it and attach to
all the inferior processes that it had.

thanks
-- PMM
