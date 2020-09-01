Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DCCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253D206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYfBU9wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5253D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3sH-0002x8-Eu
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kD3rh-0002J0-6h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:50:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kD3rf-000304-B4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598957410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Fbx3HtDgDwoy6VUvyMLJHxJtjj7AUVDGgoI6t2FUsU=;
 b=FYfBU9warbOkhs56UQ+RwPDWnaSJVFo5Lm536ymejVNupsPj7ovshfotpeov0WSDAsnG8n
 /fGqHLyRar2awdlgyzr1Xh5PuqyHFktBhCPAXFSrNlrbrCDpjMMjAOtY9usMBIX1bUHI0C
 dYsEnas/9Du5R6A+jZFK4tn5ZUoGplo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-eHZhEsD3P9OYkqV8MFw-SA-1; Tue, 01 Sep 2020 06:50:07 -0400
X-MC-Unique: eHZhEsD3P9OYkqV8MFw-SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA4652FD03;
 Tue,  1 Sep 2020 10:50:04 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64E945C1A3;
 Tue,  1 Sep 2020 10:50:01 +0000 (UTC)
Subject: Re: [kvm-unit-tests RFC 0/4] KVM: arm64: Statistical Profiling
 Extension Tests
To: Alexandru Elisei <alexandru.elisei@arm.com>, eric.auger.pro@gmail.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org,
 drjones@redhat.com, andrew.murray@arm.com, sudeep.holla@arm.com,
 maz@kernel.org, will@kernel.org, haibo.xu@linaro.org
References: <20200831193414.6951-1-eric.auger@redhat.com>
 <b5eb2cd0-9798-6e40-7690-78992eca30fd@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <817f34fb-9476-e3b8-d9a1-bebf6be11683@redhat.com>
Date: Tue, 1 Sep 2020 12:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b5eb2cd0-9798-6e40-7690-78992eca30fd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alexandru,

On 9/1/20 11:24 AM, Alexandru Elisei wrote:
> Hi Eric,
> 
> These patches are extremely welcome! I took over the KVM SPE patches from Andrew
> Murray, and I was working on something similar to help with development.
Cool.
> 
> The KVM series on the public mailing list work only by chance because it is
> impossible to reliably map the SPE buffer at EL2 when profiling triggers a stage 2
> data abort. That's because the DABT is reported asynchronously via the buffer
> management interrupt and the faulting IPA is not reported anywhere. I'm trying to
> fix this issue in the next iteration of the series, and then I'll come back to
> your patches for review and testing.
Sure. Looking forward to reviewing your respin.

Thanks

Eric
> 
> Thanks,
> 
> Alex
> 
> On 8/31/20 8:34 PM, Eric Auger wrote:
>> This series implements tests exercising the Statistical Profiling
>> Extensions.
>>
>> This was tested with associated unmerged kernel [1] and QEMU [2]
>> series.
>>
>> Depending on the comments, I can easily add other tests checking
>> more configs, additional events and testing migration too. I hope
>> this can be useful when respinning both series.
>>
>> All SPE tests can be launched with:
>> ./run_tests.sh -g spe
>> Tests also can be launched individually. For example:
>> ./arm-run arm/spe.flat -append 'spe-buffer'
>>
>> The series can be found at:
>> https://github.com/eauger/kut/tree/spe_rfc
>>
>> References:
>> [1] [PATCH v2 00/18] arm64: KVM: add SPE profiling support
>> [2] [PATCH 0/7] target/arm: Add vSPE support to KVM guest
>>
>> Eric Auger (4):
>>   arm64: Move get_id_aa64dfr0() in processor.h
>>   spe: Probing and Introspection Test
>>   spe: Add profiling buffer test
>>   spe: Test Profiling Buffer Events
>>
>>  arm/Makefile.common       |   1 +
>>  arm/pmu.c                 |   1 -
>>  arm/spe.c                 | 463 ++++++++++++++++++++++++++++++++++++++
>>  arm/unittests.cfg         |  24 ++
>>  lib/arm64/asm/barrier.h   |   1 +
>>  lib/arm64/asm/processor.h |   5 +
>>  6 files changed, 494 insertions(+), 1 deletion(-)
>>  create mode 100644 arm/spe.c
>>
> 


