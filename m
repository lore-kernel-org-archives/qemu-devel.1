Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76CE216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76CE216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaFV5-00069b-TG
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 03:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaFRe-00048B-9T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaFRc-0005RN-T3
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:46:38 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:42395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaFRc-0005Jf-Mi
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 03:46:36 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.166])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4A6F31EF111
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:46:33 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 0E1E0C919A07;
 Thu, 28 Nov 2019 08:46:26 +0000 (UTC)
Subject: Re: [PATCH 2/4] target/arm: Abstract the generic timer frequency
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191128054527.25450-1-andrew@aj.id.au>
 <20191128054527.25450-3-andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cd0b8fe7-ce7a-1ba4-2c5c-1bec0a2d1a57@kaod.org>
Date: Thu, 28 Nov 2019 09:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128054527.25450-3-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9901163780868115264
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.113
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 06:45, Andrew Jeffery wrote:
> Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
> CNTFRQ to values significantly larger than the static 62.5MHz value
> currently derived from GTIMER_SCALE. As the OS potentially derives its
> timer periods from the CNTFRQ value the lack of support for running
> QEMUTimers at the appropriate rate leads to sticky behaviour in the
> guest.
> 
> Substitute the GTIMER_SCALE constant with use of a helper to derive the
> period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
> to the frequency associated with GTIMER_SCALE so current behaviour is
> maintained.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  target/arm/cpu.c    |  2 ++
>  target/arm/cpu.h    | 10 ++++++++++
>  target/arm/helper.c | 10 +++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339bf9..5698a74061bb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
>      if (tcg_enabled()) {
>          cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
>      }
> +
> +    cpu->gt_cntfrq = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
>  }
>  
>  static Property arm_cpu_reset_cbar_property =
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 83a809d4bac4..666c03871fdf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -932,8 +932,18 @@ struct ARMCPU {
>       */
>      DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
>      DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
> +
> +    /* Generic timer counter frequency, in Hz */
> +    uint64_t gt_cntfrq;
>  };
>  
> +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> +{
> +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */
> +    const unsigned int ns_per_s = 1000 * 1000 * 1000;
> +    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
> +}

Are you inlining this helper for performance reasons ? 

C. 


>  void arm_cpu_post_init(Object *obj);
>  
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 65c4441a3896..1cc0551081a0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2409,7 +2409,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>  
>  static uint64_t gt_get_countervalue(CPUARMState *env)
>  {
> -    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
>  }
>  
>  static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
> @@ -2445,7 +2447,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>           * set the timer for as far in the future as possible. When the
>           * timer expires we will reset the timer for any remaining period.
>           */
> -        if (nexttick > INT64_MAX / GTIMER_SCALE) {
> +        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
>              timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
>          } else {
>              timer_mod(cpu->gt_timer[timeridx], nexttick);
> @@ -2874,11 +2876,13 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>  
>  static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> +    ARMCPU *cpu = env_archcpu(env);
> +
>      /* Currently we have no support for QEMUTimer in linux-user so we
>       * can't call gt_get_countervalue(env), instead we directly
>       * call the lower level functions.
>       */
> -    return cpu_get_clock() / GTIMER_SCALE;
> +    return cpu_get_clock() / gt_cntfrq_period(cpu);
>  }
>  
>  static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
> 


