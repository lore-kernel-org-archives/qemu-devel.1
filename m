Received: from eggs.gnu.org ([209.51.188.92]:51197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4OJ-0002P3-4x
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4OH-0008PQ-WC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:43:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go4OH-0008K1-RE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:43:45 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so14171171otm.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 02:43:34 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8WF1nKfgQWZ11GgMzgLxOtGwoJS9zyeFQkm5ii5GLrpw@mail.gmail.com>
	<CAHmQWvD-gqxR+7dOG3BKA-5cGA-JBb4SAfJWpRAtqrOkfRw-kw@mail.gmail.com>
In-Reply-To: <CAHmQWvD-gqxR+7dOG3BKA-5cGA-JBb4SAfJWpRAtqrOkfRw-kw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 10:43:23 +0000
Message-ID: <CAFEAcA-=g6SeFwchRqo-+BaqH+def5DTcEXo3n3CZbMp_zr_bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Mon, 28 Jan 2019 at 10:16, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 19:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Comment says 256M but the size field says it's larger...
> >
> I calculated, 256M should be 0x10000000, 7 zeros.

Yes, you're right, this was my mistake.

PS: sorry about the other blank mail, the gmail interface seems
to have changed somehow and is making it easier to accidentally
send a no-new-content email :-(

thanks
-- PMM
