Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD4F20767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kudwy4z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD4F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtboK-0002WK-CI
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbne-0001mb-MS
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:01:38 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:34760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbnc-0003QV-Tn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:01:38 -0400
Received: by mail-oi1-x22e.google.com with SMTP id e4so2771382oib.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2OSJetc9r1sWDzTOyN9R38WuBNR0IK5H0bHfp9hvpzE=;
 b=Kudwy4z0OksN3BK186XkxGRqWOmf7gRHQxegcNnn0PUb6y0sC4pgY7+ipOzBOW6Cf+
 mqDyjyRIiOMrVaTWeUXvE4Aa+JV7gUy2N8CJ6+C4loT6gaYLy7F0QYmV7qnjjKchc/C1
 YqQvoSO52xNaJF+/yuUqsg+Qj2TwPmACRT6F6ccih6aPzo7ZTmrtmFlBYax/KCmCN2au
 aC3XLm7Js/FA3IXgjGxj4tjhE8ilaTLkweutDXk0TNGb9HR9ik47/nLFmNgFwV9y1m2z
 YDIBxXhU67Uhlx20HS6HkPHJgHh5X+S6rMskYNX2VQ4jyRxMd6Y9S0jGbUxcW33H+jOx
 GKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2OSJetc9r1sWDzTOyN9R38WuBNR0IK5H0bHfp9hvpzE=;
 b=mSNZSWV0IIiFGBlxc7bA07bXxdbyuJFkUI3QZU7X7HhSuEAjEUtUOcxWy4TKGzSU4k
 2oNPjfjI2cFFJzJ1jQIrCR4pRfSE1QSSzZFZJ2vTPFgieNQ8VjGJiTlJ5a7jpHW3CSWJ
 i1Va+j9up1c2tSTbJ+DJ5c5pUC6ZOIzcOtm76ErT9NX3V1WIpDVMOPpn8tKqORNURxXK
 cdD5EdMQRvaMzQzbj0bjjPNn4n4A22ogM8X6glwkIl0x9l1wdPbHp9vI6u9vnNSnKOZw
 Od/ehpdBDEGN1nKY833ST6hmErfGpJFUDopeR5Sk14BrfZ6z5gO84KDKX6nqp8fh0WYV
 jXPQ==
X-Gm-Message-State: AOAM533s59fvui0qEszllUTt/5Ttw3kvBMXlom3sweul8GakhMJczonz
 G/05/6oLrUOBNhwZktjl4JsrzvK0P+AcCVRw5qVfuQ==
X-Google-Smtp-Source: ABdhPJx4IuF87cHIQn/8SgI/9jXknTLPiuVmd1ssfZ7GzgGV8c9jx+YPjgCXFROd0J4Vdc9ZjWYfLkBelnM9TEaOEU0=
X-Received: by 2002:aca:1706:: with SMTP id j6mr1317893oii.146.1594321295494; 
 Thu, 09 Jul 2020 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707134229.9773-1-kraxel@redhat.com>
In-Reply-To: <20200707134229.9773-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 20:01:24 +0100
Message-ID: <CAFEAcA8y_3NaayYNmz4RrEHfu_GNvPtH_c46O2AL2QJ=wbHzFg@mail.gmail.com>
Subject: Re: [PULL 00/10] Modules 20200707 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 14:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/modules-20200707-pull-request
>
> for you to fetch changes up to ef138c77249771081d8c2d09b8e729f7e92cdf28:
>
>   chardev: enable modules, use for braille (2020-07-07 15:33:59 +0200)
>
> ----------------------------------------------------------------
> qom: add support for qom objects in modules.
> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> build braille chardev as module.
>
> v2: more verbose comment for "build: fix device module builds" patch.
>
> note: qemu doesn't rebuild objects on cflags changes (specifically
>       -fPIC being added when code is switched from builtin to module).
>       Workaround for resulting build errors: "make clean", rebuild.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

