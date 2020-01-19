Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E1AC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229C3206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQBh+WuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229C3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFyG-0006Nb-Aa
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 14:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1itFxS-0005iu-DU
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1itFxR-0005Xv-Ap
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:10:02 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1itFxR-0005XR-6U; Sun, 19 Jan 2020 14:10:01 -0500
Received: by mail-yw1-xc44.google.com with SMTP id i190so16953255ywc.2;
 Sun, 19 Jan 2020 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cI9GlKmUduIQj1qPCU3Q9ivuSO9/wEiAI2naKXrrqOE=;
 b=aQBh+WuFqiQkRWA9qThGEW81q/bzwPYgALbw5n25uvZHPwgcdxIL79fiFKjCYlTFwc
 wWrRo/RAcV+IIA/uMMQ08S+UwIJNyn/fS7gQ7HS6hMVxT20mtpNXEhvgk87EDW0q/p7x
 pgKFkLVfXC4ccem48yQWyslxCrUUL+FPOsBjjcjSSNPnoUbRnAP8Y6vIF8jaSrpW2Pb6
 W90KI7oBHEvpeI1fRt55fxA1tjT5xg+NszBgdf32Xsk6XalBof0Apu3nplo3o2hdsiM/
 zfaljsKhvb1X5ONlpPjqWhTH9b5xjHlPZrT38HDPr49wjS4AHXKsn0bU7zvZGjOBHSY8
 jDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cI9GlKmUduIQj1qPCU3Q9ivuSO9/wEiAI2naKXrrqOE=;
 b=XV6yUSvhfQXmSXZB5L3WYxGxSstpHgYLCW3PQSx7OLH9xAivZLglpit/1G03B6D58K
 vg11ER4vkLNOayQuKW9bZCgGgS1m/eO94oGPryUkecvQCLHRnB7Q7vP/0xnbZgxaBzBT
 6jUOKVZPZLdcURLgJKtuTkXmFL5Gbioapv032AWOB5z4i139q4FJ+nXDX9jhSfBOvzr/
 7LY1t8LHQAAT7Pw8srHkB8G5VNxyVyNwj5Wh4vxK/o5RnuJ8BNzVjGwLRIWPlGyGaECs
 ahSZ0s9/HgtB9xGPMpFBhUOpHKvTGPMXHHL71lTf3gKihnTPsX3LOIVPpCySUTMGl5xq
 RKbA==
X-Gm-Message-State: APjAAAX5eYp5gcDmjC5tjKSj/NnSDU987q9R4JwEp+NYW53NkBvxgGWv
 iYcFCA3pnjKesYJpi1NSMSYiqUXT
X-Google-Smtp-Source: APXvYqwKVE5AJs0ZUBcAPxZ7jWLIZAUuGJ1yDG7st84l9xGXf9WIiRefhXgShMwTxXQLKjW9IfEPcw==
X-Received: by 2002:a81:a0c3:: with SMTP id
 x186mr33178446ywg.344.1579460999827; 
 Sun, 19 Jan 2020 11:09:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z12sm14016291ywl.27.2020.01.19.11.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 11:09:58 -0800 (PST)
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
 <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
 <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
 <CAFEAcA99CgreMMeTH+nmnY+6OU2xY3A-db6MfBuU8i_MCA+y3w@mail.gmail.com>
 <97dafdcd-3f4d-5cc3-efab-b07f373765d5@roeck-us.net>
 <CAFEAcA-9Q7kyJLGcz=kX+mgpL=8Hkt4hM2so1rG98t-ViBS+PQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <770ce52f-6a74-c462-6cfd-57fc369ab868@roeck-us.net>
Date: Sun, 19 Jan 2020 11:09:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9Q7kyJLGcz=kX+mgpL=8Hkt4hM2so1rG98t-ViBS+PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:01 AM, Peter Maydell wrote:
> On Sun, 19 Jan 2020 at 01:52, Guenter Roeck <linux@roeck-us.net> wrote:
>> I'd rather try to fix it all if I am at it; otherwise it feels kind
>> of incomplete. Would you be ok with addressing this separately after
>> the current patch series is accepted ?
> 
> Absolutely, if you'd like to clean up the code please feel free.
> I agree that a separate patchset is probably the best way to go.
> (Do you mean by that that you'd like me to take your v2 as-is?)
> 

Sure, if you accept it as-is.

Thanks,
Guenter

