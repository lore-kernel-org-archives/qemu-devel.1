Received: from eggs.gnu.org ([2001:4830:134:3::10]:59778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGBS-00015q-Nw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGBO-0004nh-9s
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:54:38 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpGBO-0004nR-3F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:54:34 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a47so7922675wra.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:54:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
References: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 16:54:11 +0100
Message-ID: <CAFEAcA9MLp8kUihyujJKBLUr=HNtHhy+d2VCE_6NdyxVe6RXwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/alpha: Switch to
 do_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 8 August 2017 at 13:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> Switch the alpha target from the old unassigned_access hook
> to the new do_transaction_failed hook. This allows us to
> resolve a ??? in the old hook implementation.
>
> The only part of the alpha target that does physical
> memory accesses is reading the page table -- add a
> TODO comment there to the effect that we should handle
> bus faults on page table walks. (Since the palcode
> doesn't actually do anything useful on a bus fault anyway
> it's a bit moot for now.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 1501867249-1924-1-git-send-email-peter.maydell@linaro.org
> This patch sits on top of the series adding the new hook.

The prerequisites for this patch are now all in git master.

thanks
-- PMM
