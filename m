Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471ECC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BA520717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhFV-0003fS-Dz
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hJhEU-00037l-0R
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hJhES-0003OP-Tp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hJhES-0003NL-NK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:28:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so2029991wmi.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=W/UnuPQta1eF1thP2IUrMKcGQZDkM6snYJmfOicnO8A=;
	b=tJ+dqohjOi2IBbCPx82Zi2/vkrKA8WILzA6qYHSaa40KZcH6UyXDWj6UnUn+v3mahS
	+A/+ycPsctROfzg9XYHQcaTzSduJ4SVNNKxQ7qyz+SdXQ7pYOtzkkhgYRHuOwhcLh6TW
	XR5tEZ6JNRj4H2/dj1XYsknx7iv0sdgDJ7l5xnr5UHP6FpyorQn1TUxJNNOWVu3KWd88
	f4AVUrLn/bgz67VPkl1VPxBoyUn38YzoZrBAnnLVwpqPbD6JpxJNLqkutdfjUI9aChgJ
	t9XjUUUYzdWYpJz9LPGaJpaddvM6r3NpC2gePZ8JYVCkf5e6Q3ul15iF34wfZmsdRZln
	JNUw==
X-Gm-Message-State: APjAAAX4Ytie2wnFlMX7ofY3cQ1zxuAWfCKfitUGm4f4YkPY5i6ntojU
	YZZvbyvNkcreNqTccIlJsfc/Mi3+DdeWyEPbb8WYhw==
X-Google-Smtp-Source: APXvYqyYAm51i6m5Qxwu5jEPCbQbYJqjAqmAH/zwssjI+Sl5A0sy3M+uMH66+ya6xu2+oLkaS56VTjIqx7QiDG7ms2k=
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr2368358wmj.144.1556209698392; 
	Thu, 25 Apr 2019 09:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-25-thuth@redhat.com>
	<4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
In-Reply-To: <4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 25 Apr 2019 18:28:06 +0200
Message-ID:
 <CAP+75-UkU6RkqD02FE81g1WffkhqP-uGarX42afkbdT3b_r2Lw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, 
	Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 24/29] hw/arm: Express
 dependencies for remaining IMX boards with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Qemu-block <qemu-block@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425162806.XYf7m-IcfwyWUiuWGnqr5Ajuymvho6a1H43yhmTXNs8@z>

On Thu, Apr 25, 2019 at 6:14 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 4/18/19 8:00 PM, Thomas Huth wrote:
> > IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > ---
> >  default-configs/arm-softmmu.mak |  2 --
> >  hw/arm/Kconfig                  | 19 +++++++++++++++++++
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> > index 1455d083d8..6dc388c43e 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -37,7 +37,6 @@ CONFIG_SABRELITE=3Dy
> >  CONFIG_EMCRAFT_SF2=3Dy
> >
> >  CONFIG_VGA=3Dy
> > -CONFIG_IMX_FEC=3Dy
> >
> >  CONFIG_NRF51_SOC=3Dy
> >
> > @@ -49,4 +48,3 @@ CONFIG_PCIE_PORT=3Dy
> >  CONFIG_XIO3130=3Dy
> >  CONFIG_IOH3420=3Dy
> >  CONFIG_I82801B11=3Dy
> > -CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index f5cd63860d..58439c492a 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -283,6 +283,10 @@ config XLNX_VERSAL
> >
> >  config FSL_IMX25
> >      bool
> > +    select IMX

At some point we should split the IMX config in hw/misc/Kconfig.

> > +    select IMX_FEC
> > +    select IMX_I2C
> > +    select DS1338
[...]

