Received: from eggs.gnu.org ([2001:4830:134:3::10]:55330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlji-0000A5-R5
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTljh-0004ua-Tz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:13:42 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTljh-0004uC-HE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:13:41 -0400
Received: by mail-ot0-x241.google.com with SMTP id v24-v6so1869575otk.13
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611125633.32755-1-peter.maydell@linaro.org>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:13:20 +0100
Message-ID: <CAFEAcA88FD2pEM_GmPy6QtRVwd2f41Y9V84pvcpNtt_vu7LKeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] cputlb: document iotlb.addr,
 fix txfail physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 11 June 2018 at 13:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset is two vaguely related patches that I wrote
> while I was trying to understand the cputlb code enough to
> add support for small-MPU-regions for v7M/v8M.
>
> Patch 1 is just a docs comment patch, describing what the
> CPUIOTLBEntry 'addr' field actually contains.
>
> Patch 2 fixes a bug that doesn't yet have any visible effects
> (we were passing cpu_transaction_failed() the wrong value for
> the physaddr) roughly as suggested by Paolo back in
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02419.html
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   cpu-defs.h: Document CPUIOTLBEntry 'addr' field
>   cputlb: Pass cpu_transaction_failed() the correct physaddr

I'll put these in via target-arm.next (with the ramaddr_t/ram_addr_t
typo fixed), unless anybody would prefer them to go via another route.

thanks
-- PMM
