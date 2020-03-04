Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BEC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D758521775
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D758521775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9YPO-0008PU-QI
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andre.przywara@arm.com>) id 1j9YLF-0006G2-Pu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andre.przywara@arm.com>) id 1j9YLE-00028q-Na
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:01:57 -0500
Received: from foss.arm.com ([217.140.110.172]:46058)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <andre.przywara@arm.com>)
 id 1j9YLB-0001xV-KL; Wed, 04 Mar 2020 13:01:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4703931B;
 Wed,  4 Mar 2020 10:01:52 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A7E3F6C4;
 Wed,  4 Mar 2020 10:01:50 -0800 (PST)
Date: Wed, 4 Mar 2020 18:01:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/9] arm: pmu: Let pmu tests take a
 sub-test parameter
Message-ID: <20200304180144.51fe2852@donnerap.cambridge.arm.com>
In-Reply-To: <20200130112510.15154-3-eric.auger@redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-3-eric.auger@redhat.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.140.110.172
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andrew.murray@arm.com, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 12:25:03 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> As we intend to introduce more PMU tests, let's add
> a sub-test parameter that will allow to categorize
> them. Existing tests are in the cycle-counter category.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Did you change anything? Or just forgot to add my previous R-b?

Anyway,

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arm/pmu.c         | 24 +++++++++++++++---------
>  arm/unittests.cfg |  7 ++++---
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index d5a03a6..e5e012d 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -287,22 +287,28 @@ int main(int argc, char *argv[])
>  {
>  	int cpi = 0;
>  
> -	if (argc > 1)
> -		cpi = atol(argv[1]);
> -
>  	if (!pmu_probe()) {
>  		printf("No PMU found, test skipped...\n");
>  		return report_summary();
>  	}
>  
> +	if (argc < 2)
> +		report_abort("no test specified");
> +
>  	report_prefix_push("pmu");
>  
> -	report(check_pmcr(), "Control register");
> -	report(check_cycles_increase(),
> -	       "Monotonically increasing cycle count");
> -	report(check_cpi(cpi), "Cycle/instruction ratio");
> -
> -	pmccntr64_test();
> +	if (strcmp(argv[1], "cycle-counter") == 0) {
> +		report_prefix_push(argv[1]);
> +		if (argc > 2)
> +			cpi = atol(argv[2]);
> +		report(check_pmcr(), "Control register");
> +		report(check_cycles_increase(),
> +		       "Monotonically increasing cycle count");
> +		report(check_cpi(cpi), "Cycle/instruction ratio");
> +		pmccntr64_test();
> +	} else {
> +		report_abort("Unknown sub-test '%s'", argv[1]);
> +	}
>  
>  	return report_summary();
>  }
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index daeb5a0..79f0d7a 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -61,21 +61,22 @@ file = pci-test.flat
>  groups = pci
>  
>  # Test PMU support
> -[pmu]
> +[pmu-cycle-counter]
>  file = pmu.flat
>  groups = pmu
> +extra_params = -append 'cycle-counter 0'
>  
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -#extra_params = -icount 0 -append '1'
> +#extra_params = -icount 0 -append 'cycle-counter 1'
>  #groups = pmu
>  #accel = tcg
>  
>  # Test PMU support (TCG) with -icount IPC=256
>  #[pmu-tcg-icount-256]
>  #file = pmu.flat
> -#extra_params = -icount 8 -append '256'
> +#extra_params = -icount 8 -append 'cycle-counter 256'
>  #groups = pmu
>  #accel = tcg
>  


