Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B231C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139E12065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139E12065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzTK-0004nC-AN
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1juzGQ-0007AD-FB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:17:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:39765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1juzGN-0007Mq-Px
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:17:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 873E640478;
 Mon, 13 Jul 2020 17:16:56 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8BA20AE;
 Mon, 13 Jul 2020 17:16:56 +0300 (MSK)
Subject: Re: [PATCH] Allow acpi-tmr size=2
To: "Michael S. Tsirkin" <mst@redhat.com>, Simon John <git@the-jedi.co.uk>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
 <7662bc2c-d958-731a-0882-62c5ab47c7a4@the-jedi.co.uk>
 <20200713081627-mutt-send-email-mst@kernel.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <34d24b3a-75ec-ad94-c61b-2ebe4a0f277a@msgid.tls.msk.ru>
Date: Mon, 13 Jul 2020 17:16:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713081627-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 10:16:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.07.2020 15:17, Michael S. Tsirkin пишет:
> On Mon, Jul 13, 2020 at 12:46:00PM +0100, Simon John wrote:
>> I don't profess to understand most of this, I am just a user who found
>> something didn't work and tracked down the cause with help from the people
>> on the bugtracker.
>>
>> the min=1 and max=4 was chosen as it seems to be set that way in most other
>> places in the source, and 2 fits in that range.
>>
>> so as macos seems to require 2 bytes but spec says 4 (32 bits) would it be
>> better to set min=2 max=4, given that the original revert seems to be a
>> security fix?

It's not about the security fix, it's about the piece in qemu code which
behaved wrongly for several years, which finally started to actually work.

>> this works equally well:
>>
>> static const MemoryRegionOps acpi_pm_tmr_ops = {
>>     .read = acpi_pm_tmr_read,
>>     .write = acpi_pm_tmr_write,
>>     .valid.min_access_size = 2,
>>     .valid.max_access_size = 4,
>>     .endianness = DEVICE_LITTLE_ENDIAN,
>> };
>>
>> regards.
>>
> 
> Sounds good. And how about also adding:

What this call will receive on a real HW? returning the same 4 bytes
even when asked for 2 smells wrong, no?

>       .impl.min_access_size = 4,

What does it mean? :)

/mjt

