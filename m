Received: from eggs.gnu.org ([2001:4830:134:3::10]:37052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epO65-0000Yd-1L
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epO60-0007lO-3c
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:53:53 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epO5z-0007l8-TO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:53:48 -0500
Received: by mail-pf0-x242.google.com with SMTP id t15so4186732pfh.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:53:47 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b0df779-a143-0057-722b-284aa03ebc66@linaro.org>
Date: Fri, 23 Feb 2018 16:53:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 31/31] arm/translate-a64: add all single
 op FP16 to handle_fp_1src_half
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
> This includes FMOV, FABS, FNEG, FSQRT and  FRINT[NPMZAXI]. We re-use
> existing helpers to achieve this.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - make fabs a bitwise operation
>   - use read_vec_element_i32 to read value
>   - properly wire into disas_fp_1rc
> ---
>  target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
