Received: from eggs.gnu.org ([209.51.188.92]:56615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gsZXn-0008Lk-6E
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 15:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gsZXl-000362-8c
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 15:48:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gsZXi-00031C-R5
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 15:48:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id t200so9606952wmt.0
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 12:48:05 -0800 (PST)
References: <20190209162745.12668-1-cota@braap.org>
	<20190209162745.12668-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190209162745.12668-2-cota@braap.org>
Date: Sat, 09 Feb 2019 20:48:02 +0000
Message-ID: <877ee88z99.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] exec-all: document that tlb_fill can
 trigger a TLB resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/exec-all.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index aa7b81aaf0..97b90cb0db 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -475,6 +475,11 @@ static inline void assert_no_pages_locked(void)
>  struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>                                               hwaddr index, MemTxAttrs at=
trs);
>
> +/*
> + * Note: tlb_fill() can trigger a resize of the TLB. This means that all=
 of the
> + * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers=
) must
> + * be discarded and looked up again (e.g. via tlb_entry()).
> + */
>  void tlb_fill(CPUState *cpu, target_ulong addr, int size,
>                MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);


--
Alex Benn=C3=A9e
