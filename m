Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A214DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662E520882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLGHbfEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662E520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRZo-0007oV-QL
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCRPV-0007dX-58
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCRPT-00050f-WA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:42:00 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCRPT-00050F-QL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:41:59 -0400
Received: by mail-ot1-x344.google.com with SMTP id g25so12751277otl.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OHdgwCmNhKmgMIeCtHbUWokcKBKzhyzwuQW+7P+3Cs0=;
 b=MLGHbfEFasB2e7MBeGOjFuA4SgN5ww1idNwL+rvckvAMnJDA7JXidUsnyh53PL0cZP
 aexvw3MMbjSgh9xZWbNQ5C1v4VO9J1zKYAtAFk4I2GOMst6ERliN3zYFnJEBKJD5mMtW
 tDvAuHn3Mjqtt72ltDDdQEh3a/xwECkhPXpysimkz1Or2YVgSyWjzKeVB4LWA02xy/R0
 i3cNmtPKlFx/FqXDk3curMS8SrZvvzxfibI1Ua0SS4SLh2fdEior2bF3QAyb8QRTpMMc
 FnmjwZfi0r+Q1ZYNyj20Hg0Lhrx/ixaYWh66VBmvprkHwCRvfwthykHKmHgYqTe4jbd5
 DM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OHdgwCmNhKmgMIeCtHbUWokcKBKzhyzwuQW+7P+3Cs0=;
 b=hjDBkGFlTYZ8mPBrSWHmTylGRzQsbYZwzOgFhFm7PX91xcxY/VLlHLSAWDvhumzfm1
 YEM5Ia7oraOaXxpFip75zJSHqeAS4bbNBJF9sARm8fXmSZtjbdjDoOkPbGBydDB9fBCL
 iZJj2MMUNZb/us3ackIPr0cNEcf+s/2JrKYeRZ/1RuLnANKnN2U94gOcvNNxbe99Y331
 t8NEenOqdB8K3a5p5gozk0AtvWkohMOGU9cX6T7zmegTceERMoSydWEABh8CI1HMbhxp
 4F5gkewJogoW0e7sBFZQrVBmjl7sk5k0IDmy/7HGIOvoIMrLzPomQer8crTc9328Xnn9
 gfSQ==
X-Gm-Message-State: APjAAAVCYnHHKn0H5uYM39OJwAirgmqzDyGAA9sYAVF47I92WnY/FAF9
 7jIr4EFHmxOseqQ6xWoux6ioBLSOqksrS1uSZjtXpw==
X-Google-Smtp-Source: APXvYqxyIUGRJH+FMlVfaVAtxT3QIzrUxSrg7UvanJz4YeA2RSbWlBa8jynBnATJ1X59o5a2s9ag+2B8WZHXr+AtlUU=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr605162ote.97.1569256918974;
 Mon, 23 Sep 2019 09:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
In-Reply-To: <tencent_28AAA62B694825C348B1DF49@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 17:41:47 +0100
Message-ID: <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Philippe Mathieu-Daud <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 17:26, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> Hi Philippe, Peter,
>
> In target/mips/translate_init.inc.c you can actually see that CPU_MIPS32 =
ultimately contains ISA_MIPS1. It's just no CPU model explicitly uses ISA_M=
IPS. But I agree that if my assembly has a removed instruction then it's po=
ssible to have an invalid machine code in my program.
>
> As for the cross-compiler, I used a tool chain containing a compiler, an =
assembler, and a linker. I produced the final ELF like this:
>
> $ mipsel-linux-unknown-gcc -g -S test.c -o test.s
> $ mipsel-linux-unknown-as -g test.s -o test.o
> $ mipsel-linux-unknown-ld test.o -o test

Can you run QEMU with some debugging options:

qemu-mipsel -d in_asm,exec,cpu,unimp,guest_errors,nochain -D debug.log
-singlestep test

and then put the resulting debug.log somewhere we can get it?
(it'll probably be quite large)

thanks
-- PMM

