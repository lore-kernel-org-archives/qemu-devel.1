Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5499C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6412071A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 17:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq/jc0k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6412071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpalY-0003jO-JN
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 13:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpako-00033V-CU
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 13:06:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpakk-0004iQ-21
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 13:06:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so12512939oik.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qTWt+mvSgs1766ZneFRUZiGm1stm39Oy+PJ7LDpVUow=;
 b=Oq/jc0k2DzPfZgvRe6T29Hk0jIZT2jdzSxV+t0JSUjj9BL2gn6UtWPiyDkPJgevweF
 +p1dwCnNzrzv1GWRd9tEgWcUQ5ZSthWZUErdIKdcwQTWvKgLpDwVwFov3C5lpTSM7QfP
 6CtG75jI0pnqD8KwuR4utM/5HOJEQR7QGCdoaLL69VVlZISXgD9W4FbHReXvJcWEWi0/
 5DZeUQe4JDh8sfeSZdMXdG1clOWWtjgpgMU5SaVYslbS9ngHto/P6eqV9igUSIr/nKHl
 jaUXTSzQmdG4IuELWRbaMNcIpJshgVyYHxR+Q1UlgxUG5/r50i7CW7MfdkNEKfmkOiTU
 tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qTWt+mvSgs1766ZneFRUZiGm1stm39Oy+PJ7LDpVUow=;
 b=L+l/JDTWils5lYYvSZomtWTrqn0EY26FZUdjeBGT2l+mTqKKSH8oVXTj2D6uk+SVJk
 CV+73Dh/1H0dljPhWQBCwrYh6wTkteyW1ELD921t8kroQmBo67MFY8+RLYqh84dQf1Hn
 Qc+n/OWxiwD3j7fUCpOqlXuRG7hKbczU1LfafjK6JyXt5yYG2mWKIim2xm0i/GVsokfc
 lU9QlCOUlBmQpOLiNXFCrwSOZCOD8Yw2uTcXLgVNw4x/YIhKjG3K8hjt38FkvDd6CKZ9
 smpHrzcP2dTkTQ79tQ0dPDXCrhnzNG6ED1QoPNe/cNKtmZAEkMDvjNMk9Zj5d7T+0e2H
 Lv9w==
X-Gm-Message-State: AOAM532JdTv3AXoWu28OQf4GGExPrcPMmlY5D4o9lj/WOV/XAqeiMh8w
 s3DdjqLyKOHINU3ldmp12R0q4bhtGnX0PLZyN5W6rQ==
X-Google-Smtp-Source: ABdhPJyYGvL3kFFrCjPSCdy7P5S4cWIFwknW6Bllly7jmU/AH8GHlmTvC40otH8LniDK2Voz7BeAdL7JIxobH3r/oFY=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3956500oix.48.1593363960412;
 Sun, 28 Jun 2020 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
 <CAFEAcA8wfgQxAzr_MJ+wr6XXKAHGRx5i0SXA44XDbHhum5JEwQ@mail.gmail.com>
 <2f7b2149-f671-a814-8ed7-4fb3aa885429@tribudubois.net>
In-Reply-To: <2f7b2149-f671-a814-8ed7-4fb3aa885429@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jun 2020 18:05:49 +0100
Message-ID: <CAFEAcA_CBcvCmjYt=jgd-RXja4vYbWcQ87=xNoGVuUkr7FBrsQ@mail.gmail.com>
Subject: Re: Crash when running Qemu.
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jun 2020 at 17:46, Jean-Christophe DUBOIS
<jcd@tribudubois.net> wrote:
>
> Le 28/06/2020 =C3=A0 16:38, Peter Maydell a =C3=A9crit :
> > On Sun, 28 Jun 2020 at 11:56, Jean-Christophe DUBOIS
> > <jcd@tribudubois.net> wrote:
> >> jcd@jcd-UX305CA:~/Projects/=C2=B5COS/work$
> >> ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m
> >> 128M -display none -serial stdio -kernel ./OS.elf
> >> double free or corruption (!prev)
> >> Abandon (core dumped)
> > I can't repro using your command line but without the -kernel option,
> > so it's probably specific to something your guest code is doing.
> > I tested with git commit e7651153a8801dad6; which commit are you
> > using?
>
> I was on master (553cf5d7c47bee05a3dec9461c1f8430316d516b)
>
> Reverting the June 23rd commit series on PCA9552 fixed the problem for me=
.
>
> > Can you provide either the elf file or a repro example that
> > doesn't need it ?
>
> Please, find the OS.elf file as attachment.

Ah, thanks for tracking that down. Philippe, the valgrind
error in Jean-Christophe's other email in this thread suggests
something's wrong in the typeinfo or the class init for the
pca9552 changes you've made -- would you mind having a look at it?

thanks
-- PMM

