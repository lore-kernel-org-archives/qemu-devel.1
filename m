Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F545C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ECA20862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRJs4H+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ECA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRAIv-0004Go-0o
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 02:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRAI1-0003oW-UY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRAI0-0007G9-IY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:54:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRAI0-0007Cy-75
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:54:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so1979830wrb.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=YNevOxrRU+p71W6UxqKPR58gSsTLezWbA/6NCVhfGGU=;
	b=dRJs4H+oiSoaxMlMTxOkrktsmIHWlHIvEEjs4wooio5jcza/Cn6ElTEXUlpgxK9qJu
	778MfWAG+d2yBrwODNpmjYhm7rLjJDgDk27/XH8QPDplFS1AmBOQqoJfGo/rIGiC+TAA
	qwBlZb5RQ0jqU0a1MmOv1jga0aFlxSvc6fAvd+MVY1lo3jw5PbnoMDrEuzD3fRCfLICN
	yS5v0REhH0yytu5NVsaImsP3MBGOKrZfhSPpwPfG8jkoFbTuIjXVL7DLFuGtDtVdiwa5
	mgJX9XsgXQRc5ED/kLr1CZkLun4e7si1CMf2V2vLtW3doeoXJRur+pgi6F3v0YY1Y6u5
	gLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=YNevOxrRU+p71W6UxqKPR58gSsTLezWbA/6NCVhfGGU=;
	b=QldhwwqnR2Cfiw+fbDvxqVf++EnLdfp5PJULJQvZ03J5oZuBERPz7jhx1kGlDYBQiZ
	TQKXnZdhYhvmnZtIfl5UmbYroMkW+4TkGRfppbxcEqj/McgTH+iZ+bd/1XDk8V92FxjU
	Z1l8DlBw6/zDB6EYuyJ5YU2mbXtW4fliTOXcxlGYl/Pb/K1gM0aDy+VHPHE7LdSHU6sE
	Ibi9OymnDewpP8UfUj7/pdfxwCoiwQyTnyzv7Qraw0fe3cPIWLKCwCKD8gZ+fd4BvSnm
	9yf64xdyzLwGhoQlVitpyGCcs34EzkjkTjbEm7SUwT5x2yGC9mlraC6jqQ5oJ4vwNtjv
	vsTg==
X-Gm-Message-State: APjAAAU3AWFTJLkPib8jYyEnoFruGR9ThhzpUMjKc4swo30e5vdD7FvV
	CrpPn5yrWB/qQmJJ/j1SaT8Atg==
X-Google-Smtp-Source: APXvYqzOvaKEkas1Su4sEuIx9bBqMHgpyQXeGXpLgt+nP4tK8x1VUcdiU1uNkmfkbEaAS2hHwNzrCA==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr27936014wrr.323.1557989689940; 
	Wed, 15 May 2019 23:54:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id x9sm4685633wmf.27.2019.05.15.23.54.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 23:54:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C8C7D1FF87;
	Thu, 16 May 2019 07:54:48 +0100 (BST)
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
Date: Thu, 16 May 2019 07:54:48 +0100
Message-ID: <875zqanb2f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/1] target/arm: Fix vector
 operation segfault
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis <Alistair.Francis@wdc.com> writes:

> Commit 89e68b575 "target/arm: Use vector operations for saturation"
> causes this abort() when booting QEMU ARM with a Cortex-A15:
>
> 0  0x00007ffff4c2382f in raise () at /usr/lib/libc.so.6
> 1  0x00007ffff4c0e672 in abort () at /usr/lib/libc.so.6
> 2  0x00005555559c1839 in disas_neon_data_insn (insn=3D<optimized out>, s=
=3D<optimized out>) at ./target/arm/translate.c:6673
> 3  0x00005555559c1839 in disas_neon_data_insn (s=3D<optimized out>, insn=
=3D<optimized out>) at ./target/arm/translate.c:6386
> 4  0x00005555559cd8a4 in disas_arm_insn (insn=3D4081107068, s=3D0x7fffe59=
a9510) at ./target/arm/translate.c:9289
> 5  0x00005555559cd8a4 in arm_tr_translate_insn (dcbase=3D0x7fffe59a9510, =
cpu=3D<optimized out>) at ./target/arm/translate.c:13612
> 6  0x00005555558d1d39 in translator_loop (ops=3D0x5555561cc580 <arm_trans=
lator_ops>, db=3D0x7fffe59a9510, cpu=3D0x55555686a2f0, tb=3D<optimized out>=
, max_insns=3D<optimized out>) at ./accel/tcg/translator.c:96
> 7  0x00005555559d10d4 in gen_intermediate_code (cpu=3Dcpu@entry=3D0x55555=
686a2f0, tb=3Dtb@entry=3D0x7fffd7840080 <code_gen_buffer+126091347>, max_in=
sns=3Dmax_insns@entry=3D512) at ./target/arm/translate.c:13901
> 8  0x00005555558d06b9 in tb_gen_code (cpu=3Dcpu@entry=3D0x55555686a2f0, p=
c=3D3067096216, cs_base=3D0, flags=3D192, cflags=3D-16252928, cflags@entry=
=3D524288) at ./accel/tcg/translate-all.c:1736
> 9  0x00005555558ce467 in tb_find (cf_mask=3D524288, tb_exit=3D1, last_tb=
=3D0x7fffd783e640 <code_gen_buffer+126084627>, cpu=3D0x1) at ./accel/tcg/cp=
u-exec.c:407
> 10 0x00005555558ce467 in cpu_exec (cpu=3Dcpu@entry=3D0x55555686a2f0) at .=
/accel/tcg/cpu-exec.c:728
> 11 0x000055555588b0cf in tcg_cpu_exec (cpu=3D0x55555686a2f0) at ./cpus.c:=
1431
> 12 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=3D0x55555686a2f0) at=
 ./cpus.c:1735
> 13 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5555=
5686a2f0) at ./cpus.c:1709
> 14 0x0000555555d2629a in qemu_thread_start (args=3D<optimized out>) at ./=
util/qemu-thread-posix.c:502
> 15 0x00007ffff4db8a92 in start_thread () at /usr/lib/libpthread.
>
> This patch ensures that we don't hit the abort() in the second switch
> case in disas_neon_data_insn() as we will return from the first case.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

This fixes the abort()'s I was seeing while running the qemu-iotests
under an emulated Debian Buster armhf system so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  target/arm/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index dd053c80d6..298c262825 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6598,13 +6598,13 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqadd_op : sqadd_op) + size);
> -            break;
> +            return 0;
>
>          case NEON_3R_VQSUB:
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqsub_op : sqsub_op) + size);
> -            break;
> +            return 0;
>
>          case NEON_3R_VMUL: /* VMUL */
>              if (u) {


--
Alex Benn=C3=A9e

