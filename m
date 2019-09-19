Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C541C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051C521929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIkad+/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051C521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv9W-0001x8-NM
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 08:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAv7e-0000B1-Lj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAv7Z-0004rm-Ch
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:01:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAv7X-0004pg-FN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:01:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id c10so2791209otd.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 05:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EdTIMrnVvzS5sjYLnYIH1AGMHz/4PyMthWkJ35hZwco=;
 b=qIkad+/rXiltmZq+sDZGJDtu+Fq7RxUvhMN0LcvOxx9l1UnFQIJA2DJFjjNtXWoycU
 9JF6f6NaOUuGgu0Si6gr3ndBfV5OcUWwaFpCQSSAr8Ezu8g9iXLpLTur1Fiwgii/g07F
 2vnLTmzKRFrkiVA6NshvBuETq/WW8svm3of5VyKnBjhgIhW9EOPV8XevqFAQXt/KRvEM
 LiXALHSJsTc2S9yHHZdE3urw/1o9IuVi5a2JNiZDcJfg0QduTuKUxvGiAgG6CE2q4nj5
 jgWqpY3uABcBz6gUBOIg63TIBMg+btqPej78GbrivD2vlAE2lJ7JH9CzcK32ckq9H4JF
 g0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EdTIMrnVvzS5sjYLnYIH1AGMHz/4PyMthWkJ35hZwco=;
 b=FBoDMFqM8Z+XF6knYS2tpCVHT6hZRtZ7CzLQcEjQA9AQJy3nyvCAVUxyOrlR0cnYzg
 GxpX7Esm7ItS40+sUTyoZqP3+KTO/zPEARHi3kSvGzGGHfrRVF74aYYTZYODSF9NRCX3
 0WkUCrh28SoLti1vbQk+b/PXXpMmvLVcpt5ww7WyjrwHl9UYxlrf66c+URvkOmfdaHR8
 HUwhM7Ys/4MTmcFSFJpFcVy1LkN9hOJqUvLc3k/bLsIMBD6qMY7UocPSjysy+2TSx1Y2
 eTDZPLKueNVgXIpe1e5Q3B2rXfODN+9hOVlzmuQrLUvXCi+9QobqHXBQTwuRuiK8elHc
 GboA==
X-Gm-Message-State: APjAAAXzkIDMeEfdAggLFLnq5pxmBgxkN8th0g/rKDfquoLzpdsVE1Y3
 evTmSXasxcurEYeGqUH53CGs9t2cvdWZxvyLpJY3sPB0VNM=
X-Google-Smtp-Source: APXvYqyedN16tbtMkTYGqoUjBpssMfbLPtl3rtnv4cpYotjSfGV2bDC2h33EwdcLokQgLucCGYukbsogaos4JSAGUlc=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr5826691otp.221.1568894469618; 
 Thu, 19 Sep 2019 05:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
In-Reply-To: <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 13:00:57 +0100
Message-ID: <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 02:25, Eric Blake <eblake@redhat.com> wrote:
>
> On 9/13/19 10:49 AM, Peter Maydell wrote:
> > The qemu-ga documentation is currently in qemu-ga.texi in
> > Texinfo format, which we present to the user as:
> >  * a qemu-ga manpage
> >  * a section of the main qemu-doc HTML documentation
> >
> > Convert the documentation to rST format, and present it to
> > the user as:
> >  * a qemu-ga manpage
> >  * part of the interop/ Sphinx manual
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Message-id: 20190905131040.8350-1-peter.maydell@linaro.org
> > ---
>
> In an incremental build on Fedora 30, I'm now seeing:
>
>         CHK version_gen.h
>   GEN     docs/interop/qemu-ga.8
> No filename or title
> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> Error 255
>
> and suspect this patch introduced it.  It may be that I just need to
> nuke intermediate artifacts rather than an actual problem with the
> patch, but I'd welcome help in identifying the problem.

If you build with V=1 what does it say it's doing?

thanks
-- PMM

