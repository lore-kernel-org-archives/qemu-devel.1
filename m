Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C68520818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcdzSHkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C68520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvot-0002Pt-0l
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 09:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEvRd-0006Vh-LN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEvRb-0003cK-RM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEvRb-0003aU-3b
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id u15so8210420otq.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nfNq1oSb3Eb6knzBx4QvvCh+2k15447pDUDGy4iIptI=;
	b=KcdzSHkMJGpu4XEW1vw7SxcsDo7o7cPIAAp5Aly2gpeR4eZvO1LbOUA0Heyi4Am2nj
	9yDD0Xk7Xm6h8IK6YLD6I50aXYzwC8moGJfuMjvNzJdzW10kmJ60d4lwh7h7HCkrTNvl
	MkTmIOMA4RXRPjR+erxBksOrMhusDLwLdF+UOiclOCK2UqyyVIPN8USyGPJOPpHiH1hU
	qYawBPgtn3iK5PAxzH5UX+KszGEKCJEgvXIRG6B/7FB0rGZv+KNmpA/4IzEC5tlYluiC
	MWUPlcxHOV4Khon+z/2gwOnR9YCeul/SnFPpJJQzGMgg3RNeKsCot+V1WESPf7NZWbJ4
	PFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nfNq1oSb3Eb6knzBx4QvvCh+2k15447pDUDGy4iIptI=;
	b=NEaVlz6XK3djrE3RyX+8eaHmuh4+GAIJ0U9QrKlD2NmyB4BSarJGQDhMzNYw94c0Jk
	QwKech6p6EY4CkTkzz/fInOqVEE6D4C3BlHUJg0juxQ1E4oD6J0nykZh50oTfX7ZcZ5W
	r34dNwoJb2HpArOm6s3sg6Zk2OBjZemJJXbnlnQNKOXay293VBy5VPZMeotqacALdLbT
	semXLoh3jbHxVP2h0xq34TuNO9POrgs4FWbX2Jp0GTp+h0u2gDrULXRfe1Np1WU7DpR8
	mw8RPYzsedMqZSXGyQl0BVkltWgX59VMu7qzVzDUoJeIgIClbzLld79G2/HuYvJ0yGla
	JWzA==
X-Gm-Message-State: APjAAAXiUCXDJKPsR5puZwoOO966qv40LxdlLtX1XJUcwc5tyfK483ko
	MHow8UG4PbY0m8wv13wk5SB/CDakf+i/hwYEasAtZQ==
X-Google-Smtp-Source: APXvYqzZA0iPlQho5v9cZ4vfmkS2erkuqxOHOwQ7l2y7Iajkiu4bHvcLcHdf0T7+EKxt5P9UbvpwKMJR4hVUjTWIGMQ=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr31208781ota.302.1555072688583; 
	Fri, 12 Apr 2019 05:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190402073018.17747-1-kraxel@redhat.com>
In-Reply-To: <20190402073018.17747-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 13:37:56 +0100
Message-ID:
 <CAFEAcA8L+qBhSG_6+L60VgA8_P+Eo_VuD1VEELJX2-pfUbFwrA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
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
Message-ID: <20190412123756.B4khcJoqoQigfIUKDmJe1wTZH96-rOGHfLuD-cTi9-I@z>

On Tue, 2 Apr 2019 at 08:34, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On some systems wchar_t is "long int", on others just "int".
> So go cast to "long int" and adjust the printf format accordingly.
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/curses.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/curses.c b/ui/curses.c
> index cc6d6da68463..fb63945188b2 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>      swch = sizeof(wch);
>
>      if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
> -                        wch, strerror(errno));
> +        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2: %s\n",
> +                (unsigned long)wch, strerror(errno));
>          return 0xFFFD;
>      }
>

Applied to master since we needed an rc4 for other reasons.

thanks
-- PMM

