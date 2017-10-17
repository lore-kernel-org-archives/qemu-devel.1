Received: from eggs.gnu.org ([2001:4830:134:3::10]:57211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ZxQ-0004Qb-U8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ZxN-0007c2-1H
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:03:28 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4ZxM-0007bQ-Qp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:03:24 -0400
Date: Tue, 17 Oct 2017 18:03:22 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017220322.GJ1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171016172609.23422-11-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 10/50] tcg: Avoid loops against variable
 bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:29 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Copy s->nb_globals or s->nb_temps to a local variable for the purposes
> of iteration.  This should allow the compiler to use low-overhead
> looping constructs on some hosts.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

FWIW on a Skylake host I couldn't measure a difference. However, the
generated code is indeed slightly different.

		E.
