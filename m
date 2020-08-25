Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0D12071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKcB3bRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0D12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVfL-0002bc-7D
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAVeZ-00027E-BW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:54:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:34048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAVeX-0001Wv-Cb
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:54:07 -0400
Received: by mail-ej1-x636.google.com with SMTP id d26so5615745ejr.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ysKmYptlhH46YY/Pfv8ih++Vxy1CXgmt2mkpOnMxJwo=;
 b=UKcB3bRAvouZl6Qb7sNSv3PGctQinBBfee1nuy9RTvD49UDJuS+t52i6WZVTqcyBNe
 OB9z0tM2loIh2fiILx5jlgfasA0sFwlOwXSAS8eNwprSK8vaHbGKfjZGAmVR8q9HymT9
 staCgfQeNUxdNltQ2S2fSpnLlgBw36mfTGxvAaSZMcCHMHxIYRUtgfSTZUeqweR/HRbM
 KbQxA9pOJS0rYTHW5i6hHzoqSzhFg5dWqZFLx6wHuy1XFbCY5V80vwILHGjwm60BAYWA
 43qlTgqMDFcAwPN2cpD6Mweazji34+qRRyjtbIKSG+ZrUSBBPEmLo95Jnu+TZM4qnTzz
 IX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ysKmYptlhH46YY/Pfv8ih++Vxy1CXgmt2mkpOnMxJwo=;
 b=XrEy/OOLB7agugemlYJt0ZKeGTRI0MZ+kmtNOEdCvgIoRWOtYY2kRlpvq9BGZsXHBQ
 rPNkTnYokzdO0vCFALz9YJD/AjJ0dm5AJUu4jFyBl974YthnFappFj02cOhVV0dhHIs+
 /KUBHAzF2gCCE6qWfCfUXPEQuqbGP/nE9tbrlhRhikIPawgbJl88W+6k6QYBer4S34Bj
 c0h6bM2R782r0a7Z+crpJx6dCGQqXSlagxoKnPzJb20gfBGME94TYthB1ROlQiQcgqH+
 juVRPn2vjAgAtDC/wYSuFp7xvSQpyrtNZCk/pmfAaY76t+KnESkOxfGQg8dagGh7WCSE
 5K+A==
X-Gm-Message-State: AOAM531673dFyC8aNAPBzwKtXkBg7W+MYk4lJfQqIa8HpcDpsGvE4PFh
 X2ioNd/OA3Es76hs9E4k2bbLAXeo2EvVH8AHVU/afg==
X-Google-Smtp-Source: ABdhPJwMVceK4p8WFZReg2LxXnju7KTiQyO3781Z/Q1l4T7f3KPIke3sZ3oSMITwUw4cbp9JSCAtJl0vWlJ5KEPxWqw=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr9353797ejb.407.1598349243082; 
 Tue, 25 Aug 2020 02:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
 <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
 <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
In-Reply-To: <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 10:53:52 +0100
Message-ID: <CAFEAcA919wJg00vVTyVksaZGNmD50gH1jQj6RWA1ZAafEJAbOg@mail.gmail.com>
Subject: Re: meson.build files are missing copyright/license headers
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 06:57, Thomas Huth <thuth@redhat.com> wrote:
>
> On 24/08/2020 20.46, Peter Maydell wrote:
> > We don't mandate SPDX[*],
> > but it will do the job if you want to use it.
> >
> > [*] Mostly because nobody's cared enough to say "we should
> > standardize on this and convert existing files and add the
> > check to checkpatch that new files have an SPDX line".
>
> We should standardize on this and convert existing files and add the
> check to checkpatch that new files have an SPDX line! :-)
>
> Ok, now sombody said it loud. Would there be any objections to enforce
> this via checkpatch on new files?

I wouldn't object, indeed I think checkpatch-enforcement is an
important part of the process. I think that if we're going
to move to SPDX we should:
 * look at the SPDX spec and identify what we need to do beyond
   just adding SPDX lines (eg do we need a LICENSES/ subdir
   like the kernel has with a file per license?)
 * document (in docs/devel?) that we require SPDX
 * decide what our plan is for 3rd-party code (libvixl, etc)
   [where any SPDX line we add will be lost again next time
   we resync our copy of the code]
 * put in a checkpatch check for new files (presumably the
   Linux kernel has one we can borrow)
 * update existing files (I think the kernel folks probably
   have scripted stuff for the easy parts of this; multi-license
   files like fpu/softfloat.c likely need by-hand conversion)

Mostly I think if we're going to do this we should find somebody
who wants to put in the work to push it forwards so we don't
have a half-and-half interminably extended transition between
old-style license notices and SPDX.

thanks
-- PMM

