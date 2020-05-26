Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD29207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SICK6bj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD29207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaFX-00039x-A4
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdaEz-0002ke-EF
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:07:37 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdaEy-0005jH-Bx
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:07:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id m12so22254210ljc.6
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uS1ftDSjmvy5JnPRj/u6OgAfZCzPZgf79ovzcHm3JVA=;
 b=SICK6bj/JMC1fHCfk3d6ppZvdG4JHl1ToiiDoP/pGMvsf/0OsqMbJkH5+UNwNb2PT4
 WZxyqgvpdb9kAlz+HsHu6Rmfxii48i2H5H3k7BGb6YfCnJja8tSwSQvGfKbI3oWngsz6
 hSDev8oMGzi4yPKTV+gxI9oY2or8VoEe8iY+h27Gom907vqmIKLEPk53rnLskldg6AVP
 H9i/15L+9Yl0U2GnEjZzL+0f81YqeC4ETjcSbb+7OLKlZvxfNZUjvlRvRoFK26tOaGPi
 NwiHx9cNEAG2BJLtqBXYwZtZ5/KHvjJsiGxtBhj8W9paNu8MQAEL2pWTgyYflnZurhFw
 S5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uS1ftDSjmvy5JnPRj/u6OgAfZCzPZgf79ovzcHm3JVA=;
 b=eBfeQAEOTDvO7xvc9zmF059OSkSTdKnCP0l3Hyw/5XfMulml6UDi1zP/zVI5oAAT6y
 rPXOdjfO8/Bsg5k3HTbFw2eK6Eo+8BOHwdnr/KPPYYkntphwURblVz5WPs7rHHm4GFrw
 5R3qoinuInr9G+ii9wcckzA9fWj0TdyhQUXgAjeZmHHcwfmmPy1Vo8pLqldu+2gn9W2n
 UXJ85+4ZHTqly7p3dYvKqwbi3WzHO41kE09sPmDKOCLUor8jnQkFNL/joZJXJAUdq5Ap
 qqmkFIWtTjuar+ekxCwv9DToKuAdsPpFTb4GYkTa1shmKC+s1V0OZYUwLaI/9XOv3uOk
 zwWg==
X-Gm-Message-State: AOAM530ZV1g54tAvTyGFRm8NUGBrAn0XG0gEhPKEWvY8BAPpfItDcNFS
 xbMlrBeN7czTaCbHm6ZCZIXSDaIEVfBJ8kO2lT3XYw==
X-Google-Smtp-Source: ABdhPJxxre8CFnIbNO6c8xfa3IySv7YlW0Cau1abOPfEiuBlY0JdX24E+K8SXDI+TKGHQbKLR2yQ8cuvHWvdLVeC1eY=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr686970ljd.102.1590502054133; 
 Tue, 26 May 2020 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-13-robert.foley@linaro.org>
 <20200523172729.GD382220@sff>
In-Reply-To: <20200523172729.GD382220@sff>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 10:07:29 -0400
Message-ID: <CAEyhzFsrQ3TgJ5fRnYcmoTL3vOVNXwof2a+WY7NSLT5y21mFYw@mail.gmail.com>
Subject: Re: [PATCH 12/19] configure: added tsan support for blacklist.
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 13:27, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, May 22, 2020 at 12:07:48 -0400, Robert Foley wrote:
> > Initially put several files into blacklist that were
> > causing the most problems, namely bitops.c and bitmap.c.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  configure                 | 3 ++-
> >  tests/tsan/blacklist.tsan | 5 +++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/tsan/blacklist.tsan
> >
> > diff --git a/configure b/configure
> > index c95c54fb48..8a86a0638d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6306,7 +6306,8 @@ if test "$have_asan" = "yes"; then
> >  fi
> >  if test "$have_tsan" = "yes" ; then
> >    if test "$have_tsan_iface_fiber" = "yes" ; then
> > -    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
> > +    QEMU_CFLAGS="-fsanitize=thread -fsanitize-blacklist="\
> > +             "\$(SRC_PATH)/tests/tsan/blacklist.tsan $QEMU_CFLAGS"
>
> I presume the goal here is to fix these races later (my default assumption
> is that warnings == races, since most warnings are indeed races). If so,
> please consider making the suppression optional (via
> "--extra-cflags=-fsanitize-blacklist=path-to-this-file"), since that
> way the reports are likely to get more eyeballs.

Yes, the goal is to fix these later.  Will add an explanation of this in
blacklist.tsan.

We will make the blacklist optional, and also add some documentation
on how to use the blacklist in the TSan section of testing.rst.

Thanks & Regards,
-Rob

>
> Thanks,
>
>                 E.

