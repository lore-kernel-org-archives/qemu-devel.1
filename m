Received: from eggs.gnu.org ([209.51.188.92]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj80I-0004g7-I0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj80G-00085Y-Hb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:34:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gj80G-000855-8f
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:34:32 -0500
Date: Mon, 14 Jan 2019 14:34:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190114193427.GA2286@flamenco>
References: <20190114165017.27298-1-cota@braap.org>
	<20190114165017.27298-3-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114165017.27298-3-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v6 2/3] tcg: introduce dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, Jan 14, 2019 at 11:50:16 -0500, Emilio G. Cota wrote:
> Disabled in all TCG backends for now.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-defs.h  |  57 ++++++++++-
>  include/exec/cpu_ldst.h  |  21 ++++
>  tcg/aarch64/tcg-target.h |   1 +
>  tcg/arm/tcg-target.h     |   1 +
>  tcg/i386/tcg-target.h    |   1 +
>  tcg/mips/tcg-target.h    |   1 +
>  tcg/ppc/tcg-target.h     |   1 +
>  tcg/s390/tcg-target.h    |   1 +
>  tcg/sparc/tcg-target.h   |   1 +
>  tcg/tci/tcg-target.h     |   1 +
>  accel/tcg/cputlb.c       | 202 ++++++++++++++++++++++++++++++++++++++-
>  11 files changed, 281 insertions(+), 7 deletions(-)

Just realised the riscv backend was recently merged. I've
updated this commit on the github branch with the following:

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 60918cacb4..1eb032626c 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -33,6 +33,7 @@

 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32

Thanks,

		E.
