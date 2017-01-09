Received: from eggs.gnu.org ([2001:4830:134:3::10]:38031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQYZC-00053I-11
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQYZB-0005Ye-34
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:56:46 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:33419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQYZA-0005YT-LH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:56:45 -0500
Received: by mail-ua0-x22c.google.com with SMTP id i68so355398895uad.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 03:56:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170107122047.26300-1-jcd@tribudubois.net>
References: <20170107122047.26300-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 11:56:23 +0000
Message-ID: <CAFEAcA9fRh=MteBdYAxrgGWADovA4tTa4gNmOsfVbCnYggnRVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 7 January 2017 at 12:20, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> From the documentation it is not clear what this SPI register is about.
>
> Moreover, neither linux driver nor xvisor driver are using this SPI register.
>
> For now we just remove it and issue a log on register write access.

By the way, could you make sure you use standard commit subject
line forms like
 hw/spi/imx_spi.c: Remove ...

If you put [i.MX] in square brackets like that then patch application
tools remove it (on the assumption that it's a meta-tag like [PATCH])
and the commit summary in git ends up just "Remove MSGDATA register support"
with no indication of what bit of the code it is dealing with.

(I fixed up these two patches manually when I put them into target-arm.)

thanks
-- PMM
