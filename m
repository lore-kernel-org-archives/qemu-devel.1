Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88451C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7642064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXzOH8dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7642064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlyH-0002iK-Hy
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvlxW-0002IO-AQ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:16:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvlxR-0001T7-B5
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:16:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id 18so2196533otv.6
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=M7xJ89/gH3mj/BWCOpelpnwl0hRm1CF7Ul/vLPMdj4E=;
 b=UXzOH8dgiQtziAbKas1OrUBpSZVPOWJmJyldt3y/Jse+heVhQ6t8pD/PkkHbR0O6ms
 /e/f6pJJde4A4N2IKoFFcwK1wXXjzHPDEPqAjzkQ8Gyske2Hvi8A0d2KfhdX/Btr3bmF
 AzTHJKaOJzaLRKj/RN6K6x4zWQzC8TzudFdxpvbUxDn2RFhb6KjGDznuXhveGsqsCYn8
 W3Ovw5VZM9rFbRc98eQgumgf8lf1KCiSkNnbl3KQydFXYjDgxIp2uEJ+1YgbItq/Io54
 VULjs96lZBED4GkbfBeERmL1DJVOzSo6FTzFDNTHawBMUwFrTvyFN5xrPZnuk66P52sw
 LfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=M7xJ89/gH3mj/BWCOpelpnwl0hRm1CF7Ul/vLPMdj4E=;
 b=Weldj16k08xd5hZBCu7I9Q8G3woh8Ny7Kj8zHmT6I67bTTu7xbhIrHDkFHiBfKY+RH
 PAYnJteXLafW5tV+8YtgCjaoWlJjPW0BqjCWflimg/JVkb67z8YJ+y/5+vGwR0E/NbQs
 3AKmyfhts3dN3n6zJ/w8Jgx7ypQJgchl9gM0eKG1Xoy21pxPNgCPKscJARKEyCi128O6
 oXeO7ZTqKBoim1+MMvVMwfNM1uP2fjC1AX3eNtTJJeGrYy2Bx1NkW5+a/XvbrdNR/W9W
 nVLwDtM+tGN+EpaiGFOMpanS2gAw+Hf2eEHc1Gh4u8iP1XJlBZ340EZ1ImJKROQBW2/F
 ymjw==
X-Gm-Message-State: AOAM532VIWLj1lYkTYfBgpY1/KnsWC0cWrc2Lmx9l+4S8mtqseX3aZya
 NN/B7+PqiwdixVgJpp6eaAoBWhatMG5wG/H5ET3fog==
X-Google-Smtp-Source: ABdhPJwM9TXyZ2Ibbe3IUJl9i3tmbDB7U2yihwfeGLtVdFLrpxWa6l36cQ3geIvu8KFXuz4PDbdQSjVICELob5hk9z0=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr868980oto.135.1594837000037; 
 Wed, 15 Jul 2020 11:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+6fjXvfPYECjc0YniJM5xwYjU7T26OgFDFSAatLL85AQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+6fjXvfPYECjc0YniJM5xwYjU7T26OgFDFSAatLL85AQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 19:16:28 +0100
Message-ID: <CAFEAcA_QRQNdrUYVaJiKZEabnM3K2yh4v5tSA0ouauDhGu_EbQ@mail.gmail.com>
Subject: Re: [PATCH] slirp: update to v4.3.1
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 19:12, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> On Mon, Jul 13, 2020 at 12:33 PM Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@redhat.com> wrote:
>>
>> Switch from stable-4.2 branch back to master (which is actually
>> maintained, I think we tend to forget about stable...).
>
>
> ping
>
> Peter, should I send a pull request directly?

Yes. I will not in general notice that I should be applying things
unless they are properly formed pull requests. I might notice a
patch I'm asked to apply directly, but it is pure luck.

> (I feel like it should be part of rc0, since it has a few new functionali=
ty/API...)

Sorry, you've missed that boat, I just pushed the tag ten minutes ago.

thanks
-- PMM

