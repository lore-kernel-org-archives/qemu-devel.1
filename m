Received: from eggs.gnu.org ([2001:4830:134:3::10]:60980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhM7-0007pF-2P
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhM3-0002II-Vu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:29:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYhM3-0002I6-S2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:29:07 -0400
Date: Fri, 21 Jul 2017 19:29:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721232906.GS10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-35-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-35-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 34/34] target/arm: Perform per-insn
 cross-page check only for Thumb
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

On Fri, Jul 14, 2017 at 23:42:43 -1000, Richard Henderson wrote:
> ARM is a fixed-length ISA and we can compute the page crossing
> condition exactly once during init_disas_context.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
