Received: from eggs.gnu.org ([2001:4830:134:3::10]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3lzl-0002sw-1n
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3lzi-0006H0-Ck
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:10:17 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3lzi-0006FW-5e
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:10:14 -0400
Received: by mail-wm0-x236.google.com with SMTP id m123so23344429wma.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:10:14 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-5-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-5-rth@twiddle.net>
Date: Thu, 27 Apr 2017 17:10:43 +0100
Message-ID: <8737ct96gs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 04/19] exec-all: export tb_htable_lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-2-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  cpu-exec.c              | 6 ++----
>  include/exec/exec-all.h | 2 ++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 63a56d0..5b181c1 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -309,10 +309,8 @@ static bool tb_cmp(const void *p, const void *d)
>      return false;
>  }
>
> -static TranslationBlock *tb_htable_lookup(CPUState *cpu,
> -                                          target_ulong pc,
> -                                          target_ulong cs_base,
> -                                          uint32_t flags)
> +TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
> +                                   target_ulong cs_base, uint32_t flags)
>  {
>      tb_page_addr_t phys_pc;
>      struct tb_desc desc;
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index bcde1e6..87ae10b 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -368,6 +368,8 @@ struct TranslationBlock {
>  void tb_free(TranslationBlock *tb);
>  void tb_flush(CPUState *cpu);
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
> +TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
> +                                   target_ulong cs_base, uint32_t flags);
>
>  #if defined(USE_DIRECT_JUMP)


--
Alex Bennée
