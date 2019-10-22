Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BAACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04112084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h70lvQ7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04112084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqhC-0005Xi-3m
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMqgY-00058h-0z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMqgW-0001iV-3S
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:42:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMqgV-0001iF-Tz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:42:36 -0400
Received: by mail-oi1-x241.google.com with SMTP id t84so13577009oih.10
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AWDQsNcnEDFIcVKDwUT9YNcZRuv6IBRMy3EtcZqV0EQ=;
 b=h70lvQ7TyNXB21tFyDZroFl6Fq6Hl1eqNQUbH6dMlA8JfQraDnKMKVOU81jNG6sq1/
 q/Qi75OkmSa2ECksv0gtVj7U6c+BjzX8dX5GO3TtqfGkCCk6BajmsZYTEJtGdWWG2Lvf
 cga7Hgbjp2G9B+qBMDFaveNAPG+svmofglchsyQ6uJAAxotK0jg3GJ34ZYR/wJy90WBu
 TzJonBMAlbADkLRX115CP+hkrZfVBMrkepq437Ur60o4dzwJGSa3gJdqeqOaCzi/39IK
 qY3iz1AorWY+U9/8HXABi0B87e71aPhR/caHA69dWYE1uejRDlUsYqVJ8LhEaMfmjiRX
 HC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AWDQsNcnEDFIcVKDwUT9YNcZRuv6IBRMy3EtcZqV0EQ=;
 b=TlhpCHTs7rzFDA+dFkyBGROS1rbJx7hQe1G+UjF2Wp+lPY8ECTELC5sAB7WuHzi8Bz
 Qxy3AcCUGwBlqdqRkQQWpRtfQC2eFevqmR49p7plxDm7XwOtPWC6kY4AdP+AqO3RUPTY
 7eEA0IZSCS/M0ksSJpVpdY8UrHxKSE0X5VN/TcnzWWSFnPluYCqDOcQ4sjXaIpqOH4Vq
 3hWgUfrI1OGzfGpRLIOrNxe0PUCIMC0IxOlanySxg8u/S1td5zCjRJjXmx1E0BGc0iPw
 5AqBU479OGtDaI6W9kSsvTirzM/ovueuFwFE979FSV2rZpgjwuAgU969KQ/baJVLGYdG
 qfhg==
X-Gm-Message-State: APjAAAVIyaDm/NFK68wmp5DiVE0NCXjwE6OYRdiJAGDfJDMy8OaFipXs
 Mi3mRxjqK5lXSe5cZnnOwgQUCTjAYI/ZT1XPSxGPFQ==
X-Google-Smtp-Source: APXvYqy1pKOdTvHcFP0XzOJuYsvQj/PHqE3DixwCFjquN5kcVT5U1DWjRFzC5idMPh4Y1iB7MBwDm6ikZe/nY8+oUcE=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2183082oic.98.1571737355053; 
 Tue, 22 Oct 2019 02:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <b1255a22fe4409244f7a68887137fbe43b71a08d.camel@gmail.com>
In-Reply-To: <b1255a22fe4409244f7a68887137fbe43b71a08d.camel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 10:42:24 +0100
Message-ID: <CAFEAcA-FesfcimTutrYwZFdB93mEE42ha7X93jDqAW7CFUd+0w@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
To: Esteban Bosse <estebanbosse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 09:52, Esteban Bosse <estebanbosse@gmail.com> wrote:
>
> El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daud=C3=A9 escribi=
=C3=B3:
> > +static void piix4_request_i8259_irq(void *opaque, int irq, int
> > level)
> > +{
> > +    PIIX4State *s =3D opaque;
> > +    qemu_set_irq(s->cpu_intr, level);
> > +}
> I would like to understand why in `PIIX4State *s =3D opaque;` its not
> necessary a cast or a object macro magic.
> Something like:
> PIIX4State *s =3D (PIIX4State*)opaque;
> PIIX4State *s =3D PIIX4STATE(opaque);

The simple answer to "why don't we need a cast" is
"because the type of 'opaque' is 'void *', and in C there is
no need to explicitly cast a 'void *' as it will be implicitly
converted to the pointer type of the destination". (This is
different from C++, which does require an explicit cast for void*.)

For QOM types, QEMU conventionally uses the QOM casting
macro to convert a pointer-to-instance to
pointer-to-instance-of-parent-class and vice versa.
In some places, like this one, what we have is just a
void* representing opaque data having been passed around.
You could use the QOM cast macro here, which would add
a bit of extra type-safety, but the project doesn't have
a strong convention here on whether to do so or not, so
you'll often see the just-assignment code.

thanks
-- PMM

