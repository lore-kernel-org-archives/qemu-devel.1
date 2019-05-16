Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02870C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B919C205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvYgO0L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B919C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJUz-0008Pe-1j
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:44:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJTq-0007qH-Ft
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJTp-00088i-FJ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:43:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRJTp-00087O-AE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:43:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id s19so4055703otq.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=7+za8/mffhd/+flkPPB9/EXj+dL01I/fv/Vq9n9G+4A=;
	b=dvYgO0L9sd/CbCApiufLqliLyg1PBnS8hlJ/xecY4FNUZvATBGqhpPINlETT6E7v0s
	fhB6NkeqBLhX02aO+Ai9qO3xWmAgPg2VDNH4Z0ke9U3N1puuu3DIQPOZ2fMEdepY+Piv
	3J/UjFxH9Py3Y3FWNUMESh4rKVOAToRjGmQM6iVaXGKW7US92hnUQkH013Ze02u+TUvj
	vh0tuXnrI/qIfyJa7ebqYJ66UBO/fTi7WO35FbjmlQSJm8YZ50CSvzGQ9CULn9GB2iwJ
	fSxtl9eQJTpgt5r+THcvUIDXKCaEfgWTULTRfy4j6y1socwZZnuLANN/K/wdhNqfD+EM
	m8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=7+za8/mffhd/+flkPPB9/EXj+dL01I/fv/Vq9n9G+4A=;
	b=fNyzfplkUym6EbVQEvvoqpoJNfLSwPcRadKhGY05c8UaM27WPsHjgx7HL6+N/ZAQAe
	nVLbkwYTYdbzcdBK2YHrh4WXYFvurVj6jqdBkNanoXd0pVWiYJY6z8SjOlTHsClGLvAR
	FRx1bB1JaA3QOBjvrO1FE+ai7tJnK/WkH0gi9BLgcXq4KOewNkUDEo+Oucc3eGh5EwWc
	UdG3fBo6FPT5yrRkHjwGnCrDU7SrQG46YLUKTnraNe9R+iQk/4uH5eDiNt+E8AzggRI5
	SghO80mSGq29/PfeEodFBVphSDs8fKIShL94bGewhZjNa3kKmTXeD4sTD4ScKnli/OBj
	GT9g==
X-Gm-Message-State: APjAAAWr1rdYTqqYkjGiaOGNzrk42oGrBQLkyGAnRpNQA8CdOSeDRooO
	+OZaMAoRHxizLhqxNHrgC0YLpqbisD0m8CDUEttYGg==
X-Google-Smtp-Source: APXvYqwLu8cONCw0CKhczX+QZb/Nrhaj9bm4pNmUkcAbABtmCEhkfvL2NarjGsXr46Oewmvj9FM/yKkotWyrFxDqgcI=
X-Received: by 2002:a9d:760b:: with SMTP id k11mr29107479otl.135.1558025019335;
	Thu, 16 May 2019 09:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com>
In-Reply-To: <ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 17:43:28 +0100
Message-ID: <CAFEAcA85+TK5LbsJRa8r1G4--J10AAceWS_o4-SmnoOp5VACFA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 1/1] target/arm: Fix vector operation
 segfault
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Alistair Francis <alistair23@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 at 16:56, Alistair Francis <alistair.francis@wdc.com> w=
rote:
>
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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

