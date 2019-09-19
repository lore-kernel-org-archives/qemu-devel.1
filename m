Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627772053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhqxMM8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627772053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzFB-0006oA-Bj
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAz6A-0007gd-16
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAz68-00023b-Ok
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:16:01 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:44073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAz67-00022N-B0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:15:59 -0400
Received: by mail-ot1-x32a.google.com with SMTP id 21so3566039otj.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C+I7RLBzTI4PSzd9zpKqL+nyJnGhVYjBLB9/dulrPGM=;
 b=mhqxMM8r4J5m35L4zymtX8mWnckyUm7KaEVCEd6SRrzC80q6OaJoRDcB9FQU8hZXkI
 XaN6TprP5+8p0q3jBFC7f3xDqCKsSwDu5iO4ytOYdqJm7osTZHYL+R7a+/hdvxYJRaGG
 HVwBlrQDkgYI/Ux3nZxJlrGVSby3Nt0bNy4pGgsMMMzUFcU5AbsxZEbTHqQmX8u1u5V5
 4wPrl74ud+d2krankSmJyS6uQJ3L8VS9OomlGC8vklD15v7uY2BRnXaEZb80mcV8jjva
 1J3zmZgRn0U2DXZyjAH3sa2v9+d9DDVxBcniNLm7eCEuXRMVi/BdGsluM6EydyH8+Zt1
 Faww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C+I7RLBzTI4PSzd9zpKqL+nyJnGhVYjBLB9/dulrPGM=;
 b=mJD20SUEZ3AUs3UTXFaiMOABjIJdhyoLA0pX/oB5N73QdnH0zoU/iwx6Vu0amOLN0J
 7p5mUaCc6EsjL4W9K1Atnl0p4BBGtEPdI73C1l3Ip+K2eM/GnloqOoDcGhini8d802vn
 zIQMwX1zh4x2Y3iZE94xlMEUCyDsVk/GEAKxwGdg8RS4mJMdr/+L+vfVj9O2YKU0MtE6
 yXmAfb5ER5sV0V/2Yk9l+9MUO2XTd2+M3EVJc+jUFsoMm7AIVowuYZOyrPB6DIQo1tow
 J+C8iUTbYhxpQwNeYYKNYlECB3LOsh9BFA54ccBD+P/DydnrGN2EV4p34ssXOYum0+yq
 +Ccg==
X-Gm-Message-State: APjAAAU9rkWH4Og/HigQisMRWjWtWjnswpog1A4SQ30AxLMeaqJowhQ/
 1N0ee9BpX1UBnrOyfES7kSlgzbSNczssxsNT6osECg==
X-Google-Smtp-Source: APXvYqyhnRLzNjD1EiTf35CWrbTddQXo9lPO35V8oXDQhggD5Xj2yupMPh+7LyYHQEWXSZ3oIO7Cg2nx8Jg0dm5aluA=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr7642884oti.135.1568909757234; 
 Thu, 19 Sep 2019 09:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190919091043.24503-1-kraxel@redhat.com>
In-Reply-To: <20190919091043.24503-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 17:15:46 +0100
Message-ID: <CAFEAcA9O1KMctjisS1FVrK4u08=gCzgrXbHnFRR+LYdajNZtGw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/2] Ati 20190919 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

On Thu, 19 Sep 2019 at 10:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ati-20190919-pull-request
>
> for you to fetch changes up to aab0e2a661b2b6bf7915c0aefe807fb60d6d9d13:
>
>   ati: use vga_read_byte in ati_cursor_define (2019-09-19 10:37:46 +0200)
>
> ----------------------------------------------------------------
> vga: fix cursor code in ati-vga.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   vga: move access helpers to separate include file
>   ati: use vga_read_byte in ati_cursor_define

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

