Received: from eggs.gnu.org ([209.51.188.92]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkAZW-0002O2-4y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkAZV-00027S-28
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:31:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gkAZU-00025b-RA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:31:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so11725883wra.6
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 08:31:12 -0800 (PST)
References: <20190116170114.26802-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190116170114.26802-1-cota@braap.org>
Date: Thu, 17 Jan 2019 16:31:09 +0000
Message-ID: <8736prz1o2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/3] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> v6: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02998.html
>
> Changes since v6:
>
> - Define TCG_TARGET_IMPLEMENTS_DYN_TLB for tcg/riscv (patch 2).
>
> - Fix --disable-tcg breakage (reported by Alex) by moving
>   tlb_entry_is_empty to cputlb.c, since the function's only caller
>   is in that file (patch 1).
>
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/tlb-dyn-v7
>

Well so far this has proved to be stable whilst I've been stressing it
out so have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'm currently benchmarking on my build workload but it's taking a while
to run.

--
Alex Benn=C3=A9e
