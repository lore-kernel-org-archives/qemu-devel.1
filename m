Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F429C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3052084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlSTOlGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3052084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6gEZ-0001af-Ci
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 14:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6gDt-00016r-U5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6gDs-0006rX-Km
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:50:29 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6gDs-0006oa-E3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:50:28 -0500
Received: by mail-ot1-x342.google.com with SMTP id j20so691440otq.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SUwf2n0InXkCCKtSyMhFlX2+/bDJtIzIBnhv+BgGYJ4=;
 b=HlSTOlGD3MrLZVyjIdMjFzm9r45SvPADyrQ3h/bcd7oLnyckFTrjRtBbhbr/vCpprd
 XRuJ3++OI9SBYHufOHNxpZ6cObfzl0KKEmECODgNoe6nT40N/Avu4CpOujhq9hBq8b39
 PV+qi/RxRYr13db65mt/4NDCfwz3poTFHIm5fkbTjWnc9B1zKfQAltHfoBVDa/2WNIwW
 9d+SBOqcK+mlZ0sSXEsXXT3dAM2eq3i1NOlCc4pSVpXkBSmCUzw9xAp5xElraPKPo+Uf
 nYKXajsVU9vDMBpWhfMqNha80i8nlkGjdmtx23+vA3A0LncmTG2FFwsJLFdL/aGxxr8x
 emRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SUwf2n0InXkCCKtSyMhFlX2+/bDJtIzIBnhv+BgGYJ4=;
 b=U6V8D+4zgGViapA4pr9nyhbD3Bnz544eUV4nbZDBxY6vkoPJYKqUZsgFmCBBrgST/O
 u9/k1yOdBAnL6PL1kWldYvURjd7Gz4TaZiJDG2g9TjdVC+UJQRG26fN9bP3mHQjd8P4w
 T9o1ELh4HsNwN3I/wHkDCud859bFgiIcfatAG9K/WBtar9qFPeDkmslE8Cn+t0fmEk72
 f8FEjIpD3ILWOfsaQwrx241Xf5Pn8+RHbRRNKTCIg/PfDoPENi5hPQW7PQ6S75T9R6Iz
 717weZrLAcTgJj4aVgbxOR4duJdyyfu4+tt1WEspzQsuElnxnH5NLX5tFvo+myyMSbKw
 A1Iw==
X-Gm-Message-State: APjAAAXvyfuhdDXElvtI93qND55Xe5smYW/FdE/MgGhK/opEgGm83Crv
 ABxzZRA7eBT/v3SWjB10ud9fOLG9zJndzfRMsmserA==
X-Google-Smtp-Source: APXvYqwv9+pcapNrzG0Yn/p+zbLj08TC/kI93HDdShFz9b4bM+FTHol+FqfCU5ZN8VRM6KU3beGWVrMgXfXGy3e0L7s=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr175943oto.135.1582660227243; 
 Tue, 25 Feb 2020 11:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
 <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
 <CABgObfaFyGE7sFsQ62hoLBJLo+DpO8ftznahUM1EHCzPcOEKuw@mail.gmail.com>
In-Reply-To: <CABgObfaFyGE7sFsQ62hoLBJLo+DpO8ftznahUM1EHCzPcOEKuw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 19:50:16 +0000
Message-ID: <CAFEAcA-nzSwxHqhuL+=ByM3uYCngiY4z0NJkMdPdTTyvh35M7g@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 25 Feb 2020 at 19:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This could go in independently. It would make Kashyap's series
> conflict, but I have already rebased it on top.

I'm happy to collect up 'docs' patches for pullreqs (and fix up
conflicts etc as they arise) if that helps in getting things into
the tree.

I feel like we're working a bit at cross purposes here so maybe
we'd benefit from just nailing down who's going to do what and
in which order?

My current thought on ordering is something like:
 * commit this
 * commit Kashyap's series
 * commit (an adjusted version of) your split-out-the-texi series
 * (automated) conversion of more texi -- all in one series I guess ?
 * ???
 * profit

but I'm not very strongly attached to that.

> Perhaps we could have the files in both .texi and (automatically
> converted) .rst versions at the same time in the tree for a short
> period. If that's okay for you, I can post tomorrow a series to do that.

My instinct is to say that that's a bit dangerous as it means
we might end up with changes to the "wrong" version of the
two files. Would it let us do the conversion faster or
more conveniently ?

thanks
-- PMM

