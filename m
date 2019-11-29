Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DBBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE1420833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sg0nnz31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE1420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeYz-0000fS-MD
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iadnG-0001ds-FM
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iadn7-0007ZY-Tz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:29 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:35010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iadn0-0006yJ-6j
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:25 -0500
Received: by mail-oi1-x22c.google.com with SMTP id k196so9328920oib.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1LwMbr9n02E/EfYVgYavivi596k0uwJehitpfUuLqE=;
 b=Sg0nnz31MTNP9UFZ6gvj2xI4GwPpDecjh5AIhiqmaY93IVAAwEhaHmtaVisUGdRlbj
 Pz6aV/dl5dEeUGVWT9dkExI/shBKX82M0LD1cimgeJh/3ERdgKvLEIEKgIejIU0QtxCF
 PrsN2HPtOuZYkmd+LYfCNBmELWQdINms/b+mNVrg1jTPnfYe1hYsW2PaklZgklXF0cc7
 z11ClB4K3uqZqgW+QRJMTNw26hKuojyQ30X7OwgwK8znCWitpNhvzF18vtxrsd5xERyI
 3QlU62LPIQmNKCAhEAVAqCJB9BYNFA6785iHiKueIZ/05bh6KvgfjuE9dc/CJMorhLmv
 pO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1LwMbr9n02E/EfYVgYavivi596k0uwJehitpfUuLqE=;
 b=Z7Yz4UzFPo71Cz8XVay+NIrQbY3oIDk6cSMQZbjhwbYlk46MotzJfab61LhzdXbYgh
 sPGZLYmScVu5Q4Y70915NCkr9xvG8uj6xZq9Rjfdkbj6Nfu7MN7xdhdKqw+BRQ36zzyz
 tbF/cfywJ96y0EJXAKGcByRFjz16ZOrTyGl9BEqWry0FdNLTFQFOYKmvSH0LvQNQOQrl
 rPPU0Io8BorXTBKWEuVc/ZTIQOxdKUCc6hfraVJDaarxEOaJHn5kYCBDDV9VMnavX+g7
 FAbGF8oH+erZDKI058oMY0/9wJGXr80OYkLs5cTAmlhMyOYzVdFQ5sICvjcXViHdL++6
 hsPQ==
X-Gm-Message-State: APjAAAWV3Vs4nPOxdQ+FBWFYZYb0UC0gGU8Ts0ilXVNfAV1l5nsmnU3a
 UOz5juvA8wM751K7io1eNrAvsi+GdpDgVZyZEpzMpA==
X-Google-Smtp-Source: APXvYqxdGvZTx/0yMM1tk/PrQsOMYcbllt5fORMHMM3bsL7H+vqJbkd+ivr2+8hb17z1vj7qN7OpjfeX7yA29dokpYw=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr8753004oih.163.1575024371741; 
 Fri, 29 Nov 2019 02:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20191129100835.21734-1-thuth@redhat.com>
In-Reply-To: <20191129100835.21734-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 10:46:00 +0000
Message-ID: <CAFEAcA8J4tJfa3-m_Lf4TUs6yvycp5v4umo8zp6-Cck6ACk=MA@mail.gmail.com>
Subject: Re: [PULL 0/2] Fix for the s390-ccw bios
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 10:08, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 1a61a081ac33ae6cb7dd2e38d119a572f416c7f7:
>
>   Update version for v4.2.0-rc3 release (2019-11-26 21:52:26 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-11-29
>
> for you to fetch changes up to bf876a688c9319b506d5ff1175ba7189cd933d91:
>
>   pc-bios/s390: Update firmware image with the "fix sclp_get_loadparm_ascii" patch (2019-11-29 10:12:33 +0100)
>
> ----------------------------------------------------------------
> A fix for regression in the s390-ccw bios
> ----------------------------------------------------------------
>
> ... it would be good to still get this into 4.2 if possible!

Well, it's possible, but this is currently the only thing
that would need an rc4, so the question is how important
is the regression and how safe is the fix? If it's just
a minor corner case then it's tempting to not have an rc4
unless we need it for some other reason.

Summary: it can go into 4.2 but you need to provide some
rationale in the pullreq cover letter to make the case for it :-)

thanks
-- PMM

