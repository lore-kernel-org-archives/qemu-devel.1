Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E091C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E5B205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PG2Gf8ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E5B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4Yn-0004Pk-5Y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3TN-0004Gc-Es
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3TM-0003tI-Gl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:04:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3TM-0003sl-8u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:04:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so14898386otl.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BH24mY7k31TZuEACtPdnoer+3QK+UzkYFwAlGUuW/xc=;
 b=PG2Gf8lnkqL04b54KHIPw303yj+wZif5+Nx9aTpQBUdj5AbSYQXUAps5bD+h8EObaG
 outuZZHpWugFVGZ2bjAs4gkr0Nb6EoJcxcqanqFNDFA9pp5hzcqwbpcVMQep5R/T8dQ9
 xg/QooE7bfVEXbZ7T6G5YLwI7ekHCKo7XrSQdCkeb8ywqyHJN8CAeIqKtm4XAm1oK5o7
 u824WE2f8nWeA9MVLlVJrq+O22Te9CoqsH1/cztSfuw8zObSmgzc5kstX+FNzG0Mgw2+
 ZBDVfy/1PG+WEBj6kZc2m1b7jBFAsR5rTfFRuct9dR5ZtoakOZUWn8em7oAezRXWallN
 Blzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BH24mY7k31TZuEACtPdnoer+3QK+UzkYFwAlGUuW/xc=;
 b=ONkg9JRKDzkVUDeo6JYBMy8ajziFtxswh0bCUzLb3X29Ts3lJLQoC67shopUwTp9kF
 RcAvmbu9oLuHDiOr7Oo9m2i2WMn1KYoMFxSon+LNoEIwnM2OboV4jijjiWraSF/RRnAv
 abAWBCy/2YOegyh/JMN7rri479UBCUMMgIrUeUQiOxv4vfQqtJi4ONumRrVYZlyPh7/x
 12I36chVxWUsU+WnfzsSIzCnxb0X80ftOw22Ix4KXuKbMtHGEgMnhi3ogJnGKgbYm41o
 ta1jlF1wldNgmQ2GJqnRJPDPHmnb4T+KS9xKjDuZZbVcCMUEVh5zsbXOt1mGuwZOPOAz
 bsoQ==
X-Gm-Message-State: APjAAAUngFlJbb2N9b/MLOPXJYnIDKEAiw00+Bj4T0J6xLmtJ7r48mrs
 tU7hwMmeVS8KbODwCg8DnqWWmbHSL7i128UxF2/EXdjSR64=
X-Google-Smtp-Source: APXvYqxurZRvyLXBTyGMagF+p8aXINbgp9r1YhxiIZyGtOtKkuw44zNowbC/NUnXNTNz2ius8HACwgpp5BWCKF67CGc=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr9605025otk.221.1562004794476; 
 Mon, 01 Jul 2019 11:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
 <efaaaa7aabddfb8481af4c5b2eeec23513f8fcb8.camel@wdc.com>
In-Reply-To: <efaaaa7aabddfb8481af4c5b2eeec23513f8fcb8.camel@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 19:13:03 +0100
Message-ID: <CAFEAcA_cwm_1VhGW7yGL6=ja7TuO3c9perBs_OoWMaXBhJYH9g@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 19:09, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2019-07-01 at 19:01 +0100, Peter Maydell wrote:
> > On Mon, 1 Jul 2019 at 18:50, Alistair Francis <
> > Alistair.Francis@wdc.com> wrote:
> > > PS: It seems like there are still some issues with this patch so
> > > maybe
> > > it's worth dropping this patch from the PR so that we can get
> > > everything else merged.
> >
> > Yeah, that would be my suggestion.
>
> Can you do that when you merge it or does Palmer have to send the PR
> again?

Palmer needs to respin it -- pulls are signed and I can't
modify them, only either apply them or not. (Technically I
could in theory cherry-pick all the other commits out of them
but that would be a huge amount of manual labour.)

thanks
-- PMM

