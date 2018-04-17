Received: from eggs.gnu.org ([2001:4830:134:3::10]:57132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f8Spz-0008Be-08
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f8Spy-0001Uh-5x
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:48:07 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:43854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1f8Spx-0001U7-Tc
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:48:06 -0400
Received: by mail-lf0-x241.google.com with SMTP id v207-v6so28033614lfa.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 08:48:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
References: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Apr 2018 08:47:33 -0700
Message-ID: <CAKmqyKP-cMmiZmGeZa6PX8LTpYO09fX6y8o_nNT5TwmSsF288Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/1] xilinx_spips dummy bytes fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Apr 17, 2018 at 7:18 AM, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
> For zynq-7000 boards, we saw issues when u-boot/linux accessing the qspi.
> Issue is due to wrong dummy byte transfers for few of un-handled commands ex: 0x9F, 0x6, 0xe9, 0x4, 0x18, etc
> There are many unhandled commands which do not require dummy bytes but they can be followed by address cycles.
>
> To fix this issue for above commands, the next upcoming tx bytes are not considered dummies rather sent to slave directly.
>
> Sai Pavan Boddu (1):
>   xilinx_spips: send dummy only if cmd requires it

I don't see this patch on the list, I only see the cover letter.

Do other see it?

Alistair

>
>  hw/ssi/xilinx_spips.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
>
