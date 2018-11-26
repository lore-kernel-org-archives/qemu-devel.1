Received: from eggs.gnu.org ([2001:4830:134:3::10]:35720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gR4oI-0002mW-1z
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gR4oE-0006Wy-RN
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:31:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gR4oE-0006Wi-O7
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:31:30 -0500
Date: Sun, 25 Nov 2018 19:31:29 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126003129.GB12936@flamenco>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123144558.5048-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 04/37] tcg: Add
 TCG_TARGET_NEED_LDST_OOL_LABELS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com

On Fri, Nov 23, 2018 at 15:45:25 +0100, Richard Henderson wrote:
> This variant of tcg-ldst.inc.c allows the entire thunk to be
> moved out-of-line, with caching across TBs within a region.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
(snip)
> +++ b/tcg/tcg-ldst-ool.inc.c
(snip)
> +typedef struct TCGLabelQemuLdstOol {
> +    QSIMPLEQ_ENTRY(TCGLabelQemuLdstOol) next;
> +    tcg_insn_unit *label;   /* label pointer to be updated */
> +    int reloc;              /* relocation type from label_ptr */
> +    intptr_t addend;        /* relocation addend from label_ptr */
> +    uint32_t key;           /* oi : is_64 : is_ld */
> +} TCGLabelQemuLdstOol;

Just a tiny nit, here we can move reloc down to plug a hole.

		Emilio
