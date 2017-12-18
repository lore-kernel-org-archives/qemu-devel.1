Received: from eggs.gnu.org ([2001:4830:134:3::10]:49728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3yf-0002pX-Ts
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3yf-0006DX-5x
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:33:41 -0500
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:43537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3yf-0006Cx-2e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:33:41 -0500
Received: by mail-vk0-x243.google.com with SMTP id k132so1393386vke.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:33:40 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43e090c9-dd61-f0b2-ca1b-38c9f8617ef2@linaro.org>
Date: Mon, 18 Dec 2017 14:26:14 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 12/19] fpu/softfloat: re-factor div
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

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> We can now add float16_div and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 versions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat-macros.h  |  44 +++++++++
>  fpu/softfloat.c         | 235 ++++++++++++++++++------------------------------
>  include/fpu/softfloat.h |   1 +
>  3 files changed, 134 insertions(+), 146 deletions(-)

I was involved in writing this, so

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
