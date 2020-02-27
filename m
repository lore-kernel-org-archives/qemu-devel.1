Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FFEC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945F324688
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBemmj6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945F324688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Ksb-00019b-P2
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Krq-0000bU-Ek
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Krp-0003D6-Ac
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:14:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Kro-0003CN-Qh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:14:24 -0500
Received: by mail-ot1-x344.google.com with SMTP id b3so3230295otp.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tBunEO6n1Cf3cqibwNADI9A/VhZGvU7kq5vzac51UFs=;
 b=JBemmj6fDzrzZHcTQqIF5ooil6h9GdvALZS29ShHp/Ao5mTXmNOQJvqdtrSyUwseqy
 euy2Zv46C3pOxM3Q7kO3YFmKHKM3PoVunxZdKgXcsKOSZP+DtFGAf3H6wEcAK0zyTQe5
 5j3tgVHfgpB6Z1FP0ZJzpu1+rGW5UNMO1Dqjbj9y9Wq2vnS1FVKsnUq1oEVaqhyvYO0g
 kRgu7jtNdj1lReKucp03nRmlBmw7yRO6W9hAdOgsEcM24+/QuD2umDViwhekAjnrlGlE
 RC780l6NX8vrDDHPnIih9cFnQfL04Kb+vmzspPefOJ8Z/JM3myQDBJ5aoImeKxNxhcmv
 lCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tBunEO6n1Cf3cqibwNADI9A/VhZGvU7kq5vzac51UFs=;
 b=a2TudKWLNxFIC0Y66jrSeHt8qdpvIsf8N3ka+70rxJpXJ3jTKj9QsYwU51VcF0Qiey
 uT7Yfa7VwDo56mi4BNLStj2SOctDn3aiyiI/C00mbwcbrYlivyo5uzranYo/TDADSUVI
 aNIUgBl89eTVpCVWVY1cA6UQ1BEVXPdy4nLfjVq6P6+/mvRq1VdpCxU//PB4lACTxIit
 /y3fTNYg0M8RppbUykhImrWAMKLfULGdeOXMpZcXCxxUeKoKJuKe5xw8guO6kV2M0pXV
 sTSy9QgbREO2hZbT+janji1IufxoQmxX6zCzMY1iD/900UcJYb8y/shZ39yTnU1ilgXA
 qmoA==
X-Gm-Message-State: APjAAAVzrH8rKYEavZ32j9HcxeIMkqFMqsuMTKTInSJUA11+S9+Fa3n2
 49wM3S53bRfu1+hcJebOnLwdXUsCoWSXfRB3xkjryEZP
X-Google-Smtp-Source: APXvYqzgWEjrtxJ3v6x+kSWAAQe2n9vZKrk3wMp16F5UEDfwydykqowubwzsgnz/GAkueJgKhXbOu3jyRl6E6mAdlVc=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr89504otq.97.1582816463293; 
 Thu, 27 Feb 2020 07:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20200227112617.66044-1-root@stephanos.io>
 <20200227112617.66044-2-root@stephanos.io>
 <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
 <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
 <SLXP216MB0285F1E97DBA3FDED2ED72D2BDEB0@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SLXP216MB0285F1E97DBA3FDED2ED72D2BDEB0@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 15:14:12 +0000
Message-ID: <CAFEAcA_s_UgtRJKjHnwFrPj0PSzbEuPEpdePnTpJ0bbuBrCJug@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Stephanos Ioannidis <root@stephanos.io>
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
Cc: Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 15:08, Stephanos Ioannidis <root@stephanos.io> wrote=
:
> On 2/27/20 10:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > I think Alistair and myself use the 'loader' device with Cortex-M board=
s and never hit this problem.
>
> I tried both `-kernel [ELF IMAGE]` and `-device loader,file=3D[ELF IMAGE]=
` without any success; in both cases, without this patch, QEMU hard-faults =
during start-up due to the unavailability of the vector table content at th=
e time of CPU reset.

You only run into this bug if:
 * you're using a Cortex-M CPU
 * and the board model has aliased memory regions so that the
   flash or memory you're loading the ELF file into appears at
   multiple addresses in the memory map
 * and the ELF file loads the data into the aliased address
   rather than the CPU's VTOR register reset value (which is
   0 for CPUs without the Security Extension)
 * but it doesn't matter whether you use -kernel or -device loader

So you can work around it by linking your images to be loaded
at 0 rather than the higher address. It is definitely a bug
that we don't correctly handle these ELF images.

thanks
-- PMM

