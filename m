Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54794206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54794206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTPw-0005jJ-Eu
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ieTPL-0005EC-5J
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ieTPJ-0000hP-9u
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:29:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:40797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ieTPJ-0000cx-2R
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:29:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 16:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; d="scan'208";a="414256362"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.249.175.127])
 ([10.249.175.127])
 by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2019 16:29:30 -0800
Subject: Re: [PATCH V3 0/4] Introduce Advanced Watch Dog module
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
References: <20191119123016.13740-1-chen.zhang@intel.com>
 <7efe2315-87c3-2b64-2240-087aba389016@intel.com>
 <a0667556-3228-76cc-8e4d-1adf671f4a9e@redhat.com>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <c4a3b0c5-a6bc-2f6c-2fe8-7c25e3b0e378@intel.com>
Date: Tue, 10 Dec 2019 08:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a0667556-3228-76cc-8e4d-1adf671f4a9e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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


On 12/9/2019 5:08 PM, Paolo Bonzini wrote:
> On 08/12/19 18:52, Zhang, Chen wrote:
>> Hi All~
>>
>> No news for a long time.
>>
>> Please give me more comments about this series.
> Sorry, people were probably busy with the QEMU release candidates.
>
> Even before looking at the code, the series is completely missing
> documentation on how to use it and on the chardev protocol.  The
> documentation should go in docs/ and should be written as restructuredText.
>
> The qemu-options.hx patches also lack documentation about the properties
> accepted by the new object.

OK, I will add documentation in docs/ and qemu-options.hx in next version.

For the chardev protocol part, current implementation just use plaintext 
that make AWD easy to connect with other user defined node,  I am not 
very familiar with this part, do you have any suggestions here? maybe 
use some general protocol is better? or Jason have any suggestions?


>
> In particular:
>
>>> -chardev socket,id=h1,host=3.3.3.3,port=9009,server,nowait
>>> -chardev socket,id=heartbeat0,host=3.3.3.3,port=4445
>>> -object iothread,id=iothread2
>>> -object
>>> advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=colo_opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000
> What are the two sockets for, and what should be in colo_opt_script_path?

Anything user want to send when timeout, for example:

If timeout is detected, AWD send quit command to Qemu.

colo_opt_script_path=/tmp/qemu-qmp-quit.script

------------------------------------

qemu-qmp-quit.script:

  { "execute": "quit" }

------------------------------------


Thanks

Zhang Chen

>
>>> In secondary node:
>>>
>>> -monitor tcp::4445,server,nowait
>>> -chardev socket,id=h1,host=3.3.3.3,port=9009,reconnect=1
>>> -chardev socket,id=heart1,host=3.3.3.8,port=4445
>>> -object iothread,id=iothread1
>>> -object
>>> advanced-watchdog,id=heart1,server=off,awd_node=h1,notification_node=heart1,opt_script=colo_secondary_opt_script,iothread=iothread1,timeout=10000
> Same here.
>
> Paolo
>

