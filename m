Received: from eggs.gnu.org ([2001:4830:134:3::10]:51281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb6WB-0001Me-0P
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb6W7-0006yV-UT
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:50:03 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb6W7-0006yD-Ng
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:49:59 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so5788839pfm.10
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:49:59 -0700 (PDT)
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20f56ce2-9998-75c1-a15f-80633a70bd5e@linaro.org>
Date: Thu, 5 Jul 2018 08:49:55 -0700
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target/mips: Avoid case statements
 formulated by ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: pburton@wavecomp.com, smarkovic@wavecomp.com, philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 07/04/2018 12:30 PM, Aleksandar Markovic wrote:
>      case 18:
>          switch (sel) {
> -        case 0 ... 7:
> +        case 0:
> +        case 1:
> +        case 2:
> +        case 3:
> +        case 4:
> +        case 5:
> +        case 6:
> +        case 7:

I don't see the point in this.  It is clear what 0 ... 7 means.

> -    case OPC_MULT ... OPC_DIVU:
> +    case OPC_MULT:
> +    case OPC_MULTU:
> +    case OPC_DIV:
> +    case OPC_DIVU:

These on the other hand are a good cleanup, because there's no obvious
relationship between the beginning and end of the range.


r~
