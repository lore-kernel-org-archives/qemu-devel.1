Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E45C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE00120836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE00120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUKA-0005Fv-UB
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUUJG-0004k3-Fp
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUUJE-0003ID-5A
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:58:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:32792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUUJB-0003Am-Qb; Fri, 01 May 2020 07:58:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED793746344;
 Fri,  1 May 2020 13:58:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA44A746340; Fri,  1 May 2020 13:58:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8BB3746354;
 Fri,  1 May 2020 13:58:17 +0200 (CEST)
Date: Fri, 1 May 2020 13:58:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?GB2312?Q?=C2=DE=D3=C2=B8=D5=28Yonggang_Luo=29?= <luoyonggang@gmail.com>
Subject: Re: About hardfloat in ppc
In-Reply-To: <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
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
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1897029569-1588334297=:29385"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 07:58:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Dino Papararo <skizzato73@msn.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1897029569-1588334297=:29385
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, 罗勇刚(Yonggang Luo) wrote:
> That's what I suggested,
> We preserve a  float computing cache
> typedef struct FpRecord {
>  uint8_t op;
>  float32 A;
>  float32 B;
> }  FpRecord;
> FpRecord fp_cache[1024];
> int fp_cache_length;
> uint32_t fp_exceptions;
>
> 1. For each new fp operation we push it to the  fp_cache,
> 2. Once we read the fp_exceptions , then we re-compute
> the fp_exceptions by re-running the fp FpRecord sequence.
> and clear  fp_cache_length.

Why do you need to store more than the last fp op? The cumulative bits can 
be tracked like it's done for other targets by not clearing fp_status then 
you can read it from there. Only the non-sticky FI bit needs to be 
computed but that's only determined by the last op so it's enough to 
remember that and run that with softfloat (or even hardfloat after 
clearing status but softfloat may be faster for this) to get the bits for 
last op when status is read.

> 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 and
> clear  fp_exceptions.
> 4. If the  fp_cache are full, then we re-compute
> the fp_exceptions by re-running the fp FpRecord sequence.

All this cache management and more than one element seems unnecessary to 
me although I may be missing something.

> Now the keypoint is how to tracking the read and write of FPSCR register,
> The current code are
>    cpu_fpscr = tcg_global_mem_new(cpu_env,
>                                   offsetof(CPUPPCState, fpscr), "fpscr");

Maybe you could search where the value is read which should be the places 
where we need to handle it but changes may be needed to make a clear API 
for this between target/ppc, TCG and softfloat which likely does not 
exist yet.

Regards,
BALATON Zoltan
--3866299591-1897029569-1588334297=:29385--

