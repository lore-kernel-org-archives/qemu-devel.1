Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB6BC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A6424692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5w0DS8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A6424692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JLH-0002CG-Pf
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7JKL-0001Sn-Rq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7JKK-0008Pb-R5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:35:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7JKK-0008PD-Nf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582810544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCEUskl4uu1OGcqBGj7gYZfwAshd8p11GbZWLvHd+/A=;
 b=V5w0DS8PV2/kiiZmVtBZY8ISidKCCOjqRMjJocjWVqDO0ZC3vSvXmaYlwUE/7GmauBrozQ
 e+MEfewx817WWDlpGDuLCJYbOegg7E9vubrodwdY+xCODJnRhcFR3VuAySN5nVWqDWF8tZ
 CzUAyWtsYdj2SbRp2pmiM2QwocXzJ88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-O6FZ-hPQMl-e9yju43O01A-1; Thu, 27 Feb 2020 08:35:42 -0500
X-MC-Unique: O6FZ-hPQMl-e9yju43O01A-1
Received: by mail-wm1-f69.google.com with SMTP id f207so1008308wme.6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lCEUskl4uu1OGcqBGj7gYZfwAshd8p11GbZWLvHd+/A=;
 b=eeR2fOz3q+Xg/11Dmj46iG90KIJapGaRanqy7pF+HTH1PnHoN7Qi3QdlP5RBNHJx5R
 Nkc67QbHSPNjPAIK5unudncbnHmte18wsK4rmVgiRFhmqUxbOQi8guSpOgp9xwfdYH9V
 vUuncltrGST59xJmrVKV5p7hk5JunIWQjJ+R37JAuKlBGYs7Q2QRXqkjivdJeHwMGCh5
 RaMBpLtEaQTa0FWzfz3RAUuOkM2IGBs2p4bpDZlZ+2Qq7Qr09k3gzTWx/87c3L2030bo
 iFftxy2Hi5JmLzBfl9W+N6aiiOq5TE6pXVdAEIyEQGaPp8GULxkFbQobsn+M1j2u5Pla
 ug+w==
X-Gm-Message-State: APjAAAWCwsxJyvucqJVjR25zPQF5qeFpZ83j3u/Ju9eB8hpKISRFavDU
 gBaFF70UIjQUDq87a//DF6w9rOXXDFgWWys8fqBuWe0yEIuvyxTuhRg3fI4/jqRtZ5Trm9RpUbw
 r9dRmWwidb1W7/nw=
X-Received: by 2002:adf:f611:: with SMTP id t17mr5273785wrp.38.1582810541071; 
 Thu, 27 Feb 2020 05:35:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwu+9r1xFlVe+XfV1q2MtPpC7sjBRVg0SNeCa+gOQXUbMRZ0qyrn9SxnEfAgeldof7BKTLnrg==
X-Received: by 2002:adf:f611:: with SMTP id t17mr5273771wrp.38.1582810540829; 
 Thu, 27 Feb 2020 05:35:40 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a9sm8595625wrn.3.2020.02.27.05.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:35:40 -0800 (PST)
Subject: Re: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Peter Maydell <peter.maydell@linaro.org>,
 Stephanos Ioannidis <root@stephanos.io>
References: <20200227112617.66044-1-root@stephanos.io>
 <20200227112617.66044-2-root@stephanos.io>
 <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
Date: Thu, 27 Feb 2020 14:35:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:13 PM, Peter Maydell wrote:
> On Thu, 27 Feb 2020 at 11:27, Stephanos Ioannidis <root@stephanos.io> wrote:
>>
>> The ARMv7-M CPU reset handler, which loads the initial SP and PC
>> register values from the vector table, is currently executed before
>> the ROM reset handler (rom_reset), and this causes the devices that
>> alias low memory region (e.g. STM32F405 that aliases the flash memory
>> located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
>> the kernel image is linked to be loaded at the high memory address.
>>
>> For instance, it is norm for the STM32F405 firmware ELF image to have
>> the text and rodata sections linked at 0x8000000, as this facilitates
>> proper image loading by the firmware burning utility, and the processor
>> can execute in place from the high flash memory address region as well.
>>
>> In order to resolve this issue, this commit downgrades the ARMCPU reset
>> handler invocation priority level to -1 such that it is always executed
>> after the ROM reset handler, which has a priority level of 0.
> 
> 
> I think we should be able to do this with the new 3-phase
> reset API : the rom loader reset should happen in phase 2,
> and the Arm CPU should only load the new PC and SP in
> phase 3. It's on my todo list to write some code for this
> to see if this theory works out.
> 
> I'd prefer it if we do it that way, or alternatively find
> out for certain that that approach does not work, before
> we add a reset-priority concept to the reset APIs.

Agreed.

> 
> (In particular, this use of qemu_register_reset to arrange for
> the CPU to be reset should ideally go away in favour of having
> the CPU reset handled by the SoC which owns the CPU, so it's
> not a good long-term way to look at trying to fix ordering issues.)

It would be nice to get ride of qemu_register_reset with the reset API :)

> 
> thanks
> -- PMM
> 


