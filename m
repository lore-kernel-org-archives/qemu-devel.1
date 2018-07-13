Received: from eggs.gnu.org ([2001:4830:134:3::10]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fe1BI-0001C0-PY
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fe1BH-0005Ro-RI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 12:44:32 -0400
Date: Fri, 13 Jul 2018 12:44:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180713164425.GB22074@flamenco>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710160013.26559-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] accel/tcg: Handle get_page_addr_code()
 returning -1 in hashtable lookups
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

On Tue, Jul 10, 2018 at 17:00:09 +0100, Peter Maydell wrote:
> When we support execution from non-RAM MMIO regions, get_page_addr_code()
> will return -1 to indicate that there is no RAM at the requested address.
> Handle this in the cpu-exec TB hashtable lookup code, treating it as
> "no match found".
> 
> Note that the call to get_page_addr_code() in tb_lookup_cmp() needs
> no changes -- a return of -1 will already correctly result in the
> function returning false.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
