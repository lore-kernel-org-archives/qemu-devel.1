Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5E4C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DE620857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti9Tqq+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DE620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRw1-00044c-Cs
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 10:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRv6-0003Lq-EO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRv5-0005hJ-AF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:24:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPRv5-0005gp-1T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:24:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id i22so1522912otp.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bINL+whMY8JUFNkL3EiY+3GJ5yVCYEGHi/PyCcCo5+k=;
 b=ti9Tqq+xRiQSWOwWxj9UiETP/8S5aSWAzJtPZGbwp13sUdiugCAYbDNg4qDfP2L8kt
 KmgoOP1EvbVb2qC23VbUoqiuoJlFtXf1IeIJAvqcGaJ9aj2cVMHJWBzna/o+A2lyaM+D
 Xy8xZVYie4n0Xi8VIzZly8CXlsByG44AsvHodxnXIrJHHeYKayPWK5l+5iVH+DeV11mp
 mm6qKLsQwp0M2ivD9rRfo+AJDn2ycxxyfXX5/K9dEk6W87HtZKKLH62gtYUtQHsK3ZEk
 qtOufeaXyvVOUB0N+eOhQqKG3tWGkB26G/mnYiPp6/cyGoVo1Xd/Bwq5cEaZqmj7ugJ3
 2bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bINL+whMY8JUFNkL3EiY+3GJ5yVCYEGHi/PyCcCo5+k=;
 b=FpdFaKC5YlXpQbclRISCg/5vIUxnvb6ukSyfjs/hCsEy6FOPmyG+U2Tc2N0OJfgXGc
 wyQYYrKIguBevhf7ih4ICqvY4VVS8ozGZ0hY7UqGjwRxch7WvjofuX+w9khXLgQ5iD9g
 5dzLTO5U9ziDUwnK0T9P0USjTI27H5PKktaOpHPEBPklI8ekmZ3D2hVn1fewmVrjiC+0
 SHXbK1/1UYhXw0C2PKonnbUjod7mk2fAmkExIvFhJ3zPzx7+/QAX9jey0baVV4z8DZIA
 TIj/xVaH4ioYxmAILAA8jqz2kTu7mLKx+XEJXQD8sQxH3BWHaMyNEdyVjds8VxDU7BlW
 Nglg==
X-Gm-Message-State: AGi0PuZMoV96B0HFjUxEm0XtSlaWAGBr1IFLSxjCgCwAJqFkeI05k67n
 WAnAbYLMp4xgIyIhzOfO4ZJ/y0+gqfvfj1DsLvSNpQ==
X-Google-Smtp-Source: APiQypJpUD2IU+gWxhauJfjP3/9GfO2pNn3i5Xg4of5Pd0BY0W3WBFVh2xfJeJThB9c+RV8vwtMhU7lGMJ+qioXhUz4=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr2594814otc.221.1587133477203; 
 Fri, 17 Apr 2020 07:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
 <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
 <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
 <5d9606c9-f812-f629-e03f-d72ddbce05ee@redhat.com>
 <CAFEAcA-4+Jcfxc5dax8exV+kBJKYEnWZ2d-V1A6sm6uJafZdPg@mail.gmail.com>
 <16bd73d1-ec39-7da6-77c3-a18eea5992e0@redhat.com>
In-Reply-To: <16bd73d1-ec39-7da6-77c3-a18eea5992e0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 15:24:25 +0100
Message-ID: <CAFEAcA_1F2hpYp9TkKRGKgjQ7kjJ787s4Wr_6P+7fGBKeAwZPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 15:19, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 4/17/20 3:54 PM, Peter Maydell wrote:
> > Your suggested patch isn't quite the same as RTH's suggestion,
> > because it puts the assert inside a stub probe_read()
> > implementation rather than having the ifdef at the level
> > of the writefn body. I have no opinion on whether one or
> > the other of these is preferable.
>
> I'll let Richard modify the writefn() bodies if required, as he
> understand what they do :)

RTH is suggesting

static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                          uint64_t value)
{
#ifdef CONFIG_TCG
    entire current body of function goes here
#else
    g_assert_not_reached();
#endif
}

If we take that approach then the stub probe_read() would
be pointless, so we should do one or the other, not both.

> Btw since we have this rule:
>
> obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
>
> I'll use the following patch which is less intrusive:

This is temptingly less ifdeffery, certainly

-- PMM

