Received: from eggs.gnu.org ([209.51.188.92]:54477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyZFV-0007vF-IE
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyZFU-0005eo-HH
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:42:05 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:35510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gyZFT-0005bB-1S
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:42:04 -0500
References: <20190223232954.7185-1-richard.henderson@linaro.org>
	<20190223232954.7185-6-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <7a28d61f-2b29-bca3-5038-82bbe737ffc6@mail.uni-paderborn.de>
Date: Tue, 26 Feb 2019 10:41:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190223232954.7185-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 5/5] decodetree: Allow grouping of
 overlapping patterns
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/decodetree.rst   |  58 +++++++++++++++++
>   scripts/decodetree.py | 144 ++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 191 insertions(+), 11 deletions(-)
>
> diff --git a/docs/decodetree.rst b/docs/decodetree.rst


It would be great to have tests in tests/decode/ that exercise 
PatternGroups.

Cheers,

Bastian
