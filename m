Received: from eggs.gnu.org ([2001:4830:134:3::10]:47785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff6Lp-0004le-Qr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff6Lp-0007mo-21
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:27:53 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff6Lo-0007mM-Rg
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:27:52 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so75941246ois.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180713141636.18665-1-peter.maydell@linaro.org>
References: <20180713141636.18665-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:27:31 +0100
Message-ID: <CAFEAcA_CHjuAbe3QgcL+SEc4xi=HQM6TCpY=5gkxt61_+LQVYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.0 0/2] accel/tcg: fix
 get_page_addr_code() victim TLB lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 13 July 2018 at 15:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes a bug in get_page_addr_code()'s
> lookup of the address in the victim TLB, which was another
> source of "we end up with an invalid TLB entry even after
> we've done a TLB fill for it".
>
> The second patch then removes a check that we had that was
> working around the existence of the bug patch 1 fixes and
> the bug that commit 68fea038553039e fixes, and instead
> puts in an assertion that we definitely do have a valid TLB.
>
> Tested with Laurent's m68k image to check we didn't regress that.

Thanks for the review -- I'll take these via target-arm.next
since RTH doesn't have any other tcg patches for rc1.

-- PMM
