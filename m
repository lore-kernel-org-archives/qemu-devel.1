Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOJ1G-0000Yb-EK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOJ1F-0000Zb-J1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:33:14 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOJ1F-0000Z5-5Z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:33:13 -0400
Received: by mail-ot0-x244.google.com with SMTP id 15-v6so24372245otn.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 01:33:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmME9oda=T6C53BYi-Op3cWbG2auBjVDoUWuiJoCyxxR298fQ@mail.gmail.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
	<CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
	<20171212151605.v2eoestysaogzymm@kamzik.brq.redhat.com>
	<CAFEAcA-t7XFxizUQMdo_JYTLet_a8ZL-Omg54gLOQC-=o+vjuA@mail.gmail.com>
	<CAHmME9oda=T6C53BYi-Op3cWbG2auBjVDoUWuiJoCyxxR298fQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 09:32:51 +0100
Message-ID: <CAFEAcA_Ut0hjQ=25anhHtGgyY92++eTgyBwY1KbqRbLUeje0Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/virt: Add another UART to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>

On 31 May 2018 at 03:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Peter,
>
> What ever became of this? I still really could use a second UART in
> the standard configuration. I'm still building with this cludge --
> https://=D7=90.cc/RXI3ssWV -- in order to run the test suite on
> build.wireguard.com.

It stalled on the fact that adding the second UART breaks
UEFI images (annoyingly, UEFI iterates through UARTs in
the DTB in the opposite direction to Linux, so if you add
a second UART then it picks that one to use rather than
the first one, IIRC). So it would have to be an awkward
thing with a new machine option to request the extra UART.

thanks
-- PMM
