Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B52C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9224420820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMDJ6Hh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9224420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx5rN-0001Er-AO
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 04:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hx5qo-0000kU-08
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hx5qn-0008R1-2e
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:38:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hx5qm-0008Qi-V5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:38:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id g17so5063866otl.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rt4wMHJ1FkT8oaLcosvpZeywUxaWn5M/xN0sWm1YguU=;
 b=QMDJ6Hh1HIZvEpOscypa2a+AKzxcqcfYRf4D4Wy58HzifHq5FnC4NSdXd2FsFY4Y1g
 JJBRzWaIliSIHwDlbAO/mmQBrw7N01WPhtI9T9WI/hnDQceAeejPWyoaYhY6XBNnYyJ0
 ob1y6C/V6kZZDKktq3T7bIaEVQoN6OkChXPWNtLx4xkemKRfwJ5vCf7G19fB7NCotjPE
 1QmSvcBT+UaNB/13Ol/zS9uZQYaH9sjLKj49ki5akEB39xlI/+q79fmV0ihVHjgqA4o9
 dFtie9MpSvztDypGUT1wvwv5WBdSudxeNtGHCRPmYh8q7QVku3rJkMCEAV4F6J1rY1h2
 E1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rt4wMHJ1FkT8oaLcosvpZeywUxaWn5M/xN0sWm1YguU=;
 b=qODWHbfd9DY3ftDHluzJ4xIoaUrI8ZHJaQLbcvGsrNdh13jJYOGqn9K/tszWR9I5AS
 WKEf+nhhi3SOw4x/Cgzvn7FTr15DUb65RTGUDbjtMM6uLKW61TysENRJLj/bz7CbXTND
 jKa//wSbBpOtNgImopbYX7ISm1QD5OIQ0Es94bj8u610D5/KpeObls7vEq1+j7LREKh2
 aMNa09laLb9EzpfE9v9YGtroPqEPTwu4go9f9Yhaz6q1v1EwnWeVshaLKOgdFuv0Ph+R
 VCJUwEV/EMlWZyNmgul5aAmbpIqWDjnFJIlXCB9vj3KnU3KPmmv+VRN8vW0I3JKS0WN2
 EDCg==
X-Gm-Message-State: APjAAAXM7elC7Nmzqqjf0iJg2KeiUn8l9/AQptqZPS0xFvBZ87VRvNsa
 FmN6+6TJUvtYRZ+zP8m0KfQVzaLnlCsjAKVg1yHH7A==
X-Google-Smtp-Source: APXvYqzYL6YIVtwh8OyWtbKZeqLJJ4FA9RNyh8Q7x3lXqSrM+xVXWXJXVN815UVstS59xsLs3LZ0QZ8RluU5AOjCK0A=
X-Received: by 2002:aca:4bcc:: with SMTP id
 y195mr12706070oia.146.1565599124103; 
 Mon, 12 Aug 2019 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPW-nMc2zV-VwG_sY9ca7uSenUJW+mEcV2qaKT5dELmgA@mail.gmail.com>
 <CAEUhbmWwkMR4xKu9v=10ePj=feJ7b7e5Ko75zv1xMBf+JrVwwA@mail.gmail.com>
In-Reply-To: <CAEUhbmWwkMR4xKu9v=10ePj=feJ7b7e5Ko75zv1xMBf+JrVwwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 09:38:33 +0100
Message-ID: <CAFEAcA91uvheC1gdu7DZSkaVtgA3Laoob6G+bQMQOdfsQj9aSA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 11 Aug 2019 at 08:17, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Palmer,
>
> On Tue, Aug 6, 2019 at 1:04 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Aug 2, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Currently the make rules are wrongly using qemu/virt opensbi image
> > > for sifive_u machine. Correct it.
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > Good catch.
> >
> > @Palmer Dabbelt can you take this for 4.1?
> >
>
> Is this patch merged for 4.1? Thanks!

Sorry, it doesn't look like it is, and it's now missed the
deadline for 4.1 (only critical showstopper bugs and security
issues would go in at this point).

thanks
-- PMM

