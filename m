Received: from eggs.gnu.org ([209.51.188.92]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyDGU-0002ZP-1k
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyDGT-00040h-Ay
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:13:38 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:35724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gyDGR-0003wW-EW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:13:36 -0500
References: <20190223232954.7185-1-richard.henderson@linaro.org>
	<20190223232954.7185-5-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <0d10b5b1-b97e-c7e0-5cbe-a8a34293567e@mail.uni-paderborn.de>
Date: Mon, 25 Feb 2019 11:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190223232954.7185-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 4/5] decodetree: Do not unconditionaly
 return from Pattern.output_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 2/24/19 12:29 AM, Richard Henderson wrote:
> As a consequence, the 'return false' gets pushed up one level.
>
> This will allow us to perform some other action when the
> translator returns failure.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)


Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,

Bastian
