Received: from eggs.gnu.org ([2001:4830:134:3::10]:52067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgBg-0006cX-6X
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgBf-0007tK-G6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:05:40 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVgBe-0007t3-3N
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:05:38 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so111690397uak.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 07:05:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACXAS8ALUZAxQn6y6G+aowfHCPQppovOmC67HGUsa-01Dng_4A@mail.gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
	<1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA8=gKjbo9YaRAzGHi-tP6AWY08ps_tEPOSzpNFXBC6M+Q@mail.gmail.com>
	<CACXAS8COsHWMAqoQTDqs6zh=-f0_u7posLQ1nUe6TKRfBaBSEg@mail.gmail.com>
	<CAFEAcA8cS8DMbHsVU8oWVtB1JsSQJGi1igyFZVMcuzXXjpVkEQ@mail.gmail.com>
	<CACXAS8ALUZAxQn6y6G+aowfHCPQppovOmC67HGUsa-01Dng_4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 15:05:17 +0000
Message-ID: <CAFEAcA-A+_DfEJfhX9=-wUcHgc+-s-iUY8QnBmCcJMFD3akePQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 30/30] target-sparc: fix up niagara machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 23 January 2017 at 14:59, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
> On Mon, Jan 23, 2017 at 3:24 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> If they're actually necessary then perhaps we should refuse
>> to start entirely?
>
> Yes, I think it's a best option. Don't load any images with the
> -nodefaults option and fail on missing ones wintout -nodefaults.
>
> Is there a failing variant of rom_add_file_fixed (I guess it's not
> uncommon, but I don't find it in include/hw/loader.h) or do I just
> check the return status?

I think you just have to check the return status.

thanks
-- PMM
