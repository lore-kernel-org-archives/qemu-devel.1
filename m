Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82093C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5D920856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU775Tk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5D920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2x2w-0007pe-6i
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2x14-0006MH-OF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2x12-0005VT-Ge
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:25:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2x12-0005UO-9p
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:25:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id 10so2569164wmp.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Z8qJcsDf7RYf7QVInGtHPuol4fEvfRopoSlWm0kUn0U=;
 b=DU775Tk5u1DCvDkrIk6ZeTZTr1BTPhvPTOdGSuIeA95bZ6cZHdD0n3TPNzNf/o+iAB
 GAyAz/kn2qEG90DL5gp0P6kKz434edK3e0IMvwGrXKkEPG23A5amSuYsZ4CG24AvIv91
 eSr2a6GJxeM7VYjjDe/fGGluXNDuGq8HFfEEv+NktDL0IEgabP/AVPrZSM4P6vE0CxtB
 oXaCwOvA0ec3n82ZBoFmChVTiFlncA2rr5VMNee8N6Nq1oWD8BNJpMmule/HJrqSCUGY
 tEfFrfhUUs+qEwnMTWUJpM+Svb3ocfviDlWzQqGz7fAz0XFDu48Yk0xe+gn2yTC7QAHz
 2Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Z8qJcsDf7RYf7QVInGtHPuol4fEvfRopoSlWm0kUn0U=;
 b=EO0hQGMb3rNXPeJ2QB9LB7EYY6WlXYX2g47EIPHg2fXxa6SMgcxfN0b7By9IRWLlTl
 eB3LdWUIv+LzDBvkHTLI05OUFN4j/m823XfOzcBZ3ji31LNh0uiazm2IR4IXQf2BsND2
 DHbSqj1AP7pe3H3DfjvhYO1XX4Ul9tRSPDPvdTWRwaClq1LVrHMqhv4Tne6B3A5yjr6e
 SLqWAPPeIz+ngwdHyia8TjaIYQHAUnROy9thkogP/n58faQBz2BKltQHVh6uh7eB3YxZ
 LhhMAHGPbHyO3G/h3xje5OjN+kdUIBjGEtD2OLdpmTWiRR6bMCsse281z9VZDJ1b40Ah
 nPqw==
X-Gm-Message-State: APjAAAXh5HKhPADzgXSQuKfy2ygBwohreWDqtce1Wm5tSB5BBcQFGsYZ
 tCPX3VFVq/13LiMk9FqHw+mc60NwVso=
X-Google-Smtp-Source: APXvYqxHU53mVxTXfFj2HT6QEAy7U7kI6WA83Rb/06JGmwzAqqbrwsCcmNmsoJs1g1jtMxnijlkOZg==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr4743983wme.3.1566995129888;
 Wed, 28 Aug 2019 05:25:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a11sm2377649wrx.59.2019.08.28.05.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:25:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A502B1FF87;
 Wed, 28 Aug 2019 13:25:28 +0100 (BST)
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-2-berrange@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190823163931.7442-2-berrange@redhat.com>
Date: Wed, 28 Aug 2019 13:25:28 +0100
Message-ID: <87ef155vev.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/4] docs: convert CODING_STYLE and HACKING
 to markdown syntax
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> diff --git a/README b/README
> index 441c33eb2f..374b8f1486 100644
> --- a/README
> +++ b/README
> @@ -60,7 +60,7 @@ When submitting patches, one common approach is to use =
'git
>  format-patch' and/or 'git send-email' to format & send the mail to the
>  qemu-devel@nongnu.org mailing list. All patches submitted must contain
>  a 'Signed-off-by' line from the author. Patches should follow the
> -guidelines set out in the HACKING and CODING_STYLE files.
> +guidelines set out in the HACKING.md and CODING_STYLE.md files.
>
>  Additional information on submitting patches can be found online via
>  the QEMU website

It's tempting to suggest we go the whole hog and convert the README as
well. We could then add CI buttons which would render nicely on the
github/gitlab mirrors.

--
Alex Benn=C3=A9e

