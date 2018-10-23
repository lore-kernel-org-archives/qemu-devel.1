Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwMO-0001XY-FP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwMI-0003Py-GP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:36 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:59426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwMG-0003Kt-FX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:30 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-3-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 15:04:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 2/7] decodetree: Remove "insn" argument
 from trans_* expanders
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
> ??? Needs simultaneous corresponding changes to all
> translators using decodetree.
> ---
>   scripts/decodetree.py | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>

Was the only intend of the insn argument to be used for manual decoding 
in a trans_ function?


Cheers,

Bastian
