Received: from eggs.gnu.org ([2001:4830:134:3::10]:58458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYucb-0006o6-0J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYucX-0005Xk-TC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:43:37 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYucX-0005Td-Ka
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:43:33 -0400
Received: by mail-pg0-x244.google.com with SMTP id b10-v6so4091671pgq.11
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:43:33 -0700 (PDT)
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-2-richard.henderson@linaro.org>
	<CAFEAcA8MtK93KV5ZHchUP3H+bx4eANnjndU__xrGSBZDXsXnGQ@mail.gmail.com>
	<CAFEAcA888_6QJCC2OTbdTg_9bVBC8dvu_zaDG63ZKv3R312+AA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58b4d7f9-e5e5-1de8-1557-8ce0c2bb123a@linaro.org>
Date: Fri, 29 Jun 2018 07:43:29 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA888_6QJCC2OTbdTg_9bVBC8dvu_zaDG63ZKv3R312+AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] target/arm: Fix SVE signed division vs
 x86 overflow exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/29/2018 02:10 AM, Peter Maydell wrote:
> Suggested revised comment text:
> 
> /* We must avoid the C undefined behaviour cases: division by
>  * zero and signed division of INT_MIN by -1. Both of these
>  * have architecturally defined required results for Arm.
>  * We special case all signed divisions by -1 to avoid having
>  * to deduce the minimum integer for the type involved.
>  */
> 
> ?

I'm happy with that.


r~
