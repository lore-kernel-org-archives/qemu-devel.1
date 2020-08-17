Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB14C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1943520758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ/pnHqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1943520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Xfq-0001bn-E5
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 01:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7Xf4-0001CS-Vv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:26:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7Xf3-0007Pv-El
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:26:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so13647321wrl.4
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SNQhrOHOgS1H1D2YAoDbsKMkBnR1Et1atXovo/4h/DY=;
 b=dQ/pnHqqKA4kLaLG58L7FBTQNPWGyvGUJBkWeYFYlocooSDbBBCSblwM2Kua2O1tMw
 mpUDzMXQCDzC92u7fuste6sqJlsqM1aMtWr/FFQAaqDoGYVDsMg2Mt9jvCf/la98ywcI
 eFHPGRYSDUS8TWGE36lWrSCzvi0qVkor5S9XSMpM8ThsS0/ok5E5YCdPDDAR+bv9j4Jg
 f9ImyqTS3gDRYtrUCaREEEnOGXrD+PtN2kD6A7Ky2/m5MqjJxSyvtKUWiKYiVvilqWXC
 I58w6/BfJHeIWl692H+WvBRYjcfGjHhiyMOL1svjx6L3lk3+seTq9pxWMBO1dAix5Dd7
 W3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SNQhrOHOgS1H1D2YAoDbsKMkBnR1Et1atXovo/4h/DY=;
 b=ONf4CXuub3mVfieY6B55YAhaagNcnJFEofjdX1jRXeziBBhwGvoeXGbuZNzqb3P7SV
 UxvwsZO/iSvF4iCJXSJBT4dA2hEwrjX/fgA408lPQG8w0RB6PiNqCIFzUJSSewtRTVVc
 1GR6hj7z7PVQx02bM+eA2z95462yc3cnZ37242FwZeDJEv28dep7P3O/6rstqkSznuVT
 EsSShwzmOv9M5CxfCI3rirQsix+QPbEmshKJ3P1VIaIFBWGRYQz6VjR8w/uWm8WKUNI4
 BMJU6eJFxPuE+OF3d3aubUbq++veLldyPo+IGKScczxQbVfSJ5xUCqm/TxMeLmtCrgDn
 f3AQ==
X-Gm-Message-State: AOAM5302np2/cXjNk9C7nMqz4cdmGU7kgTFa4GVg2qAIiWpMpj13YC4p
 sw1r3d8R0bn97XQNO4N0h/U=
X-Google-Smtp-Source: ABdhPJymRF18sXw4JUiDkMWlDn0xSuPQ+1HyrpF8Hk2WI4t5UwhNIgPtd+RaEBCvLmbpvOFKSlLQvw==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr14225094wro.351.1597641979586; 
 Sun, 16 Aug 2020 22:26:19 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q7sm29687721wra.56.2020.08.16.22.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 22:26:18 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
To: P J P <ppandit@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <c43dbd57-f22f-27f0-d6b3-77734be76631@amsat.org>
 <nycvar.YSQ.7.78.906.2008170954360.306228@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1bfaf72e-35ee-fce6-9894-c5346af78742@amsat.org>
Date: Mon, 17 Aug 2020 07:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2008170954360.306228@xnncv>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:02 AM, P J P wrote:
> +-- On Sun, 16 Aug 2020, Philippe Mathieu-Daudé wrote --+
> | On 8/11/20 1:41 PM, P J P wrote:
> | > From: Prasad J Pandit <pjp@fedoraproject.org>
> | > * This series asserts that MemoryRegionOps objects define read/write
> | >   callback methods. Thus avoids potential NULL pointer dereference.
> | >   ex. -> https://git.qemu.org/?p=qemu.git;a=commit;h=bb15013ef34617eb1344f5276292cadd326c21b2
> | > 
> | > * Also adds various undefined MemoryRegionOps read/write functions
> | >   to avoid potential assert failure.
> | 
> | What about read_with_attrs()/write_with_attrs()? It seems they are part of 
> | the same problem.
> 
> * read/write_with_attrs function is called if read/write callback is not 
>   defined
> 
>   ../softmmu/memory.c
>     if (mr->ops->write) {
>                     ... memory_region_write_accessor, mr,
>     } else {
>                     ... memory_region_write_with_attrs_accessor,
> 
>   So, defining read/write methods may also address read/write_with_attrs 
>   issue?
> 
> * $ grep -Eri -A 5 -B 5 '(\.read_with_attrs|\.write_with_attrs)' . | fpaste
> 
>    -> https://paste.centos.org/view/386c9597
> 
>   It doesn't show an occurrence where one of the read/write_with_attrs is 
>   missing.
> 
> * Nevertheless, if we need to define read/write_with_attrs routines, because 
>   memory_region_init_io() would assert(3) for them
> 
>   could that be a subsequent patch series please?

Yes no problem, I was just wondering and wasn't sure.

