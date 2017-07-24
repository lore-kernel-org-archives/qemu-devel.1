Received: from eggs.gnu.org ([2001:4830:134:3::10]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZkTt-0004HG-17
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZkTp-0001wt-VV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dZkTp-0001wk-S8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:29 -0400
Date: Mon, 24 Jul 2017 17:01:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170724210129.GB23091@flamenco>
References: <20170724202728.25960-1-rth@twiddle.net>
	<20170724202728.25960-32-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724202728.25960-32-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v15 31/32] target/arm: Split out
 thumb_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu

On Mon, Jul 24, 2017 at 13:27:27 -0700, Richard Henderson wrote:
> We need not check for ARM vs Thumb state in order to dispatch
> disassembly of every instruction.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate.c | 121 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 80 insertions(+), 41 deletions(-)

Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>

		E.
