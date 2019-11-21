Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87770C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512072070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrABA4tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512072070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmhI-0002Mu-Gg
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmgO-0001Xs-Gy
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmgN-0002qu-9w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:39:40 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXmgN-0002px-1u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:39:39 -0500
Received: by mail-oi1-x243.google.com with SMTP id n16so3209681oig.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D21bS1dncI5y9O3sahLEVn88cwUcrsMq4eVRRPk241g=;
 b=KrABA4tSnDV+4Uz4hWZYDeXZxWQ+1eG81Dy3k5LsCXAf/h0hzQbV6uW+b3weHSYX8d
 bayvqSHadeZ63MD05GcNennehNDc8E55moMnVv9ToPhxkgP8V1+alwCQSHQPfHPTWF0i
 NYLHQ4C1mOH4boWarY9egCRVD6dotrObVaIfFCi/bp4wYuXnIq+pJuNG62HLWPhM4sfa
 CjehMELFreVRy3gAbe/NAEpm08KaRqfjC/gVnte/1ynhV5P4v0HMY6LjyXTpPXhWEDHM
 qx+6bSvYRzxVIUhoKNFB+EzIyXmGNzbEAIdayI9IIHMRwWfWw7/8U2GUohWpVPDQfr5M
 osig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D21bS1dncI5y9O3sahLEVn88cwUcrsMq4eVRRPk241g=;
 b=lF2H/UGQwCmCP1RsxOLZJMohOzgmyq9BUg5WT44DPbEmdTaRRpcKlzCAM2yvwFtHo8
 sOIA4NsOmbmJqpOV4Sec7UhhuR7GWHR5hMpBY1h40DmEwsm6oDKTS+qbIZhBNW2oHj5L
 dnapyToIRFlGqQzzXa2LA8QJWmmiKDxkzXXzX2vUoNe0+pF8hYt85cwNenh+w1WjXZ68
 Z1Xebp/0jFOWOSYOoV2zFfeSrGatbairkd4Whdr9xXNbh27lW2i+32HUTyDPFFUaSL1e
 mNL6Vc+vOykE3IwhduC/wRn2g6la2NIMg0RcB4LtKH/fHqhF+5J7xOKmCeEm+CghU1EO
 CzDg==
X-Gm-Message-State: APjAAAW3ccg0XmkcKRiWr0VqoWs99T249qqeXgScBTADPcpuPupQ/FQ5
 w4svNv7gE3jRkzSt03rKpVah7klOI9pAf0LHclynvdH59jQ=
X-Google-Smtp-Source: APXvYqx5P7iydS86BuvNVTavjbn5bwdUkMooNB1FpVLzz/yhgbSWQGhU+SZFh1OfO84t/8ovOgpMPPVzT0yjT5QiPhY=
X-Received: by 2002:aca:4945:: with SMTP id w66mr7911237oia.98.1574343578142; 
 Thu, 21 Nov 2019 05:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-7-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 13:39:27 +0000
Message-ID: <CAFEAcA_YdCpE5Nn=b08nThROFdPsAbT1MNK0pYQSmB_9K3zy1w@mail.gmail.com>
Subject: Re: [PATCH v4 06/37] serial: initial qom-ification
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 15:25, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Make SerialState a device (the following patches will introduce IO/MM
> sysbus serial devices)
>
> None of the serial_{,mm}_init() callers actually free the returned
> value (even if they did, it would be quite harmless), so we can change
> the object allocation at will.
>
> However, the devices that embed SerialState must now have their field
> QOM-initialized manually (isa, pci, pci-multi).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +static void serial_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->user_creatable =3D false;

The comment describing user_creatable in qdev-core.h says:
     * It should never be cleared without a comment explaining why it
     * is cleared.

So we should have a comment here.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

