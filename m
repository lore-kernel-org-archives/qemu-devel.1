Received: from eggs.gnu.org ([2001:4830:134:3::10]:50556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epMnO-0000Y3-Go
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epMnL-0006cP-EU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:30:30 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:46161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epMnL-0006VQ-4D
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:30:27 -0500
Received: by mail-pf0-x22e.google.com with SMTP id z24so4126109pfh.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 15:30:27 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee422087-7454-8bff-ecac-cdee71bb570e@linaro.org>
Date: Fri, 23 Feb 2018 15:30:22 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/31] target/arm/cpu.h: update comment
 for half-precision values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
> @@ -168,6 +168,7 @@ typedef struct {
>   *  Qn = regs[n].d[1]:regs[n].d[0]
>   *  Dn = regs[n].d[0]
>   *  Sn = regs[n].d[0] bits 31..0
> + *  Hn = regs[n].d[0] bits 15..0 for even n, and bits 31..16 for odd n

Everything past here --------------^ is wrong.


r~
