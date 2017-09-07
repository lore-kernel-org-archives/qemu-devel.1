Received: from eggs.gnu.org ([2001:4830:134:3::10]:38231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpuew-0006Td-Gb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpuer-0007E6-Re
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:07:46 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpuer-0007Cx-Lh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:07:41 -0400
Received: by mail-wr0-x229.google.com with SMTP id 108so18635031wra.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 04:07:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905211232.11092-1-portia.stephens@xilinx.com>
References: <20170905211232.11092-1-portia.stephens@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 12:07:19 +0100
Message-ID: <CAFEAcA9WOZcVkBqZp9f0dLvWVEyzHbcX9hqMm2Z-cNOk3=ZTVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Add Jazelle feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Portia Stephens <portia.stephens@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, stephensportia@gmail.com

On 5 September 2017 at 22:12, Portia Stephens
<portia.stephens@xilinx.com> wrote:
> This adds the Jazelle execution state as a feature if ARM_FEATURE_V6 is
> set or if the processor is arm926 or arm1026. This fixes the issue that any
> BXJ instruction will result in an illegal_op. BXJ instructions will now
> check if the architecture supports ARM_FEATURE_JAZELLE.
>
> Signed-off-by: Portia Stephens <portia.stephens@xilinx.com>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks, applied to target-arm.next. I tweaked the text of the comment
and the commit message a little to make it clearer that all the JAZELLE
feature bit does is indicate support for the "trivial Jazelle"
implementation, not the full thing.

thanks
-- PMM
