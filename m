Received: from eggs.gnu.org ([2001:4830:134:3::10]:59938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGQlZ-0005Go-RL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGQlW-000772-3H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:12:29 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGQlV-00075b-Sf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:12:26 -0400
Received: by mail-pf0-x243.google.com with SMTP id f189so25772633pfa.7
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:12:25 -0700 (PDT)
References: <1525858768-325-1-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c7eb58c-f51d-30e9-f5ba-02b365797fd3@linaro.org>
Date: Wed, 9 May 2018 08:12:21 -0700
MIME-Version: 1.0
In-Reply-To: <1525858768-325-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] RISC-V: Add misa to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "Emilio G . Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/09/2018 02:39 AM, Michael Clark wrote:
> gen methods should access state from DisasContext. Add misa
> field to the DisasContext struct and remove CPURISCVState
> argument from all gen methods.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/translate.c | 74 ++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
