Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468B221721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDJf7NE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468B221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvN2-00071j-AR
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHvHn-0005Q3-V6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHvHk-0007fv-9Z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:36:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHvHg-0007fF-Jt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:36:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id p14so19830198wro.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Dlau6lwwBxhYGVfWqPtLOQ7MXVqwpt+Ep0TpnQVbL7Y=;
 b=pDJf7NE15aVZTGNluFjN/aJ5nnLhSWp+1sb+mZxxcHoL+Ti64+NwzsXhb8yYL1aHOZ
 O1FJG7dlq6i6H12JlKiteye1DeyGUij49873cK7Q0QYByyThn6cyrk6GihyUej/GCQeV
 +QFtMuSDBi4xudoSg173MVNairgtg/XNwnyy/L1/gYCAubWJmNs8KwHIXuqFA5uDS0FK
 Y0moEcucS5QPG70g3WYkRzauffzwZIxQM4dwd/G6FLeyMlRNN0MCFdarDBroDIUsMRVI
 2qvWBgajQpaQCMqn1gGzIiqBkDjjkyVO4/Q1F+aMs3CmjM4RfkneQYSrb/MVQYpxA3fO
 xIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Dlau6lwwBxhYGVfWqPtLOQ7MXVqwpt+Ep0TpnQVbL7Y=;
 b=syme23FGdEWgJgQ4APIYDCKtwTbK3pNNbqZYqlVNucGLQ2z0WsBKQZjdH2+BEXHXYR
 6STJ7lHhV/gJQ1BpdG2uM4EMdp0hfQ0A3Ns94lUcuAsAErc7Zg/0LUnDbJ/Garg6fHST
 ZkrkD99tL0/eyJUfSenU8GElXewhXn4PDrltgQj8eNS3jlEStOfeL2v5xRRpihpfeYeJ
 p0nRTh52SUHT8bb/1U7Rt25tUzu0y7btCkEP+K3b4VbWB+bAg0bGg32SPOFqcanTm+ku
 WM2XEgPY3vOTSahHLTEbtqVIPFFIp0XjD42HKJmFnbTlC62P3DzM2WScxrGilAAMkyND
 de1g==
X-Gm-Message-State: APjAAAXdN0GJ+XbtNKZ3gwUxRSXXdNa1zS4CLqexECgVELPZINlf3yq2
 OYyY1woWJS+lnf+XzbPcIWoEKQ==
X-Google-Smtp-Source: APXvYqxsMtvS7luDTg7wf2VwoRARP+ojec1TygM5L4zyQn1tNaCYA7G0NSgtmLS8fmXgoFif+Bw9bw==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr29854251wru.227.1570563393745; 
 Tue, 08 Oct 2019 12:36:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm7583496wmb.19.2019.10.08.12.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 12:36:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75C9F1FF87;
 Tue,  8 Oct 2019 20:36:32 +0100 (BST)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-10-alex.bennee@linaro.org>
 <57a84842-2e85-6c39-2abe-b0dd3b3750ca@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 09/13] Adding info [tb-list|tb] commands to HMP (WIP)
In-reply-to: <57a84842-2e85-6c39-2abe-b0dd3b3750ca@linaro.org>
Date: Tue, 08 Oct 2019 20:36:32 +0100
Message-ID: <87eeznhvwf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>
>> These commands allow the exploration of TBs generated by the TCG.
>> Understand which one hotter, with more guest/host instructions... and
>> examine their guest, host and IR code.
>>
>> The goal of this command is to allow the dynamic exploration of TCG
>> behavior and code quality. Therefore, for now, a corresponding QMP
>> command is not worthwhile.
>>
>> [AJB: WIP - we still can't be safely sure a translation will succeed]

I'll fix up all the other points...

>
>> +/*
>> + * We cannot always re-generate the code even if we know there are
>> + * valid translations still in the cache. The reason being the guest
>> + * may have un-mapped the page code.
>
> Um... unless I mistake what's being described here, that wouldn't be a va=
lid
> translation.  Or do you just mean that the page mapping isn't present wit=
hin
> the TLB?  Which is not quite the same thing as "unmapping".

A page entry can get dropped without invalidating the TB (for example
the guest OS sets a page as non-exec). The TLB flush takes care of the
jump cache and there are no inter-page hardwired links so if a tb_find
goes there we would get the fault.

>> + * TODO: can we do this safely? We need to
>> + *  a) somehow recover the mmu_idx for this translation
>
> We could add an interface for this, yes.  The value *must* be able to be
> derived from tb->flags, but of course in a target-dependent way.
>
>> + *  b) probe MMU_INST_FETCH to know it will succeed
>
> We *do* have this now, sort of: tlb_vaddr_to_host.
>
> So far all use of this function originates from target/foo/,
> and so some targets have not been updated to work with this.
> I've marked these with asserts within foo_cpu_tlb_fill.
>
> Notable targets for which it won't work: i386, sparc.
>
>
>> +static GString *get_code_string(TBStatistics *tbs, int log_flags)
>> +{
>> +    int old_log_flags =3D qemu_loglevel;
>> +
>> +    CPUState *cpu =3D first_cpu;
>> +    uint32_t cflags =3D curr_cflags() | CF_NOCACHE;
>> +    TranslationBlock *tb =3D NULL;
>> +
>> +    GString *code_s =3D g_string_new(NULL);
>> +    qemu_log_to_string(true, code_s);
>> +
>> +    qemu_set_log(log_flags);
>> +
>> +    if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
>> +        mmap_lock();
>> +        tb =3D tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cfla=
gs);
>> +        tb_phys_invalidate(tb, -1);
>> +        mmap_unlock();
>
> Ew.  No.
>
> Let us not go through tb_gen_code, just to get logging output from the
> translator.  What are we really after here?  Input assembly?

All of it - in_asm, op, op_opt, out_asm potentially. But I agree it's
far too hacky - c.f. above because we end up potentially delivering a
fault to the guest when we fail.

It would be nice if we could run the translation phase independently of
the CPU environment. Maybe the monitor could have it's own TCGContext
and call tcg_gen_code directly just for debug output? It would avoid
having to use safe work and all the rest of the stuff we don't actually
care about in tb_gen_code. I guess you could still use the sigsetjmp to
catch the inevitable exceptions from the code load?

--
Alex Benn=C3=A9e

