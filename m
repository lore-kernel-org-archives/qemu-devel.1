Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B0B2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrwu-000731-PH
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jyrwB-0006bj-Er
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:16:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:37076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jyrw8-00057U-Na
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:16:11 -0400
IronPort-SDR: qc3qdtaKA+6R1KU4tGQooWtiGeTYoih1/NG6Dy/cca42kEZvo680GUrUsyYok1ZTTFwGIgsyhv
 Vqy6dGn9+pXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138734967"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; d="scan'208";a="138734967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 00:16:00 -0700
IronPort-SDR: yTFHq0AP2LvEY0jZGzquJPvSzAwqNDiMNb3UgpHNiF3emY+orSi8FgfVxnZ832/j3b33zXudZe
 Jndwea6iMA5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; d="scan'208";a="327243559"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.6.132])
 ([10.238.6.132])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2020 00:15:59 -0700
Subject: Re: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
To: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200715025429.28657-1-jingqi.liu@intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <7f5ec393-b145-b41b-ed91-259c916cb76f@intel.com>
Date: Fri, 24 Jul 2020 15:15:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715025429.28657-1-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=jingqi.liu@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 03:16:01
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments.


On 7/15/2020 10:54 AM, Liu, Jingqi wrote:
> At the end of live migration, QEMU uses msync() to flush the data to
> the backend storage. When the backend file is a character device dax,
> the pages explicitly avoid the page cache. It will return failure from msync().
> The following warning is output.
>
>      "warning: qemu_ram_msync: failed to sync memory range“
>
> So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:
>
>      -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G
>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>   docs/nvdimm.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index c2c6e441b3..31048aff5e 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -243,6 +243,13 @@ use the QEMU command line:
>   
>       -object memory-backend-file,id=nv_mem,mem-path=/XXX/yyy,size=4G,pmem=on
>   
> +At the end of live migration, QEMU uses msync() to flush the data to the
> +backend storage. When the backend file is a character device dax, the pages
> +explicitly avoid the page cache. It will return failure from msync().
> +So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:
> +
> +    -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G
> +
>   References
>   ----------
>   

