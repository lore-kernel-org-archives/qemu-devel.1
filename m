Received: from eggs.gnu.org ([2001:4830:134:3::10]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fOM49-0006bC-0Z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1fOM48-00052l-9X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:48:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Ut0hjQ=25anhHtGgyY92++eTgyBwY1KbqRbLUeje0Hg@mail.gmail.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
	<CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
	<20171212151605.v2eoestysaogzymm@kamzik.brq.redhat.com>
	<CAFEAcA-t7XFxizUQMdo_JYTLet_a8ZL-Omg54gLOQC-=o+vjuA@mail.gmail.com>
	<CAHmME9oda=T6C53BYi-Op3cWbG2auBjVDoUWuiJoCyxxR298fQ@mail.gmail.com>
	<CAFEAcA_Ut0hjQ=25anhHtGgyY92++eTgyBwY1KbqRbLUeje0Hg@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 31 May 2018 13:48:15 +0200
Message-ID: <CAHmME9pLYSwBQyus7vKu1zb48EF8D-X7vW=nuf2AV+xGN5ERbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>

On Thu, May 31, 2018 at 10:32 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> It stalled on the fact that adding the second UART breaks
> UEFI images (annoyingly, UEFI iterates through UARTs in
> the DTB in the opposite direction to Linux, so if you add
> a second UART then it picks that one to use rather than
> the first one, IIRC). So it would have to be an awkward
> thing with a new machine option to request the extra UART.

Can you just add them in the opposite order for UEFI then?
