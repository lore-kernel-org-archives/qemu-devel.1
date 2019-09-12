Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F53C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F232208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKuprXUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F232208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Kau-0000S6-9F
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8KZx-0008Cj-K8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8KZw-00023B-0t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:35:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8KZv-000226-Sl
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:35:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id n7so25289959otk.6
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pwvb8EPjgAvwsW8+aMq+UytCTWuKggVwjEAniB64G3U=;
 b=mKuprXUgg4MNFXBWt5N8LOLmyafRo2zrcliKqKHen+dgRnXiClmfQhMCrd4tpZoUQt
 lWi/34/q+CeNShZxnM1T66FC+yWHhXUgIxN5RY80NZi60qhCKUuymv5uJV4FpSGLPBRS
 gIvLIIADIDC+jaf7KPOnX4KuIRlfy8H70kek+iO1CbgKSnS4e+RW9moCnVYhsFkx7eDd
 acz5piKW14dEDCSWRlQ67OG6HloBr4Im/U4O7GpMQFBhfevw5OokeOoVzHvCcT5VXZaC
 XJNcPkqB18+YYTtl2w8gVcXMYeY/6YFQuhc59yiSi5AG9HtyO5DDa05vp9en0pDnrr4V
 ngHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pwvb8EPjgAvwsW8+aMq+UytCTWuKggVwjEAniB64G3U=;
 b=daVrPyrzaoDf91dzQKJEW0Rh6G/zJcbj4tDKicVX/tii9vp8h/EL9veQaj7gpJgriB
 wPbFeElFO//XXoWu6lZwbBWsqP+RtUd8Wggfa1NhDkQhNaGZli1CWeeck5lIqBeGVaot
 bduF0oBLoKLkw9H8vMzfrQy52yu2R07pGRTU9gIIVjIop0YcmKRo5rYOBcQf8hbxc0Ny
 M5VJh4n/teKUbbbnJnHt4dPOIuqVAal2+WfduOcsdzFz9JQyoHTeNdE8d9zVCobBFfxs
 NXqbquumhOcJWYJSeE+VfExn1l3tW0XbpzAa2BS0lbjs0xVLtgY+vzOk/DmGLkrh4LiD
 gCeA==
X-Gm-Message-State: APjAAAVKUntHumK+N6M+vsuE7p6Rom4ylZzg7ZjQTOgmfS8uRQBZYzm+
 fWlXCQ+oqTpU0g4ZkusCbn0uKZB0SupcD45OyFSyVg==
X-Google-Smtp-Source: APXvYqzVdrE11tLGLe3zvwcx4a1MbBW9OJ4MT1xNME/OGl1Kux2jaIG6mMwJkWvLhhlegQKFyxLWoFOio4eNFGP9p+s=
X-Received: by 2002:a9d:538a:: with SMTP id w10mr362835otg.91.1568277346575;
 Thu, 12 Sep 2019 01:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190906202636.28642-1-alex.bennee@linaro.org>
 <CAFEAcA-DQ0Zq40Xnw5wkA6ojOUCf67xfX83nMEoKW_UrysJhjQ@mail.gmail.com>
 <871rwn0yb3.fsf@linaro.org>
In-Reply-To: <871rwn0yb3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 09:35:35 +0100
Message-ID: <CAFEAcA982nm0yFdwy8-jUDRq6Q6d0wT4y+jfFeQ_a3RiYn+bPA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4 0/4] semihosting at translate time fixes
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 14:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> It does seem a bit weird that userspace linux-user does do semihosting
> whereas EL0 in softmmu doesn't. Is that because we are effectively
> short-circuiting what a real ARM kernel would be doing for EL0?

It's because the "not for EL0" is a rather bogus attempt
at 'security' by not allowing userspace in a system emulator
to access the semihosting API, reserving it instead for
the guest OS (its EL1). This concept doesn't apply for
linux-user mode, where there is no guest EL1, and where in any
case the semihosting API doesn't allow the guest code to do
anything it couldn't do by directly making host OS syscalls.

I suspect this "not for EL0" thing is not something anybody
else's semihosting implementation does (though I haven't checked).

One idea I've vaguely thought about is an idea of a more
'safe' semihosting mode, where we only provide the calls
which we think are reasonable for a not-really-trusted
guest: so you could write to stdout but not read/write
arbitrary files on the filesystem, for instance.

thanks
-- PMM

