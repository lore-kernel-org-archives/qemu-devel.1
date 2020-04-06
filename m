Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 23:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CC520692
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 23:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP/WcX4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CC520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLbcz-0003NE-KZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 19:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLbcM-0002yC-1j
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLbcK-0008Q9-D3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:57:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLbcK-0008NQ-65
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586217443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LjfUdbrFpEE+obQ8SpgCr43DDDP1A8nbW8YNux8fdg=;
 b=QP/WcX4gSVP18ahM0FJOakCfENHVM6QTa8dvbRRir9vBX2c5pF6r2ugJIJvGfHLFTLP5xw
 WhLAQo97vWaWxqilFNKHLs16D6gzdKMgkKpBgictYPIRGRBcyFXA2eQCiiF/2vpuj7UYBe
 HPxY5a3BbF/rMZ6uqwI/wgdPwEi+ocw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-FMFRdD4vNyiXpBHKstoAWA-1; Mon, 06 Apr 2020 19:57:18 -0400
X-MC-Unique: FMFRdD4vNyiXpBHKstoAWA-1
Received: by mail-wr1-f72.google.com with SMTP id u16so762930wrp.14
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 16:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DYjTac9Du7OeFhJ1xLWTL2B09lcPLDIxVze+RnGyhkw=;
 b=axttfcoDUkMiMStRv5uVauh+ketXNVEg9L+bWHO5vy6cogVsncLbpOo0gDZC5oYhIu
 nQtjWeFauoeHoRTNWDfRtZ1nFQvxXGSivkRQD6xGO9d3kaAZ058xgmZz6lZKGaigamrf
 E4ef63XLpNBvk9xg50HEA2CZ0RzbWMLMF8JM5FJCLlG1utNHY3yxoU0nCmWfmVryT09z
 LorbBIft3ZEEDWOLIJZErJn/V9F2+vpXuRhWkJVdpZqseUmiFe8Vzt6VGisnt80LFDqb
 iZQBqZDvvfgXg9ls+ugt2KZh1Ou9EaO7DFqvSf16TM3ywzBv88hUGN6gAK6+WDEgLrsX
 LacQ==
X-Gm-Message-State: AGi0PubTPGKn29nqKPnOjNmOxMj833sgRRpOOY4JTi5pH7WtOT3mamIP
 i7ZbVAPJfmO7AIAYF21AuUyphn2bb31cfMfE/x6B9PemlpMTjPM5zTEWlbQn0RoIOh8/Nkc3COH
 0fwUH8u0VPrOSF+g=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr1423673wmk.125.1586217437339; 
 Mon, 06 Apr 2020 16:57:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLENQvKMFt8N6+VXdFoVo/PbU0ionJ2yub7g8sWYN2yZkHCnSu6o5DuLyvMj8G39is9oZjwYg==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr1423654wmk.125.1586217437070; 
 Mon, 06 Apr 2020 16:57:17 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o129sm1411978wma.20.2020.04.06.16.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 16:57:16 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in
 delay slot as UNPREDICTABLE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200406235418.18315-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c1d965a0-d40c-0505-b317-8ddc251235ae@redhat.com>
Date: Tue, 7 Apr 2020 01:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406235418.18315-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>, Brian Campbell <bacam@z273.org.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 1:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
> & ASE_MIPS16) we get:
>=20
>    $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
>    $ qemu-system-mipsel -bios cop1x.bin
>    unknown branch 0x13000
>    Aborted (core dumped)
>=20
>    (gdb) bt
>    #0  0x00007fe2d38b1e35 in raise () at /lib64/libc.so.6
>    #1  0x00007fe2d389c895 in abort () at /lib64/libc.so.6
>    #2  0x000055aa9fe066e5 in gen_branch (ctx=3D0x7fe27bdfa590, insn_bytes=
=3D4) at target/mips/translate.c:13167
>    #3  0x000055aa9fe2baf4 in mips_tr_translate_insn (dcbase=3D0x7fe27bdfa=
590, cs=3D0x55aaa0e2d530) at target/mips/translate.c:30928
>    #4  0x000055aa9fd40138 in translator_loop (ops=3D0x55aaa05e94e0 <mips_=
tr_ops>, db=3D0x7fe27bdfa590, cpu=3D0x55aaa0e2d530, tb=3D0x7fe284000040 <co=
de_gen_buffer+19>, max_insns=3D512) at accel/tcg/translator.c:102
>    #5  0x000055aa9fe2bd21 in gen_intermediate_code (cs=3D0x55aaa0e2d530, =
tb=3D0x7fe284000040 <code_gen_buffer+19>, max_insns=3D512) at target/mips/t=
ranslate.c:30999
>    #6  0x000055aa9fd3e3d4 in tb_gen_code (cpu=3D0x55aaa0e2d530, pc=3D3217=
031168, cs_base=3D0, flags=3D268435600, cflags=3D-16252928) at accel/tcg/tr=
anslate-all.c:1718
>    #7  0x000055aa9fd3ac06 in tb_find (cpu=3D0x55aaa0e2d530, last_tb=3D0x0=
, tb_exit=3D0, cf_mask=3D524288) at accel/tcg/cpu-exec.c:407
>    #8  0x000055aa9fd3b4d5 in cpu_exec (cpu=3D0x55aaa0e2d530) at accel/tcg=
/cpu-exec.c:731
>    #9  0x000055aa9fcfe33a in tcg_cpu_exec (cpu=3D0x55aaa0e2d530) at cpus.=
c:1405
>    #10 0x000055aa9fcfeb90 in qemu_tcg_cpu_thread_fn (arg=3D0x55aaa0e2d530=
) at cpus.c:1713
>    #11 0x000055aaa02ea7d7 in qemu_thread_start (args=3D0x55aaa0e465f0) at=
 util/qemu-thread-posix.c:519
>    #12 0x00007fe2d3a484c0 in start_thread () at /lib64/libpthread.so.0
>    #13 0x00007fe2d3976163 in clone () at /lib64/libc.so.6
>=20
> This is because this COP1X instruction generates a Reserved
> Instruction when used with this core, however we are in a delay
> slot, and exceptions in delay slot are architecturally unpredictable.
>=20
> Core dumps confunse users. Instead, report a friendlier error message:
>=20
>    $ qemu-system-mipsel -bios cop1x.bin
>    qemu-system-mipsel: Exception in delay slot is UNPREDICTABLE
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1663287
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   target/mips/translate.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 25b595a17d..99e675b87a 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -30925,6 +30925,10 @@ static void mips_tr_translate_insn(DisasContextB=
ase *dcbase, CPUState *cs)
>           }
>       }
>       if (is_slot) {
> +        if (ctx->base.is_jmp =3D=3D DISAS_NORETURN) {
> +            error_report("Exception in delay slot is UNPREDICTABLE");

"Exception/branch" actually.

> +            exit(1);
> +        }
>           gen_branch(ctx, insn_bytes);
>       }
>       ctx->base.pc_next +=3D insn_bytes;
>=20


