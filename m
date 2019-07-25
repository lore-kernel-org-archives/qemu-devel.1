Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F55C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0566B218D4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1N3Mjmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0566B218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqacr-00055O-9v
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqacf-0004cH-ST
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqacf-000674-12
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:17 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqace-000670-QS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so37284453oiv.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hcjGhjKlKRW0Z1DdWtVulmkGeH6J26zfkR+bG+7xcG4=;
 b=E1N3Mjmvl7AzmWH9HF02ej39uGElQ1eyauQtihj0VCZ1aoEaqckI7EWDfESfXUlZ0W
 4aaDm+ubN/MsllD/3TqOIGRfb6FWJO3WWvgSxdF2y05elWxlzcd20dlWadF1iOc5GYwB
 D9gXIRjUgZIm0bTPvW/1jcfFvsafrfvhtTNa2Zx/GGRInfC6buwvo8Qdjs5LXcijtdLf
 l/aoq/D3V2oCr06LDSULPktwFUFkF1ai8HmEGqQbb2DuMyC5JuOM31IHfSj7Zl46UeYq
 jzxPd7QLwLIH9gLSC4JXbvmxMFYmGYa1mfLSkoMjDUIhlRHCxjyjKzBZyXPzpDPY1nCf
 fdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hcjGhjKlKRW0Z1DdWtVulmkGeH6J26zfkR+bG+7xcG4=;
 b=Qd8qFG+oWheqILLs4h+Aq+ynSUORk6EOJcO0LRL2sWPRAh1Py88g+1swd0+3RsaPzI
 aXCLZlgPi5f0wm1V/DNoS2zGm6JViFNPpAwrrwi2mx7v4gN/C//lYVjWvw54kwd8VvYQ
 J2ozUGUs340oeTR5iAmSsqyaYbdIbGRCUUi/5JT2BuU6jct2t83z+gVOtCinrkSkH9KV
 XGr7gpNGc2a/OAKMIadCYzycrx6AE96bIwQAx7Qas548X55KJYxOJABklkCqyohPTCLO
 J7IvcwgNs0U1dtTTeOAjEE6nf/lFBImqv8HQmHRRpJtdB4P6HbTfOhX496sLiN8UCOct
 fLFA==
X-Gm-Message-State: APjAAAVy1aUk0GLPGpasCbzsdIOXRAQHvOeLATLnfqNTbuCMMp8/aI4j
 dCD89w49hCotUSubLcOPT7QyLK2SUXwVJ3jkvDhKLqcL8oE=
X-Google-Smtp-Source: APXvYqzGbu6dKz8Sj3YQ7CPMjjmCYxq8lBcZ/ck70VucXcwbAlKmvf8LDGn0uxdb3qr2O7s8Kwq7q5yA1vJMuMg8j40=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr44370100oib.163.1564049116206; 
 Thu, 25 Jul 2019 03:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190725055908-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 11:05:05 +0100
Message-ID: <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 maran.wilson@oracle.com, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> OK so please start with adding virtio 1 support. Guest bits
> have been ready for years now.

I'd still rather we just used pci virtio. If pci isn't
fast enough at startup, do something to make it faster...

thanks
-- PMM

