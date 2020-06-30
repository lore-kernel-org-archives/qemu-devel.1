Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D79C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4422E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhLHPffV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4422E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIaq-0006CY-Fv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqIZa-0003WW-D2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:53:26 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqIZY-0006Zl-RH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:53:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id k6so13991350oij.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bksqS5OXW4yPLtnDgxApaC1LnjKvojyARYOjWT9jY54=;
 b=vhLHPffVxPaiD8FYEzs/6assXv4aydjZlfAGsmN2QrDAO8qpdzN6mQdmr0E5Zb1h6s
 xEaKLNXOA1E2g7/JxtVnF3Qt5ynNsb8b/9wTXQv9iYlPC/Lh1P3YqnEEv8JOWWPHL34d
 qxEha3SvO/i+fn+aSbJZGWXqVqGr/R84Jzk9WiLiKJoSZyMIo2/ZksTGe74OJXphFIRb
 N7Pn5fxSnlQEP1uQ4PFsRuMVbb8JBophMJ+aFF1RE2qyc/88cTMNPr0lKWW2hCqmiWc+
 w+GjW1+Q7Wek06rmveLcDuMa02FUiVsnl7ifXmGSXvQnt1Y9JOvu5YV9NEnfBewwPQSZ
 cHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bksqS5OXW4yPLtnDgxApaC1LnjKvojyARYOjWT9jY54=;
 b=rGPebhxAfmq22zps1MdShl0OrAY8ix6gULNp9AIlRU9nH799sz0iZWAhVyJMPu/kZ6
 5+da7znVfHsGNzeXYPvSaMyRMKBknttSChZvoDIrGdzBkcAjy0g21nzywsZAKn0NkNj+
 sBGY/oTl18qnblxDZS3aYyTjx5hwB2/JKY9SmjX1IpX34gxOjPLjHpAd85bZDfuYZW6m
 rK80MZu9Sv2qyowmfNngup2G/hQ+YhDN1VBtVxeHdfHxFuBPZOQmYITn7c5Uer9lQ9NM
 44Or4VrhjOtIcNGkj+YbjDA/qvA7g0YK+y0KVN+5L7/RH3QHWETyUeDOno4HS1lti2uQ
 4EuQ==
X-Gm-Message-State: AOAM532PThOZn8z8xFFLG1+tSOL62WvY0RWVGxAcBRf1GGISoYL+QUIL
 90gP1Kd47FoI/jEfaX2tmgpNUEH/UEca311x6LbC1w==
X-Google-Smtp-Source: ABdhPJwOisfkpCweJlEMmpgTkBVV4rGLNi06rBzppVFE4pYhne6j4wMAU2XN8nzWbeieHqPveUWLdQj3HtBPEqdKv90=
X-Received: by 2002:a54:4694:: with SMTP id k20mr16009221oic.146.1593532403224; 
 Tue, 30 Jun 2020 08:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
In-Reply-To: <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2020 16:53:12 +0100
Message-ID: <CAFEAcA8jkzf8+d5AyAVH2HJ544TyHsM4xP5tpWsKiJbJtWMjKw@mail.gmail.com>
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, David CARLIER <devnexen@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 09:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Jun 30, 2020 at 08:44:24AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > +Gerd
> >
> > On 6/29/20 11:48 PM, David CARLIER wrote:
> > > From 157a0374093371719de42e99364352d64190f52a Mon Sep 17 00:00:00 200=
1
> > > From: David Carlier <devnexen@gmail.com>
> > > Date: Mon, 29 Jun 2020 22:20:06 +0000
> > > Subject: [PATCH 7/9] Skipping drm build, unsupported.
>
> --verbose please.
>
> > > -util-obj-$(CONFIG_POSIX) +=3D drm.o
> > > +util-obj-$(CONFIG_LINUX) +=3D drm.o
>
> Can't see anything linux-specific there.  Also note that FreeBSD (and
> possibly other *BSDs too) have drm support.  So CONFIG_POSIX looks
> correct to me.

This change was my suggestion; I assumed that "open /dev/dri/whatever"
was Linux-specific. The specific thing that doesn't work on
Haiku, or on Solaris for that matter, is that the code uses
DT_CHR, which isn't in POSIX but is a Linux-and-BSDism.

thanks
-- PMM

