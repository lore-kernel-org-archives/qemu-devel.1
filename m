Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hQq-00019T-Ps
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hQm-0003cs-R4
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:46:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hQm-0003c4-Ll
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:46:00 -0400
Date: Tue, 27 Mar 2018 01:45:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327054559.GA1666@flamenco>
References: <20180327034757.3432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327034757.3432-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg: Mark muluh_i64 and mulsh_i64
 as 64-bit ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, patches@groups.riscv.org, mjc@sifive.com

On Tue, Mar 27, 2018 at 11:47:57 +0800, Richard Henderson wrote:
> Failure to do so results in the tcg optimizer sign-extending
> any constant fold from 32-bits.  This turns out to be visible
> in the RISC-V testsuite using a host that emits these opcodes
> (e.g. any non-x86_64).
>
> Reported-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
