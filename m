Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4SfG-00044Z-Py
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4SfC-0004lh-Ik
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:48:30 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4SfC-0004lK-4L
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:48:26 -0400
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-6-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <71e683a8-2f47-5f84-163b-b47689dfb96f@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 16:48:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180217203132.31780-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/19] target/hppa: Unify specializations
 of OR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 02/17/2018 09:31 PM, Richard Henderson wrote:
> With decodetree.py, the specializations would conflict so we
> must have a single entry point for all variants of OR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 108 +++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 48 deletions(-)
> 

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
