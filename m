Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F123DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB3B204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzbPTb46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB3B204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RH4-000270-VA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0REx-0007Ny-PT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0REv-0007hH-Sc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595949001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wajrc5595bXMCOZDYbIG4TGDfIsoetfQTnbdxR5w6Ic=;
 b=MzbPTb46Jycjb+dmMnZZEope/57UgbwlrDfDKTDta07ITuZL0nR3avhHvVMb5LyJ61rCys
 alSJl0LQwC50fckpBj1KUZ/v2VXg6uz5V5ov/0Whb2lFgHuXwvKddu5ME4IxwderQgytj8
 DCUNo6cIuAEfS3gVgAMEYpcVjuGEtns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-EUF4TonRNOWUzThNBJq9bQ-1; Tue, 28 Jul 2020 11:09:59 -0400
X-MC-Unique: EUF4TonRNOWUzThNBJq9bQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F37780046C;
 Tue, 28 Jul 2020 15:09:57 +0000 (UTC)
Received: from [10.36.112.203] (ovpn-112-203.ams2.redhat.com [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A080971901;
 Tue, 28 Jul 2020 15:09:45 +0000 (UTC)
Subject: Re: [PATCH v3 11/11] hw/arm/smmuv3: Advertise SMMUv3.2 range
 invalidation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-12-eric.auger@redhat.com>
 <CAFEAcA-zXyzq5ph3U0vFuqRz9=NEq-piw_9gsYbrwg=+g9nbXw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9d9c93b8-9797-c18e-fc66-7f5bc6ebb0fd@redhat.com>
Date: Tue, 28 Jul 2020 17:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zXyzq5ph3U0vFuqRz9=NEq-piw_9gsYbrwg=+g9nbXw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/10/20 11:47 AM, Peter Maydell wrote:
> On Wed, 8 Jul 2020 at 15:20, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Expose the RIL bit so that the guest driver uses range
>> invalidation. Range invalidation being an SMMU3.2 feature,
>> let AIDR advertise SMMUv3.2 support.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> I think that to advertise SMMUv3.2 we would also need to
> set the IDR3.BBML field to something non-zero. That means
> we need to analyze our implementation of the caching of page
> table structures to see if we need to do anything different
> (per the behaviours and guarantees described in section 3.21.1
> of the spec).
> 
> Alternatively, we could take advantage of the language
> in section 2.5 that says that a v3.x implementation is
> allowed to implement features from v3.(x+1), and just
> set the RIL bit while leaving AIDR advertising us as v3.1.
So I eventually lazily chose this solution. I will address BBML support
in a separate patch series.

Thanks

Eric
> 
> thanks
> -- PMM
> 


