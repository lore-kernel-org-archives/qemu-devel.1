Received: from eggs.gnu.org ([2001:4830:134:3::10]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmhtl-0000EK-FE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmhth-0003IV-J6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:53:49 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmhth-0003IM-Ci
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:53:45 -0400
Received: by mail-pg0-x230.google.com with SMTP id t3so11553992pgt.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 07:53:45 -0700 (PDT)
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-4-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a54b357-4512-d36d-eb01-67471658fbe4@linaro.org>
Date: Tue, 29 Aug 2017 07:53:41 -0700
MIME-Version: 1.0
In-Reply-To: <20170829063313.10237-4-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 PATCH 4/5] mttcg: Implement implicit
 ordering semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

On 08/28/2017 11:33 PM, Pranith Kumar wrote:
> Currently, we cannot use mttcg for running strong memory model guests
> on weak memory model hosts due to missing ordering semantics.
> 
> We implicitly generate fence instructions for stronger guests if an
> ordering mismatch is detected. We generate fences only for the orders
> for which fence instructions are necessary, for example a fence is not
> necessary between a store and a subsequent load on x86 since its
> absence in the guest binary tells that ordering need not be
> ensured. Also note that if we find multiple subsequent fence
> instructions in the generated IR, we combine them in the TCG
> optimization pass.
> 
> This patch allows us to boot an x86 guest on ARM64 hosts using mttcg.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tcg/tcg-op.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
