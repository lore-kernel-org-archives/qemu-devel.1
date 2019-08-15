Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B967C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0B12064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukVz1l1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0B12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBWB-0002k4-3B
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyBVR-0001xZ-Sx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyBVR-0004ja-3M
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:53:13 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyBVO-0004iO-I3; Thu, 15 Aug 2019 04:53:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id a21so1067261oie.4;
 Thu, 15 Aug 2019 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qm+u6kAL1cfjdCRFcjcPBEaaQ8bPsxnJf0RCaKpZIgg=;
 b=ukVz1l1pp9cn440pW9mq+uj1z8JjoV01OgZIcoAUU/JJE+C8KiLQhkqglKYx3I2S9f
 KleKZ3A0/byxTluvfcyFdHn6f+s/lidcu/1wHiHur60agYcOPh7o4NX8kwKYgvBCFgB3
 F7UtxkE+lNuT+9OZ3qVZUD3JGGSrWUJgL5nn2EQ3kyECKXCD9Di3OxBTBER2CCCKOdhB
 ZCTzlHdzeIhSYvJ7ivPQ65qFmR7qnFyMQhb2lLJjYmaaf/GJ2gMCDY/lb5JD6aYBmyUh
 1PwrmOb75sMeB1JyZgaRy5Pvh8C0vuLupyY/psWZWHlQSy4iKA24IxARQWNpC4GlPzJD
 ximw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qm+u6kAL1cfjdCRFcjcPBEaaQ8bPsxnJf0RCaKpZIgg=;
 b=hDJasIk3oGBRjY2U8v20Af+mHGt2eu93QKQ6zTUIka8l5dSRZjgeQjFtnqOlIaPQwS
 nFe6HZ4rHaZnHwgF8TGGWJM8CGhUP9w+zxioMyEOBrXCuWWIN+S3h1SXvgbe7XxgZ9zl
 /D71zoBlmWS0IDuB8zVrRKL7mHz0t/rh7tTN4j3gtn8IRanBwsoAMSOaCN0JU1UoK4Ac
 lqJT0EbeXHR+oQj3iBX7eRJoCg1rc9htSLBGM/EBbedNdmZHMJ4Y6ZSP+m2VHsneglko
 MD7AKAmxptoyMYxFuLazw2t2BJiQanWW9T90uMLJ3So0Ely5GfNy2CwSrykJdw3i9i53
 baWg==
X-Gm-Message-State: APjAAAXjdPMDg5oiYyIVFVyXuXM72Qu7v01waZ69lkBDAsps2bRfODgx
 iqFclrzulphXilV1MKI+Z8MWAjtpjdW7N40QH3A=
X-Google-Smtp-Source: APXvYqzuQEtifdSHnpccS9vToaI1Rw47RE3a7tivwvx5RLRxhPFr3vfDCtLHa7v02vlXIrZcQ8gvVStXExb14vk7fWw=
X-Received: by 2002:aca:4083:: with SMTP id n125mr776145oia.106.1565859189504; 
 Thu, 15 Aug 2019 01:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 01:53:08
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 01:53:08
 -0700 (PDT)
In-Reply-To: <CAKmqyKM5zneojhPe57h1+h3pav5kQxFaMnhNiwWRUa=nbzS3Ag@mail.gmail.com>
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
 <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
 <CAKmqyKM5zneojhPe57h1+h3pav5kQxFaMnhNiwWRUa=nbzS3Ag@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 10:53:08 +0200
Message-ID: <CAL1e-=hVLQWThYSm78bTCbQPfAABjx_rG9nEa9gV6PvSN8ge2w@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU ZhiWei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> We can accept draft
> extensions in QEMU as long as they are disabled by default.
>
> Alistair
>

Hi, Alistair, Palmer,

Is this an official stance of QEMU community, or perhaps Alistair's
personal judgement, or maybe a rule within risv subcomunity?

Yours,
Aleksandar
