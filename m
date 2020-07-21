Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69652073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzn2G646"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69652073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxroU-00085h-2Z
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrnb-0007Rv-68
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:55:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrnZ-000796-IM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:55:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so2761150wml.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=228v2kygEcf/uM14ARtEb6/hMyuaawqMCSCYTYpRlFo=;
 b=Uzn2G646R1Gra1A6JRXKuGuGHzbmFzEqtMNG636dqqb2nG2cGHwqPdyR4JCOByUR7O
 ku3iTk1ZioBuE/XrRBaTqTWM4J5baPZ5Svhn+A25FGr5Dqw96JJWKzMVeOSkqbUhKMiu
 VVJhrUpWpZD9rlGdsr/4O3P9ofTcWFdv1H4tAXs//P2aj4QN8JkNf2oqzXestaaAMinP
 UCejoYE/nTXfBKTxPF3nS28udG7IpkyfL/NkgoEm6EV4I52kdpaHrxwkLj5rryPkIam1
 cKVp1t3eN8KXeW9h48lnTjR9CL89GTmbJ5M9Cf09PuAxHMu68i3YMxmxE+zTfGRUR+2R
 wJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=228v2kygEcf/uM14ARtEb6/hMyuaawqMCSCYTYpRlFo=;
 b=DKueoj0Ycgg/vprvdchzLY50LtfqjXWES5EejqkmxXFHffkMLvvJQC4hK1kErC9Oty
 Yu+8sNMSqe/Dnc7R/3MXsfnqdoKQbUC/LZMc27cjWQMTOSLbGKe48TXLha2gDZqQGrBf
 jG5NsmLaFqPmUBXenSBFj0NGUCmUrMIc03tV4bFogtqxk/cwaMlFDBQHpdwZNrmyWEjN
 SCEDXXFtkmHzJcizKJyYV8znDnMx7r3Bs3LnonfYIgl+GDro8MXl0OekDx9igklfI2H4
 StX0N0x5ZeG1P9ge/mW7eN2Viwx9OFvLG2upM/6YmVK2FxJf0Xo+IE1igxL+iX85B8wf
 yc9w==
X-Gm-Message-State: AOAM531j40fIKaxbyaOx7dUUSfX+lhyIEtP2R93I6yl9l+XhxPxZmW4u
 6Trp9AKtxm3dB9UWCAC/AYQ=
X-Google-Smtp-Source: ABdhPJxBnWFQX7yn1X9ONdvqZOjyDcbTWvFiptbeGz493+ZXJACoOmq/roUt+ZxGADWn/F/J2RwvwQ==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr4122611wmf.135.1595336107927; 
 Tue, 21 Jul 2020 05:55:07 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g144sm3002610wme.2.2020.07.21.05.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 05:55:06 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1? v3 2/2] hw/isa/isa-bus: Ensure ISA I/O
 regions are 8/16/32-bit accessible
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-3-f4bug@amsat.org>
 <CAFEAcA_Xz4OPGEx5T5aoWaW9-G92ioS-jLt1B_vFYFS+s_RkYA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f2fe44a6-e783-8c2e-27d5-9db79b77e23c@amsat.org>
Date: Tue, 21 Jul 2020 14:55:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Xz4OPGEx5T5aoWaW9-G92ioS-jLt1B_vFYFS+s_RkYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 2:41 PM, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Since commit 5d971f9e67 we don't accept mismatching sizes
>> in memory_region_access_valid(). This gives troubles when
>> a device is on an ISA bus, because the CPU is free to use
>> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
>> regardless what range is valid for the device.
>>
>> Monkey-patch the ISA device MemoryRegionOps to force it
>> to accepts 8/16/32-bit accesses. This should be reverted
>> after the release and fixed in a more elegant manner.
> 
> Do we need something similar for isa_register_portio_list(),
> or is that function OK ?
> 
> Do we have a view on what the 'more elegant manner' would look like?

What I suggested on IRC is a isabus->address_space_io is not assigned
by the bus creator but created internally as a MemoryRegion container
accepting 8/16 (ISA bus) or 8/16/32-bit (EISA bus) accesses from the I/O
address space, and this MR uses memory::access_with_adjusted_size()
(or similar) to access the registered portio devices.

We already have isa_address_space_io() to access
isabus->address_space_io.

isa_bus_new() could takes an 'is_eisa' boolean argument to select
between the adjusting MR.

> 
> thanks
> -- PMM
> 

