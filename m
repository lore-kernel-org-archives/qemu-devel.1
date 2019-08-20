Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF56C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F93214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNpGk12l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F93214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05En-0005Hq-QE
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i05Dk-0004dj-MK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i05Dj-0004tH-Kg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:34:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i05Dj-0004t3-Eb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:34:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id j7so5213868ota.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aBvFS+9iLTqJNkSg0ypWGt8/xHtp3PsRc80fO5M8+os=;
 b=SNpGk12lQM0jJG2i3K54NM+hOgnQW9skgJhRuVsZ1yYyO2UmDjNP5TwbMgcNfDSEXs
 yw4aeIJgFo5A1bV/PFNkSbbDx2FttNUdILeVmvbK877c1+H9dh8z/ZxygHO3ZS5bWC3p
 X+ppk9q107dYFg17onkUchHPF2gMhSWYUUSf/4p+SrXadF4Bh8bMLdkcT9JOEdfL/nrc
 CB1dcEul0N9mQNrPIsiCCVI7Txy2F11ahaKOAVupou7VTcT+cR5bA8IP/x3EtsgJJO36
 gSjtBRvDk9kPU40iiQFvzDisRSqen/TdD08JFCZhcR0+Qibb5I7htsoDe2bHkHD/u4zQ
 Q6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aBvFS+9iLTqJNkSg0ypWGt8/xHtp3PsRc80fO5M8+os=;
 b=P5JBCKorLRI/N1JjjK01ejqCdyuSZfrdYqIAkKApdV0hNhz3MqoWTcZViGCovVuKFh
 aVuQGF+fcpcQzmdFwtr7Qo+LzvNfOzABqvGfDT1ylcz41Xu0gN/9nPS/akFKjB6Zkz9e
 BwwdNjcSHNxQPXFNNxapy6dG1ALHAhd6G63Qr8XzS00z7DIK8e1zhqtpyXKBA48qKr4Z
 MM0x0W8Zmd4aCEmGl2HoipGj6YgciKqG0VLcyd/Xli1Onrg+NS6cDPdERS4DDrVjfyZN
 86aNSOf7n3mutIY7uho2sbS08K+zQVIK+ZBBVE5+VcByZPNrNvp0FdHtRZfyWSsvvtKA
 Pw6Q==
X-Gm-Message-State: APjAAAWLSbBndhNMzumcIxT7DG0L0fY/64vd0Zen60PNyUVVS6Y2zACz
 MbLdGKljRijO04DkD/jMhrBdaCkysqMypJzTjcyTDg==
X-Google-Smtp-Source: APXvYqwqzuJMP8NCNwsIFJTpK4FvRDVXTlhHVAQ7oobvQhvZNuLatCiwVCugkn1Cbp1qxZj6VTFY3KfDOx32I40DQXI=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr17915945otp.232.1566311686638; 
 Tue, 20 Aug 2019 07:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190820123417.27930-1-philmd@redhat.com>
 <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
In-Reply-To: <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 15:34:35 +0100
Message-ID: <CAFEAcA99kKzWL89gCQ8NZi4XKL=YzKDCJR1tLbXwQDLLmZyZJA@mail.gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 15:31, Guenter Roeck <linux@roeck-us.net> wrote:
> I tested with qemu 4.0, 4.1, and mainline (with my patch series applied on top of each).
> One problem I do see is that booting mainline (as of right now) is _slow_ compared
> to released versions of qemu. It takes some 35 seconds to get to "Unpacking initramfs",
> compared to ~8 seconds for v4.1 and earlier. Otherwise it works.

Hmm, slow compared to v4.1.0 ? That's not so long in the past so
that seems worth trying to bisect to find the culprit...

thanks
-- PMM

