Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA3C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3412080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSLGwhez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3412080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46171 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomHx-0000O3-Cx
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iom7h-0003y7-Vs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iom7f-0002Ri-Rj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:30:05 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iom7e-0002Ok-4w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:30:02 -0500
Received: by mail-ot1-x32e.google.com with SMTP id r27so75828527otc.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PcwXxgMbgfNFmznP6VilRDfSBCFpIzKjRBBdoaGkuDM=;
 b=SSLGwhezAChNIv3f9hiuWR/yBWFrnJ8nVvibsWsDiQJBGEc3rlpifZrCSmlz4g3NyZ
 VOhUHJUQxKW29e4X6c7ypOrnbIlklZ1rpznyY/RbaSbZuGqxFACWW01vtG/jerS88Nb2
 GYgjfpgnePISjqeJH/Y+O2RVprf2eMih+IiZfcVAZQR+i52xJ5dUeUqubntjnbCsSDHf
 fUaFUVzEKCD93T4EiEB18uVR8+uAC+647wJn4e0ZImHzjQvXNHc77WuONXRqqvlZ2A2V
 xd16LdJz9XBckjHqgL786dx5z3B2Vsu6f7sfOliLmTLK0gwFn1UfDWGMVijEGWqM4b2H
 bm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PcwXxgMbgfNFmznP6VilRDfSBCFpIzKjRBBdoaGkuDM=;
 b=ej/MjAHJBb/xs1/yUHp3ZnhIkWMSKvkp698ros9cYfWg8sc8/HshGRiRCsF1abFSOe
 /dIcQ+wDq8EH7jSu3UFOjq71rqvC32uPbwRkNE31ALUvon1AbJL0rlxJvJoOwPDTmngS
 ZqnfNqH7Ubhn2n7mUGdQWatJN5WBQIinkKI2x4/3mhf+6LB9fJkC9Rdu67N77BISBaf3
 KwRnYwPaZ04GQPXcUupSsI/xUyoIAfLS531s2URMFIpOkanyPlN3mWMy6p+gb04HfN8V
 y8seu5L17RnaSHBeM8dBaohTuN3dWiagllluTZMZCq+F4wkn40Ct2EXdgUzdyDBwswD2
 aTZg==
X-Gm-Message-State: APjAAAXFRpHvcodh2jGPtc5l0oJ0Pzn3bZcU2qLhdNj5YrT5OYEySEB/
 gM19qDKwox+xCzGxpjV6SXvpJ9GP7p6eLuNfkWxaXA==
X-Google-Smtp-Source: APXvYqwUwvM+Esmu36FiJzUWQffa1iLJm27mbVVq1SX2aHHwK/UVklchGrWbCp90IctsjUZWGnpjcCfHePNb57tHLig=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr16293otq.97.1578393000598; 
 Tue, 07 Jan 2020 02:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 10:29:49 +0000
Message-ID: <CAFEAcA_noBbQh3y6_5ZUu3n97o9pPDPVayLZKSnC1e7D4bjTnw@mail.gmail.com>
Subject: Re: [PULL v2 0/9] Add dbus-vmstate
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Mon, 6 Jan 2020 at 14:46, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit b0b74e1f17508cb8cef8afd698558db1bd8999=
cc:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2020-01-06 11:39:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/dbus-vmstate7-pull-request
>
> for you to fetch changes up to 586ca6ba3cd6d7a3a85ed5cdc4e53b1cd584b0c0:
>
>   tests: add dbus-vmstate-test (2020-01-06 18:41:32 +0400)
>
> ----------------------------------------------------------------
> Add dbus-vmstate


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

