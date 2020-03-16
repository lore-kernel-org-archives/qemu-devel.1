Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B9C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B9C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDp05-0000Wo-1f
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cathy.zhang@intel.com>) id 1jDo9X-0006i5-Sy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cathy.zhang@intel.com>) id 1jDo9W-0006jC-4N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:43:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:19656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cathy.zhang@intel.com>)
 id 1jDo9S-0005gx-Oa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:43:26 -0400
IronPort-SDR: dc3mJ2Txl8DGff1CoF3YZ1rFIxDu8wJfoitlWg8vjIE3JwpKboshJMQce77fr2Xava+UQe0E1I
 jg46N/9ZINAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 04:43:18 -0700
IronPort-SDR: EiABYRNHEKMltH1YHmSZmtD4LD6EuWsh4veiMbeCVAEJ1wfHX3sE+fcwdr7qzHuUjLfxrMAwtw
 WbXrAwofZsKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; d="scan'208";a="247429353"
Received: from zhangj4-mobl1.ccr.corp.intel.com (HELO [10.249.174.94])
 ([10.249.174.94])
 by orsmga006.jf.intel.com with ESMTP; 16 Mar 2020 04:43:16 -0700
Subject: Re: [PATCH 0/2] Fix Cooperlake CPU model
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
 <759b848d-8261-5997-2e2b-531246bcdf92@intel.com>
 <a972442e-2d29-674b-7ad6-2f056330ed84@redhat.com>
 <d86b7681-8d99-523b-ebb5-d7d388ef4ca5@intel.com>
 <4ef3f6f0-564b-c28e-a783-15af3ba4c927@redhat.com>
From: "Zhang, Cathy" <cathy.zhang@intel.com>
Message-ID: <c4c67eac-d34d-30f2-58a3-6efc70dc7aed@intel.com>
Date: Mon, 16 Mar 2020 19:43:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4ef3f6f0-564b-c28e-a783-15af3ba4c927@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/2020 6:24 PM, Paolo Bonzini wrote:
> On 16/03/20 11:19, Zhang, Cathy wrote:
>> Yes, I see they are already in master, but not in v4.2 yet, so will they
>> be in the next release v5.0?
> Yes, that's what master will become.
>
> Paolo
That's great! Thanks for your response!

