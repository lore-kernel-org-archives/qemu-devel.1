Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182D820673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xdx7l9n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182D820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyX2-00086M-Re
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iJyUq-0005uc-Fn
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iJyUp-0004V4-5y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:26:40 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:37203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iJyUo-0004Sr-Tw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:26:39 -0400
Received: by mail-oi1-x22f.google.com with SMTP id i16so13446453oie.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bsbo5ZAS4gFCxW0NpCGR8HMz+UxrzctfWNQtOTKW1jY=;
 b=Xdx7l9n7I6M+DwaXlU7NRrM/WdH4qbGxYpY9L8RrRbAqabXj6NJOrhV64W3sapLOn1
 NL4lweAKVrZYgLM2j0ggVhLsX/cTvTowbPqMkh/8OIVU+3Mu2+tbExIb0NmiECHeHMPS
 VVEVPltLSpAtWMebUE0q6c1cN5OnmVz/B1WqjTRZ/dgjTbGz6rWoEff9xtKnovVRfE+b
 WjajBRc+FExw41BygkCO76V30WcGhaEQq2ePQB+sJ4Z5+mkF2v9azIcn8Rp4r0xFhkL0
 DjQIISy/3VSDhV/LieDuGEXv1RBkz3eLt6ZpZiQ7TSYOlb7xmy0JUwwESzQQjI7wFw6K
 O03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bsbo5ZAS4gFCxW0NpCGR8HMz+UxrzctfWNQtOTKW1jY=;
 b=kAgx7BlPF6HzvcUioCHuAuZj32/w8LFmhzw4VHupPslFmpmI222V4jr5zEMz4GbA6r
 UdyrM2m4+2PGwEDCy38XHtF6GMDawnftoIn1kClopFTz99yY6VwtMZ1PQImIUs0e9n+0
 nzYmyw5R9hEDLhZI3CCkr63YNZ6KOQIpHnA8M3Iyx3jYnMoHV4isxcE2vT4idJnp37CR
 gfNLuC2vb5AdJ3t1ohXD9lyffIxi5Dk6F7wM1n3kwi8iQ9RMOXLMNO5LFRmN7PpBWa93
 Q5vtt5ogXU3zWtm4dGaXP8Nb5jdIzlIZCUTdwd0F++VqKFH8jJo6tEpBuCBtYjTbqUlW
 vJJQ==
X-Gm-Message-State: APjAAAUTyx1Yu/RMryc8ichvnWd68gSjZBPPWFv1UM8vMgdjBevX5NoV
 DSt4jxAsrA8lu8l5PIeTBnsSyrZODN7fHOb1eBfi6A==
X-Google-Smtp-Source: APXvYqyRPQ9GYeblAySwE4oqlFGpRX8HkHZIRqb/JVbxIuQQi85pqpvprcWnbI9bptGP4i9CCxZHtt0Ktd6r9duGqGs=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr24246109oiy.170.1571052397774; 
 Mon, 14 Oct 2019 04:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113356.5017-1-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 12:26:26 +0100
Message-ID: <CAFEAcA-0JnSTFo_nr4mYYOCOLd8cR1bJWnkvLp-g-aMJ4HuA9w@mail.gmail.com>
Subject: Re: [PULL 00/31] s390x/tcg update
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 at 12:34, David Hildenbrand <david@redhat.com> wrote:
>
> Hi Peter,
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-10-10
>
> for you to fetch changes up to 1f6493be088da969efeeee0100ea4330fb804cdf:
>
>   s390x/tcg: MVCL: Exit to main loop if requested (2019-10-10 12:27:15 +0200)
>
> ----------------------------------------------------------------
> - MMU DAT translation rewrite and cleanup
> - Implement more TCG CPU features related to the MMU (e.g., IEP)
> - Add the current instruction length to unwind data and clean up
> - Resolve one TODO for the MVCL instruction
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

