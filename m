Received: from eggs.gnu.org ([2001:4830:134:3::10]:42713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwEi-0005g9-0k
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwEd-0003Zf-0d
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:56:39 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:57282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwEV-0003KQ-6s
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:56:29 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-2-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <d435889c-e4dc-06ae-3e41-56246050d63b@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 14:56:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 1/7] decodetree: Add !extern flag to
 argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com


On 10/23/18 2:04 PM, Richard Henderson wrote:
> Allow argument sets to be shared between two decoders by avoiding
> a re-declaration error.  Make sure that anonymous argument sets
> have unique names.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,

Bastian
