Received: from eggs.gnu.org ([2001:4830:134:3::10]:57228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt8p-0005lA-9z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt8k-0005vo-MU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:49:59 -0500
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejt8k-0005vJ-HJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:49:54 -0500
Received: by mail-pl0-x22b.google.com with SMTP id o13so438411pli.6
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:49:54 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8984ebfe-9e5f-b340-3c9f-b7e0b16cde6e@linaro.org>
Date: Thu, 8 Feb 2018 12:49:49 -0800
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
> +DEF_HELPER_3(advsimd_maxh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)

DEF_HELPER_FLAGS_3 with TCG_CALL_NO_RWG.


r~
