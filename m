Received: from eggs.gnu.org ([2001:4830:134:3::10]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36tK-0006Be-QF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36tF-0003O4-H1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:49:10 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:51130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36tF-0003Nd-B7
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:49:05 -0400
Received: by mail-pg0-x22b.google.com with SMTP id y7so2081374pgb.7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:49:05 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <504601ee-33d3-654a-75b7-6c097c9ae6fe@linaro.org>
Date: Fri, 13 Oct 2017 13:49:01 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 05/30] softfloat: implement
 propagateFloat16NaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> This will be required when expanding the MINMAX() macro for 16
> bit/half-precision operations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
