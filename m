Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 23:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68402206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 23:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68402206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxgHv-0005AT-MQ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 19:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxgHY-0004j5-Qq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxgHX-0002Wo-UZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:32:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxgHX-0002WW-N2
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 19:32:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so52049467pgp.12
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 16:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=VUCYFgLRcrjaURdLsUK0F7+mqlZBM3XUnUhKf279SxU=;
 b=qr640ectSUreHyBLBlnXjBKSlNxKTD/4MbltRjAcH/ekPXTxdjUYHAdHde1mbJIBfr
 tGFnIE+0qtgcTcAnAlYNqwZxFNXfDlkQaldRVVcEuSkmhI4jCGb5F1tGh7e/25q0z/4O
 O8Dqg1+XPhPLgG2f5eLxi9ad4wqfkayAJmq0gEPqdFyE+DQ2iQ/qIYO7aDcg3KY6zrEk
 bzvkzkzYKA2cNQ0jWgQv96Bq0LgH1ot6aqC9u44NDrk0h492pPMNBQo1+zPYdX6uJajH
 Ava5IUTv9xtQ+cvtiZ5nCi+EuFjlkMOMvpc+EFC1LNCO3yfRiLhkmhUno7yH432xhO/q
 Zehg==
X-Gm-Message-State: APjAAAUHnGObJsYveTNMvbJPXECgUm8b89KpFczWU4KHgsBPJItqgBcO
 kKcao5PembAJQ0oPHm5W0BrysI8QIJI=
X-Google-Smtp-Source: APXvYqxyEIxdhY9OaPUWlG3GQ/bez3G6FJqIi3VcEa5NwTg5kaG1TXxE5Auzehp+LL7a4ZcojnnFHQ==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr41734308pfd.48.1565739166427; 
 Tue, 13 Aug 2019 16:32:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id t7sm113231981pfh.101.2019.08.13.16.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2019 16:32:45 -0700 (PDT)
Date: Tue, 13 Aug 2019 16:32:45 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 16:32:33 PDT (-0700)
In-Reply-To: <CAKmqyKNFTFjzHpt5YewksjW=eEZp+A=tmrcb3AynXK56e0tLXg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-9d672209-4c16-444d-964f-54dbb46c8466@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: Re: [Qemu-devel] [FOR 4.1 PATCH] riscv: roms: Fix make rules for
 building sifive_u bios
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, kraxel@redhat.com,
 imammedo@redhat.com, bmeng.cn@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 09:52:13 PDT (-0700), alistair23@gmail.com wrote:
> On Tue, Aug 13, 2019 at 6:00 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 12 Aug 2019 at 09:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> > On Sun, 11 Aug 2019 at 08:17, Bin Meng <bmeng.cn@gmail.com> wrote:
>> > >
>> > > Hi Palmer,
>> > >
>> > > On Tue, Aug 6, 2019 at 1:04 AM Alistair Francis <alistair23@gmail.com> wrote:
>> > > >
>> > > > On Fri, Aug 2, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> > > > >
>> > > > > Currently the make rules are wrongly using qemu/virt opensbi image
>> > > > > for sifive_u machine. Correct it.
>> > > > >
>> > > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> > > >
>> > > > Good catch.
>> > > >
>> > > > @Palmer Dabbelt can you take this for 4.1?
>> > > >
>> > >
>> > > Is this patch merged for 4.1? Thanks!
>> >
>> > Sorry, it doesn't look like it is, and it's now missed the
>> > deadline for 4.1 (only critical showstopper bugs and security
>> > issues would go in at this point).
>>
>> Since a very late ppc pullreq turned up which needed to also go into
>> rc5 and meant we couldn't just have a single-change rc, I figured this
>> was safe enough to also apply for rc5, so I've put it in.
>
> Thanks Peter!

Ya, that's great -- this will save us some headaches.

