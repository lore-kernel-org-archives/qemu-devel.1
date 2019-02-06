Received: from eggs.gnu.org ([209.51.188.92]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKzh-0001HT-NH
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKzf-000556-KU
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:03:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKzb-0004ds-HB
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:03:51 -0500
Received: by mail-wr1-x444.google.com with SMTP id r2so6997528wrv.10
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 03:03:22 -0800 (PST)
References: <20190206105339.32664-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e558cc4-90c4-8c27-b11c-14dc7dcb7e83@linaro.org>
Date: Wed, 6 Feb 2019 11:03:18 +0000
MIME-Version: 1.0
In-Reply-To: <20190206105339.32664-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: Implement float128_to_uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/6/19 10:53 AM, David Hildenbrand wrote:
> Handling it just like float128_to_uint32_round_to_zero, that hopefully
> is free of bugs :)
> 
> Documentation basically copied from float128_to_uint64
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fpu/softfloat.c         | 29 +++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |  1 +
>  2 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
