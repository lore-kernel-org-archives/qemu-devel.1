Received: from eggs.gnu.org ([2001:4830:134:3::10]:50379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejunT-0007QY-Ao
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejunQ-0003im-HG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:36:03 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejunQ-0003iH-BC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:36:00 -0500
Received: by mail-pg0-x241.google.com with SMTP id o1so2320002pgn.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:36:00 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <793713b1-37af-80e8-8985-939d809489f9@linaro.org>
Date: Thu, 8 Feb 2018 14:35:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 19/32] arm/translate-a64: add FCVTxx to
 simd_two_reg_misc_fp16
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
> This covers all the floating point convert operations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper-a64.c    | 32 +++++++++++++++++
>  target/arm/helper-a64.h    |  2 ++
>  target/arm/translate-a64.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 118 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
