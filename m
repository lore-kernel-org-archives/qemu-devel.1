Received: from eggs.gnu.org ([2001:4830:134:3::10]:52340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqMcE-0007i4-NL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqMcB-0006ps-Oh
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:58:50 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dqMcB-0006pZ-IA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:58:47 -0400
Received: by mail-pg0-x22a.google.com with SMTP id t3so5797581pgt.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:58:47 -0700 (PDT)
References: <CGME20170908110212eucas1p27c5eecf44c5501d23b322d3679a4f12d@eucas1p2.samsung.com>
	<001801d32891$ec40b930$c4c22b90$@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <633f5a2d-a333-5c78-1e0c-3af2a4c896f9@linaro.org>
Date: Fri, 8 Sep 2017 09:58:43 -0700
MIME-Version: 1.0
In-Reply-To: <001801d32891$ec40b930$c4c22b90$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] AArch64: Fix single stepping of ERET
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jaroslaw Pelczar <j.pelczar@samsung.com>, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 09/08/2017 04:02 AM, Jaroslaw Pelczar wrote:
> Previously when single stepping through ERET instruction via GDB
> would result in debugger entering the "next" PC after ERET instruction.
> When debugging in kernel mode, this will also cause unintended behavior,
> because debugger will try to access memory from EL0 point of view.
> 
> Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
> ---
>  target/arm/translate-a64.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
