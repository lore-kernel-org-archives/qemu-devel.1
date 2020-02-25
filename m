Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26EC4BA00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 22:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBF62176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 22:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwVBGKqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBF62176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6imO-00052K-RN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 17:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6ilA-00049P-66
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6il8-0008D2-Ac
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:32:59 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6il8-0008BC-3p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:32:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id i6so1089367otr.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XN/2YfwI+hSDIfd/OHw2gJXKfCTVnouytMelv7QIKE=;
 b=HwVBGKqhG9w7gb3rbMDi6d8mfXXbv8CztAFBOcXWTdkoho01Z1s7BAeFoslBP3hyL3
 O1OnMIKikB4nrIqzFxx7oPfLKLRUjXaU9pxdwuuE1FSoSz5PSek9HiRph1fsXrLrjPYU
 4i0nkIvSRonSQ3Wxtr4lVi32vgKMJHr+W7+ebeW5PNPG9V263p9kg/IDz0dAypI5zc/2
 pc2TBHN0mkv6tfgJmUypOFaT/Q7sDVas3fvvVhRx7TiTT4SV8ncXd8FBkBsTqDUxEc34
 2aD1qtYVn3KB834YH3ArpqV1LeWqj823X6RdAP1CzXY28lRrzhHQnXIi49L4DtYgn2+n
 WWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XN/2YfwI+hSDIfd/OHw2gJXKfCTVnouytMelv7QIKE=;
 b=dm1XBE2zGgbSdce+K+PetUZRtP0+yocKTwYxdB1swbiBRgpa6b4nmWWLi9EPv1MCsB
 RcQfn0yv05vM0Gblip3c/TsEbVLn0vHd86sCdFwE+HL6bMsMJcOby9mgfOuxBM0tpWiX
 iDSt1V3viUwAjcerjLspCPl87H+U/klO1HywC040UcM5VxxOMmKZePrJqVjZhVVL3z3I
 us/pbN8DRnLBB4JJiOGEH7KYB2Mq2Omoeg6rl3G2IZKX8TY/UOxQ/3c4SRf86qHIdDBC
 OQ5VlCjQEbzS+kLDMw5WKzwRL2hYD6mrFyqJWOwMJkrir+YLGYWYzRjGFtgrwGiTY8m4
 At9w==
X-Gm-Message-State: APjAAAV0iitr1j+YZZgrHaXdjsi7JVDjB2Xq/kc2oe5xcQDzhcxuU8wy
 NM0x06Jo5UALsdZoV9cquTj/j1AiSQWi+xZrYFXH4w==
X-Google-Smtp-Source: APXvYqwXtE9fac0DsLUfs5Dj7gUwcSV3cc6jKQy4i/tTDcRSz/1IDfWAhVBWXXo/rJXg1gOc46QytpvyYT71FQx50xA=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr662310ota.232.1582669976778; 
 Tue, 25 Feb 2020 14:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
 <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
 <CABgObfaFyGE7sFsQ62hoLBJLo+DpO8ftznahUM1EHCzPcOEKuw@mail.gmail.com>
 <CAFEAcA-nzSwxHqhuL+=ByM3uYCngiY4z0NJkMdPdTTyvh35M7g@mail.gmail.com>
 <CABgObfY0QY0g42QGB6K_PzKUX8OPhiSe-KXwU+rB9ksK3FzPog@mail.gmail.com>
In-Reply-To: <CABgObfY0QY0g42QGB6K_PzKUX8OPhiSe-KXwU+rB9ksK3FzPog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 22:32:45 +0000
Message-ID: <CAFEAcA97fcmgLx_QGgRs1Q8XvWAVVf7ykjfHQ6c0R5xPcq41BA@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 20:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The main issue with this series and Kashyap's is that if we don't manage to get
> everything done in 5.0 we have a mutilated qemu-doc. Then either we keep it
> mutilated or we scramble to undo the work. So I would agree to commit the
> series in this order, but without the removal of the .texi files.

Kashyap's set is in the same ballpark as what we've currently
converted (notably it's pretty much equivalent to the qemu-block-drivers
conversion in that it takes what was part of qemu-doc plus a manpage
and turns it into part of the system manual plus a manpage).
It's also the most awkward to try to keep the texi around for, because
the makefile runes for the texi want to generate the manpage too.
So I think I would argue for taking that as-is, including removal of the
texi files.

I agree that it would be good to avoid a half-converted qemu-doc;
if people think keeping two parallel doc files until we're sure we
can do the conversion is useful insurance I'm happy to go along
with that.

If we ended up with "we managed all the conversion except for
the qapi json doc comments parts" would we be ok with having a
qemu-doc.html that just contained those, and all the actual docs
transitioning to rST for this release? Or would we want to roll
back the rST for the main qemu-doc parts too in that situation?

thanks
-- PMM

