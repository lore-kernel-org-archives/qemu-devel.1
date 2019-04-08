Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQoj-0003Ru-Tl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQoh-0007Rc-5o
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDQog-0007Qi-PX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id t8so11393258otp.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
	<cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
In-Reply-To: <cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 10:43:37 +0100
Message-ID: <CAFEAcA_7GVwQfiyJi-dRkCaoyGrGJQtCd6DdF1dgJcGPcCDTRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Laszlo Ersek <lersek@redhat.com>

On Mon, 8 Apr 2019 at 02:45, Heyi Guo <guoheyi@huawei.com> wrote:
> On 2019/4/7 21:16, Peter Maydell wrote:
> > I don't think it makes much sense to keep adding UARTs for every
> > bit of the system software stack. We don't have an infinite
> > supply of UARTs on real hardware either -- how is this handled
> > there ?
> As you were in the edk2 mail thread, I supposed you also agreed to add one more UART. What did you mean by "I do still have a todo list item to add a 2nd UART"? How shall we do that?

That would be a simple second UART available to both secure
and non-secure and advertised in the device tree. It would
only be created if the user specifically asked for it on
the QEMU command line. I still need to investigate exactly
how that ought to work, though.

thanks
-- PMM
