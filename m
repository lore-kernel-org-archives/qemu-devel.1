Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1526F21D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnhhYErL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526F21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6GG-000140-4Q
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX65i-00048K-7R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX65g-0007rV-9F
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603732525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIbkRPojou0/9NMHW1B/ur67WVggS3hynEBJUA7QjQw=;
 b=WnhhYErLNOT+dPmxhlcSlxbQM7AnY/QKpDUD9wBLuayBVj/odLkVbiYPFawh6a74YTimFI
 5sIS/zojnDUeBSZENP+LAGrpTZbWhgHg4Cr46EHTJu7+B/9+qWNxTs9yphMDGLGbuO8qjp
 817in+Jzbbo5n36Gu6WwA+JnOW4b7i8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-t8u9WbPAM-qD1IAefka0kA-1; Mon, 26 Oct 2020 13:15:23 -0400
X-MC-Unique: t8u9WbPAM-qD1IAefka0kA-1
Received: by mail-wm1-f71.google.com with SMTP id o15so6856952wmh.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nIbkRPojou0/9NMHW1B/ur67WVggS3hynEBJUA7QjQw=;
 b=Hbh01v0DQybTThmTvfQD745q5geOiC5d5AaO05hAOf3hvIOCLnggXCAwE6t2WxC6v4
 B3f+MCKHEOZEJBiwGGMHFXD2Yqy1XaheOGzO4az14l7peXARBF46lDvHWYj7DliZvUT/
 HdZrZplfmF0p9nc6fp6MJXTw2UgAJ8NGytxhHY7KlcSIxeNKz3W1WupMsKwhC13x6/fS
 fi+aItUR9iSF73SwK/A9Wr8WVBxQSA4WaYOP88Z8JzsTbRq6D5FBUiCQS0kYyG+r9osq
 f29/t/j8T7OWl2fmkL7UQYl+EtuTsyl0D4Sc/p6LNoW9ep9DI/GjyE78VQUqtaiLt6I6
 hdxg==
X-Gm-Message-State: AOAM5339CHfTuzN7SaV6i5XhcNYDZ7Iu2TL8Bm209zMA32W7fokADKI3
 qzUjZDVI9Z6wz7zbSC2cHtrE9Mi5r0aufYUyiPntTRcVqlxZwAVtEzak93SFfWBMLEd1DrgjXx3
 P/W3A/OmHa/KImAQ=
X-Received: by 2002:a1c:192:: with SMTP id 140mr8247525wmb.73.1603732519519;
 Mon, 26 Oct 2020 10:15:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP+DS5SywOOxB6bGLC0Yfb1oM6OvTTahqjxrscOxWLvSD6PPAMfL27fBQCWBkF+N+Kb069VA==
X-Received: by 2002:a1c:192:: with SMTP id 140mr8247499wmb.73.1603732519258;
 Mon, 26 Oct 2020 10:15:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id w1sm23297474wrp.95.2020.10.26.10.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:15:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/ssi: Rename SSI 'slave' as 'peripheral'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201012124955.3409127-1-f4bug@amsat.org>
 <e15493bf-f31e-daf2-d216-b9d67ea638b1@amsat.org>
 <11aef83d-64ae-8954-e61f-911282896455@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecae635c-6780-b01e-4efb-2f52e2cd7081@redhat.com>
Date: Mon, 26 Oct 2020 18:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <11aef83d-64ae-8954-e61f-911282896455@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 18:05, Philippe Mathieu-Daudé wrote:
> ping^2?
> 
> On 10/19/20 6:04 PM, Philippe Mathieu-Daudé wrote:
>> Ping for review?
>>
>> On 10/12/20 2:49 PM, Philippe Mathieu-Daudé wrote:
>>> Since v1:
>>> - Fixed patch #1 subject (Kevin)
>>>
>>> In order to use inclusive terminology, rename SSI 'slave' as
>>> 'peripheral', following the resolution Paolo pointed in [*]:
>>> https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/
>>>
>>> Candidate to be merged via the ARM or Trivial trees.
>>>
>>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg739108.html
>>>
>>> Philippe Mathieu-Daudé (3):
>>>    hw/ssi/aspeed_smc: Rename 'max_slaves' variable as 'max_peripherals'
>>>    hw/ssi: Update coding style to make checkpatch.pl happy
>>>    hw/ssi: Rename SSI 'slave' as 'peripheral'
>>>
>>>   include/hw/misc/max111x.h   |  2 +-
>>>   include/hw/ssi/aspeed_smc.h |  2 +-
>>>   include/hw/ssi/ssi.h        | 56 +++++++++++++++++++------------------
>>>   hw/arm/spitz.c              | 32 ++++++++++-----------
>>>   hw/arm/stellaris.c          |  4 +--
>>>   hw/arm/tosa.c               | 12 ++++----
>>>   hw/arm/z2.c                 | 14 +++++-----
>>>   hw/block/m25p80.c           | 14 +++++-----
>>>   hw/display/ads7846.c        | 12 ++++----
>>>   hw/display/ssd0323.c        | 12 ++++----
>>>   hw/misc/max111x.c           | 18 ++++++------
>>>   hw/sd/ssi-sd.c              | 12 ++++----
>>>   hw/ssi/aspeed_smc.c         | 53 ++++++++++++++++++-----------------
>>>   hw/ssi/pl022.c              |  2 +-
>>>   hw/ssi/ssi.c                | 48 +++++++++++++++----------------
>>>   hw/ssi/xilinx_spips.c       |  7 +++--
>>>   16 files changed, 152 insertions(+), 148 deletions(-)
>>>
>>
> 

Queued, thanks.

Paolo


