Received: from eggs.gnu.org ([209.51.188.92]:58979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjeWE-0000J5-CW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjeWD-0004zj-IC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:17:42 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjeWC-0004rJ-U1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:17:41 -0500
Received: by mail-pl1-x644.google.com with SMTP id b5so2495723plr.4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 22:17:40 -0800 (PST)
References: <20190116041916.130523-1-aik@ozlabs.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <511a675b-fa61-1ef0-643f-9c568b5daaa8@linaro.org>
Date: Wed, 16 Jan 2019 17:17:33 +1100
MIME-Version: 1.0
In-Reply-To: <20190116041916.130523-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

On 1/16/19 3:19 PM, Alexey Kardashevskiy wrote:
> because TARGET_FMT_lx is defined as "%016"PRIx64.
> 
> This uses simple "%lx" to suppress the warning. Since it is spapr which
> is always 64bit, we assume here that hwaddr is always "long".

This file is not solely for kvm, i.e. ppc64 hosts.  Thus this
is a bad assumption and will fail for a 32-bit host.

You may want to use PRIx64 and assume hwaddr == uint64_t, or
also include an explicit cast to uint64_t.


r~
