Received: from eggs.gnu.org ([2001:4830:134:3::10]:36953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga580-0001ka-AD
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga57y-0007sO-Ew
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:41:08 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ga57y-0007rI-7x
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:41:06 -0500
Received: by mail-oi1-x241.google.com with SMTP id x202so2993719oif.13
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 12:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20181220201502.12285-1-richard.henderson@linaro.org>
In-Reply-To: <20181220201502.12285-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Dec 2018 20:40:53 +0000
Message-ID: <CAFEAcA8G8Yi=j1G70vspSFm57AsLbNsm07yxPmwaJgWPJFtu4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add safe_syscall for riscv64
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Laurent Vivier <laurent@vivier.eu>

On Thu, 20 Dec 2018 at 20:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> At some point we should make this routine be non-optional for
> porting to a new host.

Yes, I agree -- how many hosts do we still have which are
missing support for it?

thanks
-- PMM
