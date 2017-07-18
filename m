Received: from eggs.gnu.org ([2001:4830:134:3::10]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGAM-0003Q0-AR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGAL-0001c5-ER
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:15:06 -0400
Date: Mon, 17 Jul 2017 20:14:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718001458.GF30851@flamenco>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170711175937.23140-7-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 6/6] target/arm: use DISAS_EXIT for eret
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On Tue, Jul 11, 2017 at 18:59:37 +0100, Alex Bennée wrote:
> Previously DISAS_JUMP did ensure this but with the optimisation of
> 8a6b28c7 (optimize indirect branches) we might not leave the loop.
> This means if any pending interrupts are cleared by changing IRQ flags
> we might never get around to servicing them. You usually notice this
> by seeing the lookup_tb_ptr() helper gainfully chaining TBs together
> while cpu->interrupt_request remains high and the exit_request has not
> been set.
> 
> This breaks amongst other things the OPTEE test suite which executes
> an eret from the secure world after a non-secure world IRQ has gone
> pending which then never gets serviced.
> 
> Instead of using the previously implied semantics of DISAS_JUMP we use
> DISAS_EXIT which will always exit the run-loop.
> 
> CC: Etienne Carriere <etienne.carriere@linaro.org>
> CC: Joakim Bech <joakim.bech@linaro.org>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
