Received: from eggs.gnu.org ([2001:4830:134:3::10]:38166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiir-0001Fw-9Y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiiq-0002j8-JD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:37:17 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceiiq-0002hq-CO
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:37:16 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so10331562wmg.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487313115-9510-5-git-send-email-vijay.kilari@gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-5-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:36:54 +0000
Message-ID: <CAFEAcA8ZvmbbWPM70TxnPCrKCQjL4_O5_1=MW24EJacxigm7Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 4/5] target-arm: Add GICv3CPUState in
 CPUARMState struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 17 February 2017 at 06:31,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> Add gicv3state void pointer to CPUARMState struct
> to store GICv3CPUState.
>
> In case of usecase like CPU reset, we need to reset
> GICv3CPUState of the CPU. In such scenario, this pointer
> becomes handy.
>
> This patch take care of only GICv3.

I'm not sure what you mean to say with this sentence ?

>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
