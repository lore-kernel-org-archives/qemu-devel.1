Received: from eggs.gnu.org ([2001:4830:134:3::10]:50749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCUp-0002rM-J6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCUo-0006S0-Lv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:02:15 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCUo-0006Rn-GM
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:02:14 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so22964097oik.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:02:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-7-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-7-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 19:01:53 +0100
Message-ID: <CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 6/7] loader: Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Alistair Francis <alistair@alistair23.me>, Liviu Ionescu <ilg@livius.net>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> From: Su Hang <suhang16@mails.ucas.ac.cn>
>
> This patch adds Intel Hexadecimal Object File format support to the
> loader.  The file format specification is available here:
> http://www.piclist.com/techref/fileext/hex/intel.htm
>
> This file format is often used with microcontrollers such as the
> micro:bit, Arduino, STM32, etc.  Users expect to be able to run them
> directly with qemu -kernel program.hex instead of converting to ELF or
> binary.

I'm still not convinced we want to add another random
special case only-works-on-one-architecture-and-some-boards
feature to the -kernel command line option.

Adding it to the "generic loader" device might be more plausible?
Or just get the user to create ELF files or plain binary files,
both of which we already handle.

thanks
-- PMM
