Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990EFC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634B720780
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKowtfSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634B720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP3dt-0003M3-H7
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jP3d7-0002Hm-Km
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jP3d5-0007N3-P7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:28:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jP3d5-0007MH-58
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:28:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so4616462wrx.4
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cMPkCMlqwl3yXb/VVFCTfLN11oVh/xjvMsOT4/7WQk0=;
 b=BKowtfSqqF3I9mEY8o3N/wAIkueWSOaWjKnRxf16CuNNUXqMgBe1PZDOBLVH1KZZbW
 B1d4NXhXE30zt6slNR5HPMIYfppoq/G7AJXk1mwggtYImulksoeHGjTs0p/uLlgXRhRe
 NVNrCcmHxP8IXcjXZNrWc/phuqzLkAl5ygcS9FNChg1zN5dWMLxmSQoFWFSMMwFm3ZyT
 INC7+nw7hBLenwrtKujK/rhn7Pm+bcbaCNdq1YJogjn54qxd5L3VuyN//IThLb/R2yhl
 4Bi+YqdADN0xSsj9IZxWX6dwC87sn0/cCvHKATDs6vSLUFBk7Fjxw1861JVJuYNp7mNu
 NffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cMPkCMlqwl3yXb/VVFCTfLN11oVh/xjvMsOT4/7WQk0=;
 b=KWsOyigsEEH4VnnieBeMp5llPN1ilpjK64OmAmUEC5NThIoXy/8E7hs8P/iECTXKwH
 07ze/nS6NLP9hpkR33Kw3Km2AgridN1mMosZc/J1aotXuFcr9pwNvzqexyiBbOyW2TpN
 XLt3NoA8eDDU//zKLTSpVlYCFcYiatDoGKd6Zwt1Xj1SNg4iq4GRK3IUWqFQ8mt0mgwC
 Dkq79O3dzx3mso8zwuIYhYAVGnC7RcnVoo/wXWXotmKSisbvcunvhp4nES7Jhp+JOWzc
 WeF/wICyj/LhX6c8N3Fcx8UTwCayoK5F6qG7h4Mfvobh7gO8IbJWDCs+MrwIdxCQtJ6t
 e2YQ==
X-Gm-Message-State: AGi0PuaS0ZA2ZBTZnbtY80X/j8Cktpo/GAUMttOeUaWDeBPO2wKrKoOz
 qEr8dCzNd7u1uhCb1SZV0HYuFw==
X-Google-Smtp-Source: APiQypIjYJwFDPI8PVovlQFxKski+eCbaQ21MFDv3mC7HaE3sHGpYUobkvtZTA0lOUcvr6aYNQBbmw==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr32713237wrs.4.1587040105587; 
 Thu, 16 Apr 2020 05:28:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm6848626wrq.74.2020.04.16.05.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 05:28:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 510DC1FF7E;
 Thu, 16 Apr 2020 13:28:23 +0100 (BST)
References: <20200414111131.465560-1-npiggin@gmail.com>
 <74e47708-fcc0-d3db-5f6b-2a513722fef9@kaod.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [EXTERNAL] [PATCH] target/ppc: Fix mtmsr(d) L=1 variant that
 loses interrupts
In-reply-to: <74e47708-fcc0-d3db-5f6b-2a513722fef9@kaod.org>
Date: Thu, 16 Apr 2020 13:28:23 +0100
Message-ID: <87o8rrfwd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 4/14/20 1:11 PM, Nicholas Piggin wrote:
>> If mtmsr L=3D1 sets MSR[EE] while there is a maskable exception pending,
>> it does not cause an interrupt. This causes the test case to hang:
>>=20
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.org_arc=
hive_html_qemu-2Dppc_2019-2D10_msg00826.html&d=3DDwIDAg&c=3Djf_iaSHvJObTbx-=
siA1ZOg&r=3DXHJsZhhuWSw9713Fp0ciew&m=3DTQfi_v-8XYgz7MiMDAZ_CjkyalSh9-EXhQ3o=
DesUm74&s=3DpFoesXbioVBh5wCuzEnzwgfze6X7e-a9unkfUgsRwiw&e=3D=20
>>=20
<snip>
> I was expecting more changes but this looks fine.=20
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Anton Blanchard <anton@ozlabs.org>
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> I gave it a try on PowerNV, pseries and mac99. All good.
>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> I don't know how we could include tests in QEMU such as the one Anton=20
> sent. These are good exercisers for our exception model.

It certainly looks possible. The ideal would be a fresh boot.S for ppc64
that supported:

 a) some sort of serial output
 b) a way to exit the test case with a result

For ARM we use semihosting, for x86 we use plain ioport and an ACPI
exit. See the tests in: tests/tcg/[x86_64/aarch64]/system/boot.S and the
Makefile.softmmu-target files under tests/tcg.

>
> Thanks,
>
> C.=20
>
>> ---
>> Thanks very much to Nathan for reporting and testing it, I added his
>> Tested-by tag despite a more polished patch, as the the basics are=20
>> still the same (and still fixes his test case here).
>>=20
>> This bug possibly goes back to early v2.04 / mtmsrd L=3D1 support around
>> 2007, and the code has been changed several times since then so may
>> require some backporting.
>>=20
>> 32-bit / mtmsr untested at the moment, I don't have an environment
>> handy.
>>
>>=20
>>  target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
>>  1 file changed, 27 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index b207fb5386..9959259dba 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -4361,30 +4361,34 @@ static void gen_mtmsrd(DisasContext *ctx)
>>      CHK_SV;
>>=20=20
>>  #if !defined(CONFIG_USER_ONLY)
>> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> +        gen_io_start();
>> +    }
>>      if (ctx->opcode & 0x00010000) {
>> -        /* Special form that does not need any synchronisation */
>> +        /* L=3D1 form only updates EE and RI */
>>          TCGv t0 =3D tcg_temp_new();
>> +        TCGv t1 =3D tcg_temp_new();
>>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>>                          (1 << MSR_RI) | (1 << MSR_EE));
>> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
>> +        tcg_gen_andi_tl(t1, cpu_msr,
>>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
>> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
>> +        tcg_gen_or_tl(t1, t1, t0);
>> +
>> +        gen_helper_store_msr(cpu_env, t1);
>>          tcg_temp_free(t0);
>> +        tcg_temp_free(t1);
>> +
>>      } else {
>>          /*
>>           * XXX: we need to update nip before the store if we enter
>>           *      power saving mode, we will exit the loop directly from
>>           *      ppc_store_msr
>>           */
>> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> -            gen_io_start();
>> -        }
>>          gen_update_nip(ctx, ctx->base.pc_next);
>>          gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
>> -        /* Must stop the translation as machine state (may have) change=
d */
>> -        /* Note that mtmsr is not always defined as context-synchronizi=
ng */
>> -        gen_stop_exception(ctx);
>>      }
>> +    /* Must stop the translation as machine state (may have) changed */
>> +    gen_stop_exception(ctx);
>>  #endif /* !defined(CONFIG_USER_ONLY) */
>>  }
>>  #endif /* defined(TARGET_PPC64) */
>> @@ -4394,15 +4398,23 @@ static void gen_mtmsr(DisasContext *ctx)
>>      CHK_SV;
>>=20=20
>>  #if !defined(CONFIG_USER_ONLY)
>> -   if (ctx->opcode & 0x00010000) {
>> -        /* Special form that does not need any synchronisation */
>> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> +        gen_io_start();
>> +    }
>> +    if (ctx->opcode & 0x00010000) {
>> +        /* L=3D1 form only updates EE and RI */
>>          TCGv t0 =3D tcg_temp_new();
>> +        TCGv t1 =3D tcg_temp_new();
>>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>>                          (1 << MSR_RI) | (1 << MSR_EE));
>> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
>> +        tcg_gen_andi_tl(t1, cpu_msr,
>>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
>> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
>> +        tcg_gen_or_tl(t1, t1, t0);
>> +
>> +        gen_helper_store_msr(cpu_env, t1);
>>          tcg_temp_free(t0);
>> +        tcg_temp_free(t1);
>> +
>>      } else {
>>          TCGv msr =3D tcg_temp_new();
>>=20=20
>> @@ -4411,9 +4423,6 @@ static void gen_mtmsr(DisasContext *ctx)
>>           *      power saving mode, we will exit the loop directly from
>>           *      ppc_store_msr
>>           */
>> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> -            gen_io_start();
>> -        }
>>          gen_update_nip(ctx, ctx->base.pc_next);
>>  #if defined(TARGET_PPC64)
>>          tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 3=
2);
>> @@ -4422,10 +4431,9 @@ static void gen_mtmsr(DisasContext *ctx)
>>  #endif
>>          gen_helper_store_msr(cpu_env, msr);
>>          tcg_temp_free(msr);
>> -        /* Must stop the translation as machine state (may have) change=
d */
>> -        /* Note that mtmsr is not always defined as context-synchronizi=
ng */
>> -        gen_stop_exception(ctx);
>>      }
>> +    /* Must stop the translation as machine state (may have) changed */
>> +    gen_stop_exception(ctx);
>>  #endif
>>  }
>>=20=20
>>=20


--=20
Alex Benn=C3=A9e

