Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A939FC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D2E206C0
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCiTgH+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D2E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUVTw-0002YV-GQ
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUVSc-0000zj-P9
 for qemu-devel@nongnu.org; Fri, 01 May 2020 09:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUVQn-0007gD-Qn
 for qemu-devel@nongnu.org; Fri, 01 May 2020 09:12:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUVQn-0007dj-8d
 for qemu-devel@nongnu.org; Fri, 01 May 2020 09:10:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id g13so11466157wrb.8
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ph5IJg3NDrTJhu9V19xWv3ZqhpuKndVABhMSWDbXDNo=;
 b=MCiTgH+ZvHkvqTXA3uaX2ri2rljux7mWtWcU9wEC0W3MX4TwckS9KXbSzOwqXBBPaW
 u/e1rX69WXWLclWBAKaJUKmh6mOHWwstyi1jd/ZmGVXlJS2FdDjJG1LheST/T+1q33Pr
 04X6Tjw90QPbD2WS/8GRvA26k5GovKwxJuYgk4bM3M8q+FscBC2+wchMjHZdHZN81aeL
 NMa8GozMTlETpJieT3msP9+bXn2bA/z/ds0IJi6p3BZAWnpDXjN7+wI5yzW7TnCy1JCd
 4v1/Yq5s7K6CZfH6uT8yzsdQvAcHQh0QofVeUYcBL+4K/7WeK3DSVDltCAO8O2jKpBbH
 gP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ph5IJg3NDrTJhu9V19xWv3ZqhpuKndVABhMSWDbXDNo=;
 b=bR4WA9x2s7oZ/asZWl7wHsxKsfp/18HQOWXHtrIF7rl/B7Y1FIH0/b8g8W1vN6GdC2
 nQLwZqqLJp8uh+l/cU+ebqkf5iTxcOjVg6jgPOxg0Ud3m7k18FwnQhXWMvxa7flZ6Awb
 0AvZPjK8jylvBwPxBDUDLidDtP49NGcuNyBl9Pc6Ed1cm0Pjl+TeBkUC1sjaQDESCeWZ
 DnH+vfszVrMSbwaMVU6NHIuLB3Q8IwUEZp37wPrc71ZK1tx3vuuKtbmC1SV2QQJljtFD
 5Dfp/cANIFW/49hhhMV1+YLNcS1Q/tXL2I9TLL10pciB2iKYVJ8F0E8vEqIqc/MUoFpU
 dXwg==
X-Gm-Message-State: AGi0PubpTveNijQC9t9UMKLL6I4OUsYw0xLhEkk3RDdU8avV9kwXptvg
 prsT5r8KlifOmzgrvLYDz+oRdA==
X-Google-Smtp-Source: APiQypI1XH0i8ee+LKJTpelnEe8zBDzS4n58nlgod1r7TX4rct88vWWkmkFnVg4qPjhtgaO/PqFZoA==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr4480046wrg.105.1588338615380; 
 Fri, 01 May 2020 06:10:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm4360863wrv.60.2020.05.01.06.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 06:10:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 522F61FF7E;
 Fri,  1 May 2020 14:10:13 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
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
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: About hardfloat in ppc
In-reply-to: <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
Date: Fri, 01 May 2020 14:10:13 +0100
Message-ID: <874kszkdhm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::436
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
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> > That's what I suggested,
>> > We preserve a  float computing cache
>> > typedef struct FpRecord {
>> >  uint8_t op;
>> >  float32 A;
>> >  float32 B;
>> > }  FpRecord;
>> > FpRecord fp_cache[1024];
>> > int fp_cache_length;
>> > uint32_t fp_exceptions;
>> >
>> > 1. For each new fp operation we push it to the  fp_cache,
>> > 2. Once we read the fp_exceptions , then we re-compute
>> > the fp_exceptions by re-running the fp FpRecord sequence.
>> > and clear  fp_cache_length.
>>
>> Why do you need to store more than the last fp op? The cumulative bits c=
an
>> be tracked like it's done for other targets by not clearing fp_status th=
en
>> you can read it from there. Only the non-sticky FI bit needs to be
>> computed but that's only determined by the last op so it's enough to
>> remember that and run that with softfloat (or even hardfloat after
>> clearing status but softfloat may be faster for this) to get the bits for
>> last op when status is read.
>>
> Yeap, store only the last fp op is also an option. Do you means that store
> the last fp op,
> and calculate it when necessary?  I am thinking about a general fp
> optmize method that suite
> for all target.

I think that's getting a little ahead of yourself. Let's prove the
technique is valuable for PPC (given it has the most to gain). We can
always generalise later if it's worthwhile.

Rather than creating a new structure I would suggest creating 3 new tcg
globals (op, inA, inB) and re-factor the front-end code so each FP op
loaded the TCG globals. The TCG optimizer should pick up aliased loads
and automatically eliminate the dead ones. We might need some new
machinery for the TCG to avoid spilling the values over potentially
faulting loads/stores but that is likely a phase 2 problem.=20

Next you will want to find places that care about the per-op bits of
cpu_fpscr and call a helper with the new globals to re-run the
computation and feed the values in.

That would give you a reasonable working prototype to start doing some
measurements of overhead and if it makes a difference.

>
>>
>> > 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 and
>> > clear  fp_exceptions.
>> > 4. If the  fp_cache are full, then we re-compute
>> > the fp_exceptions by re-running the fp FpRecord sequence.
>>
>> All this cache management and more than one element seems unnecessary to
>> me although I may be missing something.
>>
>> > Now the keypoint is how to tracking the read and write of FPSCR regist=
er,
>> > The current code are
>> >    cpu_fpscr =3D tcg_global_mem_new(cpu_env,
>> >                                   offsetof(CPUPPCState, fpscr), "fpscr=
");
>>
>> Maybe you could search where the value is read which should be the places
>> where we need to handle it but changes may be needed to make a clear API
>> for this between target/ppc, TCG and softfloat which likely does not
>> exist yet.

Once the per-op calculation is fixed in the PPC front-end I thing the
only change needed is to remove the #if defined(TARGET_PPC) in
softfloat.c - it's only really there because it avoids the overhead of
checking flags which we always know to be clear in it's case.

--=20
Alex Benn=C3=A9e

