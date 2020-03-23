Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0689AC54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EFB20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao+4PJOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EFB20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGP6I-0003Kz-V0
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGP51-00020v-C4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGP50-0000RC-93
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:46776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGP50-0000Qd-2l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:33:30 -0400
Received: by mail-ot1-x333.google.com with SMTP id 111so13727468oth.13
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wOwiXVcWEnQr1I8cyA7hdB4GB74HWZl3DfCIlkn0V3c=;
 b=ao+4PJOLhmX9BqIGGdGkwSVffJ7p+evLpSvP3l2vjTD0oWVR1kI8YJWef3VRcWkG5K
 gMifFAxP7aTjdSZN31DbSw6ZUq8ekkqwDnAGRomZzvFMwpN9zNictyUvx6ZJ4jTIwPvk
 tGGini4boScRs5k4MqlcmWmh7e6b0v933dkcgoWohks2Mvus1/NfwwVLiUBuqAACaTK5
 ZTSfuwp/f0eqodqbDocSYVQ0sD9FEWUtQdgyEtpjK4+zeqpHdV+S4C1J4K5pcg4SeKp7
 zUysQmPAMBWy1AsFj+5BvF1/KCYxcxlvoHqvp8r3IwyRCg4jHn4jC+wxFnvjSlwET2Bg
 3VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wOwiXVcWEnQr1I8cyA7hdB4GB74HWZl3DfCIlkn0V3c=;
 b=rymSER0I2Frz0CkjLjWcV0MVDjD99VAOqAPPyznHvYAv7F7/St0x74aOTGwEqhYkFx
 esxOG+1WvbbWrww5Hd1kWAQGj208uwrVzeD9NvMgb2F/HI2+dJBEcl3WskSzF3/HnHO/
 qkGAsl+3VkfGsGv5OnnSBU/ef0hGN38BsRt+bLnNHrCmDwAWb9ns+NMPcaSBf+Oz7VBx
 5bjXqpi0cd6bLwG2W+s9om/vjHbo8CjeYM4exYv8VrxbfOTcYbmGTLvxBGfzZ8aoPN0i
 CkBC48ltn5HX3w7bWvkuTgS1DKRO+3h3lrQZ2grvOoNq7kKL1jGmUGekyhLYee+dWTP+
 xfzQ==
X-Gm-Message-State: ANhLgQ0tYfNmENT4ryhUamm49SCFovY5C+XeXqmJwHGkvO5MZZreP6kS
 uJbnAdOEpmhQG4Swo84dkdVV/r2nFiNXQocZqIHsAQ==
X-Google-Smtp-Source: ADFU+vtasJvfB+jfzlIU3dglQhztl62M+cKkVRbZnammOfGhQA7TActeDKaU8qqF5V8wpdu98C/ldFdbLxw4WLm4PeY=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr3400360oth.135.1584977608926; 
 Mon, 23 Mar 2020 08:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
 <CAFEAcA9Ubue9Lk2jXJyZ+OUmk0j58ZKKnER1RxMi0b05FaN4QQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231539160.47226@zero.eik.bme.hu>
 <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231619510.61044@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003231619510.61044@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 15:33:17 +0000
Message-ID: <CAFEAcA8HgxbvN+GL-nELonDQkfBcpq=789RUTfA41NQAdKrLvA@mail.gmail.com>
Subject: Re: Coverity CID 1421984
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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

On Mon, 23 Mar 2020 at 15:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Is this documented anywhere?

Unfortunately not. You're quite right that we should document this
(I hadn't realized/had forgotten that the qdev gpio APIs are
entirely undocumented -- they date from a time when we were
much less strict about asking for at least a doc-comment documentation
of new globally visible functions.)

thanks
-- PMM

