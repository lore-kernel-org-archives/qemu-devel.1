Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61749C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CD8216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/KthSq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CD8216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOesY-0003WH-GC
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:58:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOer6-0002oP-GN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOer5-000142-FC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:56:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOer5-00013Q-7n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:56:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id c3so1605335otr.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jf6ifxJqPtil2/If28fs+y7n/g4tQYWn1lQ2e/0s1qM=;
	b=m/KthSq7xgarQiDaDpp732zr99vemEsW5qUQu4ag39sUycka1m/+buVfaM4ItnbjKE
	vvvRiNgmWfmut4BWnBEuexkPWgsyFAdHt0FuGJy6oPvI1eAFqN59y7gBt4lPIXxhmnup
	ZiFniPS2orkrHhszzkkE19KyJv6LM/u4JUnAm7SJsRW/CyAtnxHfLEzoijuHrTdPtMjr
	AGL/Kzcah9ufOlnXzcQrvkqAO7JLpe1VRLzRNVaksgubS0Ifz5uP2zn69X1ThmaVvjn9
	/PLtKJI+f0Zj94Th/nzJD1OHMYbN8/2SNDBorHVTu9dGEQ2RGEGdscQMDS8VJ8g7FMjs
	mAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jf6ifxJqPtil2/If28fs+y7n/g4tQYWn1lQ2e/0s1qM=;
	b=rIOlrU2BNeb7oeVDukM1UKMUAieKGTL4vA/ng4sVk75nWdMAbuY15UpsNo0/xSKoYQ
	sur62TiE11yjOS4sw3jx+yVYeeLGtyVuFtjaw6E9lvfm/rghRGIGU5B4h0n7hzzL4xRi
	cwBcVZWixrEFaf0WIAa/qvvf+u0PKkwErGK2LhRVe4B9KImk6f6FeQnYfmg5HGnmJUDR
	BqeDQ+tyl2cecvJ0BlkRq2YBujaqNKeJiZkC2aAt/JuNORK3rK4JDIWAgBmMcRLxi0cs
	9UWSrzVnDgq/YpWGYvELpYoLSHx5IiC33xBlPw9EgUGv0WNedOChsT6PcYh4zf8U6ubA
	O1rg==
X-Gm-Message-State: APjAAAUcJ4ZUHFnE/y4h3zfTV4qrnbfRbHW3RsLXMV9FWoHwfE8SwIhv
	1Ds1B2eml+UWOwnjSpBy+bRampdMpdKoa1nTdvrDMoux
X-Google-Smtp-Source: APXvYqxLEfE4PsHRc704KQ2UVAZOdutNmIhBMsNbFtYxjKtZRjRcfqCcR2ceIen4MdMZWL++J4MTY9diSwWBFLbpvxs=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr827338oto.151.1557392202174; 
	Thu, 09 May 2019 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-27-richard.henderson@linaro.org>
	<CAFEAcA_TJJ7V3apxmGvhoiRk2dxzT77SapcyMuopGwqmeQoosw@mail.gmail.com>
	<b6518e96-e77f-8ae7-0890-091e42334a12@linaro.org>
In-Reply-To: <b6518e96-e77f-8ae7-0890-091e42334a12@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:56:31 +0100
Message-ID: <CAFEAcA-Agc6KWMqAA3V7tA0aNYF8NhDuC6Opw2Qx5qVey-YTfQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 26/26] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 06:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/29/19 10:41 AM, Peter Maydell wrote:
> > On Wed, 3 Apr 2019 at 05:05, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Most of the existing users would continue around a loop which
> >> would fault the tlb entry in via a normal load/store.  But for
> >> SVE we have a true non-faulting case which requires the new
> >> probing form of tlb_fill.
> >
> > So am I right in thinking that this fixes a bug where we
> > previously would mark a load as faulted if the memory happened
> > not to be in the TLB, whereas now we will correctly pull in the
> > TLB entry and do the load ?
>
> Yes.
>
> > (Since guest code ought to be handling the "non-first-load
> > faulted" case by looping round or otherwise arranging to
> > retry, nothing in practice would have noticed this bug, right?)
>
> Yes.
>
> The only case with changed behaviour is (expected to be) SVE no-fault, where
> the loop you mention would have produced different incorrect results.

OK. If we're fixing a guest-visible bug it would be nice to
describe that in the commit message.

thanks
-- PMM

