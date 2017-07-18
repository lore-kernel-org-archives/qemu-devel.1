Received: from eggs.gnu.org ([2001:4830:134:3::10]:53173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG6u-0001r1-Cu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG6t-0007Lc-GF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:11:32 -0400
Date: Mon, 17 Jul 2017 20:11:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718001124.GE30851@flamenco>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170711175937.23140-6-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] target/arm: use gen_goto_tb for ISB
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
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On Tue, Jul 11, 2017 at 18:59:36 +0100, Alex Bennée wrote:
> While an ISB will ensure any raised IRQs happen on the next
> instruction it doesn't cause any to get raised by itself. We can
> therefor use a simple tb exit for ISB instructions and rely on the

s/therefor/therefore/

> exit_request check at the top of each TB to deal with exiting if
> needed.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
