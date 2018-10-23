Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsbk-0001rx-Bb
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsbh-0002ad-5h
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsbg-0002ZR-OP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:04:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id i4-v6so751116wrr.13
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 02:04:08 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-29-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35f63774-4921-e84b-cbbf-703fb6f029aa@linaro.org>
Date: Tue, 23 Oct 2018 10:04:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-29-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/29] target/riscv: Remove
 decode_RV32_64G()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> decodetree handles all instructions now so the fallback is not necessary
> anymore.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v1 -> v2:
>     - Add missing gen_exception_illegal

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
