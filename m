Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260E121783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGf9w8Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260E121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3nJ-0002KY-9h
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho3n7-0001vp-ST
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho3n6-0006lg-RL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:37:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho3n6-0006kl-L2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:37:36 -0400
Received: by mail-oi1-x242.google.com with SMTP id g7so21081661oia.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j5zboelYJkl5XVLBTwC4HEhgEDrsrFVoDFnWOqY8VdY=;
 b=LGf9w8PgJqZIbEMD6E1w3WRPe8mrTW1wz/t9J6T61pqL0nyYyXtEYkHCh7FuSPbuE5
 LVotpCSmjCuDD6+IZER0znptma//+g3aQHryiz8RN8nUWKgBjq202YDHYosiG5N3udP3
 Eacw/YFHKa9f62y1Gk8vTtZXHJZBMHhIXUDaWLVYg+bRTNjeYwXPwMJhtYItpO0e4HAL
 1YBlzG3lYEWbhowK31zEdyhr97VDNJnqyKkIceycFDvo9NsU+eVBgNXmo/Nlp+dKK49N
 gHi4Oi1M+FXvzGcYX2iDvVhcnBKS8yQpSuzzcJiWMmfjrURY/p4xkeI5CU4ApTl+0wc+
 TX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j5zboelYJkl5XVLBTwC4HEhgEDrsrFVoDFnWOqY8VdY=;
 b=iDnj5vYlgQlN+Zg7ze6vV7akeK2CXpSBsR4RwmskBzebV7Q9K4i5JMaxdXghBtm/JV
 SQDqXCz8l2JiWzXRQJnRHBzM2zVN9BP2yxhVrChdz/z9e7d+WfVyVOPOyx9xuhxNcsc/
 FbMFHQYWEPgNQTUx0ZmAwzYg2uecWUwohYpL5gLUhzBaMVT7MX4eWA2D5bjNdAs6OkKp
 +/7VaJpT+eWtwjWIDjAaig8suGu9FFxCxfAIyuLIaOYoRkcR7GXyUqcho89XRMO+jekw
 lx2MW5XIe1JBpnapGigyrWyixJChLKdtNN0hmD1hsiEjVRozjtZTSHcujx/Ul4c9w87J
 7fpQ==
X-Gm-Message-State: APjAAAXQpxRVS2poK+LJ3KwgJ0pBug19Hor+qAfFj+nX/uB8/GvlDLu9
 bGr6SAF+23ONAM9PDnhpg5aZT7iLq0479T9VxMwP7Q==
X-Google-Smtp-Source: APXvYqzjQa7/5dYEw4vNQ5eIgo3ZthVuXC79vjzPWy2WxHhBYLE3zYxMnCZ9Vhctb5IqD3R2QcyrAA62En432er97tg=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr2338514oic.170.1563446254988; 
 Thu, 18 Jul 2019 03:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190718092219.20081-1-chen.zhang@intel.com>
 <375615d7-7cdf-4711-68fb-47ce3c8cb308@redhat.com>
In-Reply-To: <375615d7-7cdf-4711-68fb-47ce3c8cb308@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 11:37:24 +0100
Message-ID: <CAFEAcA8oQ0buYaOAXsjzUecDjrsk+=BAtM3bW3skKkTEZ5Ngtg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 at 11:28, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 7/18/19 11:22 AM, Zhang Chen wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > This patch to fix the origin "char *data" menory leak, code style issue
>
> "memory"
>
> > and add necessary check here.
> > Reported-by: Coverity (CID 1402785)
> >
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > ---
> >  net/colo-compare.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index 909dd6c6eb..fcccb4c6f6 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
> >                              uint32_t vnet_hdr_len,
> >                              bool notify_remote_frame);
> >
> > +static bool packet_matches_str(const char *str,
> > +                               uint8_t *buf,
>
> You can use 'uint8_t *buf'.

?? that seems to be the same as what is written...

>
> > +                               uint32_t packet_len)
> > +{
> > +    if (packet_len !=3D strlen(str)) {
> > +        return false;
> > +    }
> > +
> > +    return !memcmp(str, buf, strlen(str));
>
> If you don't want to use a local variable to hold strlen(str), you can
> reuse packet_len since it is the same value:
>
>        return !memcmp(str, buf, packet_len);
>
> However it makes the review harder, so I'd prefer using a str_len local v=
ar.

I'm pretty sure the compiler is going to optimise the
strlen() away into a compile time constant anyway, so
this is somewhat unnecessary micro-optimisation I think.

thanks
-- PMM

