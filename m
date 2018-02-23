Received: from eggs.gnu.org ([2001:4830:134:3::10]:37891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHBl-0004IK-8s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHBk-00027y-6v
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:17 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epHBk-00026y-0Z
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:16 -0500
Received: by mail-pl0-x242.google.com with SMTP id d4so5264763pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:31:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d778b0e0-fafb-5e39-76e5-054722210c62@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-15-richard.henderson@linaro.org>
	<CAFEAcA9wa32T_vjH2NVxnsW3jzDw6nwPjMXuAdaBfrAXfCdHEw@mail.gmail.com>
	<d778b0e0-fafb-5e39-76e5-054722210c62@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 17:30:54 +0000
Message-ID: <CAFEAcA8hPuKKzQSfxVK9Njip7GNsHJqaXx7vNtpP9fULduuMug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 14/67] target/arm: Implement SVE Integer
 Arithmetic - Unary Predicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 February 2018 at 17:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/23/2018 05:08 AM, Peter Maydell wrote:
>>> +# SVE unary bit operations (predicated)
>>> +# Note esz != 0 for FABS and FNEG.
>>> +CLS            00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
>>> +CLZ            00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
>>> +CNT_zpz                00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
>>> +CNOT           00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
>>> +NOT_zpz                00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
>>> +FABS           00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
>>> +FNEG           00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
>>
>> Indentation seems to be a bit skew for the _zpz lines.
>
> There are tabs in here.  I know they're not allowed for C, but this isn't.

I don't think we should have tabs in these files either for the
same reasons we don't have them in C code.

thanks
-- PMM
