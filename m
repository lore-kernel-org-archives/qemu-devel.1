Received: from eggs.gnu.org ([2001:4830:134:3::10]:46225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFbd-0004vr-6C
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFN1-0005Zw-TI
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:24:32 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:41036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUFN1-0005ZV-GD
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:24:31 -0500
Received: by mail-oi1-x229.google.com with SMTP id j21so15129756oii.8
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
	<20181126132731.GJ18284@habkost.net>
	<CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
	<b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
	<CAFEAcA8j4xTiS3_ktiA0hm2N4cu5RvxAtYqUHgvY-bUXgcwbjQ@mail.gmail.com>
	<50645862-a638-ad2a-bafe-1b46be42aec4@greensocs.com>
	<20181204180607.GB18284@habkost.net>
In-Reply-To: <20181204180607.GB18284@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 18:24:19 +0000
Message-ID: <CAFEAcA9JXeRGfKzouYJQKxgXuw_Z-up0a1ijZX9hZvXbdkwiuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 4 Dec 2018 at 18:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
> In either case, I'm still missing a clear description of what a
> cluster is supposed to represent, exactly (see my previous reply
> on this thread).

Here's my attempt:

A cluster is a group of CPUs which are all identical and have
the same view of the rest of the system.
If CPUs are not identical (for example, Cortex-A53 and
Cortex-A57 CPUs in an Arm big.LITTLE system) they should be
in different clusters.
If the CPUs do not have the same view of memory (for example
the main CPU and a management controller processor) they should
be in different clusters.

I agree that this is slightly confusing, because the concept
is on the boundary between something that's real in hardware
(eg in a big.LITTLE setup the CPUs are in separate hardware
clusters, and of coures a BMC processor and the main CPU
are definitely different things) and something that we're
defining for its effects on the GDB UI and so we can make
sure we don't share TCG translated code where we shouldn't.

thanks
-- PMM
