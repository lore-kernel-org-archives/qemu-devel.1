Received: from eggs.gnu.org ([2001:4830:134:3::10]:55347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYvt-0000AN-Tl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYvq-0008Hs-SW
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:33:25 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYvq-0008HX-Me
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:33:22 -0400
Received: by mail-pl0-x244.google.com with SMTP id b14-v6so4141908pls.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:33:22 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f25a71ad-4ee4-0064-4e27-67e4e7dce7d2@linaro.org>
Date: Thu, 14 Jun 2018 10:33:17 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 19/22] risu_reginfo_aarch64: add
 support for copying SVE register state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> Add the ability to save SVE registers from the signal context. This is
> controlled with an optional flag --test-sve. The whole thing is
> conditionally compiled when SVE support is in the sigcontext headers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - support EXTRA_MAGIC contexts
> v3
>   - handle conditional bits
>   - include <signal.h> in reginfo.h
>   - move from helper function to main init function
>   - (void *) cast for memcpy
>   - additional ifdef SVE_MAGIC stuff
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
