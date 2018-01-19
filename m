Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecPMT-0002ok-22
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecPMP-0002cB-WE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:37:09 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecPMP-0002by-Pc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:37:05 -0500
Received: by mail-pf0-x244.google.com with SMTP id k19so598674pfj.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 21:37:05 -0800 (PST)
References: <20180118193846.24953-1-laurent@vivier.eu>
	<20180118193846.24953-6-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b3c41ca-ab80-c25b-84b6-de016fbe5322@linaro.org>
Date: Thu, 18 Jan 2018 21:37:01 -0800
MIME-Version: 1.0
In-Reply-To: <20180118193846.24953-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/7] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <huth@tuxfamily.org>

On 01/18/2018 11:38 AM, Laurent Vivier wrote:
> and introduce SFC and DFC control registers.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v4: remove QEMU_SFC and QEMU_DFC
>     use directly tb->flags
> v2: copy bit 2 of SFC and DFC to tb->flags to
>     inline memory access in moves decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
