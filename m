Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7753C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB74120674
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUClcpAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB74120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblUA-0003nl-U8
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iblTU-0003EY-8B
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iblTS-0004PH-Uk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:10:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iblTS-0004Of-N8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:10:46 -0500
Received: by mail-ot1-x342.google.com with SMTP id o9so9949376ote.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 05:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dtmk+AViR5zUt+ZAvHOkNZ2Mi79saamn3iW5l1Vzgto=;
 b=SUClcpAMdEJS8EdmXJRr1EU6yjG7j/JR/pHHYbaOAhpsKtV4LLuLUpeWGc1F4hucaO
 GcAdMWZ9MPMH/gZZltSS/fLABCEzeHJxsZAsR8pLsVVoyNG8N9az09Q7IGlSdW22TWTv
 yc7BJQcIUsKUyTnUipzAV4X8g6+wMN7ARf3b1wkC+JBD8DEwEEjwuPWbWLxiQDJhF3Ip
 lQzkBPcksBnZfoZtlIHh9RlJJ1AIRssOfcSiKDxc2nFXPoVt8VI40iQasqhpJgnUutpt
 TSPHTyVWOLTpKtHEzTxhI6lhzwpMnvzzJOFNL/EynHqkBQMvrWxWjT878Beb5rmCgM8x
 J8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dtmk+AViR5zUt+ZAvHOkNZ2Mi79saamn3iW5l1Vzgto=;
 b=S91c5SUlnyVPVYIq76Cseg81aS9oxWMZfXnbdMooeHZS2dwPG2qY6UlBK1oIzNsZZY
 eL/Ut6sUTqKHqjd+RdtHDlgRtME86n6FEd+kSpYYC7eUpet9s9wO1k+eOFMkup9zAvKH
 SyElNaNMCUl4y5Jt/RjbfpE/IDnrQca8OBjSPFXqg/ocvARSyL6RBLTQcnbadrw1Yido
 Fd3NzIpJcM2amkpGvGz3fRwp1pcGori/aNEJ1BGJ1YToQr+sVCQxIZROrYT7uEScVp10
 qt1fKnnESadVfTKqLbeYe2R4fe7DdvtfJ2apkU/9CRAgtTZpnK2RdimENYjhhcV7sFAm
 avTw==
X-Gm-Message-State: APjAAAVcI9Rn5GrDxGOPxy6qja2Re1rgmYO4KHefkJ2R1S3BFHZqZ7FZ
 4kFAJZz8cZEp8S2emfu4JFcsfS6bi8HoNMQxNhez4g==
X-Google-Smtp-Source: APXvYqzmcoOLw0QYt3zqBJ/c7wxqjCCiZeY/bv2r/fQGQeZJ1cLoFaqCenZ6zo7uszy04pOfnKT5lHLO5s440zg45to=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2063572otq.135.1575292245725; 
 Mon, 02 Dec 2019 05:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-13-damien.hedde@greensocs.com>
 <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
 <1ae3a4d3-26e6-fe6d-87a3-d5dcce1fd64c@greensocs.com>
 <CAFEAcA89bbvd0Zi44GZrCDc8e-AEKqGkJ3SA3e=Sz6xVHNbfEw@mail.gmail.com>
 <8bd421d9-d0a9-853d-1ab2-09467df64e05@greensocs.com>
In-Reply-To: <8bd421d9-d0a9-853d-1ab2-09467df64e05@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 13:10:34 +0000
Message-ID: <CAFEAcA8rs_YtUWsdzgmyv3h8_mxe8a5WU9Gd3W8XYGjbRw8Syg@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 13:05, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> I don't know why it has been implemented like this but right now the
> raspi_init() does the following during machine creation:
> | bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
> | [...]
> | carddev = qdev_create(bus, TYPE_SD_CARD);
> which put the sd in the BCM2835GpioState.sdbus .
>
> Then the reset procedure of the BCM2835Gpio move the sd card
> to one of the two usable controllers and the sd card can never go back
> to the initial BCM2835GpioState.sdbus.

This seems like it's just an oversight. The code in raspi_init()
which creates the SD card was added in 2016, a year before
the gpio device was added, so when it was written there was
only ever one place the SD card could be, I think. We should
fix it so it puts the card in the right place to start with.

> As far as I understand, it is theorically possible to have the sd card
> on no controller at all (it's maybe the reason for the .sdbus "useless"
> bus) (for example if the BCM2835Gpio is badly configured) but this is
> not implemented in qemu.
>
> Anyway I can add some plumbing to only call sdbus_reparent_card() when
> really needed by:
> + not duplicating the sdbus_reparent_card() in gpfsel_update_sdbus()
> + adding needed test in reset() method to only do the initial
>   sdbus_reparent_card() if needed (first time we call reset).

I don't think you need the latter if we make the machine model
put the card in the right place to start with.

thanks
-- PMM

