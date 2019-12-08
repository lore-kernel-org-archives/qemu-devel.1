Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C8C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 17:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41AB205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 17:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41AB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie0mo-0006i7-TZ
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 12:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ie0jp-0005ba-CU
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ie0jn-0008RN-E9
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:52:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:58816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ie0jn-0007yz-3v
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:52:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Dec 2019 09:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,292,1571727600"; d="scan'208";a="413857926"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.249.175.127])
 ([10.249.175.127])
 by fmsmga006.fm.intel.com with ESMTP; 08 Dec 2019 09:52:34 -0800
Subject: Re: [PATCH V3 0/4] Introduce Advanced Watch Dog module
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
References: <20191119123016.13740-1-chen.zhang@intel.com>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <7efe2315-87c3-2b64-2240-087aba389016@intel.com>
Date: Mon, 9 Dec 2019 01:52:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191119123016.13740-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All~

No news for a long time.

Please give me more comments about this series.


Thanks

Zhang Chen

On 11/19/2019 8:30 PM, Zhang, Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Advanced Watch Dog is an universal monitoring module on VMM side, it can be used to detect network down(VMM to guest, VMM to VMM, VMM to another remote server) and do previously set operation. Current AWD patch just accept any input as the signal to refresh the watchdog timer,
> and we can also make a certain interactive protocol here. For the output user can pre-write
> some command or some messages in the AWD opt-script. We noticed that there is no way
> for VMM communicate directly, maybe some people think we don't need such things(up layer
> software like openstack can handle it). But we engaged with real customer found that in some cases,they need a lightweight and efficient mechanism to solve some practical problems(openstack is too heavy).
> for example: When it detects lost connection with the paired node,it will send message to admin, notify another VMM, send qmp command to qemu do some operation like restart the VM, build VMM heartbeat system, etc.
> It make user have basic VM/Host network monitoring tools and basic false tolerance and recovery solution.
>
> Demo usage(for COLO heartbeat service):
>
> In primary node:
>
> -chardev socket,id=h1,host=3.3.3.3,port=9009,server,nowait
> -chardev socket,id=heartbeat0,host=3.3.3.3,port=4445
> -object iothread,id=iothread2
> -object advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=colo_opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000
>
> In secondary node:
>
> -monitor tcp::4445,server,nowait
> -chardev socket,id=h1,host=3.3.3.3,port=9009,reconnect=1
> -chardev socket,id=heart1,host=3.3.3.8,port=4445
> -object iothread,id=iothread1
> -object advanced-watchdog,id=heart1,server=off,awd_node=h1,notification_node=heart1,opt_script=colo_secondary_opt_script,iothread=iothread1,timeout=10000
>
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
> Zhang Chen (4):
>    net/awd.c: Introduce Advanced Watch Dog module framework
>    net/awd.c: Initailize input/output chardev
>    net/awd.c: Load advanced watch dog worker thread job
>    vl.c: Make Advanced Watch Dog delayed initialization
>
>   configure         |   9 +
>   net/Makefile.objs |   1 +
>   net/awd.c         | 491 ++++++++++++++++++++++++++++++++++++++++++++++
>   qemu-options.hx   |   6 +
>   vl.c              |   7 +
>   5 files changed, 514 insertions(+)
>   create mode 100644 net/awd.c
>

