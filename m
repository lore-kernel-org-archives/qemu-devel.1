Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73776C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4F5207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4F5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKF8-0006Xv-GD
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jbKDh-0004Cl-BW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:36:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:62091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jbKDf-0005bx-Fk
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:36:56 -0400
IronPort-SDR: 6wYyuc4TvJfMdy5Hum6OCs+Pof7FYbjsIsQmGdQevrwwcdrBM4E5vML5WwKwc0Ivy1+Bh5zcpI
 BM+DYs7gu8lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 01:36:45 -0700
IronPort-SDR: mPAufXk1q5jy0ZWohpYK7Zozy98521t47WiGJgsQhBrCZVZOtrd5SEK7/4yFeShfhtji+7f4JS
 ovMx6vsnAaYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; d="scan'208";a="264605784"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.238.4.118])
 ([10.238.4.118])
 by orsmga003.jf.intel.com with ESMTP; 20 May 2020 01:36:43 -0700
Subject: Re: Migration with ``drive-mirror`` + NBD will let quorum qcow2 image
 become larger
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
References: <3b1bbe79-088c-2e65-178f-074ac0f72ec6@intel.com>
 <20200519091544.GD7652@linux.fritz.box>
 <w51blmknfnr.fsf@maestria.local.igalia.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <d0e85184-2732-bba5-883a-98cf92d9c7e4@intel.com>
Date: Wed, 20 May 2020 16:36:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <w51blmknfnr.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=tao3.xu@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:36:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/2020 10:49 PM, Alberto Garcia wrote:
> On Tue 19 May 2020 11:15:44 AM CEST, Kevin Wolf wrote:
>> But maybe it could return a limited set of flags at least so that the
>> mirror job can get the BDRV_BLOCK_ZERO information if the quorum
>> children agree on it.
> 
> Yeah, maybe it is possible to implement a conservative version of that
> function and fall back to BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED (or
> something like that) in the cases where there's no clear alternative.
> 
> Berto
> 

Thank you Kevin and Berto for your suggestion.

