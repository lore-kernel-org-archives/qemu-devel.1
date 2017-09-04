Received: from eggs.gnu.org ([2001:4830:134:3::10]:51709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dou6w-0006td-0i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dou6r-0006Zb-Ji
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:20:30 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dou6r-0006Yw-D6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:20:25 -0400
Received: by mail-wm0-x230.google.com with SMTP id i145so7554875wmf.1
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 09:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504535944-32321-1-git-send-email-peter.maydell@linaro.org>
References: <1504535944-32321-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 17:20:03 +0100
Message-ID: <CAFEAcA8bf+Q7X52pMyQVnHT+MKtA5-0eJxc2u00ya=XgA=coPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/36] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2017 at 15:39, Peter Maydell <peter.maydell@linaro.org> wrote:
> Try #2, with the compile failure in kvm32.c fixed
> (trivial change, not resending patches)

Rats, this doesn't work either -- turns out that
boards.h: Define new flag ignore_memory_transaction_failures
breaks the usermode emulators.

I'm going to drop:

>       boards.h: Define new flag ignore_memory_transaction_failures
>       hw/arm: Set ignore_memory_transaction_failures for most ARM boards
>       target/arm: Implement new do_transaction_failed hook

and resend the pullreq.

thanks
-- PMM
