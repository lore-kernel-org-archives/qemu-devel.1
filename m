Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7SUX-0004Kx-JK
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7SUT-0007KC-Id
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:46:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7SUT-0007K5-EP
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:46:01 -0400
Date: Tue, 2 Oct 2018 17:45:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181002214559.GA10503@flamenco>
References: <20181002195347.26712-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002195347.26712-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Tue, Oct 02, 2018 at 14:53:47 -0500, Richard Henderson wrote:
> The __udiv_qrnnd primitive that we nicked from gmp requires its
> inputs to be normalized.  We were not doing that.  Because the
> inputs are nearly normalized already, finishing that is trivial.
> Inline div128to64 into its one user, because it is no longer a
> general-purpose routine.
> 
> Fixes: cf07323d494
> Fixes: https://bugs.launchpad.net/qemu/+bug/1793119
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

Tested-by: Emilio G. Cota <cota@braap.org>

		E.
