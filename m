Received: from eggs.gnu.org ([2001:4830:134:3::10]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC8C7-0007ZG-7n
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC8C1-0000fk-JV
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:01:51 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:54199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC8C1-0000dM-E8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:01:45 -0500
Received: by mail-wr0-x22c.google.com with SMTP id u40so47015wrf.10
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 10:01:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1711070957150.30448@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1711061412330.30448@sstabellini-ThinkPad-X260>
	<CAFEAcA9txp80bxgV5dYCPx7xoxqgutpbLyZ7PDkkL_OfVjSxYA@mail.gmail.com>
	<alpine.DEB.2.10.1711070957150.30448@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 18:01:23 +0000
Message-ID: <CAFEAcA8=Yrn53odaaSp+fvZ96sdLX4B5ZGZqf8FgYNjpCwYE+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] aarch64: advertise the GIC system
 register interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, qemu-arm <qemu-arm@nongnu.org>, julien.grall@arm.com

On 7 November 2017 at 17:57, Stefano Stabellini <sstabellini@kernel.org> wrote:
> On Tue, 7 Nov 2017, Peter Maydell wrote:
>> I thought about this on the cycle into work this morning, and I
>> think that rather than require every board that uses gicv3
>> to set a property on the CPU, we should change the definition
>> of the id_aa64pfr0 register so that rather than being ARM_CP_CONST
>> it has a readfn, and then at runtime we can get that readfn to
>> add in the right bit if env->gicv3state is non-null.
>>
>> I'll put together a patch this afternoon.
>
> Great, please CC me when you do, I'll help you test the patch.

http://patchwork.ozlabs.org/patch/835300/ -- should already be
in your inbox somewhere...

thanks
-- PMM
