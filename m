Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA338C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CC02082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CC02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sBi-0000ti-Q4
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0sB2-00009A-DS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0sB1-0008PT-3l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0sB0-0008Om-S4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:51:15 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB4B6C05AA58
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 18:51:12 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w11so3600352wru.17
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOd/0lxhMMncn9/zjbUQcniLrEhUAMubqYae2mPC8tc=;
 b=j23UGOWam9fvbjhC2X7pkBwDifHU9w/ma64MjqroQATu+d9Q9UNFVYZ++M8bH4Nmw5
 kuXLfHsVvv7jsNMWyXPIKYgVqKg0JtZjQeRCgSRtsCdZSXpZaMxh9gMQCtPSL0TdP0dl
 Fs2Dd49qSMPy5U0nmXMm1/RT7mqgdygHcnL5uR+qGZY9UClKIu8kAjhQGTNLk76/cP7N
 roEz6H6EIWV4rWmKALzm10bGMJtm2T+qTIgC4/Pk11M1q675NjXpMgQoEKtBEZJl9nLD
 dAoro8IZNjLaZBNoomVapn79qE7bgiKGwUca5r6xKvje+OXGcEZdYhCDiXp14cCCZTr3
 KWSA==
X-Gm-Message-State: APjAAAXFEj5rWQdR92TJVA2WUdVS9dsifw37RBb06NVYpXLSzh8XFfw+
 g8UUDVO5Q8Bbn5jS+Vzz3/a8DJ2loZRXrqGw3YUmdP4OlkyoY2oChHLoitTKf12F14LFvDyq1aE
 8IdJZMs4qTxSBib4=
X-Received: by 2002:a5d:4211:: with SMTP id n17mr394698wrq.137.1566499871443; 
 Thu, 22 Aug 2019 11:51:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFG9/dg7Jb8nh1cm7+zXyoczy5JK/BtCc0m5iQbr28PXT65RTgIzUZUEcA9fPvDKw7HEdarg==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr394683wrq.137.1566499871145; 
 Thu, 22 Aug 2019 11:51:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id w14sm449363wrl.21.2019.08.22.11.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 11:51:10 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
 <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
 <772d64f7-e153-e9e6-dd69-9f34de5bb577@redhat.com>
 <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c96fc875-ac07-b33c-e752-35cb65fa0e5e@redhat.com>
Date: Thu, 22 Aug 2019 20:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 20:29, Laszlo Ersek wrote:
> On 08/22/19 08:18, Paolo Bonzini wrote:
>> On 21/08/19 22:17, Kinney, Michael D wrote:
>>> DMA protection of memory ranges is a chipset feature. For the current
>>> QEMU implementation, what ranges of memory are guaranteed to be
>>> protected from DMA?  Is it only A/B seg and TSEG?
>>
>> Yes.
> 
> This thread (esp. Jiewen's and Mike's messages) are the first time that
> I've heard about the *existence* of such RAM ranges / the chipset
> feature. :)
> 
> Out of interest (independently of virtualization), how is a general
> purpose OS informed by the firmware, "never try to set up DMA to this
> RAM area"? Is this communicated through ACPI _CRS perhaps?
> 
> ... Ah, almost: ACPI 6.2 specifies _DMA, in "6.2.4 _DMA (Direct Memory
> Access)". It writes,
> 
>     For example, if a platform implements a PCI bus that cannot access
>     all of physical memory, it has a _DMA object under that PCI bus that
>     describes the ranges of physical memory that can be accessed by
>     devices on that bus.
> 
> Sorry about the digression, and also about being late to this thread,
> continually -- I'm primarily following and learning.

It's much simpler: these ranges are not in e820, for example

kernel: BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
kernel: BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved

The ranges are not special-cased in any way by QEMU.  Simply, AB-segs
and TSEG RAM are not part of the address space except when in SMM.
Therefore, DMA to those ranges ends up respectively to low VGA RAM[1]
and to the bit bucket.  When AB-segs are open, for example, DMA to that
area becomes possible.

Paolo

[1] old timers may remember DEF SEG=&HB800: BLOAD "foo.img",0.  It still
works with some disk device models.

