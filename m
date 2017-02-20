Received: from eggs.gnu.org ([2001:4830:134:3::10]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfoNz-0002gY-1m
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfoNx-00085b-Pn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:52:15 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfoNx-00085K-JJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:52:13 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t18so22594645wmt.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:52:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486997062-23227-2-git-send-email-clg@kaod.org>
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
	<1486997062-23227-2-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 13:51:51 +0000
Message-ID: <CAFEAcA-q-VSup75PO-To9N11+0WCm=LNiFQ-SQXaTQMroyHFbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] aspeed/smc: add a 'sdram_base' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2017 at 14:44, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The setting of the DRAM address of the DMA transaction depends on the
> DRAM base address of the SoC. Let's add a property to give this
> information to the SMC controller model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> --

This seems a bit weird -- what does it actually do in hardware?
(Does it really have the ability to dma anywhere in the
address space and just use an odd base address, or is it
DMA'ing to a more restricted address space?)

thanks
-- PMM
