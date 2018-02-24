Received: from eggs.gnu.org ([2001:4830:134:3::10]:36629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epO2H-0007v9-3u
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epO2C-0003FZ-6Y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:49:57 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epO2C-0003E5-1U
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:49:52 -0500
Received: by mail-pl0-x241.google.com with SMTP id 31so5839060ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:49:51 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-31-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0274e558-e60a-6af8-25ea-ce465ff7b6d8@linaro.org>
Date: Fri, 23 Feb 2018 16:49:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 30/31] arm/translate-a64: implement
 simd_scalar_three_reg_same_fp16
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
> This covers the encoding group:
> 
>   Advanced SIMD scalar three same FP16
> 
> As all the helpers are already there it is simply a case of calling the
> existing helpers in the scalar context.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> v3
>   - check for FP16 feature
>   - remove stray debug
>   - make abs a bitwise operation
>   - checkpatch long line
> ---
>  target/arm/translate-a64.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
