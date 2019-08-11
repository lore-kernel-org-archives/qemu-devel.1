Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD20C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 16:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4549B208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnygUUUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4549B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwr4C-0005p9-Hk
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 12:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwr3e-0005N7-4K
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 12:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwr3c-0003dm-RZ
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 12:51:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwr3c-0003d4-Mv; Sun, 11 Aug 2019 12:51:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id c34so10895651otb.7;
 Sun, 11 Aug 2019 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2bNd7kS07e8DmxE9VISRIf3yUieomvDkgZDU7pz9CAQ=;
 b=MnygUUUjCUzf+B78U23UVPJca9vfU1tfNKret7TB71RNVvI0JhH3hUByqgt36dnULL
 6+iSqaoXV4ih1IzpvSLTF5N45phstlH+T1AsuHsWaVXvS5YZ3QRCj8rp3fHs3aI6aRFV
 JubNQSDdC06Esu2UvlGDOyK4MUIym06esVXQ7sNbcmLVSiqlrjL/YsPEUnyDfWIG4e2e
 4zxFmU9i3fRVG1oFWgVtWHB34HSWLZ0WUhooLugLZV7dl3JAEPtLZsFURr9KW0zPEcOm
 jS5ik3Zc8aul+Q7YeL4d7u9lwxzGlOpQ/k5v11B1LN+13/HgIh8KJ7E+6dDNastJw1Jo
 3Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2bNd7kS07e8DmxE9VISRIf3yUieomvDkgZDU7pz9CAQ=;
 b=TRm0QVTFigPzYNkftwZlYUjgkY8EvBKubSkKTLwJd0bdhAdyOXYvR79ZK3PxjoaOul
 bpuMrYaOmZBp9D/LugV0i61P+np4MpmVI9xki5y+bYcmSP/62YBNaDJNmKLI39EBD/Ac
 m/n31QFbkS3ZVx2LDZG808zufdEql7hDGxIEHObefYiONzVWkikWCTmPUIDpC/FtfYd0
 kCtpBEG/U+MLHiD7ekkvvQDeYMRb7lGcPbeon6XvU7Tdt3ZGTFtM10akEVYoVNXe/pVg
 tWjEx69SLsJ1s1GZzFXAMUjUYhQVSLkRLv2DqSFrdjiYAmTgWgSd3rlqAR6wxNnEyLQQ
 3C3A==
X-Gm-Message-State: APjAAAV9GO8nnd6js8LmHs0e6EpYcTnqnMLi9aHYAgnaP3wSL5ZPRYMV
 D9vD4suzpmontKOz48uhVICmIFBs9gbKz7J1FKw=
X-Google-Smtp-Source: APXvYqwJ3GlW46Z5hXwCAWkQ3FkfcfRQh7UYu1lGslG+KpyVSf4z7G5PitkHRbauBzDPUZL6P4V0wBa6dGLEdkM1pBs=
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr12115520iok.75.1565542259591; 
 Sun, 11 Aug 2019 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
 <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
In-Reply-To: <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 09:50:31 -0700
Message-ID: <CAKmqyKM5zneojhPe57h1+h3pav5kQxFaMnhNiwWRUa=nbzS3Ag@mail.gmail.com>
To: LIU ZhiWei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 10, 2019 at 6:55 AM LIU ZhiWei <zhiwei_liu@c-sky.com> wrote:
>
>
> On 8/9/19 6:54 PM, Alistair Francis wrote:
>
> On Thu, Aug 8, 2019 at 2:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Hi all,
>
>     My workmate  and I have been working on Vector & Dsp extension, and
> I'd like to share develop status  with folks.
>
> Cool!
>
>     The spec references for  Vector extension is riscv-v-spec-0.7.1, and
> riscv-p-spec-0.5 for DSP extension. The code of vector extension is
> ready and under testing,  the first patch will be sent about two weeks
> later. After that we will forward working on DSP extension, and send the
> first patch in middle  October.
>
> What code are you talking about? Is this QEMU code?
>
> Hi Alistair,
>
> It's the QEMU code I have been working on these days, which implements Vector extension. It is under testing,
> and will be sent later.

Great! Please send it when you have it ready. We can accept draft
extensions in QEMU as long as they are disabled by default.

Alistair

>
>      Could the maintainers  tell me whether the specs referenced are
> appropriate? Is anyone working on these extensions?  I'd like to get
> your status, and maybe discuss questions and work togather.
>
> Just use the latest (master) from the ISA spec git repo.
>
> I will follow your advice.Thanks for your attention to this matter.
>
> Best Regards,
>
> Zhiwei
>
> I don't know anyone doing vector work for QEMU. It would be very
> useful, but everyone is busy with something at the moment
> unfortunately.
>
> Alistair
>
> Best Regards
>
> LIU Zhiwei
>
>
>

