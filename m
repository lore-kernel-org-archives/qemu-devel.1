Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE0C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4D32051A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsZTYga7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4D32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWFP-0006xx-UB
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUWEN-0006Qt-NB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUWEL-0008DL-47
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:01:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUWEK-0008Cy-LI
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:01:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id o27so6311739wra.12
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=l+kcpKtlztBDbGK3L4+JLi4cdQecEZhFWk1zzgKYxeM=;
 b=HsZTYga7DCNOdgMryz58eIusM6q+b5dCifdaBwjh5nZAd4EZvrZmN7cUrsedlgerdM
 8QZQsqwM9JSscITSO63oZrttvv1kqqfV9ZxQbGhc+Tb+vhmuVY/k4qUqTmjSTwtTYg9W
 GlUnxLUmX1wg3l9BSMN1YVEdVQcfNUTAsDKs8P2DbMy+iWnSo+ISW7Hn+eWB9FH0e1Ak
 1PiN2mqIOG0Jp2NbmkSX65/QabMg96ynTJohzh09c6HXnlFAhyKE4Y4v09Erq0q05ZOU
 wKUoEGVdp5wKlWTrGgqmCMbdQaLKiToS1M/AgwfawnX0T75hrzj9MqJx1YUdMktIvjuZ
 v7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=l+kcpKtlztBDbGK3L4+JLi4cdQecEZhFWk1zzgKYxeM=;
 b=QMxZDhbGqNTWqZ2C4HKBYewjsv4iF804dfHPrDbZSRHFs3/vB7lpmJLwRDj3a2q56/
 A16HSBrRE+BzGBderYI4YQEjwZSdwVHhWMLfBRU0ekhfCOX8yj8wlkkPNCLiS7NLeNDk
 BQSrlQAMfFTsoZ/g7ITjLG9QS8oPCh0vSZnsPXy72J+Ia75IPJBySvuJip/CEuD2JRtq
 +7OnJOA4HGRW1YP43TZzi+HsRtgV4pLJtd71XeftsoW0RZUPZqWK45BX+CIYEZtxaAkk
 32qpoRVr3c8K0mR5Ofl3Nj0Jp4E5tlivAxcc1AudgJff7/A8a8ZGuY4FZUzNaCfOSwGC
 miBQ==
X-Gm-Message-State: AGi0PuanWP7wuHyFau7Qse/49LdRe2ldqQmGm2Rqi/SMbdWqCQ+LxWJb
 XY0igWR2YwM1vFNDWm1G98M7ng==
X-Google-Smtp-Source: APiQypKYRfoJKcIlzreoWVj4QFNsiKCDWQppm2bith1zx4NRE6AH1YWjDKLwwuWfWliQ7sK+bUf06g==
X-Received: by 2002:adf:f24c:: with SMTP id b12mr4333675wrp.359.1588341686848; 
 Fri, 01 May 2020 07:01:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm3983200wmg.34.2020.05.01.07.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:01:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 681CF1FF7E;
 Fri,  1 May 2020 15:01:24 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
 <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
 <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
 <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
 <874kszkdhm.fsf@linaro.org>
 <alpine.BSF.2.22.395.2005011517360.62443@zero.eik.bme.hu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: About hardfloat in ppc
In-reply-to: <alpine.BSF.2.22.395.2005011517360.62443@zero.eik.bme.hu>
Date: Fri, 01 May 2020 15:01:24 +0100
Message-ID: <87y2qbiwjv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>, luoyonggang@gmail.com,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Fri, 1 May 2020, Alex Benn=C3=A9e wrote:
>> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:
>>> On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
>>>> On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>>>>> That's what I suggested,
>>>>> We preserve a  float computing cache
>>>>> typedef struct FpRecord {
>>>>>  uint8_t op;
>>>>>  float32 A;
>>>>>  float32 B;
>>>>> }  FpRecord;
>>>>> FpRecord fp_cache[1024];
>>>>> int fp_cache_length;
>>>>> uint32_t fp_exceptions;
>>>>>
>>>>> 1. For each new fp operation we push it to the  fp_cache,
>>>>> 2. Once we read the fp_exceptions , then we re-compute
>>>>> the fp_exceptions by re-running the fp FpRecord sequence.
>>>>> and clear  fp_cache_length.
>>>>
>>>> Why do you need to store more than the last fp op? The cumulative bits=
 can
>>>> be tracked like it's done for other targets by not clearing fp_status =
then
>>>> you can read it from there. Only the non-sticky FI bit needs to be
>>>> computed but that's only determined by the last op so it's enough to
>>>> remember that and run that with softfloat (or even hardfloat after
>>>> clearing status but softfloat may be faster for this) to get the bits =
for
>>>> last op when status is read.
>>>>
>>> Yeap, store only the last fp op is also an option. Do you means that st=
ore
>>> the last fp op,
>>> and calculate it when necessary?  I am thinking about a general fp
>>> optmize method that suite
>>> for all target.
>>
>> I think that's getting a little ahead of yourself. Let's prove the
>> technique is valuable for PPC (given it has the most to gain). We can
>> always generalise later if it's worthwhile.
>>
>> Rather than creating a new structure I would suggest creating 3 new tcg
>> globals (op, inA, inB) and re-factor the front-end code so each FP op
>> loaded the TCG globals.
>
> So that's basically wherever you see helper_reset_fpstatus() in
> target/ppc we would need to replace it with saving op and args to
> globals? Or just repurpose this helper to do that. This is called
> before every fp op but not before sub ops within vector ops. Is that
> correct? Probably it is, as vector ops are a single op but how do we
> detect changes in flags by sub ops for those? These might have some
> existing bugs I think.

I'll defer to the PPC front end experts on this. I'm not familiar with
how it all goes together at all.

>
>> The TCG optimizer should pick up aliased loads
>> and automatically eliminate the dead ones. We might need some new
>> machinery for the TCG to avoid spilling the values over potentially
>> faulting loads/stores but that is likely a phase 2 problem.
>
> I have no idea how to do this or even where to look. Some more
> detailed explanation may be needed here.

Don't worry about it now. Let's worry about it when we see how often
faulting instructions are interleaved with fp ops.

>
>> Next you will want to find places that care about the per-op bits of
>> cpu_fpscr and call a helper with the new globals to re-run the
>> computation and feed the values in.
>
> So the code that cares about these bits are in guest thus we would
> need to compute it if we detect the guest accessing these. Detecting
> when the individual bits are accessed might be difficult so at first
> we could go for checking if the fpscr is read and recompute FI bit
> then before returning value. You previously said these might be when
> fpscr is read or when generating exceptions but not sure where exactly
> are these done for ppc. (I'd expect to have mffpscr but there seem to
> be different other ops instead accessing parts of fpscr which are
> found in target/ppc/fp-impl.inc.c:567 so this would need studying the
> PPC docs to understand how the guest can access the FI bit of fpscr
> reg.)
>
>> That would give you a reasonable working prototype to start doing some
>> measurements of overhead and if it makes a difference.
>>
>>>
>>>>
>>>>> 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 a=
nd
>>>>> clear  fp_exceptions.
>>>>> 4. If the  fp_cache are full, then we re-compute
>>>>> the fp_exceptions by re-running the fp FpRecord sequence.
>>>>
>>>> All this cache management and more than one element seems unnecessary =
to
>>>> me although I may be missing something.
>>>>
>>>>> Now the keypoint is how to tracking the read and write of FPSCR regis=
ter,
>>>>> The current code are
>>>>>    cpu_fpscr =3D tcg_global_mem_new(cpu_env,
>>>>>                                   offsetof(CPUPPCState, fpscr), "fpsc=
r");
>>>>
>>>> Maybe you could search where the value is read which should be the pla=
ces
>>>> where we need to handle it but changes may be needed to make a clear A=
PI
>>>> for this between target/ppc, TCG and softfloat which likely does not
>>>> exist yet.
>>
>> Once the per-op calculation is fixed in the PPC front-end I thing the
>> only change needed is to remove the #if defined(TARGET_PPC) in
>> softfloat.c - it's only really there because it avoids the overhead of
>> checking flags which we always know to be clear in it's case.
>
> That's the theory but I've found that removing that define currently
> makes general fp ops slower but vector ops faster so I think there may
> be some bugs that would need to be found and fixed. So testing with
> some proper test suite might be needed.

You might want to do what Laurent did and hack up a testfloat with
"system" implementations:

  https://github.com/vivier/m68k-testfloat/blob/master/testfloat/M68K-Linux=
-GCC/systfloat.c

I would be nice to plumb that sort of support into our existing
testfloat fork in the code base (tests/fp) but I suspect getting an
out-of-tree fork building and running first would be the quickest way
forward.=20

>
> Regards,
> BALATON Zoltan


--=20
Alex Benn=C3=A9e

