Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45803C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7F822BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giSJzTmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7F822BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Du2-0004MZ-UI
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dt7-0002e4-D2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:55:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dt5-0005Pv-Ld
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:55:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id v6so8254855ota.13
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QFA+/sGzUvZB3ksquoHC1n+ZdzOejatiGSJQXQruFEM=;
 b=giSJzTmK0ZdrXD0yvOqgpASp6h1vDwPhhjMMA7RymfJA/Zkxv2Y5+eWhkxYW+QQEi1
 y8lvim3H11sCVdfOnQxF6QexUzYO8acbVid6FaK4hI1XquHBNNaT8Va+ZehIyqxJCpDo
 mm6QP0+505SxVi3hPHCqTMOjLuXRND72rUYHF5nkZiRrzizTN0CZYy0Z4QveDoik3kSN
 JdTGN2l437K0qJu6e4/qCrbD/aOBq6hAWSZQ656qUlGb3anJogHSlsL+htccWiSaosRG
 6mhUE0Gg8JFIZvT5/C/wWCS/iEMqpYnQ0o32yMYylPTrRadtD68sNI1kLygC7dHy8orp
 NDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QFA+/sGzUvZB3ksquoHC1n+ZdzOejatiGSJQXQruFEM=;
 b=Dh2eQCFEWZcifA0J27kKsNxKf9DphoF0dmtyZ/y5+S9pQb9Hi2w9DnShFuczhqIG2W
 CmTZ/Due4pX1hbGHjsDxjdqbjWHyTUVQqm9dR+MkJe9vQV5r0TFkKH4g4zvAa0I0+FTm
 xhK6wiZNgkddIYT5Bf8qxztef58JXB5nukLJoYJ9GldqHguUaeXtG1hsUodGLoRUCPIT
 sOuu/WuFkUc8UTsB1AwDHOLkiHReoy/2dHEXrmrpxjUZYey7nHXUAoZK0ZYT+IcQtsML
 FcPUOwfKGN86vY/BJRNi10qrZHW7bfWOCQrI+HcBJQYFAqNC+0ZoExYYvVevAbglX1tc
 OVJg==
X-Gm-Message-State: AOAM532Fmb1uYEGavusnXnK4vD+7mb2cbVXHNIF4TggqN+V/FDRORUoU
 5LD2z9GFujG9Vbdm4U2t1nYHDQBFC6TMP+aJdpEqGw==
X-Google-Smtp-Source: ABdhPJxBIlhB/wPVrmePJWjmzg2cVO1YHHr9D5FTcknR4ziOEB2tWLCKGklIQ3sKF94nyFt/LiUBqKKeGuK3wpJanVw=
X-Received: by 2002:a05:6830:1305:: with SMTP id
 p5mr2140112otq.135.1597089314278; 
 Mon, 10 Aug 2020 12:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
 <b710345e-1644-782a-44a9-537493b85d95@redhat.com>
 <CAFEAcA9v7jv=SYZ0NLeSkjoM3da-apeu4OC5BMmorxMue0-viQ@mail.gmail.com>
 <6a82c3b5-037f-7cd7-68fd-0fffd8eff192@redhat.com>
 <CAFEAcA8xB=vOLvj_w9iTWWKh6kwu7fWN8QUbVAYunRdnJG0Qmg@mail.gmail.com>
 <4bbf807f-6ff0-66b5-ac13-65f2bc954d9c@redhat.com>
In-Reply-To: <4bbf807f-6ff0-66b5-ac13-65f2bc954d9c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:55:03 +0100
Message-ID: <CAFEAcA-M1OXT5Kj0rt4aNHZvzCGi9gX=JDzfdKSp=bD0jOYTVg@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 21:45, Peter Maydell wrote:
> >> Note that if you don't install it, you just get the previous behavior
> >> (plus a warning).  But if you want that, it would be simply "gettext" I
> >> guess.  You're using tests/vm/*bsd right?
> > Yes. Unless there's a strong reason for testing the no-gettext
> > configuration via the BSD VMs it seems like we might as well
> > just install the dependency. Silencing the warning would be
> > nice as well if the lack of it isn't actually problematic.
> >
>
> No, I think the warning is valid.  Silencing it would be predicated on
> --disable-gettext or something like that.  I'll just add the dependency.

Our usual default convention is "if the host system has feature X,
act as if --enable-X, otherwise act as if --disable-X", not
"act as if --disable-X apart from warning about it".

thanks
-- PMM

