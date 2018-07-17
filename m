Received: from eggs.gnu.org ([2001:4830:134:3::10]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQw2-0002IX-Uu
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQw2-0001Rq-4N
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:26:38 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQw1-0001Rf-Nk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:26:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id i12-v6so2376549oik.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:26:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-15-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-15-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:26:16 +0100
Message-ID: <CAFEAcA__GVdga=VDuwiVq9XW4gBRxMECd2Xm_U8fDzH+aTkzOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 14/20] intc/arm_gic: Wire the vCPU
 interface
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
> Add the read/write functions to handle accesses to the vCPU interface.
> Those accesses are forwarded to the real CPU interface, with the CPU id
> being converted to the corresponding vCPU id (vCPU id = CPU id +
> GIC_NCPU).
>
> As for the CPU interface, we create a base region for the vCPU interface
> that fetches the current vCPU id using the current_cpu global variable, and
> one mirror region per vCPU which maps to that specific vCPU id. This is
> required by the GIC architecture specification.

Is it? The spec says the GICH registers need to be accessible
like this, but not the vCPU (GICV) registers...

thanks
-- PMM
