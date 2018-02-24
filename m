Received: from eggs.gnu.org ([2001:4830:134:3::10]:32901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNYS-0000Zn-W1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNYP-00065X-1Q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:19:08 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNYO-00064u-R7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:19:04 -0500
Received: by mail-pf0-x236.google.com with SMTP id s24so4171117pfm.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:19:04 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5042c1c1-2831-493a-ba80-13593b3a3a29@linaro.org>
Date: Fri, 23 Feb 2018 16:19:00 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/31] arm/translate-a64: add FP16 FCMxx
 (zero) to simd_two_reg_misc_fp16
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
> I re-use the existing handle_2misc_fcmp_zero handler and tweak it
> slightly to deal with the half-precision case.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - use size directly wuth read/write_vec_element
>   - drop unneeded break
>   - WIP: mess with calculating maxpasses
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
