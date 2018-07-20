Received: from eggs.gnu.org ([2001:4830:134:3::10]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY7k-0002vu-Ub
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY7h-0002Jp-Pz
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:19:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgY7h-0002JT-J2
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:19:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id d14-v6so89255pfo.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:19:17 -0700 (PDT)
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c56c0d5-3b29-7d3c-607c-f1cecd2077ca@linaro.org>
Date: Fri, 20 Jul 2018 09:19:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/arm: Restore M-profile
 CONTROL.SPSEL before any tailchaining
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
> On exception return for M-profile, we must restore the CONTROL.SPSEL
> bit from the EXCRET value before we do any kind of tailchaining,
> including for the derived exceptions on integrity check failures.
> Otherwise we will give the guest an incorrect EXCRET.SPSEL value on
> exception entry for the tailchained exception.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
