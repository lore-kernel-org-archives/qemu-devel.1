Received: from eggs.gnu.org ([2001:4830:134:3::10]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0Sx-0006Xc-TB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0SF-0004nm-IU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:48:43 -0500
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:43437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR0SF-0004mm-9p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:47:59 -0500
Received: by mail-pl0-x236.google.com with SMTP id z5so5351875plo.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:47:59 -0800 (PST)
References: <20171215170732.31125-1-richard.henderson@linaro.org>
	<20171215170732.31125-3-richard.henderson@linaro.org>
	<CAFEAcA_b4SOUN1tCyjNBPnf12SejPzBL-9dHQv6=K0C1HqTwag@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <042c1d72-6e46-1751-111b-5897174c24bd@linaro.org>
Date: Mon, 18 Dec 2017 10:47:55 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_b4SOUN1tCyjNBPnf12SejPzBL-9dHQv6=K0C1HqTwag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/moxie: Fix tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>

On 12/15/2017 09:31 AM, Peter Maydell wrote:
> I suspect this codepath has never been tested. There's another
> bug in moxie_cpu_handle_mmu_fault() where it will call
> tlb_set_page() even in the "mmu lookup missed, we're
> going to throw an exception" codepath.

Ah, didn't notice that one, but yes.

> Is moxie even worth bothering to keep in QEMU? As far as I can tell:
>  * the only changes to target/moxie since the target was added in
>    2013 have been generic cross-tree changes and cleanups and
>    minor bugs found by static analysis etc
>  * the last commit signed-off-by the moxie maintainer was
>    in March 2013
>  * last email to qemu-devel by the maintainer was December 2013
>  * as far as I can tell nobody's ever reported a bug to us,
>    which is suggestive that it has no users
> 
> This target is costing us maintenance effort -- is it actually
> useful to anybody ?

I doubt it.  I'd be ok removing it.


r~
