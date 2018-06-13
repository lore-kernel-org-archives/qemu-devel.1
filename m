Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSwXp-0005WF-KS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSwXk-0006hj-Ov
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:34:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSwXk-0006h0-Dq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:33:56 -0400
Date: Tue, 12 Jun 2018 23:33:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180613033353.GA25430@flamenco>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
	<20180611125633.32755-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611125633.32755-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] cpu-defs.h: Document CPUIOTLBEntry
 'addr' field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Mon, Jun 11, 2018 at 13:56:32 +0100, Peter Maydell wrote:
>  typedef struct CPUIOTLBEntry {
> +    /*
> +     * @addr contains:
> +     *  - in the lower TARGET_PAGE_BITS, a physical section number
> +     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> +     *    must be added to the virtual address to obtain:
> +     *     + the ramaddr_t of the target RAM (if the physical section

s/ramaddr_t/ram_addr_t/ ? Also in cputlb.c:

> +     * TARGET_PAGE_BITS, and either
> +     *  + the ramaddr_t of the page base of the target RAM (if NOTDIRTY or ROM)

Thanks,

		Emilio
