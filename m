Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE64C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C6220833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raPILevP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C6220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcoVG-0006L7-Hg
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 06:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcoSX-0004pL-Bg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcoSS-0006ct-1n
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:01:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcoSQ-0006ax-9d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:01:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id u8so8408752wmm.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NFutvvR5LuLvTE87745Aytjigi3UuLydf7sSIZ4qTbc=;
 b=raPILevPD5Q58k4Ph0exLK6GEvjd3r4YDhyoLir5B1DKzphUjnANxnOSC5/4HmMIMB
 FwKfRBvPTMUm+iG7awDoTSKqR4w6SfhET6Q1ygUdXiOU/D8jg69gyOaCkvXMDmiy4x5Y
 73FMmDeQ5vDX0UitRCunpAXWE3kvFviMKHjQq1XhtoaksfBFREyEysZW5cWgunPVTIdM
 PuEFSl6kLBK9AIzO2pLlplmKBta54q3XatnoYurkcN1YuwqRsI8vevOvWoJ+rr2c4/Oh
 cw5KXlT6qHuTrbBjpuuJLGGixXzMfcIZfdY89pL4rgojtXFbgCk2Ugxzck/a6wZINueD
 BSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NFutvvR5LuLvTE87745Aytjigi3UuLydf7sSIZ4qTbc=;
 b=cVjQlQd2pwD0yO6osrMyrzec5OHkL0J7ZvV8dmI9wgWniRDR2Wgo6qBeGSIUxgBpOV
 1iI8567Nxul3xJbBDT3xnojitkRoy+W5Q2RfuM9cI34aIYhhgHiawd5i9/HH4pXHGJir
 p640Jni21Jv1RFp8yEkh8C/4ntkkAuLtwzKv/AZXmAjciZrUoK1xxPK1pfvjae8kLNzK
 jQNkxqtTo6Ipg13PthB8HBpfA6O5GadXktnSfH+Hal/vRSPoeHcHDULgUy4xg47qGxF5
 xu1F8gWkVX9eJbTcEUvAcx+WcXlqIPFJDudUnGlht7be8zIXwhQrfB9Vv9IG4Tu2ZMr6
 JMZg==
X-Gm-Message-State: APjAAAWLzaEQXjOHD0tVnNe7ahQWheQQmC40xNiQWelR0k/34s9XmxjG
 Ck9HY3GsY13IH1OMRxZcM2WxzA==
X-Google-Smtp-Source: APXvYqxjnZxxNvUJYW9GqDkS7M9O107DPSUbOrpx864PucEQyS5mf1v4IJ590PjTJBoCneyPlDzbMg==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr17897906wmc.106.1560765704795; 
 Mon, 17 Jun 2019 03:01:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e21sm11325637wra.27.2019.06.17.03.01.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 03:01:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 856071FF87;
 Mon, 17 Jun 2019 11:01:43 +0100 (BST)
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
 <20190614135332.12777-2-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190614135332.12777-2-vandersonmr2@gmail.com>
Date: Mon, 17 Jun 2019 11:01:43 +0100
Message-ID: <87imt4bke0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-Devel][PATCH 1/3] Adding an optional tb
 execution counter.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


[repeat of reply to wrong email...]

vandersonmr <vandersonmr2@gmail.com> writes:

> An uint64_t counter was added in the TranslationBlock struct and
> it is incremented every time that the TB is executed.
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tcg-runtime.c   | 6 ++++++
>  accel/tcg/tcg-runtime.h   | 2 ++
>  include/exec/exec-all.h   | 1 +
>  include/exec/gen-icount.h | 7 +++++++
>  linux-user/main.c         | 1 +
>  vl.c                      | 1 +
>  6 files changed, 18 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..d1f4127d31 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,9 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>  }
> +
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TranslationBlock* tb =3D (TranslationBlock*) ptr;
> +    atomic_inc(&tb->exec_freq);
> +}
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 4fa61b49b4..bf0b75dbe8 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, pt=
r, env)
>
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
> +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
> +
>  #ifdef CONFIG_SOFTMMU
>
>  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 16034ee651..a80407622e 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -342,6 +342,7 @@ struct TranslationBlock {
>      uint32_t flags; /* flags defining in which context the code was gene=
rated */
>      uint16_t size;      /* size of target code for this block (1 <=3D
>                             size <=3D TARGET_PAGE_SIZE) */
> +    uint64_t exec_freq;

Maybe exec_count would be more correct. Frequency occurs over a given
time. Also a single line comment would be useful.

>      uint16_t icount;
>      uint32_t cflags;    /* compile flags */
>  #define CF_COUNT_MASK  0x00007fff
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index f7669b6841..a540d12005 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -6,11 +6,18 @@
>  /* Helpers for instruction counting code generation.  */
>
>  static TCGOp *icount_start_insn;
> +extern bool enable_freq_count;
>
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;
>
> +    if (enable_freq_count) {
> +        TCGv_ptr tb_ptr =3D tcg_temp_new_ptr();
> +        tcg_gen_trunc_i64_ptr(tb_ptr, tcg_const_i64((int64_t) tb));

TIL: tcg_const_ptr which elides the details of casting to a TCGv_ptr on
32 and 64 bit hosts. So:

    TCGv_ptr tb_ptr =3D tcg_const_ptr(tb);
    gen_helper_inc_exec_freq(tb_ptr);
    tcg_temp_free_ptr(tb_ptr);

(don't forget to free temporaries once used, otherwise the translator
will keep tracking them. This should show up in a --enable-debug-tcg build).


> +        gen_helper_inc_exec_freq(tb_ptr);
> +    }
> +

I think we should move the counter bellow the icount check otherwise we
might be counting TB's that never execute because an IRQ was pending.

>      tcg_ctx->exitreq_label =3D gen_new_label();
>      if (tb_cflags(tb) & CF_USE_ICOUNT) {
>          count =3D tcg_temp_local_new_i32();
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a59ae9439d..1bf7155670 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -58,6 +58,7 @@ static const char *seed_optarg;
>  unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
> +bool enable_freq_count =3D false;
>
>  /*
>   * When running 32-on-64 we should make sure we can fit all of the possi=
ble
> diff --git a/vl.c b/vl.c
> index 005468cbfb..cb6c0ad63d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -190,6 +190,7 @@ bool boot_strict;
>  uint8_t *boot_splash_filedata;
>  int only_migratable; /* turn it off unless user states otherwise */
>  bool wakeup_suspend_enabled;
> +bool enable_freq_count =3D false;

We only need the space allocated once in common code. Maybe
accel/tcg/translator.c?

Also you don't need to initialise to false (=3D=3D 0 =3D=3D initial bss set=
ting).

>
>  int icount_align_option;

--
Alex Benn=C3=A9e

