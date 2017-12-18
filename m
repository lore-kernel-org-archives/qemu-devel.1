Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR46e-0008Cv-LD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR46Z-0005QA-KN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:41:56 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR46Z-0005Os-E2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:41:51 -0500
Received: by mail-pg0-x244.google.com with SMTP id b11so9733312pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:41:51 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c5ec87ba-79be-c822-19c2-0e40e41aa87d@linaro.org>
Date: Mon, 18 Dec 2017 14:41:45 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 14/19] fpu/softfloat: re-factor
 round_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:57 AM, Alex Bennée wrote:
> We can now add float16_round_to_int and use the common round_decomposed and
> canonicalize functions to have a single implementation for
> float16/32/64 round_to_int functions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c         | 304 ++++++++++++++++++++----------------------------
>  include/fpu/softfloat.h |   1 +
>  2 files changed, 130 insertions(+), 175 deletions(-)

I was involved in writing this, so

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
