Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5899C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BBC206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BBC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkMv-0006bZ-Qj
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jLk4s-0003XU-2a
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jLk4p-0001c2-BO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:47870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jLk4p-0001Xm-3O
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:23 -0400
IronPort-SDR: d2cb/5tP0CvcIOqrBJ11Bm6FOEBXUEJb7JaYDh5+qrcy+XefKp8gLpp1R09ubKKNFOWJfX3D7p
 XrlxnLxWi5XQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 01:59:15 -0700
IronPort-SDR: WKJFqFOfyFAz/iZefGgNo7+y0kXilaeKRpCwo1seWztHtIOeJF+On3e/90c2QaSwvGrNFZptvy
 59d8WyJNUqBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; d="scan'208";a="251165450"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.4.174])
 ([10.238.4.174])
 by orsmga003.jf.intel.com with ESMTP; 07 Apr 2020 01:59:13 -0700
Subject: Re: [PATCH v2 0/4] modify CPU model info
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200328030625.16428-1-chenyi.qiang@intel.com>
Message-ID: <62803177-01dd-46a1-c2f4-241adf515ecd@intel.com>
Date: Tue, 7 Apr 2020 16:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328030625.16428-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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

Hi Paolo and Eduardo,

ARCH_CAPABILITIES has been added into Icelake-Server CPU model.
What your opinion of the missing feature bits in this patch set?

Thanks
Chenyi

On 3/28/2020 11:06 AM, Chenyi Qiang wrote:
> Add the missing VMX features in Skylake-Server, Cascadelake-Server and
> Icelake-Server CPU models. In Icelake-Server CPU model, it also lacks
> sha_ni, avx512ifma, rdpid and fsrm. The model numbers of Icelake-Client
> and Icelake-Server need to be fixed.
> 
> Changes in v2:
> 	- add missing features as a new version of CPU model
> 	- add the support of FSRM
> 
> Chenyi Qiang (4):
>    target/i386: add missing vmx features for several CPU models
>    target/i386: add fast short REP MOV support
>    target/i386: add the missing features for Icelake-Server CPU model
>    target/i386: modify Icelake-Client and Icelake-Server CPU model number
> 
>   target/i386/cpu.c | 22 ++++++++++++++++++----
>   target/i386/cpu.h |  2 ++
>   2 files changed, 20 insertions(+), 4 deletions(-)
> 

