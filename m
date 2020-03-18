Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C142C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5212076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5212076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETfj-0008S5-V6
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jETf3-0007xy-I7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jETf1-00024a-T6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:02:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:38562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jETf1-0001t4-LP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:02:43 -0400
IronPort-SDR: iPczoqVhx/esjWDVSRlVvyPNHgzTZ949AHEe1WMNOfTatkYo8QFFcNU4PTSraovdvuRPkfc09K
 4ziXyZ+rixCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 01:02:37 -0700
IronPort-SDR: POgG4qM+iddGaXz2bAg6CNW/f4UPFrP5J9sAjQGroJXFAK26AVKVrNul8V5IOFLNKBYSPuMg0G
 EMRWFhe5iPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="248092643"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.4.174])
 ([10.238.4.174])
 by orsmga006.jf.intel.com with ESMTP; 18 Mar 2020 01:02:36 -0700
Subject: Re: [PATCH 0/3] Fix Skylake, Cascadelake and Icelake Server CPU models
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <20200227090808.17686-1-chenyi.qiang@intel.com>
Message-ID: <03fb4682-8430-c792-028b-54f859da3dcb@intel.com>
Date: Wed, 18 Mar 2020 16:02:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200227090808.17686-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

On 2/27/2020 5:08 PM, Chenyi Qiang wrote:
> Current Skylake-Server, Cascadelake-Server and Icelake-Server CPU models
> lack several VMX features. Icelake-Server also lacks two features in
> FEAT_7_0_EBX. In addition, The model numbers of Icelake-Client and
> Icelake-Server need to be fixed.
> 
> Chenyi Qiang (3):
>    target/i386: add missing vmx features for several CPU models
>    target/i386: add two missing features for Icelake-Server CPU model
>    target/i386: modify Icelake-Client and Icelake-Server CPU model number
> 
>   target/i386/cpu.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 

