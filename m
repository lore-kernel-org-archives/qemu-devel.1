Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00672C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC054217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw8HkL41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC054217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvgcA-00016V-3M
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvgbn-0000gW-1M
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvgbl-0000yW-TL
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:29:26 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hvgbl-0000y5-MD; Thu, 08 Aug 2019 07:29:25 -0400
Received: by mail-ot1-x329.google.com with SMTP id r6so117092737oti.3;
 Thu, 08 Aug 2019 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=65T6irR93j3o1VJcC82y3rfX/tr7CMxrI07g2y2C2D8=;
 b=lw8HkL41ObGdPfULnTR4ObPDSIITp9VSjynNiA4G4vsoX1ATCjNxES4rH9Yx1rQBP4
 6jspzObs5UkPKVQsvDptu/tOcxo1s6trIPYcfK9vrGX0MiwN+ZWPfgvZlnDSqNsugrV/
 iocymHcid0bkDrfQz7vTorvVru8A8eSg8ekdu7E8B9vnhR+Vx5GP6shaOMuMsiyJpI+D
 ysI/0f6IoL4XPT1E4Ccexhpg4N1Jh7EOtTrXaeo4mb9jmUI3LQCKEAoBHTKo6q4Bha1j
 Qm/Kk+BbLYs8xbRfdbgSUnlNyo31QN9qOAEAnxQFS86J7SRQtXv6oQ10DytAutIY5Z4J
 GwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=65T6irR93j3o1VJcC82y3rfX/tr7CMxrI07g2y2C2D8=;
 b=IylGpSqH4I7bMRVTiS/ol8GixHBKTeY8am9jOrIn6V9WVoMFQ9Vjb55rmYJuEgKvUF
 NrI9gZ+4Gg+1OWMceUBnwLNAwveuhP5Be2nB+C4BQLK1q+9DaUh+F0ZobHYq1n0XNk7V
 8kVv8b8NVJJS+OuX9Xo7RumZgpF4cv/awqwAV2654o3Cosr5SdZ1zl46h3zg2fuRZotU
 CucEM/x5u8g+Mi6ss8ObE2r/MDusITJmyolY2dfDPSZ6XU665XCLon+/aO7/xoPQecjk
 3vkXoPq4Oy7o787rsYpM5KwNS1VMMxoUF4MCei2c2Ovmkn7xass6uzCprEb0rAwK/LLJ
 RUSg==
X-Gm-Message-State: APjAAAVq31NbIYHfsZBaoHJB5F1gsvSrn/qTKh5EcHLSzMMQSwHGnYYG
 qXPRtj8me8k8SD/wzLJtb5z6Akvq24IHHkqs5Ac=
X-Google-Smtp-Source: APXvYqybs91oDjdeadFRoI4qIHVBQcyjiBy5qxm7UrdGTvV51z+nRjaGhL5PhB/xNTIuuMxQMYYN9CZrO90GCGrZsG4=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr1501828otq.306.1565263764509; 
 Thu, 08 Aug 2019 04:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
In-Reply-To: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 8 Aug 2019 13:29:13 +0200
Message-ID: <CAL1e-=jceerbvam57mmXoKWHzepB-qUFL08gBEnSws_ohewLzw@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 11:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:

> Hi all,
>
>     My workmate  and I have been working on Vector & Dsp extension, and
> I'd like to share develop status  with folks.
>
>     The spec references for  Vector extension is riscv-v-spec-0.7.1, and
> riscv-p-spec-0.5 for DSP extension.


Hello, Liu.

I will not answer your questions directly, however I want to bring to you
and others another perspective on this situation.

First, please provide the link to the specifications. Via Google, I found
that "riscv-v-spec-0.7.1" is titled "Working draft of the proposed RISC-V V
vector extension". I could not find "riscv-p-spec-0.5".

I am not sure what the QEMU policy towards "working draft proposal" type of
specification is. Peter, can you perhaps clarify that or any other related
issue?

I would advice some caution in these cases. The major issue is backward
compatibility, but there are other issues too. Let's say, fairness. If we
let emulation of a component based on a "working draft proposal" be
integrated into QEMU, this will set a precedent, and many other developer
would rightfully ask for their contributions based on drafts to be
integrated into QEMU. Our policy should be as equal as possible to all
contribution, large or small, riscv or alpha, cpu or device, tcg or kvm -
in my honest opinion. QEMU upstream should not be a collecting place for
all imaginable experimentations, certain criteria on what is appropriate
for upstreaming exist and must continue to exist.

Yours,
Aleksandar




> The code of vector extension is
> ready and under testing,  the first patch will be sent about two weeks
> later. After that we will forward working on DSP extension, and send the
> first patch in middle  October.
>
>      Could the maintainers  tell me whether the specs referenced are
> appropriate? Is anyone working on these extensions?  I'd like to get
> your status, and maybe discuss questions and work togather.
>
> Best Regards
>
> LIU Zhiwei
>
>
>
>
