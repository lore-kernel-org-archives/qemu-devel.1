Received: from eggs.gnu.org ([2001:4830:134:3::10]:33994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoou9-0006CS-8k
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoou8-0003Ue-9H
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:19:13 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoou8-0003Tv-3I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:19:12 -0500
Received: by mail-ot0-x241.google.com with SMTP id f11so4271273otj.12
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 03:19:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMVh5KYxrPPL6Cg8foua3Ot_m3-_Uu+S+H=32sD8mfzJQ@mail.gmail.com>
References: <20180209093643.GC27456@shattrath>
	<1518555259-26463-1-git-send-email-rbraun@sceen.net>
	<CAKmqyKMVh5KYxrPPL6Cg8foua3Ot_m3-_Uu+S+H=32sD8mfzJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 11:18:50 +0000
Message-ID: <CAFEAcA-nTiOPQ-Gu1e=qs-UPmbaDUu1kmGCH=K++APLn0+X9fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/char/stm32f2xx_usart: fix TXE/TC bit
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Braun <rbraun@sceen.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On 15 February 2018 at 22:27, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 12:54 PM, Richard Braun <rbraun@sceen.net> wrote:
>> I/O currently being synchronous, there is no reason to ever clear the
>> SR_TXE bit. However the SR_TC bit may be cleared by software writing
>> to the SR register, so set it on each write.
>>
>> In addition, fix the reset value of the USART status register.
>>
>> Signed-off-by: Richard Braun <rbraun@sceen.net>
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>



Applied to target-arm.next, thanks.

-- PMM
