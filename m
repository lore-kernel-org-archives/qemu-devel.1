Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC51C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A3320830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWf/ONNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A3320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGWV-00068L-Lc
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:56:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEGVg-0005dY-2x
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEGVf-00080M-1G
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEGVe-0007zf-OJ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:55:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id j132so2397042oib.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AZKYUAD26Q4BWm3XwOGYBaDpcNOx4LZhF83PEPTQMPk=;
	b=rWf/ONNC5CZw9IbavJoO1uAwOYe19tnKqbXuyIRvuO+Gz+WwbN88MADRbou+bf+07b
	t8TB7XnkSdRLOsu2JpdSuHVYg1lqt2XQTsnKdwbrba/F7wKQKOkukaRAZMahimLlcYw5
	Bpj9Io57hmsnJU6UEUTuCuWQX1k+bK4Z+b28Kzmwcx5jaA+lnryacNyQVcA+8mCqZm1k
	p5vHNuZzN9WIyspYG2pwlmvP3Hg1o8lqyz6JJOp0Uk0eDIi4HLrg4rUymb4qhUxcmIbI
	kaCYkfIee5wYlv7rSsnX9dfRCfaopKoKlub3e6RktR2u1Nl4fizwB3YT4UZd50D5Y41F
	/KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AZKYUAD26Q4BWm3XwOGYBaDpcNOx4LZhF83PEPTQMPk=;
	b=IxDnKF76YFwwwm3R8/PI47a5s1AKzgtTmTyvrnB58xuEUozBRIRtKiWTRf4HzqlVeE
	oN3MTXIPWmAQ7Vf87+SkiyRXIyjO8+jTMC6JMTM7MLhxHKdK1APIdUvNSKGX70KDEt5o
	RJhpcRsEXplDrC44Gw96YyK+AFVbBKqMxpm/dRTEz1HLqqnHUPRnURjJJK96E7mTX5o6
	ERaWN1tC/vU4oGTXrpfQxLOPAe2pvjw1HaHHWPm8O2Nee7wvb9t/52KLCb2x+QBVDUnX
	jf3Mgt2FnCGvI2S051a7wFnJdRlT5PAhWDzyTSBypj/Wr7g34lqEuTmX6iqlkd7QGS44
	3hjg==
X-Gm-Message-State: APjAAAUcyXErHe06urQXXvS6or2AN2RJ/1krYaZvHKuVHm/SFsAcYrgt
	L3zlmEtW8a8DlOxlmgjxhsz82EAH5nZ3nrMdEidODQ==
X-Google-Smtp-Source: APXvYqz46MqHkH0x+vH3+ySHezhmIP6VbXvmtua1LM1AfHy4x2rJfNYb21ni+tAEvNIfPn1/IGe+DWpzzjp6OxAw6mw=
X-Received: by 2002:aca:e054:: with SMTP id x81mr3279005oig.146.1554915336823; 
	Wed, 10 Apr 2019 09:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162918.9343-1-mreitz@redhat.com>
	<aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
	<3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
In-Reply-To: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 17:55:25 +0100
Message-ID:
 <CAFEAcA-iOuvsPoUGNOCaJFBsaC-D7WcxM3X_2FNw1r_gsb8SxQ@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410165525.oba8AeO9q1D3mx_DZduVmewkDTb2ydN2WkDMY9GSFXw@z>

On Wed, 10 Apr 2019 at 17:40, Max Reitz <mreitz@redhat.com> wrote:
>
> On 10.04.19 18:39, Eric Blake wrote:
> > On 4/10/19 11:29 AM, Max Reitz wrote:
> >> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
> >> @direct if the filesystem does not support it.
> >>
> >> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  tests/qemu-iotests/245 | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > Are you trying to get this in 4.0-rc3? (As a test, it has no bearing on
> > the actual binaries; fewer testsuite failures are nice if we squeeze it
> > in, but at the same time it is not enough to delay the release if it
> > does not get fixed until 4.1).
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> If there are other patches for rc3, we could take this as well.  But
> there is no point in making a pull request just for this.

rc3 has been tagged already, I'm afraid. rc4 will be only
if something release-critical crops up.

thanks
-- PMM

