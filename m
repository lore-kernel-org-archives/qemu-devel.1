Received: from eggs.gnu.org ([2001:4830:134:3::10]:35103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epH6P-000094-IB
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epH6M-0003ar-Fe
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:25:45 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:41629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epH6M-0003Zj-7V
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:25:42 -0500
Received: by mail-pf0-x22c.google.com with SMTP id a17so3775324pff.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:25:42 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-15-richard.henderson@linaro.org>
	<CAFEAcA9wa32T_vjH2NVxnsW3jzDw6nwPjMXuAdaBfrAXfCdHEw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d778b0e0-fafb-5e39-76e5-054722210c62@linaro.org>
Date: Fri, 23 Feb 2018 09:25:38 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wa32T_vjH2NVxnsW3jzDw6nwPjMXuAdaBfrAXfCdHEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 05:08 AM, Peter Maydell wrote:
>> +# SVE unary bit operations (predicated)
>> +# Note esz != 0 for FABS and FNEG.
>> +CLS            00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
>> +CLZ            00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
>> +CNT_zpz                00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
>> +CNOT           00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
>> +NOT_zpz                00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
>> +FABS           00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
>> +FNEG           00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
> 
> Indentation seems to be a bit skew for the _zpz lines.

There are tabs in here.  I know they're not allowed for C, but this isn't.


r~
