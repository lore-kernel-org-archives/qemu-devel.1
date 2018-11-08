Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnof-00021U-8m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnoc-0007Nq-J6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:10:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKnoa-0007KM-Js
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:09:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id f1-v6so1992556wmg.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:09:50 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3027e46a-42b2-4c5c-eaec-ce9caa64ecc0@linaro.org>
Date: Thu, 8 Nov 2018 18:09:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/arm64: properly handle DBGVR
 RESS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/8/18 5:33 PM, Alex Bennée wrote:
> -        .bvr = addr
> +        .bvr = sextract64(addr, 52, 53)

I think you meant sextract64(addr, 0, 53).
What you wrote *should* have asserted, since 52+53 > 64.


r~
