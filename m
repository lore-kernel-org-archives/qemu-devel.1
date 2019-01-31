Received: from eggs.gnu.org ([209.51.188.92]:33030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin@duskware.de>) id 1gpCr8-0005nf-TV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin@duskware.de>) id 1gpCr8-000871-Ax
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:58:14 -0500
Date: Thu, 31 Jan 2019 14:58:02 +0100
From: Martin Husemann <martin@NetBSD.org>
Message-ID: <20190131135802.GA3213@mail.duskware.de>
References: <20190131130700.28392-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131130700.28392-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] target/arm: Make FPSCR/FPCR
 trapped-exception bits RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Martin Husemann <martin@netbsd.org>

On Thu, Jan 31, 2019 at 01:07:00PM +0000, Peter Maydell wrote:
> Martin: this is a different fix to the one I suggested you test,
> because I realized we need to make these bits RAZ/WI in the aarch32
> FPSCR as well as the aarch64 FPCR, but it should have the same effect.

This one works fine for me too.

Thanks!

Martin
