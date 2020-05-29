Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078652073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bi3iZMPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078652073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejHX-0000ki-87
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 13:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jejGq-00086Q-Pt
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:58:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jejGo-00046k-Mk
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:58:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ed14d280001>; Fri, 29 May 2020 10:58:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 29 May 2020 10:58:12 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 29 May 2020 10:58:12 -0700
Received: from [10.40.100.117] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 17:57:57 +0000
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
To: Alex Williamson <alex.williamson@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home> <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
 <20200526141939.2632f100@x1.home> <20200527062358.GD19560@joy-OptiPlex-7040>
 <20200527084822.GC3001@work-vm> <20200528165906.7d03f689@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <b6d78fd3-d2d7-91c9-5f5d-a76ebe5a7a5e@nvidia.com>
Date: Fri, 29 May 2020 23:27:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528165906.7d03f689@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590775080; bh=9rTtu3kf9bEqSZ338TiGiLKhOLfMIwfqgDH96m+5MN0=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Bi3iZMPRJkmpjpq4uCCp3csVA1rvg7ZAooXAbf73Z5wpp6GqG5UlV+dgG5faUiSJK
 /yJWHLGfqUOR7J0AB+ts4MWUeVF2yyzyB5c5eNsswzJ/9aBbgif4+VdnQlymTNaQli
 SToQlEnwJHQ9t5iGeOm5l9m3BRx2Yskol1AOY57tt7H7iXnVtk1MXGtk2aSnr3rSCg
 lgCxbsxLxyPPDr4A4xchIphUrNM0jelpn536XpUgSs+r84gS79kC3WcRKLsLlRfZrl
 VhwQexmuvf8rKvmy1F5NQM2xjVp+fLAtezFTrlMGGMjKVm6ZgpJC7XhLy9IlxIQxQR
 IR6TwBLCqeyqA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 13:58:12
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 Yan Zhao <yan.y.zhao@intel.com>, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/29/2020 4:29 AM, Alex Williamson wrote:
> On Wed, 27 May 2020 09:48:22 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * Yan Zhao (yan.y.zhao@intel.com) wrote:
>>> BTW, for viommu, the downtime data is as below. under the same network
>>> condition and guest memory size, and no running dirty data/memory produced
>>> by device.
>>> (1) viommu off
>>> single-round dirty query: downtime ~100ms
>>
>> Fine.
>>
>>> (2) viommu on
>>> single-round dirty query: downtime 58s
>>
>> Youch.
> 
> Double Youch!  But we believe this is because we're getting the dirty
> bitmap one IOMMU leaf page at a time, right?  We've enable the kernel
> to get a dirty bitmap across multiple mappings, but QEMU isn't yet
> taking advantage of it.  Do I have this correct?  Thanks,
> 

That's correct.

Thanks,
Kirti

