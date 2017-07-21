Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYh7W-00040T-30
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYh7R-0004Ke-47
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:14:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46939)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYh7Q-0004KR-Vp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:14:01 -0400
Date: Fri, 21 Jul 2017 19:14:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721231400.GO10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-32-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-32-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 31/34] target/arm: [a64] Move page and
 ss checks to init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:40 -1000, Richard Henderson wrote:
> Since AArch64 uses a fixed-width ISA, we can pre-compute the number of
> insns remaining on the page.  Also, we can check for single-step once.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Pity, if it wasn't for thumb, we could get rid of dc->next_page_start.

		E.
