Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A832C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B660B2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B660B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2zJ-0001lQ-ER
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandru.elisei@arm.com>)
 id 1kD2WM-0000db-Dn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:24:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59946)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexandru.elisei@arm.com>) id 1kD2WJ-0008Bd-FR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:24:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC94D30E;
 Tue,  1 Sep 2020 02:24:00 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6123F71F;
 Tue,  1 Sep 2020 02:23:59 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 0/4] KVM: arm64: Statistical Profiling
 Extension Tests
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org,
 drjones@redhat.com, andrew.murray@arm.com, sudeep.holla@arm.com,
 maz@kernel.org, will@kernel.org, haibo.xu@linaro.org
References: <20200831193414.6951-1-eric.auger@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <b5eb2cd0-9798-6e40-7690-78992eca30fd@arm.com>
Date: Tue, 1 Sep 2020 10:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831193414.6951-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=alexandru.elisei@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:24:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

These patches are extremely welcome! I took over the KVM SPE patches from Andrew
Murray, and I was working on something similar to help with development.

The KVM series on the public mailing list work only by chance because it is
impossible to reliably map the SPE buffer at EL2 when profiling triggers a stage 2
data abort. That's because the DABT is reported asynchronously via the buffer
management interrupt and the faulting IPA is not reported anywhere. I'm trying to
fix this issue in the next iteration of the series, and then I'll come back to
your patches for review and testing.

Thanks,

Alex

On 8/31/20 8:34 PM, Eric Auger wrote:
> This series implements tests exercising the Statistical Profiling
> Extensions.
>
> This was tested with associated unmerged kernel [1] and QEMU [2]
> series.
>
> Depending on the comments, I can easily add other tests checking
> more configs, additional events and testing migration too. I hope
> this can be useful when respinning both series.
>
> All SPE tests can be launched with:
> ./run_tests.sh -g spe
> Tests also can be launched individually. For example:
> ./arm-run arm/spe.flat -append 'spe-buffer'
>
> The series can be found at:
> https://github.com/eauger/kut/tree/spe_rfc
>
> References:
> [1] [PATCH v2 00/18] arm64: KVM: add SPE profiling support
> [2] [PATCH 0/7] target/arm: Add vSPE support to KVM guest
>
> Eric Auger (4):
>   arm64: Move get_id_aa64dfr0() in processor.h
>   spe: Probing and Introspection Test
>   spe: Add profiling buffer test
>   spe: Test Profiling Buffer Events
>
>  arm/Makefile.common       |   1 +
>  arm/pmu.c                 |   1 -
>  arm/spe.c                 | 463 ++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg         |  24 ++
>  lib/arm64/asm/barrier.h   |   1 +
>  lib/arm64/asm/processor.h |   5 +
>  6 files changed, 494 insertions(+), 1 deletion(-)
>  create mode 100644 arm/spe.c
>

