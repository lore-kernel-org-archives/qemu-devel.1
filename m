Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG3G-0006gp-Iz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXG3F-0005J0-Ir
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:07:46 -0400
Date: Mon, 17 Jul 2017 20:07:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718000738.GC30851@flamenco>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170711175937.23140-3-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] target/arm/translate: make
 DISAS_UPDATE match declared semantics
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

On Tue, Jul 11, 2017 at 18:59:33 +0100, Alex Bennée wrote:
> DISAS_UPDATE should be used when the wider CPU state other than just
> the PC has been updated and we should therefor exit the TCG runtime

s/therefor/therefore/

> and return to the main execution loop rather assuming DISAS_JUMP would

Rather *than* assuming ?

> do that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
