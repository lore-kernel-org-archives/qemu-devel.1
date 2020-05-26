Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A531C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E22E2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzPUYp5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E22E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWgs-0001Es-HV
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdWgB-0000jg-Jz
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:19:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdWg9-0003kx-2d
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:19:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so15783104otr.12
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JyfsFJFD+BAt8CX4aJMgn7wkqw75yQGdwHlrYj83Nus=;
 b=mzPUYp5acwzEmU/adkGUg1kr6Mymo7kmNAfZDd59mx8dRVQGuE93Z9jvOZo/j6yPeC
 EQi1C5cw0hDmO1D2Bv87PuWhoMQMXu6lpYd99shFkOR63H0nblJETNexIH0CYLlG3spY
 eXlp1qA2OZZnh1ULrqeChzFtroxa3ecP7D69k84xfgIO+uN2o7/XadYYaU0Wudj6tkLi
 jXysaM649bjRnvDVQqCNJsFKQNeAvs9CodEgW730zWsj0sq7le4boEpbbLjZPj5568ND
 mVAxdIjDQ5Jhqyp9iN7IRSlCQQLcRbKEseun6r6sdvy9qjyAD+hPvabT5nMEhp4umxo1
 hbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JyfsFJFD+BAt8CX4aJMgn7wkqw75yQGdwHlrYj83Nus=;
 b=Zgdjksmv1lEUAS4h9bo2XtB0hF6K/D6ccNrBrq9576eHlazcVMm46nxdGaVTfh8L0h
 sl1FFLWys5IahitU+mrz9jv/wmHyvNPl3m0A5WLg8tKpikAzchhxSMf1ZsXRQaPS4hVb
 XRkvrhDQb92ORhFjDzWmk1Bz+vGEiH2rQqE70SGc1AkJz3IA3PdIOOk8mZt7w1cPTTWL
 r3dYZP96p7PsiS4to2lM7BFMBI6O8AWEEjA4fDAnejaQOVYcXpe7blZFDwdT4UFqinrF
 CH0SjqPL9wMXWd+8mEcEIJF3JXkp5qxDQrWZTwdjEha6LtzR1gBwkDivW+E3ot7ov6Dz
 +OqA==
X-Gm-Message-State: AOAM5321mDZnNXdXQd6LiRjuMtevOMDN1KvFpi0qXpZ8hamMNaloIW/u
 AKthaUOUQ6UDwAi/ZDWiOq69u17TM9BvsKHg1XS3YQ==
X-Google-Smtp-Source: ABdhPJywF/ifwAkg6IaF89i9q8AsFOZuTqD1Fgr8egSllEm4Pj8jjyBk7fLHIv1sfIJaQ4ryWjG4F4iw6x8Er11urQM=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr281264oth.221.1590488363314;
 Tue, 26 May 2020 03:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200526075042.420162-1-ppandit@redhat.com>
In-Reply-To: <20200526075042.420162-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 11:19:12 +0100
Message-ID: <CAFEAcA9N7n4mpznFBXgZeZnFXhCaeJwfwvJVeAc6U3W2mjQPAQ@mail.gmail.com>
Subject: Re: [PATCH v3] exec: set map length to zero when returning NULL
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 08:53, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When mapping physical memory into host's virtual address space,
> 'address_space_map' may return NULL if BounceBuffer is in_use.
> Set and return '*plen = 0' to avoid later NULL pointer dereference.
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

The doc comment for this function in include/exec/memory.h
currently says
"May return %NULL if resources needed to perform the mapping
 are exhausted."

If we're tightening the API to guarantee to also set *plen to 0
in this failure case it would be good to capture that in the
documentation, eg:

"May return %NULL (and set *@plen to 0) if resources needed
 to perform the mapping are exhausted.)"

thanks
-- PMM

