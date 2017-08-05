Received: from eggs.gnu.org ([2001:4830:134:3::10]:41848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1de2ia-0004Xq-Mn
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 13:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1de2iZ-0000NO-Jv
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 13:18:28 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1de2iZ-0000MP-Cv
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 13:18:27 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 12so26264736wrb.1
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 10:18:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170805011209.GA4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
	<20170805011209.GA4859@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Aug 2017 18:18:05 +0100
Message-ID: <CAFEAcA-9Os-e5rZZCNWoi0nzjo_g6wjMui=DA4K+8KM+ZjExJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/8] cpu: Define new
 cpu_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>, Laurent Vivier <Laurent@vivier.eu>

On 5 August 2017 at 02:12, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> BTW, a question. I don't know of any from memory but does any arch
> have the ability to report the payload that failed for stores?
> I guess it's easy enough to add that if needed though.

I think maybe m68k bus fault stack frames have
store payload data? The description of them is pretty
complicated though and I'm not sure how much of the
frame is "stuff we actually need to emulate" vs "data
that's only important if your implementation pipelines
instruction execution"...

As you say, we can easily add a 'uint64_t data' (only valid
when access_type == MMU_DATA_STORE), either now or later.

thanks
-- PMM
