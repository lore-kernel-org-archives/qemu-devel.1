Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415F320702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5O3Gdff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415F320702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtBo-0004Qr-Ih
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxtBF-00041x-Bc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:23:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxtBD-0003bU-O8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:23:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id a14so6550028wra.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DlDjYkqyT0WXRTIAcygOe4vNvk8iPi7jLObRtHwXZGU=;
 b=G5O3GdffnX9yclwo/Fzzrm/pVlX3ydfRHPpiZGC5c2KVBpyNrR7hkb5fFgFTMxFidk
 eWcUGn9tK1IyZnDeXN3T2ij52f9/Zbbvq1XGieEe/cWCPzeiPmnlw9AnuFZ9uyUgpLht
 xaHGocpojhrdxwFbWxQDB5tA6UQfMDmkkitDe9OIdytdJ5c2OSdsWizAWXAMGTHpSrhF
 rGLSUyxpIxmcYn6HIV2yYB99QDqknI+he+lxRt0qqRP3FiDXwJujDwwULkBjzvcG4MCJ
 2EvvUrSC4s7QLAuZIjVTrUHUYpcWSk+/4LYSojHgsgEgCHQ2N1/UrAq46iKj081UH7gC
 lS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DlDjYkqyT0WXRTIAcygOe4vNvk8iPi7jLObRtHwXZGU=;
 b=UMkGECKsuLzoarI/hg0ZIzVayaQS3Yyn/T5LhPr93dmzBligXXviOpkWAgMJZzTgaf
 295wgwQ2hjnJn4aucclV6pnuhPNQ/0KDSHphoTSlvtaDb3ZjbQsHWVqbicGIF85aNMIx
 ASDZ2m3GhGzrn81KCfMKCMlGcR5QntkzOOPxYogIBwbETJZSQbSChgny3EY1kixF227k
 wSEtc8Sz3nMvUXFsdUQZcmQRF8wWf/jC1BkaKlP/cYvA5ZU5xHEo75LfdkPViD0qGWaq
 iJZ56aCAiv7N6lRGPaErGJ2ArPBqhM75f+FFDkkqJoe99Vfno3KVEhqck2eYX6PcPSpJ
 PJTg==
X-Gm-Message-State: AOAM533eJsRbnQeckh8DxR/PQUJhNq+f870NFxCZCh79n14Zf7eY7ppV
 Pkd3vBNfmYFio91TZ3LNGqk=
X-Google-Smtp-Source: ABdhPJy79WdOlk2HyOgNP84QVrpm8kZ/1ZPREYVGu8vmJm6FnvmZWklS5DSamiMG44lRkX9Y1yiL9w==
X-Received: by 2002:a05:6000:124c:: with SMTP id
 j12mr10065204wrx.83.1595341417692; 
 Tue, 21 Jul 2020 07:23:37 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u1sm46650916wrb.78.2020.07.21.07.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 07:23:36 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-2-f4bug@amsat.org>
 <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
 <1e60f58f-b4b1-3490-5485-d51f4584caf4@amsat.org>
 <CAFEAcA_bDSqH=JHWJDYAehov8p1VHS8rjMFWp27-DPi2Nu8nxQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c235275-7cbb-7f50-2ff6-4d4ffe6a086f@amsat.org>
Date: Tue, 21 Jul 2020 16:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bDSqH=JHWJDYAehov8p1VHS8rjMFWp27-DPi2Nu8nxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 2:49 PM, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 13:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/21/20 2:33 PM, Peter Maydell wrote:
>>> On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> Don't you now need to g_memfree() mr->ops somewhere? Otherwise
>>> you've leaked it if the device which owned this MemoryRegion
>>> is hot-unplugged, I think.
>>
>> I haven't thinking of hot-unplug. I went with the simplest fix
>> considering we are in freeze, and fixing the bug was more
>> important that a leak at this point.
>> I'll have a look at freeing this memory, hoping it is still less
>> disruptive than a proper architectural change to fix this problem.
> 
> Instead of g_memdup()ing the ops struct here, you could maybe
> do it in isa_register_ioport() instead. Then you don't need to
> worry about leaks because we know all ISA devices are not
> hotpluggable, and the ugliness is also a bit more constrained
> to the ISA code. (Coverity probably still thinks it's a leak though.)

I tried that first but got:

memory.c: In function ‘memory_region_initfn’:
memory.c:1221:13: error: assignment discards ‘const’ qualifier from
pointer target type [-Werror=discarded-qualifiers]
 1221 |     mr->ops = &unassigned_mem_ops;
      |             ^
memory.c: In function ‘memory_region_init_io’:
memory.c:1488:13: error: assignment discards ‘const’ qualifier from
pointer target type [-Werror=discarded-qualifiers]
 1488 |     mr->ops = ops ? ops : &unassigned_mem_ops;
      |             ^
memory.c: In function ‘memory_region_init_ram_device_ptr’:
memory.c:1625:13: error: assignment discards ‘const’ qualifier from
pointer target type [-Werror=discarded-qualifiers]
 1625 |     mr->ops = &ram_device_mem_ops;
      |             ^
memory.c: In function ‘memory_region_init_rom_device_nomigrate’:
memory.c:1667:13: error: assignment discards ‘const’ qualifier from
pointer target type [-Werror=discarded-qualifiers]
 1667 |     mr->ops = ops;
      |             ^

Since this whole series is a kludge, I'm tempted to cast that to
non-const but it starts to get really ugly...

> 
> thanks
> -- PMM
> 

