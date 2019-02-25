Received: from eggs.gnu.org ([209.51.188.92]:39780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDuG-0003xa-HR
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDuE-0002wi-Db
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:54:44 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyDuC-0002v2-F6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:54:42 -0500
Received: by mail-ot1-x332.google.com with SMTP id v62so7435441otb.3
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:54:39 -0800 (PST)
MIME-Version: 1.0
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
In-Reply-To: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 10:54:27 +0000
Message-ID: <CAFEAcA8teAW3XG+DbCxGYLry7oB2dRhS5oS-=U4WERZR5JA=Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On Mon, 25 Feb 2019 at 10:49, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi,
>
> I had more thought about the reset problem and what we want to achieve
> (add power gating and clock support).
> Feel free to comment. I'll start to implement this and send a first
> version with a reroll of everything when it's ready.

Thanks very much for taking this up. I'll read this email
through in more detail over the next day or so and provide
some feedback. In the meantime, just to save you having to do
a search-n-replace over all your changes:

> I propose to add a Resetable interface and a ResetDomain object.

...this should be "Resettable" :-)

thanks
-- PMM
