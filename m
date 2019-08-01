Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB3220644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FLT9z3/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB3220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htByT-0001q4-Vh
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1htBxB-0000Wr-SI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1htBx9-0007Xb-Pa
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:21:13 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1htBwy-0007Tt-Af; Thu, 01 Aug 2019 10:21:01 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4890D96F50;
 Thu,  1 Aug 2019 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564669254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/al+RlmCG68yjHS0+nQyhBsMsPmB3jwvG1d2/Kx/6c=;
 b=FLT9z3/o/CxgwvtVIZVl3Cwv3+Pps5jDo1mU19kl9achq2nRv/kbJ3463lt/tjoH+cJx5Q
 tthfqhVWm+TiQ9vgQxQOWR7dZmnATIdbejEVqvMRlzNeQUAblifDD/qok6WAs1hTvqhrhG
 RWA39rFenrNhBB5pskcC3znMq8GGKOI=
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190801105742.20036-1-peter.maydell@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <af347b17-b524-1075-d462-2b0e6eef41a5@greensocs.com>
Date: Thu, 1 Aug 2019 16:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190801105742.20036-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564669254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/al+RlmCG68yjHS0+nQyhBsMsPmB3jwvG1d2/Kx/6c=;
 b=nu+c48VnDczwCR2StkbQDAAnq49BC/4KM7Sd4vuQF8o4sj+nM2R30Zx583St1g1H6Z+rgF
 35Tn7Xg2L2VfyvGBCunsXCls+wbkBxjePnwr5MnpMnoMShniP2t98y6eu05vFBYzhoGuRS
 9+5ZIfniBxYprsZKDNy4jn5xm8OBCSQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564669254; a=rsa-sha256; cv=none;
 b=qF7VLBUem9oXMALwJZenCWFpsMLx1nv/hHzHcEJz9C76bm3qblv7thiXRDEyFecCBxkKtF
 R1DOIM+NKpeyFl6uQ8Tp2Tz2CFA/65NIilGpll/rsMlnBZLtiHaeyE+OKmcCG13cKJh4nf
 Q19R1vea/w67vf0SxZuTg8dtPjykJsw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Avoid bogus NSACR
 traps on M-profile without Security Extension
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/1/19 12:57 PM, Peter Maydell wrote:
> In Arm v8.0 M-profile CPUs without the Security Extension and also in
> v7M CPUs, there is no NSACR register. However, the code we have to handle
> the FPU does not always check whether the ARM_FEATURE_M_SECURITY bit
> is set before testing whether env->v7m.nsacr permits access to the
> FPU. This means that for a CPU with an FPU but without the Security
> Extension we would always take a bogus fault when trying to stack
> the FPU registers on an exception entry.
> 
> We could fix this by adding extra feature bit checks for all uses,
> but it is simpler to just make the internal value of nsacr 0x3ff

s/0x3ff/0xcff/ I think, given you put 0xcff after and in the code

> ("all non-secure accesses allowed"), since this is not guest
> visible when the Security Extension is not present. This allows
> us to continue to follow the Arm ARM pseudocode which takes a
> similar approach. (In particular, in the v8.1 Arm ARM the register
> is documented as reading as 0xcff in this configuration.)
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1838475
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've marked this as for-4.1 because support for M-profile FPU
> is new in this release and this is a pretty bad bug for it.
> It probably doesn't qualify as so bad we need an rc4 but I
> think we need an rc4 anyway and it probably does merit putting
> in at that point.
> 
>  target/arm/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 9eb40ff755f..ec2ab95dbeb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -266,6 +266,14 @@ static void arm_cpu_reset(CPUState *s)
>               * on ARM_FEATURE_V8 (we don't let the guest see the bit).
>               */
>              env->v7m.aircr = R_V7M_AIRCR_BFHFNMINS_MASK;
> +            /*
> +             * Set NSACR to indicate "NS access permitted to everything";
> +             * this avoids having to have all the tests of it being
> +             * conditional on ARM_FEATURE_M_SECURITY. Note also that from
> +             * v8.1M the guest-visible value of NSACR in a CPU without the
> +             * Security Extension is 0xcff.
> +             */
> +            env->v7m.nsacr = 0xcff;
>          }
>  
>          /* In v7M the reset value of this bit is IMPDEF, but ARM recommends
> 

