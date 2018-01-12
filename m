Received: from eggs.gnu.org ([2001:4830:134:3::10]:34140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2pH-00040F-LC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2pG-0002a7-El
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:09:07 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea2pG-0002ZA-9W
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:09:06 -0500
Received: by mail-ot0-x22a.google.com with SMTP id g59so5584462otg.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:09:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180110203823.22292-1-jcd@tribudubois.net>
References: <20180110203823.22292-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 17:08:45 +0000
Message-ID: <CAFEAcA9q9tKedxXxMDS3e2jWA8geL2q2pe=Oo3-E8RQ=cD7LFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fyleo45@gmail.com, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Jason Wang <jasowang@redhat.com>

On 10 January 2018 at 20:38, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> The actual imx_eth_enable_rx() function is buggy.
>
> It updates s->regs[ENET_RDAR] after calling qemu_flush_queued_packets().
>
> qemu_flush_queued_packets() is going to call imx_XXX_receive() which itself
> is going to call imx_eth_enable_rx().
>
> By updating s->regs[ENET_RDAR] after calling qemu_flush_queued_packets()
> we end up updating the register with an outdated value which might
> lead to disabling the receive function in the i.MX FEC/ENET device.
>
> This patch change the place where the register update is done so that the
> register value stays up to date and the receive function can keep
> running.
>
> Reported-by: Fyleo <fyleo45@gmail.com>
> Tested-by: Fyleo <fyleo45@gmail.com>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Could you have a look at current QEMU master, please? I think that
commit b2b012afdd9c has probably fixed this bug. (At any rate it
has changed that code so that your patch won't apply.)

thanks
-- PMM
