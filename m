Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyHN-0004oR-M2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyHM-0000zo-Su
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:38:13 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgyHM-0000zX-MO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:38:12 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so37706928wmv.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:38:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487850673-26455-6-git-send-email-vijay.kilari@gmail.com>
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-6-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:37:51 +0000
Message-ID: <CAFEAcA-wQwM=g-geopcn+9Y28UL22ugTWKwUOqmdbV=YD5Q1Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v9 5/5] hw/intc/arm_gicv3_kvm: Reset GICv3
 cpu interface registers
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

On 23 February 2017 at 11:51,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> Reset CPU interface registers of GICv3 when CPU is reset.
> For this, ARMCPRegInfo struct is registered with one ICC
> register whose resetfn is called when cpu is reset.
>
> All the ICC registers are reset under one single register
> reset function instead of calling resetfn for each ICC
> register.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
