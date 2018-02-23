Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epN83-0005YQ-UQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epN81-0005L2-08
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:51:52 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epN80-0005KJ-Q9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:51:48 -0500
Received: by mail-pg0-x22d.google.com with SMTP id q27so2343414pgn.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 15:51:48 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93ed5c75-c704-2d47-c1b8-699f419ab2b3@linaro.org>
Date: Fri, 23 Feb 2018 15:51:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/31] target/arm/cpu.h: add additional
 float_status flags
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
> Half-precision flush to zero behaviour is controlled by a separate
> FZ16 bit in the FPCR. To handle this we pass a pointer to
> fp_status_fp16 when working on half-precision operations. The value of
> the presented FPCR is calculated from an amalgam of the two when read.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - add FPCR_[FZ/FZ16/DN] defines to cpu.h and use
>   - only propagate flag status to fp_status as they are ored later
>   - ensure dnan and round mode propagated to fp_status_fp16
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
