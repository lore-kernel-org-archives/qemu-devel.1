Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A04CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D464921872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZzFTPWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D464921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcfV-0006Yp-MO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNc39-0006rT-MN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNc34-00033s-Iq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:17:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNc34-00033N-CO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:17:02 -0400
Received: by mail-ot1-x342.google.com with SMTP id z20so1789043otk.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bkRtwDTjVI3MLPVrtGeXczRUegD3guGhnNoJAE5WxCU=;
 b=KZzFTPWJOqN/6KlWG2H83ofpUsrR+SjsVlufm+ReByDY29pZypcuJ2FbCgkzFBTlY/
 hhT8rVLO2w+MKrOZJZHDSBbXpJxo0qh8ahAW/Jm2XfXUqwqVyXosqsL/hgK+Mm6mRCAw
 E4+9C1Mo2bDoyxtRBKvpfxm9V3mJ5LR3R1HRxwfJCEuTjDP9AuchrHiqK73SG7UG4zs7
 1NPHMFz+oW3h3+mane1rXoWkhvrFhUPvxmf0rEu56lEzPyUnmcwklJcqflBWIpbOogbX
 8R4sETggxR2CW0aS6jyQlQP/Pw+wm7OwUz3JjOqqdi8ayR+f1pXEnT2CMy3kYVFcUrQ8
 Sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bkRtwDTjVI3MLPVrtGeXczRUegD3guGhnNoJAE5WxCU=;
 b=YjEnP78BHIKF0aJH+nMkEbCnyNqddm2WndY5KlHYHkkdqP3ZtVBCYtA+p/AUDR1lz9
 z/Wg8lgunEeEYGU1bqH2U7fC0GwL1VuE2Yu11sLAoaMmzDQpJBsIywDfR1QIwGnD3YA2
 Dfgw8kJI0QkqYrVZU4xE4jBYBwyAdZX6RB5aCaaqL9x5dfRTPDLp+6YaQiBN479x5X43
 nrrhFsDzUeSRXRuIuIacR2FEgLDafimhEs7VzlXFSfjPTCxNELRv0ngFI3auNSxzCSfI
 RgMuTlkeu7C0Xf40SEgqcgu28ssKyJD59tlHBPgGmGiDKdtGu563o8dC0OcbnWyBgvQz
 hLeQ==
X-Gm-Message-State: APjAAAUlg/pyZLL5SqSmPEmSCuqr1/U3uQWiM0c9J5Bo506aswcVLX9P
 yiGQKiVp34kmH4eIxODs0NaR8lhCM/GO8TvwtnRM6nSRfng=
X-Google-Smtp-Source: APXvYqwkvz1xNxIrjNvtFZ8EoHy/uFXuaWRexPhDESAlhud8uBodphImUWOnSVUxSjWbclDVgKQs05wLvPpcVZDgWR4=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr11816095otd.232.1571919421371; 
 Thu, 24 Oct 2019 05:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132122.4402-1-peter.maydell@linaro.org>
In-Reply-To: <20191017132122.4402-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 13:16:50 +0100
Message-ID: <CAFEAcA84xJPWjF0h=4e1g049e=4ZD2Kg0Y6aPG5K-97_e1Y4SQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Convert ppc and microblaze devices to new ptimer API
To: QEMU Developers <qemu-devel@nongnu.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 14:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset converts the devices used by ppc and microblaze
> machines to the new ptimer API. (xilinx_timer is used by both,
> hence putting both archs in the same patchset).
>
> Currently the ptimer design uses a QEMU bottom-half as its mechanism
> for calling back into the device model using the ptimer when the
> timer has expired.  Unfortunately this design is fatally flawed,
> because it means that there is a lag between the ptimer updating its
> own state and the device callback function updating device state, and
> guest accesses to device registers between the two can return
> inconsistent device state. This was reported as a bug in a specific
> timer device but it's a problem with the generic ptimer code:
> https://bugs.launchpad.net/qemu/+bug/1777777
>
> The updates to the individual ptimer devices are straightforward:
> we need to add begin/commit calls around the various places that
> modify the ptimer state, and use the new ptimer_init() function
> to create the timer.
>
> Testing has been 'make check' only, which obviously doesn't
> exercise the devices very much, so more specific testing would
> be appreciated. I'm happy for these patches to go in via the
> ppc tree if you want, or I can collect them up with the other
> ptimer-related changes I'm sending for other archs.

I'll put these in via target-arm.next, since they've all
been reviewed now and nobody's suggested a preference
for some other route.

thanks
-- PMM

