Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771AC2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F91206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F91206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLzL8-00083g-8S
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 21:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jLzK6-0007Lx-Dl
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 21:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jLzK4-0008LA-NX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 21:16:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:25268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jLzK4-0008J7-ER
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 21:16:08 -0400
IronPort-SDR: sS5ZH1gxCJ1F0OBNJEM5rS8yRAfmVRNAhixFNZw+eDR+d/c6Tp7sbb+kt0kKLlzPiKRLrQ49dY
 TgY4E3PcpVVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 18:16:04 -0700
IronPort-SDR: BtZVysrvB+t6Qu+F6LsKZhrGX1Efu59nsTuMaIJU6K9/eIEyBrpudb21o00qoiAIYIXBNSVOqg
 ZhVD0s3aj4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; d="scan'208";a="452653902"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.4.245])
 ([10.238.4.245])
 by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2020 18:16:03 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <b15709c2-bea7-2717-6833-ac4616b88660@redhat.com>
 <7de3eccb-f0b4-a858-2fc4-addfc7b198aa@oracle.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <6b809ac5-1251-c80e-bbf6-82aa47333c1b@intel.com>
Date: Wed, 8 Apr 2020 09:16:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7de3eccb-f0b4-a858-2fc4-addfc7b198aa@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/2020 11:51 PM, Joao Martins wrote:
> On 4/7/20 3:31 PM, Paolo Bonzini wrote:
>> On 07/04/20 12:59, Joao Martins wrote:
>>> Perhaps, you meant instead:
>>>
>>> 	/sys/dev/char/%d:%d/align
>>>
>>>   ?
>>>
Hi Joao,

In my machine with real NVDIMM, the devdax device is as follows:

$ ll /dev/dax0.0
crw------- 1 root root 250, 6 3月  25 15:16 /dev/dax0.0

$ ls /sys/dev/char/250\:6/align
ls: cannot access '/sys/dev/char/250:6/align': No such file or directory

$ ls /sys/dev/char/250\:6/device/align

/sys/dev/char/250:6/device/align

So:
The file of "/sys/dev/char/%d:%d/align" does not exist.
It should be "/sys/dev/char/%d:%d/device/align".

Anyone has a real NVDIMM can help double check. Thanks.

Hi Dan,

You may have a real NVDIMM, in what directory is the 'align' file ?

Thanks,

Jingqi

>> So it works with that change?
> Yeah.
>
> 	Joao

