Received: from eggs.gnu.org ([2001:4830:134:3::10]:44766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fe18M-0000SF-WA
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fe18M-0003sf-99
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:41:31 -0400
Date: Fri, 13 Jul 2018 12:41:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180713164121.GA22074@flamenco>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710160013.26559-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] accel/tcg: tb_gen_code(): Create
 single-insn TB for execution from non-RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On Tue, Jul 10, 2018 at 17:00:11 +0100, Peter Maydell wrote:
> If get_page_addr_code() returns -1, this indicates that there is no RAM
> page we can read a full TB from. Instead we must create a TB which
> contains a single instruction and which we do not cache, so it is
> executed only once.
> 
> Since this means we can now have TBs which are not in any page list,
> we also need to make tb_phys_invalidate() handle them (by not trying
> to remove them from a nonexistent page list).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		Emilio
