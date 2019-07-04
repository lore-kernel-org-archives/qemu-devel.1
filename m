Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE1C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF742085A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF742085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2Me-00066n-GX
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hj2Lk-0005Vh-K2
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hj2Lj-0001mE-Lj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:04:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hj2Lj-0001li-GD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:04:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id u18so6805248wru.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 07:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LWRY2c2Ebwp1DWQNoCI/IhdNoK09xtQDnLOORpqUBvo=;
 b=QotDIxYl5/CvkNducCamJCLqb0/UDAKmxB9LFeP3WPsLOOFOrQUuoEdvJSeDX5ivZL
 Oea1G3shBbwIUw8QjulQbjCkUqFPD8us8jvNjlnWBZIuTvPuY5ijU5g8g57rK0XSFn71
 utq1rRVkZeouIivON+XnWVs0VT8ajIGCdhCEDEMhwwZ4UNDsLLsve51XPba7mKpGuvDp
 a31aI9TlhKDMxsRVgM43C/KZ/+WZkPgbdEuRtVA6TeW1JcegyDgWYlKsoIkLIcolmgOw
 6qlRn2V7Qmf9up7GKifaB2TorlZX7q+Z3m6VEWdp8X2tKXcZfCPU8DQRbygjRND1adMq
 DsGg==
X-Gm-Message-State: APjAAAXMw0ibHFxrF1TlvFjeziawzhB5UlT8pLYmwREf73WTXWsrgNWG
 5hfxij6K/qihFyqH7y1k/n6/Ow==
X-Google-Smtp-Source: APXvYqxuJh1pVYF9AnGCW0HYEIXGBcSMrusEqNZXWIxGvhT4h/ouQW/HVFjnX6t3UElMfpg0/TxJNw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr18184107wrn.52.1562249074477; 
 Thu, 04 Jul 2019 07:04:34 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id s2sm3682553wmj.33.2019.07.04.07.04.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 07:04:33 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <41536801-f8ac-b3c6-a74a-4a7ead43695f@redhat.com>
 <20190704135550.x75fdmzezl3be5xk@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb96921e-f751-a6e4-6e2f-5aaefa38ba6a@redhat.com>
Date: Thu, 4 Jul 2019 16:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704135550.x75fdmzezl3be5xk@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] hw/display/vga: Why architecture specific code?
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 15:55, Gerd Hoffmann wrote:
> On Thu, Jul 04, 2019 at 03:27:25PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Gerd,
>>
>> I'm looking at:
>>
>> static const MemoryRegionPortio vbe_portio_list[] = {
>>     { 0, 1, 2, .read = vbe_ioport_read_index, .write =
>> vbe_ioport_write_index },
>> # ifdef TARGET_I386
>>     { 1, 1, 2, .read = vbe_ioport_read_data, .write =
>> vbe_ioport_write_data },
>> # endif
>>     { 2, 1, 2, .read = vbe_ioport_read_data, .write =
>> vbe_ioport_write_data },
>>     PORTIO_END_OF_LIST(),
>> };
> 
> Unaligned 16bit ioport access works on x86 only.

But I'm not sure that it needs to be target-dependent now.  Worst case
you'd have a dead MemoryRegion.

Paolo

