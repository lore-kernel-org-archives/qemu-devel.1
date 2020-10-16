Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB69207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcZYc4Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB69207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPR8-0001UH-QK
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTPQF-0000jN-Bl; Fri, 16 Oct 2020 09:05:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTPQD-0004xv-IT; Fri, 16 Oct 2020 09:05:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id d81so2416358wmc.1;
 Fri, 16 Oct 2020 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R25o+fOVDwKTa4kZbF/3Mxw3Ftjg3Tt95tdneF4tGfQ=;
 b=VcZYc4MiUDARYJN1ACbBMeuPgc95bFPUwsKuIOImYfxaTQuoOln8hEjfnq/HomWyGj
 7y4OsQ4BCMG/8N9cjFs8JLF0vW1seDBjOdNVJoy9jXJkMZQYx2ITQjaWxtrOTo7pN06S
 W/2L8HwSoo51fT/y8miEJ82/f8d0lfk1zWDhvPr9h7b2TLTruDsmcpS5XQp2uVAouE+F
 cKKbKYVLO5p8odayXb8e5pPHRfIIKwAYUmOMYyoKXEjleZX1aSPlcITRGuM3DA8quGVJ
 qXm2hQWpnMQjsQGFwUFv0sZo1CpywgUotPwUy1994jfebt2O4vGmpkA5odtdNnzyLm4Q
 cHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R25o+fOVDwKTa4kZbF/3Mxw3Ftjg3Tt95tdneF4tGfQ=;
 b=MIQS+eIZnACJP9Ugk/DBjrrTpU/muqyLk6Ul6+Jzoqa6I9TKDbkhtN9KmhHdfn1Peb
 NXYmhmpfOe6LjRtaoHgzzTT7yl4YXwNgVSo5RkgoIdjIngNcGTcX3z8ykE7K7+zQoGCk
 PmMdN3cIdZrYYZm0X8tRscUBmU/sni9u8qxkklDLtV3Kl8Ur8Y4l8aP3yBR2T+Ales3y
 GEIv1TCJhgU2uWlpbd7CzKdwZzGEh0SY5lFhevrgCh8mGBSFzKC+NxXZybqSEZ+ZHVhc
 n64DV7wZq4tjzrkK0jjDFaq23OITB3HPlj7GNMPDdDQHdgSm83Y01dPQZC69WdofF39N
 FnBg==
X-Gm-Message-State: AOAM530UDdBDjDCHbDy5EYd3Me5pu7Z0Oo9U11enYwfcAaUZwiaaT05F
 r7c61yMPoiziLoSyyZRm7x2W2Zgkpgo=
X-Google-Smtp-Source: ABdhPJy4KoCwkXMUabXbE4oTJV/g14raQEhIPCuqy/A39ZBhj0QNF7tN5MmJyn/MEslwj64ionQmPQ==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr3680928wmj.23.1602853523002;
 Fri, 16 Oct 2020 06:05:23 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k190sm2694086wme.33.2020.10.16.06.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:05:21 -0700 (PDT)
Subject: Re: [PATCH v8 0/5] Mac Old World ROM experiment (ppc/mac_* clean ups
 and loading binary ROM)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1602805637.git.balaton@eik.bme.hu>
 <005ed95d-65ee-ab36-c068-e96a773ef8ed@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c34f053-268e-6dbf-205f-48792328ebe8@amsat.org>
Date: Fri, 16 Oct 2020 15:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <005ed95d-65ee-ab36-c068-e96a773ef8ed@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 11:58 AM, Mark Cave-Ayland wrote:
> On 16/10/2020 00:47, BALATON Zoltan via wrote:
> 
>> This is the cut down version of the earlier series omitting unfinished
>> patches that I plan to rework later and rebased to Mark's qemu-macppc
>> branch. Compared to v7 the only change is the cast to (target_ulong)
>> from (uint32_t) as requested by Mark in patch 1.
> 
> FWIW the reason for suggesting the cast to target_ulong is so that the 
> same code works for both qemu-system-ppc and qemu-system-ppc64. For 
> qemu-system-ppc that should correctly drop the sign extension from 
> 32-bit, whilst still allowing someone to load a 64-bit ELF into 
> qemu-system-ppc64 if requested.

IMO this is part of a bigger design problem. Not all
machines main bus is 64-bit. I did some experiments
but changing that involves a lot of work.

