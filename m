Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5DEC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ED120869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1Se4Jqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiUW-0002Js-It
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iSiTh-0001NQ-D7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iSiTf-000100-Rj
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:09:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iSiTf-0000zP-JQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:09:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so3168175wrm.8
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sqhgbNz7sLtWLUk1m/b2Lnb5Ms1IygVNHMM0xSDB5/E=;
 b=j1Se4Jqt4T/pEkrY/KG66Sj3UDGB7XADDsRpFOnL8slEjblwRD3p7d0va5nGHAQdFB
 LQg45b98DBZw/ek0WeoC48Re+VWazBf+Jo+X/Itl+k/kn1BtZj73c9ryaEkiKsC3PMro
 cqYRTwjpuOfTL6ZyAVrDAbqqSNz0vAvKe2b0dD5j1veC+Ja2ztwQ/xuON8kBH6HDS0vK
 j1HbCtg1TmOfAXNQFC4vfNHblKJOJuA64r301BcgxIRQkvcp99z4yk+e2GC3Si1/7+fv
 yKc3GEBGcoKPq6l6tw3EwPwa9HrLSjqIV+OzFPij27UZpVpZmN32StItTLkzeFSiKmwr
 0fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sqhgbNz7sLtWLUk1m/b2Lnb5Ms1IygVNHMM0xSDB5/E=;
 b=DpD4HDLYsRSfXtFbdY5Fc1Wk8k3O1mFVk+ddSeWKOUZstBd2lIdGrHxmqZV9WsStZE
 IFRVFGyNFx8cx3M7ZbDpccPilI8rjHLJnqD05I2h9Cp0QSgEVgtjq0LEN8mPjOKu1wJS
 RfV+wXek/f8uf7DnwC1yMuI4a79mc908ErR0yVnbbjW4vkxvYgjhIMZSOicJrlAnmu70
 5d0ZTMKEdYJdySyN61/kBDV1qmTonL8vadRycmw7itQqZBjYRB/qEtWL6Vn0gqPG+zX6
 Wx33mBA44jLiXQMqZHC3uc8psxYHJCLHeDCRYV8vK5CwUUXqzbxVgnyl7bPglfkt2dP9
 uCMQ==
X-Gm-Message-State: APjAAAULT/KvvonrMM9P+VkO1SmhVVAFgJ9GpT07J/kgW04SxUt4R4wR
 NUabBg2nx5xXf1oIo5e8kVleUU2dzQ1zDS57YxUv6w==
X-Google-Smtp-Source: APXvYqw48TGy9L5DPThcqmmXqKKYkPtZq+zLbJiKc7XZPAYfaTUmGOPB2+cKMA77dw4HtpRHls57bClzFc3I8SPfeLc=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr2931815wrn.32.1573135773478;
 Thu, 07 Nov 2019 06:09:33 -0800 (PST)
MIME-Version: 1.0
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <20191107115203.GD120292@redhat.com>
 <31917972-da28-8e0d-432d-1cb7607ff3e7@redhat.com>
 <ad6a25e6-6019-e02f-b632-e19e6eeb0b95@redhat.com>
In-Reply-To: <ad6a25e6-6019-e02f-b632-e19e6eeb0b95@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 7 Nov 2019 15:09:22 +0100
Message-ID: <CAKv+Gu-AszKGwF+hRP6q90MVpP4griUKJ3+bMBgJLuq92E5SQw@mail.gmail.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 14:44, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 11/07/19 13:47, Paolo Bonzini wrote:
> > On 07/11/19 12:52, Daniel P. Berrang=C3=A9 wrote:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013
> >>
> >> Is it practical to provide a jitter entropy source for EDK2
> >> too ?
> >
> > The hard part is not collecting jitter (though the firmware might be to=
o
> > deterministic for that), but rather turning it into a random number see=
d
> > (mixing data from various sources, crediting entropy, etc.).
>
> If there is *any* entropy source that (a) we can trust to be random
> enough and (b) depends only on the CPU, then we shouldn't struggle with
> virtio-rng (or similar devices) at all. RDRAND would be a no-brainer,
> but the "community literature" suggests it should not be trusted in itsel=
f.
>
> I've read the commit message linked above, and it appears too good to be
> true.
>
>     The CPU Jitter RNG provides a source of good entropy by collecting
>     CPU executing time jitter. [...] The RNG does not have any
>     dependencies on any other service in the kernel. The RNG only needs
>     a high-resolution time stamp. [...]
>
> http://www.chronox.de/jent.html
>
>     The CPU Jitter Random Number Generator provides a non-physical true
>     random number generator that works equally in kernel and user land.
>     The only prerequisite is the availability of a high-resolution timer
>     that is available in modern CPUs.
>
> http://www.chronox.de/jent/doc/CPU-Jitter-NPTRNG.html
>
>     Today=E2=80=99s operating systems provide non-physical true random nu=
mber
>     generators which are based on hardware events. With the advent of
>     virtualization and the ever growing need of more high-quality random
>     numbers, these random number generators reach their limits.
>     Additional sources of entropy must be opened up. This document
>     introduces an entropy source based on CPU execution time jitter. The
>     design and implementation of a non-physical true random number
>     generator, the CPU Jitter random number generator, its statistical
>     properties and the maintenance and behavior of entropy is discussed
>     in this document.
>
> If this construct is legit, a core edk2 implementation (available to all
> platforms, and on all edk2 arches) would be a huge win.
>

 "that works equally in kernel and user land"

Firmware running at boot time on a single core without any serious
scheduling or I/O going on is not going to produce any entropy worth
mentioning, I'm afraid. And if it does, it is going to delay the boot
substantially.

> On the other hand, we're having this discussion because the premise of
> TianoCore#1871 is that we shouldn't rely on just the CPU and a high
> resolution timer... I simply cannot decide if this construct is
> trustworthy. (With any solution that was based in the host's /dev/random
> or /dev/urandom, the trustworthiness question would be side-stepped in
> the firmware.)
>

