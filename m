Received: from eggs.gnu.org ([2001:4830:134:3::10]:33647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQq4-0000UA-SW
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQq3-0005yX-NX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:20:28 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQq3-0005xd-Ir
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:20:27 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so2316200oie.7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:20:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-10-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-10-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:20:06 +0100
Message-ID: <CAFEAcA_sg9XpTXT5HJQ4yf9GTbcMY_ShZYQUXK_1qYgzEdUtWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 09/20] intc/arm_gic: Add virtualization
 enabled IRQ helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
> Add some helper functions to gic_internal.h to get or change the state
> of an IRQ. When the current CPU is not a vCPU, the call is forwarded to
> the GIC distributor. Otherwise, it acts on the list register matching
> the IRQ in the current CPU virtual interface.
>
> gic_clear_active can have a side effect on the distributor, even in the
> vCPU case, when the correponding LR has the HW field set.
>
> Use those functions in the CPU interface code path to prepare for the
> vCPU interface implementation.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
