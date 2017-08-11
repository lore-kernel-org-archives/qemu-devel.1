Received: from eggs.gnu.org ([2001:4830:134:3::10]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgALX-0000rl-Id
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgALW-0001CL-M1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:51:27 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgALW-0001C1-G0
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:51:26 -0400
Received: by mail-pg0-x22d.google.com with SMTP id l64so15734944pge.5
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:51:26 -0700 (PDT)
References: <1502116754-18867-1-git-send-email-peter.maydell@linaro.org>
	<1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c319371-41d7-d72a-bdfa-33f85e3bfa36@linaro.org>
Date: Fri, 11 Aug 2017 06:51:22 -0700
MIME-Version: 1.0
In-Reply-To: <1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] loader: Ignore zero-sized ELF segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Hua Yanghao <huayanghao@gmail.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 08/07/2017 07:39 AM, Peter Maydell wrote:
> Some ELF files have program headers that specify segments that
> are of zero size. Ignore them, rather than trying to create
> zero-length ROM blobs for them, because the zero-length blob
> can falsely trigger the overlapping-ROM-blobs check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/elf_ops.h | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
