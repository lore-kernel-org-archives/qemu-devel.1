Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A863FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F3922CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/7IhaCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F3922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0T77-0006dc-S2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0T0v-0007Jm-9L
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0T0u-0004t8-0W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:59:09 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0T0t-0004sS-S6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:59:07 -0400
Received: by mail-oi1-x234.google.com with SMTP id b25so1980515oib.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8N2r9GOGJYMo/IjB5u2BBE6LsGoZPxQDmra/k6XKTK0=;
 b=x/7IhaCDwDBzwFtpArfZY/QdXpKehD9hz2dWRTW0QE2F7Fgw+QZKjiDBQNPbmX41T9
 FS/9Fa61zoclfVggCQnxDGH0j259B1f7NH9oiYLySH0YZnyyqZdTsmqvLoxLoiTXD+kC
 aFbRAPLSDN8pnDm5uoVuLbpG4vm3ItZQWLUyCuB9GqpXjx67zO3Ug1nmO+RPxUus+o6j
 8vjsFTkcq001YzipA5wUX9zs0fNjFxGg+cj6MQ7KiuuvIV06Dzfe5Eqr1yWGPhM99hLV
 7Ie73yb9j/dyOmdUKPFrNyo5jfjObxhrXdooBDXiHrvGuHn9My+NbZEyp8JpsYUscWvn
 XW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8N2r9GOGJYMo/IjB5u2BBE6LsGoZPxQDmra/k6XKTK0=;
 b=j9/0FqM7UX4usru/ZBfbVY2QpyyprjpV8UrAB04fUGFgoEZxgTg0n9hQAOSxBDiqcS
 mKmCfYl91EMXiHXO/WWkaTdEUp7ygrETdG7+cOfjk5bhAxxZJbZK/OviUJiIbjM/dV4t
 7tINgXk0ewaMsbgUgkHI+lRHhkr18Wh9HFSSq1/h0ToL94yuHYkqDjgT2mcJbQ/g1Jga
 w+ped9qlUFLpAV5W8OtvYSLcCjuKSr/PwaF23mOED26eDBnTT8cAL6uIDeOlYNULMGSZ
 E9uk/vnuf418v1Sse3eLZTDSl4cCerXeFW7eTaUHGgKftj5PrSSxzMI4vdX+fJXn5n0V
 D7fw==
X-Gm-Message-State: APjAAAVtV+CBJyOUMDJaK9koXoCNgx06myPgKU4u3tWM+GnrPQoRhomP
 g5jwV+fDuTkASpdCKb0z3ibKdoUUhpVC2KwQZta1uA==
X-Google-Smtp-Source: APXvYqzFxaW6vxF3ACvp3PKeQZD6eSgXFXukBMjqzdMat571/SHSk8MOOC21ivDEmu8Yj22309KWUQ2r0Oc9+vcEMVY=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr534606oib.48.1566403146725; 
 Wed, 21 Aug 2019 08:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190821084113.1840-1-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2019 16:58:55 +0100
Message-ID: <CAFEAcA9SrwVG4+3sP5hdJRS46ZNBmVpxjJ5Xa1vjFkoR5rTs_Q@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 00/15] Audio 20190821 patches
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 09:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190821-pull-request
>
> for you to fetch changes up to e76ba19a1f1377314573a6df7e2d82b597aa3d0a:
>
>   audio: fix memory leak reported by ASAN (2019-08-21 09:13:37 +0200)
>
> ----------------------------------------------------------------
> audio: second batch of -audiodev support, adding support for multiple backends.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

