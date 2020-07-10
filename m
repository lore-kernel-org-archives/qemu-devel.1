Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD43C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5C620772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYg+FaCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5C620772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpyH-0005pm-8T
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpxh-0005If-9R; Fri, 10 Jul 2020 06:08:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpxf-0000xI-La; Fri, 10 Jul 2020 06:08:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so5342139wrv.9;
 Fri, 10 Jul 2020 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UlkyKKBHO+nUNuANLJRz8KQYbRRZFrR6NlkBYUvk8jM=;
 b=gYg+FaCbFubUC+SxvRX72CVICXR4jdhkcmMxUk0hLVBPnagEu6qklj09IrFe+9m8nO
 wCC292wkRPCu+DsB3yumX3lrxbFjQw8JZx2Q4enwZhV8WQGbHVclT+sI7n1Ml7JzZiRu
 tqrKBSmEDgTsPphEPFemYEU+EVxoZGWydCeQfXdiwFsJEW/loODL68HoJeWvF1TzJCww
 EzjUSqSivwHUndw2zXkpe43E6cE7CUzsbLtZGtYglbbzKt9+K0WwUUsq3qerxCtrdsr7
 M0D+3lktdbLyQ49EVwnyUlrX0lN/hbEFXJebtX17wQrWMo1+EQRrF4wXcb0VX3zGONv6
 gmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UlkyKKBHO+nUNuANLJRz8KQYbRRZFrR6NlkBYUvk8jM=;
 b=HsaB83HqUhMWfThGybJrovV3TxqjfDzF8rJp9KV//JiEHN40twQu4b5oSrhRPeE9TP
 6NOdGdEwm89i9wFAuA+ohyx3696dMyk2MG+ze6ST+ubXDChN2PkBxwA7O5mn6uQjo7uL
 U+tAWXzqo6BKeO7XGB95pt0nHfAzUoNxXrEvbRIAz5FusyvjLqo/vveUymxj9FLSFSaS
 dZK0XndP70RpvQZY8HpLZt9aYAoT33wmQWTEHHcrDiOl0ooxIj/Q2KdC97ciMV4omSMb
 uFUHoVq/HfGoyP1d91gQZ+zrJwyDC2/+Vsaoaa3eLHfwujH4VONJHrq2OBdo5KdJ2kJu
 vsoQ==
X-Gm-Message-State: AOAM530xbN4/u+4y7hV0wggtWVe2HO+cBj3CkV3SyOKd4+s/mZQb8ZST
 v3j3WDWBWanptcuQpzKHX6QVTmA2ws4=
X-Google-Smtp-Source: ABdhPJzzRXFRWQBwR9q93n4Zu8ICezeX6SdfQIg7wfMpu676xpnmiDFO44wK28jf5C4x8+exNuOzDw==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr63753788wrw.28.1594375733558; 
 Fri, 10 Jul 2020 03:08:53 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f12sm9688728wrj.48.2020.07.10.03.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 03:08:52 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] hw/sd: Deprecate the SPI mode and the SPI to SD
 adapter
To: Bin Meng <bmeng.cn@gmail.com>, Pragnesh Patel <pragnesh.patel@sifive.com>
References: <20200705220731.28101-1-f4bug@amsat.org>
 <CAEUhbmXV1ZvL3N7di0HgVnGmMB69H=RTFFET=3+VLyK+e3Dj8A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5acfe73-b0ac-1cd7-0e3b-694f6bf6e615@amsat.org>
Date: Fri, 10 Jul 2020 12:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmXV1ZvL3N7di0HgVnGmMB69H=RTFFET=3+VLyK+e3Dj8A@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 11:27 AM, Bin Meng wrote:
> Hi Philippe,
> 
> On Mon, Jul 6, 2020 at 6:07 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> I tried to maintain the SPI mode because it is useful in
>> tiny embedded devices, and thought it would be helpful for
>> the AVR MCUs.
>> As AVR was blocked, I thought it was wise to deprecate the
>> SPI mode as users are interested in the faster MMC mode.
>> Today Thomas surprised me by posting an update of it!
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
>>
>> I'm still posting this as RFC to discuss, but I'm reconsiderating
>> keeping this mode a bit more.
>>
> 
> AFAIK, SiFive folks (Pragnesh in cc) are investigating supporting QSPI
> model on "sifive_u" machine, and it will definitely use this SPI over
> SD model.
> 
> In fact, the QSPI is the last big gap in the "sifive_u" machine to
> make it a complete platform for hardware replacement.

Good news!

I have some idea about the design, but don't have the time to work
on it. Help in this area is welcomed, and I am happy to review the
patches.

The way I'd do it is keep the generic sd.c code and make it an abstract
class (or interface), and split SD / SPI protocols handling in different
implementation files. Only the negotiation at reset is common, once you
switch to a protocol mode you can't switch to another without resetting
the device. Also this would make the MMC protocol (already implemented
by Xilinx) upstreamable more easily.

Having different files also allows different maintenance granularity.

I haven't looked at QSPI, but I expect it to be quite different that
the old SPI mode.

Regards,

Phil.

