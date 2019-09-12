Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82306C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE1F206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSB3An+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE1F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ncr-0002w9-9Z
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Nc4-0002N8-KD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Nc3-0004c1-7G
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8Nc2-0004bZ-Tx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:50:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id g16so10570668otp.8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q0TALGyqS6vw/07WRSxOGLEF7IH8JmJLM8psL7al33k=;
 b=vSB3An+7k1+kJtG0FvtD8kDeYTF+z0YnaPS2Iw8kerN1X4SjQeaAqOrwArWYuZz8st
 7Ym4o+LVKP/dyc7s/A2pvNU0UfxDwelsEH5O2J+3ve6OTFY7o0tmr2oP0QT49BGe+axP
 n24ZsH2+KtjAfbAmrmWakctoz6HXYochxTumKE7jBsMZOGi4j7GKGisJnxq7HGnYY+tx
 J4b2jLN30tr/+VLa8kkpWmYRqbhp6RoqfRUTVS0vGWrs3H+gxZWPTOC39wZp58cTX2vp
 neEKe+jcLXmo5Z4xjw8BLe8Wx6sOaKYG9sz4PhB8Jzgkx/JJ0ZvLYgmzXj14DMU4gbuf
 i5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q0TALGyqS6vw/07WRSxOGLEF7IH8JmJLM8psL7al33k=;
 b=MWDi5r61wI/fz/ng+fdqFVRU7uRmsy0LjucEYNOl3l46MTkcIZjmmBQh4uF75JwLCH
 rVNWEHRFflnOe7q/oMqxDOYbvrp8yOdYbpwJRcJMVjvXGbPZ285bqpKQyKhtfC3epu/3
 PwXlo20l+aNOtgu1kADJf8Lz9NhEidb2ZbVa64WpIhL75XHsneRhMdAjYand2Yp/Rnrv
 Jvxpr0xmP/vvjVX76GMKYj2CA1BxQgVzAmlQ2fhPf+LfUaRQorVj2LRzWfc6FVmXmI0Q
 kN/YuU6JYyaTWYIjuu9y7M5IDXRHF6H7zfVAQv4DhEn8ibzq1EXFrBrUVXHJrgPBHl0W
 nwQg==
X-Gm-Message-State: APjAAAU0MEndfcAdjB4vOWLrWOvAYkD58NIAEIm9Jl51793g3jrXNFlL
 D1DQC7ra9Y0GsIf3U0AUKofKRAa3EbI9VHVXXTDyNw==
X-Google-Smtp-Source: APXvYqxk9aCu3KQ0UFHfhGWOr77qWXEbz2qP4ZZdSIZdx8b0cMFnqotIrdboA4+pNSXzYyTLHsYwj1j/IS2zOCU9/is=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr12609896oti.135.1568289009674; 
 Thu, 12 Sep 2019 04:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-5-peter.maydell@linaro.org> <87ftl1zqo2.fsf@linaro.org>
In-Reply-To: <87ftl1zqo2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:49:58 +0100
Message-ID: <CAFEAcA-iaae3+AKv3F5iV=XnqgaVB3BS1dT_ur+1+YopNqxQrw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 04/13] target/arm/arm-semi:
 clean up TaskState* usage in non-user-only code
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 12:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Why not pass cs to set_swi_errno and deal with all the differences in
> the helper?

Mmm, that might be better. I think I was going for
not changing the existing use of TaskState in the
code paths that use it.

thanks
-- PMM

