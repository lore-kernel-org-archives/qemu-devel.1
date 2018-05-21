Received: from eggs.gnu.org ([2001:4830:134:3::10]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fKqsL-000676-Ud
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fKqsJ-0003h4-L0
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:53:46 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fKqsJ-0003g0-Eh
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:53:43 -0400
Received: by mail-pl0-x241.google.com with SMTP id c11-v6so9415788plr.5
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 12:53:41 -0700 (PDT)
References: <20180521172712.19930-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7da8b572-de65-8ea5-2f80-6defe9c4b8c5@linaro.org>
Date: Mon, 21 May 2018 12:53:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180521172712.19930-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Honour FPCR.FZ in FRECPX
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

On 05/21/2018 10:27 AM, Peter Maydell wrote:
> The FRECPX instructions should (like most other floating point operations)
> honour the FPCR.FZ bit which specifies whether input denormals should
> be flushed to zero (or FZ16 for the half-precision version).
> We forgot to implement this, which doesn't affect the results (since
> the calculation doesn't actually care about the mantissa bits) but did
> mean we were failing to set the FPSR.IDC bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper-a64.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
