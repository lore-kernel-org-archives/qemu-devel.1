Received: from eggs.gnu.org ([2001:4830:134:3::10]:38463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6Hvc-0004ji-VL
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6HvZ-0005MD-9q
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:44:57 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f6HvY-0005Lv-SQ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:44:53 -0400
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-2-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c5ea8d98-b594-ae2d-6524-40baae8f1763@mail.uni-paderborn.de>
Date: Wed, 11 Apr 2018 17:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <1523377186-32578-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] target/riscv: avoid integer overflow
 in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>

On 04/10/2018 06:19 PM, Emilio G. Cota wrote:
> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
