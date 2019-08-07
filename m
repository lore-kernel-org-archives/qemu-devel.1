Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E42C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A0722296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDu31RDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0722296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOPw-00049s-VK
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOP9-0002W2-EI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOP8-0007Yu-DR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:03:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvOP8-0007XP-5K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:03:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id r6so106329155oti.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LJwEbtQLWhV3k7QvClVoCw2Rk5mrtwJdm8oQM5wyapw=;
 b=jDu31RDIwyBWlJFgB1Kbd66DFi990MrCIPBK9OpDtn2xkKX+ZFOXyoDI6wi3VbR7F4
 LCSbB1Od1qXf6vTr2bGKngOiiugI19qqckgIlBUtHgF6r2Nh+3OaiEFQm5l1TASUn7d6
 J6ynsHai2k0YgGaSm3sbYVIaPuMjhjVlMUQl4kWTo27ksTfYdtpo28ZMQin7u/5gN0Yx
 xDz9jXQWuYVoS2q+pt7wkhGwNVWCsPtQ1zQy4R/VD2Qr/BdRHGJK0qIr0ERu4k9cRhsZ
 Fc+MzsNnPEX/DpIcp8uXVWf6gHeJ/HX4Gbm/bkfHPAYsBJVAT9Yl9nJfRew1lSuhOykk
 xTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LJwEbtQLWhV3k7QvClVoCw2Rk5mrtwJdm8oQM5wyapw=;
 b=pUxUUxbIHh3T7c6dIWyVBOcqks72akfEsGBRicAasW7PpM52JBHCNR+R68ckaUffkv
 EGMLUyclJ3uH/++TcOQSkLpOQyA2NXIgs88xlFdV34Bfr2LFQPzOKGVrJgPIMwm0g07C
 +TcQxgIS0jt9IMIJ4PldEKQWm7EDRvhCEm6hjISwa7JqGOfsZugyhVic+LnJeKOEh4ly
 mMn9qJZywdyTH7TNg/pLEWMbiwpPQ0uFjm8mt+uoAsrmw1y1JyV+5jmYdMFhQ0rqxofl
 Um5idpRx6XxLm2SZr3bK1836Ls6VpzdppsYrX2KIW2uRTrjUVCmVP+/OG7nEEgWeAIHl
 rmBQ==
X-Gm-Message-State: APjAAAWjs1XEPwJwQKXRysIT4GibLBrGvPUm+ApfOlewUDZ2WYLlbJw4
 h4cza9Ce55v4OoQT+vL2GWg0scBIByGUWhrLYEPYUg==
X-Google-Smtp-Source: APXvYqz11yG0BHXG8ZJVmcAnKP4YA5rcnbuPimhF0HyqYow9k6R/d2Nz2538c7dTGAq6WbnSCOgBM3kqPVVceDIOLJU=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr461661oie.48.1565193789286;
 Wed, 07 Aug 2019 09:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-10-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 17:02:58 +0100
Message-ID: <CAFEAcA-fTJ117Pv-LgQSbJ90qXxqj8vM9pm9rJ4NVb1MHJ1AwA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:

> +For Devices and Buses there is also the corresponding helpers:
> +void device_reset(Device *dev, bool cold)
> +void bus_reset(Device *dev, bool cold

Just noticed, but the prototype here is wrong: bus_reset() takes
a BusState*, not a Device*.

thanks
-- PMM

