Received: from eggs.gnu.org ([209.51.188.92]:38482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gsFrZ-0000Zi-Vy
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gsFrX-0006qF-NJ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:47:17 -0500
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:42713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gsFrX-0006pa-Bl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 18:47:15 -0500
Received: by mail-yw1-xc36.google.com with SMTP id v201so2055577ywa.9
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 15:47:15 -0800 (PST)
MIME-Version: 1.0
References: <CAMo8BfJ63PaA=0jJs4B03EK7idg8om7cyjud1hMUCRsBwBHrbA@mail.gmail.com>
	<20190208232737.GA5156@flamenco>
In-Reply-To: <20190208232737.GA5156@flamenco>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 8 Feb 2019 15:47:02 -0800
Message-ID: <CAMo8BfLsEtpEnAUBNmGcZLky4jOwOOX2UUHUEwROm7ZoqXbRBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] segfault on the mainline qemu-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Hi Emilio,

On Fri, Feb 8, 2019 at 3:27 PM Emilio G. Cota <cota@braap.org> wrote:
> On Fri, Feb 08, 2019 at 13:00:44 -0800, Max Filippov wrote:
> > after updating to the latest qemu mainline I get segfault with the following
> > backtrace when I run qemu-system-xtensa:

> The problem is that tlb_fill can end up triggering a resize of
> the TLB, and therefore after tlb_fill() we might end up with a
> stale entry pointer and index.
>
> Can you please test the appended?

that fixed the segfault for me, thank you!
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
