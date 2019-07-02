Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA7FC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B14206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jkJskk3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B14206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiD9i-00017q-Sz
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38749)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anup@brainfault.org>) id 1hiCoj-0000EY-IP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1hiCoi-0002hP-Cx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:03:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1hiCoi-0002gg-0p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:03:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1949274wma.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BBAmZmdgcdDCD9usnpWrZf0ZUqD4D/I7QKuIr/LnZ0w=;
 b=jkJskk3/98WO1x9NFoL7SWQirw65UzlxaGT8hrGFRCnUCA09cALgQ+52zdIZpqwnOJ
 gvC8K4pPnDytZ66YInszUTzzlYq5scoTUHwsynwDF16TDH1ta8qleAmk3ITUMg8oqs/U
 FOtwi4r9uEUJxo1CG/e2EwlGeCkjd9Csu8w9p1pRQg1Dd7YYZlfGYjeh/RiFWUEHsvYK
 ju9YX7cnAlPaX6Ck5abB0dqrFfFqHzDs+PsdIgm67LnwO0NrNCj6iqUHmMoGEzj2u2gY
 LuOKd9XTD3sbzONI4fX3tjKqRa5MAzW27E9+R5DcHQH/eZPrfQe8d3JgT7A8UeK0FCOt
 pxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BBAmZmdgcdDCD9usnpWrZf0ZUqD4D/I7QKuIr/LnZ0w=;
 b=DBjFUrpLtPrc79KcJd7qJ71MZ8prQwnDcU80X1dMgCoYvJVS/v2cVCUzOlzatpMvxX
 Tzr0W3NZ3RvVRrbQvZeVXB6lXjms4xWI5LWeuv1LCOFEgYEbZwOs2X9D6KbcN5c3s16D
 A5t7LyMBsSbtlHjJQmgdyfqTlPn4aFWPXniwzAwRupzh7WyxyxewOLQSMMh5OEks6pxf
 CZEtvtR7dM0ZArRKriwXLXu4mOBA5jIRT0u9plt+zGPo+KLtbOccds4B7vK8+4vUiMWC
 PTAzCflrtRntb8ilE0zLHvMFy8nOibwgD9Gk8lMcwl7oLQ2MZgnb2PDcYJ+RbOtkp2Hb
 OEVA==
X-Gm-Message-State: APjAAAU48lFbFOBRofUXnVTbdlCQfxQGKuPuIpnyoYrlnByVWz+xQX4i
 3bI6BteSVGNwQKp5ee70TJw5dHA/Cwbd2uhk3h27lQ==
X-Google-Smtp-Source: APXvYqwshUJg51/IqmFHtP5wqfAw17GO1Mgfkp7BurlTalAFHP6l+zwVmunfJPNbhoSaFvma7U6LNsYIoeMtSdQH89k=
X-Received: by 2002:a05:600c:254b:: with SMTP id
 e11mr1952064wma.171.1562050982287; 
 Tue, 02 Jul 2019 00:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
 <efaaaa7aabddfb8481af4c5b2eeec23513f8fcb8.camel@wdc.com>
 <CAFEAcA_cwm_1VhGW7yGL6=ja7TuO3c9perBs_OoWMaXBhJYH9g@mail.gmail.com>
 <9363cb8764e800d8c30ff6722c680e4aa8bd9271.camel@wdc.com>
In-Reply-To: <9363cb8764e800d8c30ff6722c680e4aa8bd9271.camel@wdc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 2 Jul 2019 12:32:51 +0530
Message-ID: <CAAhSdy32YLhqXi2Gsk7zYfhUx1r2US=AsJn2E0WVSvNutHQ8_Q@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-riscv] [PULL 33/34] roms: Add OpenSBI
 version 0.3
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 2, 2019 at 2:57 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2019-07-01 at 19:13 +0100, Peter Maydell wrote:
> > On Mon, 1 Jul 2019 at 19:09, Alistair Francis <
> > Alistair.Francis@wdc.com> wrote:
> > > On Mon, 2019-07-01 at 19:01 +0100, Peter Maydell wrote:
> > > > On Mon, 1 Jul 2019 at 18:50, Alistair Francis <
> > > > Alistair.Francis@wdc.com> wrote:
> > > > > PS: It seems like there are still some issues with this patch
> > > > > so
> > > > > maybe
> > > > > it's worth dropping this patch from the PR so that we can get
> > > > > everything else merged.
> > > >
> > > > Yeah, that would be my suggestion.
> > >
> > > Can you do that when you merge it or does Palmer have to send the
> > > PR
> > > again?
> >
> > Palmer needs to respin it -- pulls are signed and I can't
> > modify them, only either apply them or not. (Technically I
> > could in theory cherry-pick all the other commits out of them
> > but that would be a huge amount of manual labour.)
>
> No worries.
>
> @Palmer can you please drop these two patches from this PR?
>
> hw/riscv: Load OpenSBI as the default firmware
> roms: Add OpenSBI version 0.3
>
> Sorry for the all the last minute changes. I'll wait until OpenSBI 0.4
> to respin those two patches.

OpenSBI v0.4 is now available.
(Refer, https://github.com/riscv/opensbi/releases/tag/v0.4)

Regards,
Anup

