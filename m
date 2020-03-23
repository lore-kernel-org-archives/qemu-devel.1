Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDFC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3202072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKSrABSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3202072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOBy-0001mP-Db
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOAn-00085p-RQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOAm-0005nK-FQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:35:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGOAm-0005n1-3m
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:35:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id y71so14887989oia.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O8YrqvVpvDcWYfFBN5ISXiV8DsKV9qyGEicBOPeQA20=;
 b=tKSrABSEGOIQEruU32R2e86igRezCPGZNNFDMfFKl2TnuVAxQ4QWoVerEFWIT2w/1X
 Xhf8l1Rnor6R4z7ZtR9bXU5g7cOzAnK/Y0CgAF/FRMDMb5tf4IOc4C5ICcaNICDmM2ki
 BNVo8iS0bNuvoMx+3YRPMSoGcU7o3t9A/wn2JpGQE/p2fT+gHFWNPwSesnGzfPuHuALU
 CKEI8L0vjcpokqHdJiN3/jswWP9EeWbtYbvY9Nx9x2uVmbm41FYU6a8pk4JE+XWrnn+C
 w+ZZeA6aYMLwS+q7R2Y+OHFHSdQbcB1RlwTGY9lDAeEIa8BNUPHzqGpBa9B8sjt7032u
 tnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O8YrqvVpvDcWYfFBN5ISXiV8DsKV9qyGEicBOPeQA20=;
 b=jToorThX6r9X0foQXBLQq4ofU6A9kzWw131pTQAQ4omhBrqbb15I5rOiZd3gNJj+zA
 vgL9MUjSdCI4qkjte+xLHgFfRdpL6TAXkNs2EoG19YrW47K+XZuiCHJP8haPj2EaJUyk
 EGLLAlZZV9wsIbwfnsonwxjX7l7I5D2QtxfH3hAaDQqBjNeLkZjxoGClQDsxpvGrUGzk
 3rCLmUHTGTUvfu1Vz5yRja0xz+SePoIOpXfGd8lA/xmix5rHP8dDgRzVbwvzoif0ye/Q
 15hWKV8Nd7SBP32dONrMOrbw+KhfU60pJWWFo22LRKeFkZO/FgHEYUyQ/wg9WxhWNNhe
 srJA==
X-Gm-Message-State: ANhLgQ2tLr1jASVVlzT8O1fp1BGzL5vm3L9WxhF9PcaCnYCzbXR1fEn4
 HktF7nrlX1pGVSppN+g9+ZpLXgKSz94WxchrlX3Qrg==
X-Google-Smtp-Source: ADFU+vuCBlWyv8k1gtoVKNNkyMltZBsvGrEdEugvK7FS/N1zFvJKo9kmVCUWowskkIWjg1JW9SAHmTPIT3FA+VXqjec=
X-Received: by 2002:aca:c608:: with SMTP id w8mr17584827oif.163.1584974123157; 
 Mon, 23 Mar 2020 07:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 14:35:12 +0000
Message-ID: <CAFEAcA9Ubue9Lk2jXJyZ+OUmk0j58ZKKnER1RxMi0b05FaN4QQ@mail.gmail.com>
Subject: Re: Coverity CID 1421984
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 14:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Mon, 23 Mar 2020, Peter Maydell wrote:
> > Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
> > most of them I've for the moment just set as "insignificant, fix
> > required" because they're in called-once functions like board init.
> > If this device can't be hot-unplugged and so we will only ever call
> > realize once, it would fall in that category too. Otherwise I'd
> > suggest conversion to qdev_init_gpio_in(). (This allocates arrays
> > of IRQs under the hood too, but the device_finalize() function will
> > automatically free them for you, so it's easier to use non-leakily.)
>
> I think I can't do that in sii3112 becuase I need to pass irq to this func:
>
> void ide_init2(IDEBus *bus, qemu_irq irq);

 ide_init2(bus, qdev_get_gpio_in(DEVICE(dev), i);

should do what you want, I think.

thanks
-- PMM

