Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951AB20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ic9n0shd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951AB20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfuZ-0007rK-6k
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNf5M-0008N9-K2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNf5L-0005cM-Du
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:31:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNf5K-0005bn-5b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:31:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id d8so9837393otc.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vuNzvSaBraIFLt8uoV90RNwLo/LGzjlc4pA2Q+3haAE=;
 b=ic9n0shd81jfYrQfgsj9GVgWmZ0/iHYok/QHtmw1pXz7CMvy++bXLBS6Wk8pWS4N0m
 5TjbmRudqde8Yc9W6orVmnArE0JVnhJQbwt7RXr47kBNbPQZirh/G+GgEs+CaxZBNQsv
 dzzZxOFFvL9BI8TB0go2M6rDhI3V8gUuIF7hC7Uj0Jt9q+oifV3Xdzgq/AIoKw56A6Wq
 rVzRydxTlV77IK1hu6+oVE8Tb6SHHnTd4x4O66AgXTVXpPrdcpBiF6DVHsZNDjkcL/Md
 dv3POWYx3Tb9ddTtO0y39xDm7C6leMKKar34oVgsbKfJxvoPpXk9HiNLT2ZILdazv9kU
 9wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vuNzvSaBraIFLt8uoV90RNwLo/LGzjlc4pA2Q+3haAE=;
 b=I3hWz7q6CBD0N5PGdWyMDJQhG1t3Bt3Qss8e5nRAhbhQEk7qIX9qyduw1amg8/FN5G
 uCvJs0YncIpe1BodSnjV/85OXa2CYSHd3JMQwjkNOX6c6TpSpPu7HYtDPeJ3hTNjaAKR
 n88+xbkUHgxKxdmfKuhfOUDhVjAigcbs70oGM/YKoyJDGw+SPLn5VgR61Sq/jCqizoVn
 mLDSxMBOrPygS9nXX8YDZPQwuUhjleOAcF7LDahvgX/yytAbQzJs/nzrbMbTLPxXXN4H
 bvvgzAYZmp5BJTQu4+tb8uwDO3jCe0JsSHC7Zh/J66KNtji6ORb7a4R5oAGyEJNEl90S
 srgA==
X-Gm-Message-State: APjAAAW0JLxpkS3Y1OQXm3bJ93J7QOAvhYQ8zTyO1LP7vwBj/R2u+zpe
 bW/PMTN5L0w4b8bqwgpSbn4sMWYbFebCwBN+9iCFJA==
X-Google-Smtp-Source: APXvYqxaJgpk8wLDPfzMPfGtiJwY2NxiVtTwifxN7KLvgeTvniiUQlEXQFbq7BCgV7WOapZxp7FM6PQ7nJ9QPdkvM1M=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr12580473otg.91.1571931091907; 
 Thu, 24 Oct 2019 08:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
In-Reply-To: <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 16:31:20 +0100
Message-ID: <CAFEAcA-0qg+VbE6VQpdCAX5g6=GzZG18j_FoiamHR8YrKHrmFg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sun, 20 Oct 2019 at 00:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> >
> > Since v2:
> > - fixed issue in videocore address space
> > - allow to start with some cores OFF (to boot firmwares)
> > - add proof-of-concept test for '-smp cores=3D1' and U-boot
> > - fixed my email setup
> >
> > Previous cover:
> >
> > Hi,
> >
> > Some patches from v1 are already merged. This v2 addresses the
> > review comment from v1, and add patches to clean the memory
> > space when using multiple cores.
> >
> > Laurent, if you test U-Boot with this patchset again, do you mind
> > replying with a "Tested-by:" tag?
> >
> > The next patchset is probably about the interrupt controller blocks,
> > then will come another one about the MBox/Properties.
> >
> > The last patch is unrelated to the series, but since I cleaned this
> > for the raspi and the highbank is the only board with the same issue,
> > I included the patch in this series.
>
> I'm going to apply 1-10 and 14 to target-arm.next.
> (I've reviewed 10, and the rest have been reviewed.)

...but that causes tests/boot-serial-test to throw
a clang sanitizer error and then hang:

e104462:bionic:clang$ QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm
./tests/boot-serial-test
/arm/boot-serial/raspi2:
/home/petmay01/linaro/qemu-from-laptop/qemu/memory.c:2517:27: runtime
error: null pointer passed as argument 2, which is declared to never
be null
/usr/include/stdlib.h:819:6: note: nonnull attribute specified here

The offending patch is "hw/arm/bcm2836: Use per CPU address spaces"
(patch 7). So I'm dropping 7/8/9.

thanks
-- PMM

