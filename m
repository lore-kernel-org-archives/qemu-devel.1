Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927AACA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5273C20717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIMJqDzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5273C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOoTM-0005E5-9D
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 15:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iOoSL-00042D-Lf
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iOoSK-00055n-HD
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:44:05 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iOoSK-00055d-BR
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:44:04 -0400
Received: by mail-oi1-x22a.google.com with SMTP id g81so4685368oib.8
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oEGTlG+GUy9t7jaexHH+7UQelisJq2vesnasHDoNoj0=;
 b=pIMJqDzD5hO0NLyy2aJHGwkkfCmDNzfMhrtUq05D3Yf779V9IUZ2N4xLyhJYSiv8eN
 Il1X03CDANAk0JKxznLFvjTO6Mucs850ZmzqXBV6gGybveptqxnh4dOTT2CixGKI+oiu
 uQ1POsbDy44Ca3uviP8/0OfqVLhmPPfDcmpllPJFj+hpq/Jm+mdtnBYK/23zmk0g+ULy
 q9ayDFvcZ9MiDuDXvAFbw1tgIP7KZZewckSNureEO+sKDZajMqnjYWEb8f4K80qquVfG
 51+9rGceqRMOz3OhrbX2AXxylegXU/TLg4r4RXHnZcii19OG9vddKNmPGehic8rETEpD
 674A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oEGTlG+GUy9t7jaexHH+7UQelisJq2vesnasHDoNoj0=;
 b=YLuhNGqx2OfNJ/Hf4KCG+9dAmfJF5TOeJEKsb6DQH5mZ80Yljnxt+9nU639QiHtt2l
 /XaiIPZ8aYHswtZpw9gFpY+mBqo7eicb9h4gBsTe1vgcQMokBLHq7V897XTb3IRyjSTV
 /zoQxdup2cwnfd7qwAPMRyOGb6E7TYMkyGs7KK1/sY2JADgSWpB86/Fn6tcBFjb10BG9
 YEpTprZ9fMg0QowEu7ZhITszCvfCZ4H/eBRyP+UgAmw5Rc2P+sieUpk82x01/ujLeOnx
 gBhi5rwXloCCm414jRFnuei6shau/YMy409ypndn1kwn9YlRCUBms0rnC9ARX08tIFI6
 f6jw==
X-Gm-Message-State: APjAAAUFqnQJDRVTbCeQlpgtqCHfbe2eumKSNsUaPNDH9BCi/AF2rxJH
 I5IkW8JqlgDepguaJX7uILFbvp3S+5UD7ZifX63i4g==
X-Google-Smtp-Source: APXvYqwjCsTtTir23KD447oLi+kzeg3tD1xGIj+zMc+hi9uRG0ibJnDV4cdETXAeBd6iA4xf+8dBnh8LTvN4ywiTDIE=
X-Received: by 2002:aca:451:: with SMTP id 78mr11516987oie.170.1572205443239; 
 Sun, 27 Oct 2019 12:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org> <87lft8lvdh.fsf@linaro.org>
 <874kzw60bp.fsf@dusky.pond.sub.org>
In-Reply-To: <874kzw60bp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 27 Oct 2019 19:44:02 +0000
Message-ID: <CAFEAcA88xPAcDYmD=dDZeBh12eYZLHfK0qA5_WfTuDQPpx7mNQ@mail.gmail.com>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 21:24, Markus Armbruster <armbru@redhat.com> wrote:
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> > I'd rather not unless we can make an exception for late merging of the
> > PR. I've worked quite hard to make sure everything is ready for the 4.2
> > window and I'd rather not miss a whole release cycle on a
> > misunderstanding of what these plugins allow.
>
> I think there are multiple ways to avoid the nuclear outcome.
>
> Coming to a conclusion before the soft freeze is the nicest one.
>
> Making an exception for late merging is another one, but Peter may
> prefer not to.
>
> Yet another one is merging the pull request before the soft freeze with
> the understanding that it'll be reverted unless we come to a positive
> conclusion before say -rc0 (Nov 5).  I'm confident we can work it out in
> Lyon.

I'm happy with any of these (and we have a longstanding rule
that as long as a version of the pullreq was on list before soft
freeze it's ok to apply before hardfreeze, even if it needed to
go through a few versions or was otherwise a bit delayed).

In practice, since I'm on holiday Mon/Tues and this hotel wifi is
awful it's quite likely that I wouldn't get round to actually processing
a pullreq with the TCG plugins in it before we all get a chance
to talk face-to-face on Wednesday anyhow :-)

Alex: I suggest you send out a pullreq with the plugins stuff
(I've just applied your testing pullreq), and then we can
make sure it gets over the "passes merge build/tests" hurdle.

thanks
-- PMM

