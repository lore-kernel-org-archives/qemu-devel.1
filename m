Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0EC32751
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA364217F5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwBaaAGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA364217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvXZH-0007Ec-Rn
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 21:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51112)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvXYp-0006Wk-Ny
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvXYo-0006GT-OZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:49:47 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvXYo-0006GB-IU; Wed, 07 Aug 2019 21:49:46 -0400
Received: by mail-ed1-x544.google.com with SMTP id w13so88544763eds.4;
 Wed, 07 Aug 2019 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J7ISMZ0v61lDO7u7LIiTD5traq8L9JDwd8ZcKfq0ZvA=;
 b=WwBaaAGipJN9VaDjvJxucrLCnBzAftGJCKvhiYKULE7CK8UA9c28ovIDWkw9OWkgME
 rmAOtPMR3SuhN1DXUNP30rar+ue/tvHerxUTvcw1QJjDq3mxrebg9IO5QXfDLYhp9BWQ
 BuIFFs1Tak6b1SvEFJErx/ep+kvUPxwat8j6EaVb1UvD6QhtOrxgTj4kBERkx7PmVZsq
 PB+Rg+FA4Tpn9SJCr8x2ia0xrkD4+SfVMH1Mtrw47pYPfH6e50g4w6FNnhrj2PZxmNo6
 g84AhNQHAqDZcdBPIpHgnz1Wt9f03a8l1KyntNcczMh3CrIhYcXzyYDuKk4fPd5SQTtY
 dqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J7ISMZ0v61lDO7u7LIiTD5traq8L9JDwd8ZcKfq0ZvA=;
 b=j+RBgd1qSUv4feY2i5dsZ1hM0cKlTtger3yRgZRMM+YQk/764OrWV7AqHsRbfwTkFf
 wUO8FH6O5w5HjThd0ouXAFpuOAvnxm18fTMN0d+WORJ7FmVjqkgeKHoPwQGFW6NUgKoa
 YpQ3TXjaa1s9Y2UjQDPaHkPjmh+kmfAfrLedkAzLod9A+2urEOIIeaW2nu+Xwgy0nSYI
 Wdb8Q9PKC3cbERkGwruibN1WgfmS61yqp9f1b65Fo/wA7DkL2XKNZ9ETfjqVUF0UljBt
 rAKU1iXIzB/DilM9+TPGZRwg36pUvNbiu+ZF4/IF0pmWfRNNX1JPDP1EM2HmlQ058nPi
 01jQ==
X-Gm-Message-State: APjAAAUxo3SiMl4M6wGsxgsjixJ09Lem498GnAgkGgqadq0CO8Wp7NlZ
 eRnELRuM3+5YFUx/YtlhoASpnuOUXqe0mu1tcPE=
X-Google-Smtp-Source: APXvYqwccFEwgrTaLcPG9Yk7YYyyeoxlavRQE6Iiq0Efoysosu+YfhI44WubRhYxmQyVX/VIL4qPRSQQQS5j+BdLQSc=
X-Received: by 2002:a17:906:340e:: with SMTP id
 c14mr11306605ejb.170.1565228985039; 
 Wed, 07 Aug 2019 18:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
 <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
 <ac4453de-81cd-c32a-17f8-283fa3569ed0@linaro.org>
 <CAEUhbmX2C_FbW_m=Mri19hpz0c74SQTt3ogsatGgveH09t3_4g@mail.gmail.com>
 <CANs6eMkRQ1-Gb42DhHGz++4Q79JbH4S3MnccwmwKKEB-sdozag@mail.gmail.com>
In-Reply-To: <CANs6eMkRQ1-Gb42DhHGz++4Q79JbH4S3MnccwmwKKEB-sdozag@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Aug 2019 09:49:34 +0800
Message-ID: <CAEUhbmVe=wRZfJmXx2XP4a-OpEgB0uAHP=x6NrdfCq_y7DSr8w@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: QEMU riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Thu, Aug 8, 2019 at 4:55 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, Aug 1, 2019 at 7:58 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> On Thu, Aug 1, 2019 at 10:16 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>> >
>> > On 7/31/19 6:53 PM, Bin Meng wrote:
>> > > I am not sure how (idx * ptesize) could overflow. It represents the
>> > > offset by a page table which is [0, 4096).
>> >
>> > You're right, I mis-read what was going on there.
>> >
>> > However, lower down, "target_ulong ppn" needs to be promoted to hwaddr, so that
>> >
>> >     ppn = pte >> PTE_PPN_SHIFT;
>> >     ...
>> >     base = ppn << PGSHIFT;
>> >
>> > does not overflow.  (Which is the part of the page table walk that I thought I
>> > had gleaned from the patch without actually reading the entire function.)
>>
>> Ah, yes. ppn should be promoted. Thanks for the review!
>
>
> Did I miss a v2?

No, I will send a v2 soon.

Regards,
Bin

