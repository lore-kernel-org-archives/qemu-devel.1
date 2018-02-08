Received: from eggs.gnu.org ([2001:4830:134:3::10]:38398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnIx-0002Lj-C2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnIt-0007K6-Fb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:36:03 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejnIt-0007JT-9f
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:35:59 -0500
Received: by mail-pg0-x22b.google.com with SMTP id s73so1669807pgc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:35:58 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-7-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36012021-2859-8690-002d-aaef6b3b8bae@linaro.org>
Date: Thu, 8 Feb 2018 06:35:55 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-7-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 06/23] Softfloat support for IEEE
 754-201x minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 02/07/2018 05:28 PM, Michael Clark wrote:
> QEMU currently implements IEEE 754-2008 minNum/maxNum. This patch adds
> support for IEEE 754-201x minimumNumber/maximumNumber which is required
> by the RISC-V port.
> 
> minNum(x, y) is defined as
> - min(x, y) if neither is NaN
> - if one of x and y is a number and one is qNaN, return the number
> - if both are qNaN, or either is sNaN, return NaN
> 
> minimumNumber(x, y) is defined as
> - min(x, y) if neither is NaN
> - if one of x and y is a number and one is qNaN or sNaN, return the number
> - if both are NaN, return the number
> 
> Both functions signal the invalid exception on sNaN inputs.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---

Thanks for the description of the function.  We've got a reorg of softfloat
pending at the moment; I'd want to defer this patch until that set has landed.


r~
