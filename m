Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78AC28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 05:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225ED208E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 05:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225ED208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZU7D-0001xK-2I
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 01:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hZU6P-0001Vq-Vj
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hZU6O-0001WP-UP
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:41:17 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hZU6N-0001Uu-16
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:41:16 -0400
Received: by mail-pg1-f178.google.com with SMTP id f25so2220831pgv.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 22:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=0xFujibSNYzWMLVp8zBawg+0B0c5vMsRBy4UZe+YTh8=;
 b=PHzP3Pjn+DmWL80i9bHaBrSx1k4hXhRepTt1mjmVhVB3jjRYDk9wn3XPaZAjq6N2sH
 ebmJp6VRRiJHbyKQRI7Dm4PBydGR+GWHkcpVxdx0SsYiKysJaDLhXFacHkbk6YiJA/oy
 RjDJZuQvPQo3C/dcPVUT3l7VKWAwEA5vxI6yvsQU7WE+u6mCIiLuFrfoKnme/Mu7OvMk
 H+XBtDUBr9ulhm6rXiShxYjvdoEF1f8c8aEK+2gFIwlkphK6w8qSX7TSALydycY3WR1x
 ZTt+UI+7H7FBUpj2TKAGR6kwrftT+9Le7oMQHhMLfAMqk4+NpfjTrIpoJ4VniLKAtxLH
 9cNQ==
X-Gm-Message-State: APjAAAWMLm8sZEPqU5sqmyUFvJLw2K4KH+sgY+u2AbRdMTKPF2Fmj7Wx
 FBe8QeQLhsNtWKGGzrhtz8gpxw==
X-Google-Smtp-Source: APXvYqwWwPq6c5pMpiwr3aOT4NFXgsBFf+bMOBpBtkrZ19WmSIA9Uq49ihBfsjjwpEZqAqV6FW943A==
X-Received: by 2002:a17:90a:9514:: with SMTP id
 t20mr9413798pjo.124.1559972472276; 
 Fri, 07 Jun 2019 22:41:12 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r11sm955628pgs.39.2019.06.07.22.41.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 22:41:11 -0700 (PDT)
Date: Fri, 07 Jun 2019 22:41:11 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:33:12 PDT (-0700)
In-Reply-To: <CAFXwXrkEVJgPEZtvzyekJEZDk90XvntHkdfUe0s37RZ-ir1MKw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-9a9b8dc8-4249-4695-9b30-9303df3a9c6d@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.178
Subject: Re: [Qemu-devel] Fwd: [joel@sing.id.au: atomic failures on
 qemu-system-riscv64]
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 06 Jun 2019 19:50:57 PDT (-0700), richard.henderson@linaro.org wrote:
>>
>> Also, unless I'm misunderstanding something our implementation of LR/SC is
>>
> pretty broken.  We're just using a CAS to check if the value changed, which
>> suffers from the ABA problem that LR/SC is there to fix in the first
>> place.  I
>> might be missing something here, though, as it looks like MIPS is doing
>> essentially the same thing.
>>
>
> All of our load-lock/store-conditional implementations do the same.
>
> You are correct that we do not implement the exact correct semantics.
> Correct semantics, as far as I know, cannot be modeled without emulating
> everything in a serial context, including caches.
>
> We therefore make a considered choice to observe that while ll/sc can be
> used to do all kinds of wild and woolly things, no one actually does so.
> What people actually do is write portable code, using c/c++ atomic
> primitives. And that all of these can be done with cmpxchg, because that's
> what x86 has.
>
> Using that choice, we can provide multi-threaded smp emulation that,
> demonstrably, works.

OK, that makes sense.  I was just worried that we were screwing something up on
our end.

