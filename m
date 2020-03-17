Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E2EC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392F920674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392F920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE81A-0004QP-Eg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1jE80O-0003vx-Pg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1jE80N-0003BK-44
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:55:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:64139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1jE80M-0002Lr-QL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:55:19 -0400
IronPort-SDR: rFliY/Y+Sk1i87aWN6vw9sAXpGME3Xy1VWUFvcUhuIODDqCB/wwu7mWfxGdSgJPQzFamq5drsT
 GWWl1BOXCZhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 01:55:14 -0700
IronPort-SDR: ZTnAPo6wvnA4Yo89kkAKT/aCslMd5FSd7jttqw+YuvVIn+LrNXCBxQqhaN9UdY611TcHV4v9pi
 d4YUnja+EySg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267893087"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.52])
 ([10.239.160.52])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 01:55:13 -0700
Subject: Re: [PULL 09/61] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
 <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
 <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
 <bc354cda-b731-183f-3860-43c3a0af434c@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <41756673-bbd4-593f-ade8-3232db8b512e@intel.com>
Date: Tue, 17 Mar 2020 16:55:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bc354cda-b731-183f-3860-43c3a0af434c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Reply-To: Colin.Xu@intel.com
Cc: Wenchao Wang <wenchao.wang@intel.com>, Hang Yuan <hang.yuan@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-03-17 16:26, Paolo Bonzini wrote:
> On 17/03/20 08:46, Colin Xu wrote:
>> Hi Paolo,
>>
>> For future HAX patch, once it's "Reviewed-by" haxm maintainers and other
>> reviewers, do we need "SubmitAPullRequest" separately or you will do it
>> together with other patches?
> As you prefer.  I wouldn't mind having to send fewer pull requests. :)
>
> Paolo

Would you mind continue help HAX send pull request? It feels like easier 
to track the changes when stay together with other accelerator patches. 
We'll regularly check the reviewed patches and do necessary tests, and 
send you a list of patches that can be queued for next pull.

What do you think?

Colin

-- 
Best Regards,
Colin Xu


