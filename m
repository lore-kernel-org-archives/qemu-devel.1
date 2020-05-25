Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB5CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E132068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E132068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdJ55-0005Wz-Df
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 15:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jdJ3n-0004ki-0J
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:46:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:39543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jdJ3l-0000ac-CB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:46:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97BC1405BE;
 Mon, 25 May 2020 22:46:40 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 76DB383;
 Mon, 25 May 2020 22:46:40 +0300 (MSK)
Subject: Re: -nic model=rocker causes qemu to abort
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <eafa7c11-b3af-2247-ddb3-538891ad0732@msgid.tls.msk.ru>
 <1f540f9c-45f3-d02e-a087-d1059d7a8977@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a06c7d1b-5d69-0ce0-1cf1-ea9d39cac02c@msgid.tls.msk.ru>
Date: Mon, 25 May 2020 22:46:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1f540f9c-45f3-d02e-a087-d1059d7a8977@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_HI=-5 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.05.2020 21:45, Thomas Huth wrote:
> On 29/04/2020 18.43, Michael Tokarev wrote:
>> Hi!
>>
>> Just a fun case of (invalid) usage of qemu-system command line.
>> Someone tried -nic model=rocker, and qemu does this:
>>
>>  Unexpected error in object_property_find() at /build/qemu/git/qom/object.c:1029:
>>  qemu-system-x86_64: Property '.mac' not found
>>  Aborted
>>
>> This happens after this commit:
>>
>> commit 52310c3fa7dc854dd2376ae8a518141abcdb78f3
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Fri Mar 2 10:30:50 2018 +0100
>>
>>     net: allow using any PCI NICs in -net or -nic
>>
>> Previously rocker rightly wasn't usable as a nic model,
>> and after this commit it is now possible.
>>
>> While I agree this is invalid usage, perhaps qemu should not
>> abort like this?  Maybe it should check the required property
>> too, before allowing this device to be a nic model?
> 
> QEMU theoretically should never abort() - abort() means there is
> something wrong in the code ... so we should definitely fix this by
> other means. Some questions:
> 
> 1) How is that rocker device normally used? Similar to a normal network
> card? Or completely different?

Nope, this is not a network card, it is a network SWITCH, used as a
regular PCI device, not network-specific. Hence the problem at hand, -
before the patch this device weren't "nic-able", so to say, because
while it is network-related PCI device, it is not a NIC.

I guess while building a list of "nic-able" cards, we should skip some
"nic-alike" devices and use some more specific criteria. Not everything
which is network-related is a regular NIC.

Maybe in time some other devices will appear in qemu with similar effect
which will require another condition.

Or adding a new field into the pci structure to indicate this device
can be a NIC will solve it once for all. Or just reverting the patch :) -
after all it isn't that bad to have a list of NIC-able devices outside
of the device definitions, - we don't have tons of devices anyway where
maintaining such a list outside of device model is a problem.

Thanks,

/mjt

> 2) In case it is similar to a normal network card, would it make sense
> to allow it with -nic or -net, too? Or should we simply disallow it
> here? I think we could either use a list of devices that should never be
> allowed here, or we check for the availability of that "mac" property...
> 
>  Thomas
> 


