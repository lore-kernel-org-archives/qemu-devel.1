Received: from eggs.gnu.org ([2001:4830:134:3::10]:52609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXCLT-0000gQ-OV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXCLQ-0004FO-6k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:47:07 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXCLQ-0004Ed-03
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:47:04 -0500
Received: by mail-ot1-x341.google.com with SMTP id 81so19196325otj.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 13:47:03 -0800 (PST)
References: <7dfbddf7014a595150aa79011ddb342c3cc17ec3.1544648105.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07d5da22-02c9-bfd4-cfca-918ad4b5a665@linaro.org>
Date: Wed, 12 Dec 2018 15:46:57 -0600
MIME-Version: 1.0
In-Reply-To: <7dfbddf7014a595150aa79011ddb342c3cc17ec3.1544648105.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] tcg: mips: Improve the add2/sub2
 command to use TCG_TARGET_REG_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "smarkovic@wavecomp.com" <smarkovic@wavecomp.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/12/18 2:58 PM, Alistair Francis wrote:
> Instead of hard coding 31 for the shift right use
> TCG_TARGET_REG_BITS - 1.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tcg/mips/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
