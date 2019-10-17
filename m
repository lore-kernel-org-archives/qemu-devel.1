Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6997D20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnXINwOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2eY-0004E3-Ib
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL2dk-0003jy-8G
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL2dj-0004x9-1W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:04:16 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:44624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL2di-0004wc-SC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:04:14 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w6so1615137oie.11
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x46/Y0c5lJXtRFzt2GFc9umks5ThF0UiZW+q+cH2RpQ=;
 b=RnXINwOpPBJlW6crevhHZdf53Yicd2GnobuomIxcDF0ND++0ruiu7ZofOdz6vDWcJG
 CNBV9OVaQXYNAa+Hdla/cey+suPGOR3WRRd4XHNuPHcV7RSeqm6i0o5h6GW2Fa6GQNU2
 G4iM8Tw9ulEIDVcBkzcgrfSSpau5A4omsPCB+n+8f7WEF28833qTHmrZSdXGlWeQJja1
 ZxIyr5XttG0xStSOrbKMq8/bdePpc6eY+q0h7B/yZdXwBsq+jEQuwiHf22W2yhGdMmjd
 2YIe0Yni6bW4lE7W6EhRKODHAlbcHHGBW0pHMa3pvn+fJkLvCKk3xq1kOsPPubsTZ+9E
 AY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x46/Y0c5lJXtRFzt2GFc9umks5ThF0UiZW+q+cH2RpQ=;
 b=AIxnkhBQvcl0FYbVnBfLh0J1HNg7fa9YDDHivneXi3khKezRamkGitQ4qDoHm3DRQV
 HMJ2ScAaVg+IIYEldDIVnXvrDTI/8mb7sQIKVHsM64nA5rcsxhDRL1ajjtolfvFOlzV8
 MemLclzKBEcw2HcWMN+aaSGNDNlBQxul8R9sBB2GJAYwE3Gv86lMuPJhdShWmN8576SZ
 dtTeWQqbJT0286js0tyl/2cdw5vWctrPfd5OzF0dAErOeB04ppzNkBEr+rUP8ARF6krM
 xt6bWHgr8BpEQB6pVMnKgEf81Eu5ddZt9pOgbR9Uxtgk7gSQdrwJMNXRepsm3/16wZBQ
 WE+Q==
X-Gm-Message-State: APjAAAV+JwdY39jdRTye6ZvTrklr8zt7V5TY0feJqneltRss+TKD1SoA
 uKWJIMpPVPCvnm/xYH9LiMWVEN6kKaLBr8jeROqXlQ==
X-Google-Smtp-Source: APXvYqwBu6bKoROTiDWyqiMeAAbTqj9UK5eGTDGvxBObPTcm0VjFDncUZvGQ1OvCtVpx+TRj/ysDBXnx1N+ZUAfefZ8=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr2315796oik.146.1571306653982; 
 Thu, 17 Oct 2019 03:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-jutAw2KFBDX9v=Q7LQ8_Mj0AHB79wi74hoW6J81fbhw@mail.gmail.com>
 <71badd7c-a9f0-ef91-5477-623389aa52fd@redhat.com>
In-Reply-To: <71badd7c-a9f0-ef91-5477-623389aa52fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 11:04:02 +0100
Message-ID: <CAFEAcA-0aYLbEoWf_ZeTxoLdKNaeFESyiuHi5KYG9kdUWaAJtg@mail.gmail.com>
Subject: Re: iotest 260 failure (linux host): "OSError: AF_UNIX path too long"
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 10:53, Max Reitz <mreitz@redhat.com> wrote:
>
> On 17.10.19 11:51, Peter Maydell wrote:
> > I just got this iotest 260 failure processing an
> > unrelated merge on my x86-64 Ubuntu box. I assume
> > it's an intermittent (have just kicked off a retry) but
> > post the backtrace in case it's of interest:
>
> I hope it=E2=80=99s intermittent, although I presume it might not be.

It has indeed failed again. Is there some way to get the
build to pick a shorter test directory name, or to get
'make check' to skip the iotests, so I can proceed with
testing until that fix lands?

thanks
-- PMM

