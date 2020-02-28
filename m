Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EBC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F7324677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+53t4VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F7324677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7kVk-0006lg-P3
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7kV7-0006JH-1n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7kV5-0001Si-D2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:36:40 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7kV5-0001Q3-76
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:36:39 -0500
Received: by mail-oi1-x244.google.com with SMTP id b18so3828338oie.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tJeWJoQT0nLiWqSSmKcFLnNnL7fxEhl/pzuLSYnDieM=;
 b=F+53t4VR4MihRtqcJy9J1kWpMaPuJKL2DSOWDhXrjs7uBAyN6UEGS+wJbvKb8pxwTm
 0wUki+ohXIfpoWF7F+C9YnNzP7lZMWhAaJiWr0Kt5Q9fYcuzuxvXFVkUtGxvbXuFT/+/
 ZzZCAn/v+UOunjezVy4jySEy6UsQ3n5ZIuZIRekNH7ZxWxT/DhA7cMnNTsmSoPdk7IZw
 TwrXWStp3n1di4i1Ea74MejN6N/ls4P1Qterdh2oLHiuMiRhvLcff7hEMkc19RQZkCLi
 2I/zZQcYzLVy4Bg891YPibbPntUYAcil8Ah3YTMpUGfvm8hWSbdIaT4Nb+p6WRihY/1W
 J7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tJeWJoQT0nLiWqSSmKcFLnNnL7fxEhl/pzuLSYnDieM=;
 b=dEPwzV0K5U83Aua2vvuJqAf/sMQuZNkxgVXHicn5ChE07OerIU3PvKyqB1p+6AGZlh
 IXZDAyEL0mDsLPiyqnnyr6ileKK5qPMgTuVRPoSsSLV/qBGaMngKes5D+QP4QX4oC0VX
 JBRAtAV0Y/3b6VRSx/TfCUp8GRF2uxeySvTehexnXV2s+Hb5EWBJs3eLVU8TiiZmL8BA
 pH/9KHpySfW8X+caMOgCoGiC4fXurG+G9WupOvuwHCKkrZJVIUe9aJQpXWbXAwXpF+Z5
 zMPfZUkBdMpoPmUvYWzkAVzUs+SeDDfZX4WETaRejcu6NbcCDgE/WnjX7W5d52iiDKUO
 uFzg==
X-Gm-Message-State: APjAAAWb8/h1rQoR6J7kX8N5duVQuG7wOgOpxqAhF2axxb8X23A0LqlZ
 1DXugmTKwISCiC/wvr+NfzQhCSedEWxMHEVUUvaY5hbT
X-Google-Smtp-Source: APXvYqzvkhLxmL+njKrfUhhG5/md8sYY8zF5MesLRHhUDRCNHLYeoHSBkbzUerf7q0v7R0yyDbLjVSSHBzSScEvRuMs=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr4017488oic.48.1582914994594; 
 Fri, 28 Feb 2020 10:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 18:36:23 +0000
Message-ID: <CAFEAcA_nURkAfum3AxbN2S1DDy3YETuuewOiZ8+RLgbH7OFuAw@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan -- I meant to cc you on these but forgot, relating to the
"qemu.nsi needs updating to know that it should install
Sphinx documentation these days" part...

On Fri, 28 Feb 2020 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; this series does a complete conversion of qemu-doc from
> Texinfo to rST, including the hxtool-generated parts and
> creation of the qemu.1 manpage from rST.
>
> It's marked v3 because it's a development of the v2 that
> Paolo sent out earlier this week.
>
> Changes from v2:
>  * I made the various review-comment fixes I suggested in
>    replies to Paolo's series
>  * rebased on current master
>  * new patches at the end of the series which do the conversion
>    of the .hx file doc fragments to rST
>    (I did part of this semi-by-hand and then qemu-options.hx
>    entirely automatically)
>  * new patches which generate the qemu.1 manpage with Sphinx
>  * new patches which remove the old qemu-doc makefile runes
>    and other references to it
>  * new patches which delete the old texinfo sources, etc
>
> The only thing left still using Texinfo after this is the
> docs autogenerated from the QAPI doc-comments, which are
> their own standalone html and manpages so not affected by this.
>
> A couple of notes:
>  * I haven't actually been in a position to test the cocoa.m
>    update of the HTML filename
>  * qemu.nsi (the Windows installer config file) thinks that
>    qemu-doc.html is the only doc file it needs to know about,
>    which is clearly wrong. However I don't have any idea about
>    the Windows installer to be able to update or test it...
>
> The conversion is a little rough around the edges in a few
> place (mostly I have noted in commit messages when this is
> the case) but I would like to argue for (assuming we're happy
> with the series broadly) taking it into master and then refining
> it in-place. Having it out-of-tree for long is an invitation
> to conflicts and to accidentally losing docs updates if they
> hit master as changes to the texi or hx files before this
> series goes in.
>
> You can find a prerendered set of docs at
> https://people.linaro.org/~peter.maydell/qdoc-no-texi/
> (the interesting part is the system emulation user's guide,
> mostly), and a copy of the new manpage at
> https://people.linaro.org/~peter.maydell/qemu.1
> (download and examine with 'man -l path/to/qemu.1').
>
> thanks
> -- PMM

