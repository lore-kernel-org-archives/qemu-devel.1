Received: from eggs.gnu.org ([2001:4830:134:3::10]:56258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt5W-0002xw-Kx
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt5R-0003b4-VP
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:46:34 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejt5R-0003aj-R5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:46:29 -0500
Received: by mail-it0-x244.google.com with SMTP id c80so8012672itb.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:46:29 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f79871c-2aaf-1127-c3a5-019383c06e7a@linaro.org>
Date: Thu, 8 Feb 2018 12:46:25 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/32] arm/translate-a64: implement
 half-precision F(MIN|MAX)(V|NMV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> This implements the half-precision variants of the across vector
> reduction operations. This involves a re-factor of the reduction code
> which more closely matches the ARM ARM order (and handles 8 element
> reductions).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> --
> v1
>   - dropped the advsimd_2a stuff
> v2
>   - fixed up checkpatch
> ---
>  target/arm/helper-a64.c    |  18 ++++++
>  target/arm/helper-a64.h    |   4 ++
>  target/arm/translate-a64.c | 144 ++++++++++++++++++++++++++++-----------------
>  3 files changed, 111 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
