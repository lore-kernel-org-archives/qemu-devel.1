Received: from eggs.gnu.org ([2001:4830:134:3::10]:38075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdak7-0000tV-VI
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdak6-00045W-N0
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:30:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdak6-00044w-Gq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:30:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so29847178oic.12
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:30:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-9-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-9-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 13:30:21 +0100
Message-ID: <CAFEAcA-_=94PcEsaGmQBjN2HXgCB5QyvS53MdnAcfcWSKeApSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/20] intc/arm_gic: Refactor secure/ns
 access check in the CPU interface
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

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> An access to the CPU interface is non-secure if the current GIC instance
> implements the security extensions, and the memory access is actually
> non-secure. Until then, it was checked with tests such as
>   if (s->security_extn && !attrs.secure) { ... }
> in various places of the CPU interface code.
>
> With the implementation of the virtualization extensions, those tests
> must be updated to take into account whether we are in a vCPU interface
> or not. This is because the exposed vCPU interface does not implement
> security extensions.
>
> This commits replaces all those tests with a call to the
> gic_cpu_ns_access() function to check if the current access to the CPU
> interface is non-secure. This function takes into account whether the
> current CPU is a vCPU or not.

Thanks -- this approach looks much cleaner.

> Note that this function is used only in the (v)CPU interface code path.
> The distributor code path is leaved unchanged, as the distributor is not

"left"

> exposed to vCPUs at all.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
