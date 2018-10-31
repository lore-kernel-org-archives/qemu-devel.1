Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzIv-0005VM-IX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzIs-0000IP-15
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:49:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzIq-0000Ge-O7
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:49:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so4053722wre.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:49:25 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-36-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <123f566a-6a57-8b89-eb03-d9296460ab5b@linaro.org>
Date: Wed, 31 Oct 2018 22:49:21 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-36-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 35/35] target/riscv: Remaining rvc insn
 reuse 32 bit translators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
> only a translate functions of rvc need to handle special cases. For
> the other rvc instruction we can remove the extra layer of indirection.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/insn16.decode              | 37 +++++++++----------
>  target/riscv/insn_trans/trans_rvc.inc.c | 48 -------------------------
>  2 files changed, 17 insertions(+), 68 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
