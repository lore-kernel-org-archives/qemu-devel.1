Received: from eggs.gnu.org ([2001:4830:134:3::10]:37998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gup-0001Vm-OD
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gul-0002mU-30
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:53:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6guk-0002ln-SD
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:53:27 -0400
Date: Mon, 23 Oct 2017 13:53:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023175325.GH6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-25-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-25-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 24/52] tcg: Add CPUState cflags_next_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com

On Fri, Oct 20, 2017 at 16:19:55 -0700, Richard Henderson wrote:
> We were generating code during tb_invalidate_phys_page_range,
> check_watchpoint, cpu_io_recompile, and (seemingly) discarding
> the TB, assuming that it would magically be picked up during
> the next iteration through the cpu_exec loop.
> 
> Instead, record the desired cflags in CPUState so that we request
> the proper TB so that there is no more magic.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

This does indeed fix icount with and without MTTCG. Nice!

		E.
