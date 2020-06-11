Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1372C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 03:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07752064C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 03:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07752064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjDnv-0007QE-08
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 23:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jjDnL-0006zn-Lw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 23:22:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:59770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jjDnK-0004G8-1q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 23:22:22 -0400
IronPort-SDR: FyRjYxT5F2+NeBdaUC2OkAN1xyCPLLALW8j6XGM3UHRbTAdGa3r98a85epT35WTWAvEu7gwsIH
 /Q98YjQJ9t4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 20:22:11 -0700
IronPort-SDR: 6q+0nlkG8ReIoGmL2fuHYSRImMtcjf7u5U6h/uBCLp2IO50hGkF3WPSQJw7e9Qvc67dJOcjb/K
 x2wjoSnK9F+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; d="scan'208";a="418967557"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.4.174])
 ([10.238.4.174])
 by orsmga004.jf.intel.com with ESMTP; 10 Jun 2020 20:22:09 -0700
Subject: Re: [PATCH v4 0/5] modify CPU model info
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200520021007.30649-1-chenyi.qiang@intel.com>
Message-ID: <23f42ddb-70b5-dbfc-a355-2455eecd0766@intel.com>
Date: Thu, 11 Jun 2020 11:22:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200520021007.30649-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=chenyi.qiang@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 22:48:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments.
Ignore the last patch("remove Icelake-Client CPU model").
Robert is working on the CPU model deprecation API in
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg03109.html

On 5/20/2020 10:10 AM, Chenyi Qiang wrote:
> Add the missing VMX features in Skylake-Server, Cascadelake-Server and
> Icelake-Server CPU models. In Icelake-Server CPU model, it lacks sha_ni,
> avx512ifma, rdpid and fsrm. The model number of Icelake-Server also needs
> to be fixed.
> Remove the Icelake-Client CPU model due to no Icelake Desktop products
> in the market.
> 
> Changes in v4:
> 	- remove the Icelake-Client CPU model
> 
> Changes in v3:
> 	- change the missing features of Icelake-Server from v3 to v4
> 
> Changes in v2:
> 	- add missing features as a new version of CPU model
> 	- add the support of FSRM
> 	- add New CPUID of FSRM and RDPID in Icelake-Server CPU model
> 
> Chenyi Qiang (5):
>    target/i386: add missing vmx features for several CPU models
>    target/i386: add fast short REP MOV support
>    target/i386: add the missing features for Icelake-Server CPU model
>    target/i386: modify Icelake-Server CPU model number
>    target/i386: remove Icelake-Client CPU model
> 
>   hw/i386/pc.c      |   1 -
>   target/i386/cpu.c | 133 ++++++----------------------------------------
>   target/i386/cpu.h |   2 +
>   3 files changed, 19 insertions(+), 117 deletions(-)
> 

