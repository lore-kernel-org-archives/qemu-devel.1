Received: from eggs.gnu.org ([2001:4830:134:3::10]:46183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyG1-0002uP-WC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyG1-0000cU-3o
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:50 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgyG0-0000cJ-Ts
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:49 -0500
Received: by mail-wm0-x236.google.com with SMTP id r141so7210654wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:36:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487850673-26455-3-git-send-email-vijay.kilari@gmail.com>
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-3-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:36:27 +0000
Message-ID: <CAFEAcA8g7S2gwnQ6YRhmq76_gqi=emYftFUoP5CmqaPzpZ4ShQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v9 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
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
> To Save and Restore ICC_SRE_EL1 register introduce vmstate
> subsection and load only if non-zero.
> Also initialize icc_sre_el1 with to 0x7 in pre_load
> function.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
