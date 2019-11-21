Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6020C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD56A2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn2d/dFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD56A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXr1L-0004aZ-RY
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXqzb-0003Uh-O0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXqza-0008AA-PE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:15:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXqza-00089g-HF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:15:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id u18so4818185wmc.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PHVWNq2aFAGh+oBslV7lj5urUTg8KyGhkS6wQArelrU=;
 b=Yn2d/dFJcxvZ7a1OXyHPyP58PN969b+PWoPR8/mVlozAil8k2GM2CwRDjf806hKs5R
 z+uJwuDUuJK8kwrm9TNryb5bexms/fGxVHc9lBbdwR/EomgUNffcu6TLko2xd/k9xPUY
 DaKkJdCtrXarejNFQg/zjC89IpV0wVcb39KK9aid/mQE4KPYAhDhg6f6cIVx+rHNMc/t
 E07Zt9oz+WA0FevtsICjPHi/QUUo2YhZzf+PdX4ICTTIZlgHew6dQVH7XSWcK15sCTMe
 RroSTUyY9uwj1HCJ8LqTj1e8EPEPeQY8HhUzW2+bWtADzuAA7LqIvXV1sbENaAqoxvGb
 kl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PHVWNq2aFAGh+oBslV7lj5urUTg8KyGhkS6wQArelrU=;
 b=BcG+WZYqMKvdAdT3yqU69N2uG6hatu24vclaw6sA9Brn4sZv6Syez1eZWSxE/HTQ3K
 KUeIQhTE6A+XZxZKoALu5FgOW/1NqFVWtwCTzZFetrwkW1R9mubkHKXwYgZ6Kynv1ARz
 ErRlkqIBCn0qdrzqBHBpcu9FU3t/OltQUgeBogoJJwUifUmEBIa/T4OXKe+eRAv4sgVH
 8Bkck46kkEQgfdHlQM5pr9G8A8vFBiANIF+0xX/IC4mbDiqRJEoQyLNf7Dr1xQ6cgi6r
 f09L/ymluJ1OG36UwbsYXXizLTNPtJOYo3dAwkAtkSzq2FCaqvIzA8uWxuCxwafLUBEg
 DaOQ==
X-Gm-Message-State: APjAAAVRk+DB2MQjF6nBIanHbvv3ULHr3i53MWodgMI7BhSkYbPReQt0
 7/+F2xgOQRJbgvzSn/7uOC3lqj+ViZCw/60Aa9k=
X-Google-Smtp-Source: APXvYqyJNSznKYkvfxohF/L95fsq73Dz8JA0kcKMdVOECf35ANK5u9LeFL+UfdDfbGwiTPzFpWCg6yqMiOaHH6Nfl/U=
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr11588383wme.91.1574360144900; 
 Thu, 21 Nov 2019 10:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-13-marcandre.lureau@redhat.com>
 <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
In-Reply-To: <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Nov 2019 22:15:31 +0400
Message-ID: <CAJ+F1CJhaQxrceCqPpPULN5RUUQ+jTVaRa912jX0Ct8MM0ucaw@mail.gmail.com>
Subject: Re: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 5:47 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 20 Nov 2019 at 15:27, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Memory mapped serial device is in fact a sysbus device. The following
> > patches will make use of sysbus facilities for resource and
> > registration. In particular, "serial-mm: use sysbus facilities" will
> > move internal serial realization to serial_mm_realize callback to
> > follow qdev best practices.
>
> What goes wrong if you just put the realize of smm->serial in
> the right place to start with ?

You mean squash the following patches?
Sometime I go too fast, sometime it's too slow.

Decide what you prefer, this doesnt' matter much to me.


--=20
Marc-Andr=C3=A9 Lureau

