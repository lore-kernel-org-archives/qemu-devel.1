Received: from eggs.gnu.org ([2001:4830:134:3::10]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgYBB-0005J8-G9
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgYB9-0003zs-LJ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:22:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgYB9-0003zb-DJ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:22:51 -0400
Received: by mail-pg1-x543.google.com with SMTP id k3-v6so7293126pgq.5
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:22:51 -0700 (PDT)
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72aa0d1f-92ad-1cdb-84b7-1649b03a54ff@linaro.org>
Date: Fri, 20 Jul 2018 09:22:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Implement tailchaining for
 M profile cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/20/2018 07:56 AM, Peter Maydell wrote:
> Tailchaining is an optimization in handling of exception return
> for M-profile cores: if we are about to pop the exception stack
> for an exception return, but there is a pending exception which
> is higher priority than the priority we are returning to, then
> instead of unstacking and then immediately taking the exception
> and stacking registers again, we can chain to the pending
> exception without unstacking and stacking.
> 
> For v6M and v7M it is IMPDEF whether tailchaining happens for pending
> exceptions; for v8M this is architecturally required.  Implement it
> in QEMU for all M-profile cores, since in practice v6M and v7M
> hardware implementations generally do have it.
> 
> (We were already doing tailchaining for derived exceptions which
> happened during exception return, like the validity checks and
> stack access failures; these have always been required to be
> tailchained for all versions of the architecture.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
