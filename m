Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B98F207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSPxRNc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDToN-00060D-Qz
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDTnl-0005Zh-0z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:31:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDTnj-0002Aj-5f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:31:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id z4so5485899wrr.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0HfNgAhkbvKLf/drJILiXX1PdhxAvkLkIHCVhCfllfc=;
 b=ZSPxRNc4qqiK6z2gIb9pUXqKCyWcjSflovjWIjCTz6W5l9UHDuHV6QHGIx0Mf1FrpY
 ZzjCvqXqH6C5PAxcqcwUGc1W8LBmDZ5GBX1U+AB5/jEWP9a0ZVvOa4LEBTC0mX41wJjD
 YrwOlCzFwpT6tKi+Gy9G1c5lowZUnpDLnfP5LSdsb0fuHWbrSVAJc2WxW5K0Vbntbvgz
 xLEjFRFq4GIWO5mOFWSYoWlCcPo6AdPdNVwj6pZLIWaVsCL42sC5Jzf+SmzBHRl7qxFH
 Grr79YfJPr32MSDABhrnNXtmv2+cBDJKTcZJePXhlTdr+XFEL5VaW9MCrztvIi/0Lydy
 Wuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0HfNgAhkbvKLf/drJILiXX1PdhxAvkLkIHCVhCfllfc=;
 b=VXe7WrapsIsthZcSNyBuMdBHn/IJSYsZHTsM5mEU4/teci9Rc8VqFq1cWUCH6Js1II
 wBPz88cxvluOirJZRprtWKSHiHP25tsGWAd4ZpYA0mzrmX8C/xi7I+FUr7hXWRtHy0qX
 rzppd09bTNpTbX5eue2lLihXLTmNMg2B5U0RWcyP2qba2JyjBHqBxx7xIWW1UlFRRvLL
 WvuuUsPxOVKDjFttPVIH2g8NbG/M+1IGDV8eC3ud02hA2TvS9QFHFqVqaBb1DM+yuF46
 9VlNdnJ5JqkBuqp8BrVlXtAAiuEkYgSTH6c4sWW5L/QDcV52Ueh7+kQNmUbvfkV/0nkW
 E85A==
X-Gm-Message-State: AOAM530IeZAAg+D79+2jB0f6zniXI+vCG/ywhsc4m/6Bkj+9fDlgDqqS
 DxtxQmVYRG1eYMDlJcvX95keoSGNfBstbA==
X-Google-Smtp-Source: ABdhPJzM8Ehvg+B/S5KdulAwMVflyBG1sVKQRGyH9uHgtSj/plQjBxGc5qExfEHH4OM5fH65IN82Ng==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr4144804wrv.369.1599057107797; 
 Wed, 02 Sep 2020 07:31:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o125sm7395287wma.27.2020.09.02.07.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 07:31:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2411C1FF7E;
 Wed,  2 Sep 2020 15:31:46 +0100 (BST)
References: <20200824110057.32089-1-kraxel@redhat.com>
 <878sdt618f.fsf@linaro.org>
 <20200902080937.p6fweexn7cxzru5p@sirius.home.kraxel.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] usb-host: workaround libusb bug
In-reply-to: <20200902080937.p6fweexn7cxzru5p@sirius.home.kraxel.org>
Date: Wed, 02 Sep 2020 15:31:46 +0100
Message-ID: <87wo1c45d9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

>> > +#include <linux/usbdevice_fs.h>
>
>> > +        int rc =3D ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
>>=20
>> This (further) breaks a bunch of the Travis jobs - I assume because libu=
sb doesn't
>> always have this symbol:
>>=20
>>   ../hw/usb/host-libusb.c:954:32: error: =E2=80=98USBDEVFS_GET_SPEED=E2=
=80=99 undeclared (first use in this function)
>
> It isn't libusb, it is the kernel (linux/usbdevice_fs.h).
>
> /me checks git ...
> Added in 4.13, so available for quite a while.
> I guess that is the prehistoric ubuntu version travis has?
>
> Given that we only need that workaround with rather new libusb versions
> (which have libusb_wrap_sys_device() support) which most likely isn't
> present in that old ubuntu version we can probably just do this:
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 08604f787fdf..c25102f3aca1 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_dev=
ice *dev, int hostfd)
>      usb_host_ep_update(s);
>=20=20
>      libusb_speed =3D libusb_get_device_speed(dev);
> -#ifdef CONFIG_LINUX
> +#if LIBUSB_API_VERSION >=3D 0x01000107 && defined(CONFIG_LINUX)
>      if (hostfd && libusb_speed =3D=3D 0) {
>          /*
>           * Workaround libusb bug: libusb_get_device_speed() does not

That works. Do you want to include that in your next PR or send a patch
for me to include in my testing/next PR?

In the meantime:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

