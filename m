Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB5C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 04:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2507F206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 04:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2507F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iogap-0001Qw-Ek
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 23:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iogY4-0006Ju-Ba
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 23:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iogY1-0002WS-Ug
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 23:32:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:3704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iogY1-0002NY-DB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 23:32:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jan 2020 20:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; d="scan'208";a="217608127"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.239.196.244])
 ([10.239.196.244])
 by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2020 20:32:41 -0800
Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20191217124554.30818-1-chen.zhang@intel.com>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
Date: Tue, 7 Jan 2020 12:32:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217124554.30818-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

No news for a while about this series.

This version already add new docs to address Paolo's comments.

Please give me more comments.


Thanks

Zhang Chen


On 12/17/2019 8:45 PM, Zhang, Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Advanced Watch Dog is an universal monitoring module on VMM side, it can be used
> to detect network down(VMM to guest, VMM to VMM, VMM to another remote server)
> and do previously set operation. Current AWD patch just accept any input as the
> signal to refresh the watchdog timer, and we can also make a certain interactive
> protocol here. For the outputs, user can pre-write some command or some messages
> in the AWD opt-script. We noticed that there is no way for VMM communicate
> directly, maybe some people think we don't need such things(up layer
> software like openstack can handle it). so we engaged with real customer found
> that they need a lightweight and efficient mechanism to solve some practical problems,
>
> For example Edge Computing cases(they think high level software is too heavy
> to use in Edge or it is hard to manage and combine with VM instance).
> It make user have basic VM/Host network monitoring tools and basic false
> tolerance and recovery solution..
>
> Please see the detail documentation in the last patch.
>
> V4:
>   - Add more introduction in qemu-options.hx
>   - Addressed Paolo's comments add docs/awd.txt for the AWD module detail.
>
> V3:
>   - Rebased on Qemu 4.2.0-rc1 code.
>   - Fix commit message issue.
>
> V2:
>   - Addressed Philippe comments add configure selector for AWD.
>
> Initial:
>   - Initial version.
>
>
> Zhang Chen (5):
>    net/awd.c: Introduce Advanced Watch Dog module framework
>    net/awd.c: Initailize input/output chardev
>    net/awd.c: Load advanced watch dog worker thread job
>    vl.c: Make Advanced Watch Dog delayed initialization
>    docs/awd.txt: Add doc to introduce Advanced WatchDog(AWD) module
>
>   configure         |   9 +
>   docs/awd.txt      |  88 +++++++++
>   net/Makefile.objs |   1 +
>   net/awd.c         | 491 ++++++++++++++++++++++++++++++++++++++++++++++
>   qemu-options.hx   |  20 ++
>   vl.c              |   7 +
>   6 files changed, 616 insertions(+)
>   create mode 100644 docs/awd.txt
>   create mode 100644 net/awd.c
>

