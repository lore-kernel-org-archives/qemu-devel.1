Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E774C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D9423401
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D9423401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ohl-0004o4-7B
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i5Ogw-0004DP-Bb
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i5Ogu-00043g-DY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:22:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:27115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1i5Ogu-0003pL-3y; Wed, 04 Sep 2019 02:22:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 23:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="185011380"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.130])
 ([10.239.196.130])
 by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 23:22:40 -0700
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190903175258.GS3694@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <428a67b2-4bf4-b9ab-b06e-f06bc12e721d@intel.com>
Date: Wed, 4 Sep 2019 14:22:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903175258.GS3694@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/2019 1:52 AM, Eduardo Habkost wrote:
> On Mon, Aug 05, 2019 at 03:13:02PM +0800, Tao Xu wrote:
>> Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
>> is expected to be created implicitly.
>>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> 
> This introduces spurious warnings when running qemu-system-ppc64.
> See: https://lore.kernel.org/qemu-devel/CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com/
> 
> To reproduce it, just run 'qemu-system-ppc64 -machine pseries'
> without any -numa arguments.
> 
> I have removed this patch from machine-next so it won't block the
> existing pull request.
> 
I got it. If default splitting of RAM between nodes is
deprecated, this patch can't reuse the splitting code. I agree with 
droping this patch.

