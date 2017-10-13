Received: from eggs.gnu.org ([2001:4830:134:3::10]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36p2-0004I3-Gw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36ow-00013s-4B
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:44 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:56325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36ov-00012n-OQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:37 -0400
Received: by mail-pg0-x22e.google.com with SMTP id m18so2073637pgd.13
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:44:37 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9bfb1d9-95b3-aca1-77e0-551e88815925@linaro.org>
Date: Fri, 13 Oct 2017 13:44:34 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/30] include/exec/helper-head.h:
 support f16 in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> This allows us to explicitly pass float16 to helpers rather than
> assuming uint32_t and dealing with the result. Of course they will be
> passed in i32 sized registers by default.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/exec/helper-head.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
