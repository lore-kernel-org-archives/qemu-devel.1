Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0427C10F28
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B7B20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBEn1-0006ys-EX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jBEls-0006aA-5L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jBElq-0006Gy-3P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:32:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:63219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jBElp-0006CM-RS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:32:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 02:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; d="scan'208";a="276446858"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.255.29.176])
 ([10.255.29.176])
 by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2020 02:32:12 -0700
Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
 <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
 <3049425105b94f6cb9cd846c84c95a84@intel.com>
 <783bac16-0e4d-f027-3e4a-b6fff500c244@redhat.com>
 <c6564993-ec06-7fe1-137d-956f3d554e74@intel.com>
 <679426098de74479a19c2287c68785c4@intel.com>
 <029efd6f-f461-da09-c6b6-1acf67818b64@redhat.com>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <c16e2cda-a498-4913-2811-6c6ea6b0b0df@intel.com>
Date: Mon, 9 Mar 2020 17:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <029efd6f-f461-da09-c6b6-1acf67818b64@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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


On 3/4/2020 9:37 PM, Paolo Bonzini wrote:
> On 04/03/20 09:06, Zhang, Chen wrote:
>>> Hi Eric and Paolo, Can you give some comments about this series?
>>>
>>>
>> No news for a while...
>> We already have some users(Cloud Service Provider) try to use is module in their product.
>> But they also need to follow the Qemu upstream code.
> My main comment about this series is that it's not clear why it is
> needed and how to use it.  The documentation includes a demo, but no
> description of what is an awd_node, a notification_node and an
> opt_script.  I can more or less understand the notification_node and
> opt_script role from the documentation, but not entirely because, for
> example, the two-host demo has hardcoded IP addresses without saying
> which host is which IP address.

Hi Paolo,

Sorry for slow reply and thank you for your comments.

Let me summarize your main opinions and methods:

1. Why AWD is needed.

Advanced Watch Dog is an universal monitoring module on VMM side, it can 
be used to detect network down(VMM to guest, VMM to VMM, VMM to another 
remote server) and do previously set operation. Current AWD patch just 
accept any input as the signal to refresh the watchdog timer, and we can 
also make a certain interactive protocol here. For the outputs, user can 
pre-write some command or some messages in the AWD opt-script. We 
noticed that there is no way for VMM communicate directly, maybe some 
people think we don't need such things(up layer software like openstack 
can handle it). so we engaged with real customer found that they need a 
lightweight and efficient mechanism to solve some practical problems,

For example Edge Computing cases(they think high level software is too 
heavy to use in Edge or it is hard to manage and combine with VM instance).
It make user have basic VM/Host network monitoring tools and basic false 
tolerance and recovery solution.

For COLO FT/HA solution, we already have some CSPs try to use AWD with COLO.

2. Documentation issues, include how to use it.

I will address all your comments and complete details about documentation.

3. Communication protocol issue.

Current AWD without any protocol, any data it gets will be considered a 
heartbeat signal.

I think use QMP format is good for me.

4. Implementation issue.

The AWD script as an optional feature is OK for me.

And report the triggering of the watchdog via QMP events is enough for 
current usage.

But it looks have limitation to notify outside Qemu. I don't know which 
is better choice.

If the QMP events solution is better, I will fix it in next version.


I don't know if I understand your means correctly.

Please give me more guidance on this series.  :-)

Thanks

Zhang Chen


>
> The documentation does not describe the protocol, which is absolutely
> necessary, and does not describe _why_ the protocol was designed like
> that.  Without such documentation it's not clear if, for example, the
> watchdog protocol could be implemented as QMP commands (e.g.
> start-watchdog, stop-watchdog, notify-watchdog).  Another possibility
> could be to use the systemd watchdog protocol, which consists of
> essentially three commands (WATCHDOG=1, WATCHDOG=trigger,
> WATCHDOG_USEC=...) which are transmitted as datagrams.  Documentation is
> important for reviewers to judge the merits of the protocol without (or
> before) diving into the code.
>
> In the demo, the opt_script mechanism is currently using the "human"
> monitor as opposed to QMP.  The human monitor interface is not stable
> and not meant for consumption by management interface.  It is not clear
> if this is just a sample usage, and in practice the notification_node
> would be outside of QEMU, or not.  In general I would prefer to have the
> script as an optional feature, and report the triggering of the watchdog
> via QMP events.
>
> Paolo
>

