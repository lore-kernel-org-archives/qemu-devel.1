Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E52C11D41
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 01:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FA121D56
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 01:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FA121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4aoZ-0006j3-Sn
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 20:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j4ans-0006D8-5x
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 20:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j4anq-0005W0-Qo
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 20:39:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:30456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j4ann-0005RZ-Mk; Wed, 19 Feb 2020 20:38:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 17:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; d="scan'208";a="224693885"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.255.31.29])
 ([10.255.31.29])
 by orsmga007.jf.intel.com with ESMTP; 19 Feb 2020 17:38:44 -0800
Subject: Re: [PATCH v7 0/4] colo: Add support for continuous replication
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel <qemu-devel@nongnu.org>
References: <cover.1571925699.git.lukasstraub2@web.de>
 <20191113173559.0713c27d@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D7806309C8C@shsmsx102.ccr.corp.intel.com>
 <049fdd65-c654-f619-4de1-5a3fe0a2ad5b@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780630AB3E@shsmsx102.ccr.corp.intel.com>
Message-ID: <f105e19b-6f1d-a539-459d-076a031b86b8@intel.com>
Date: Thu, 20 Feb 2020 09:38:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780630AB3E@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

I noticed this series can't be merged or queued, do you met some problem 
about it?


Thanks

Zhang Chen


>>>> Max Reitz <mreitz@redhat.com>; qemu-block <qemu-block@nongnu.org>
>>>> Subject: Re: [PATCH v7 0/4] colo: Add support for continuous
>>>> replication
>>>>
>>>> On Fri, 25 Oct 2019 19:06:31 +0200
>>>> Lukas Straub <lukasstraub2@web.de> wrote:
>>>>
>>>>> Hello Everyone,
>>>>> These Patches add support for continuous replication to colo. This
>>>>> means that after the Primary fails and the Secondary did a failover,
>>>>> the Secondary can then become Primary and resume replication to a
>>>>> new
>>>> Secondary.
>>>>> Regards,
>>>>> Lukas Straub
>>>>>
>>>>> v7:
>>>>>    - clarify meaning of ip's in documentation and note that active and
>> hidden
>>>>>      images just need to be created once
>>>>>    - reverted removal of bdrv_is_root_node(top_bs) in replication and
>>>> adjusted
>>>>>      the top-id= parameter in documentation acordingly
>>>>>
>>>>> v6:
>>>>>    - documented the position= and insert= options
>>>>>    - renamed replication test
>>>>>    - clarified documentation by using different ip's for primary and
>>>>> secondary
>>>>>    - added Reviewed-by tags
>>>>>
>>>>> v5:
>>>>>    - change syntax for the position= parameter
>>>>>    - fix spelling mistake
>>>>>
>>>>> v4:
>>>>>    - fix checkpatch.pl warnings
>>>>>
>>>>> v3:
>>>>>    - add test for replication changes
>>>>>    - check if the filter to be inserted before/behind belongs to the
>>>>> same interface
>>>>>    - fix the error message for the position= parameter
>>>>>    - rename term "after" -> "behind" and variable "insert_before" ->
>>>> "insert_before_flag"
>>>>>    - document the quorum node on the secondary side
>>>>>    - simplify quorum parameters in documentation
>>>>>    - remove trailing spaces in documentation
>>>>>    - clarify the testing procedure in documentation
>>>>>
>>>>> v2:
>>>>>    - fix email formating
>>>>>    - fix checkpatch.pl warnings
>>>>>    - fix patchew error
>>>>>    - clearer commit messages
>>>>>
>>>>>
>>>>> Lukas Straub (4):
>>>>>     block/replication.c: Ignore requests after failover
>>>>>     tests/test-replication.c: Add test for for secondary node continuing
>>>>>       replication
>>>>>     net/filter.c: Add Options to insert filters anywhere in the filter
>>>>>       list
>>>>>     colo: Update Documentation for continuous replication
>>>>>
>>>>>    block/replication.c        |  35 +++++-
>>>>>    docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++---------
>> -
>>>>>    docs/block-replication.txt |  28 +++--
>>>>>    include/net/filter.h       |   2 +
>>>>>    net/filter.c               |  92 ++++++++++++++-
>>>>>    qemu-options.hx            |  31 ++++-
>>>>>    tests/test-replication.c   |  52 +++++++++
>>>>>    7 files changed, 389 insertions(+), 75 deletions(-)
>>>>>
>>>> Hello Everyone,
>>>> So I guess this is ready for merging or will that have to wait until
>>>> the 4.2 release is done?
>>> Due to Qemu 4.2 release schedule, after soft feature freeze(Oct29) the
>> master branch does not accept feature changes.
>>> But I don't know if sub-maintainer(block or net) can queue this series first
>> then merge it after 4.2 release?
>>> Thanks
>>> Zhang Chen
>>
>> Will try to queue this series.
> Thank you Jason~
>
> Thanks
> Zhang Chen
>
>> Thanks
>>
>>
>>>> Regards,
>>>> Lukas Straub

