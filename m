Received: from eggs.gnu.org ([209.51.188.92]:51070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQU7-0007b2-Pu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQU6-0002mu-Vz
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:19:15 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQU6-0002mZ-PF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:19:14 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so17403524otl.6
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 02:19:14 -0800 (PST)
MIME-Version: 1.0
References: <1548755497-30459-1-git-send-email-tklauser@distanz.ch>
In-Reply-To: <1548755497-30459-1-git-send-email-tklauser@distanz.ch>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 10:19:02 +0000
Message-ID: <CAFEAcA-nePUjjABt+r6ODq_7Pmbbz58prAU7Gr2LM5efaRMFaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juro Bystricky <juro.bystricky@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 29 Jan 2019 at 09:51, Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Add the Altera JTAG UART model.
>
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> (Please see "Register Map" on page 65)
>
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> Acked-by: Marek Vasut <marex@denx.de>
> Tested-by: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Do you also have a patch which makes one of the QEMU machine
models use this new device ?

thanks
-- PMM
