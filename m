Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B12A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQVSfMO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B12A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6wY-0000xZ-Kg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD6v9-0007jN-CD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:05:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD6v7-00038C-6h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:05:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so1293825wmi.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=plfGsLJdFfIUeO3Eskw8eBlBEL40oNkSssS+EPWlzu0=;
 b=WQVSfMO3QuaJrZ1kKzSwJUEZ2JW7LVqNkQ6Vzw8DEAf70vDJfpALYqhKHxpd5buaaI
 TxInbsqXE1EikXf03bxaqXA9MZ+Xt7lcgtOLRc9cv7Y48hMKUvgLLaKV7KDFkaw+18kL
 RYYB1L+2f3RI3DTEemXNMX9GIyinuIIVgKSPF9USgRj9oCMrYmyymMqMjEo82pBwrtaD
 TIS2nd4kDVdqKsj50eVWZEfRvmU690no+SHWJsLwXARB0AT1OjOEZBbTt2PMaeVbogAv
 tT9eHTBQQjoR3+yvV9iEDqEVbmBfiJ8BZgP4hj1Jvtrd3vJJo1I5N+FREzYWn92pDexE
 HnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=plfGsLJdFfIUeO3Eskw8eBlBEL40oNkSssS+EPWlzu0=;
 b=HiVC2ybt/+7U1jQbNatl+nx6kPATnQ+LWqmwf/VhrbXv0ejVV45E68xVbDo8PMGdUC
 I1WdjOrK7AATJ2F80jeH0gGLwOItH75HFwl3zAw2HzOSCl3TjlBqylgVaM9qXfaXn5lL
 rpNUwumlR+1zV8eJOG27HRLAi8CTDg+JDNIWSwpLjNF66RZ/x80dMhy95Z0j5kkJ129G
 0P0bPuSrF9lIj2VM9uLkHVGByuiwICwBh6V+FwHXlmNjSWU6nfB55Nlq0u4goTDKV6da
 WgG+bSLNzy7XlMoFwwube7IpiegXin/IZ9prx8bUIfr8eXbQT+M9QtIc94o0OKS1g/5T
 hNPw==
X-Gm-Message-State: AOAM5329+TUjVSZCYbY0xx02uSwq5TY4CK/qSTTHvQwv6R/3xxAFLwSV
 LQX6Q8yXkOiNUX+qMAvyfUTeP7cQuAzX5A==
X-Google-Smtp-Source: ABdhPJz+g8K1kcMWRQmXBOXWgpYnV6ZXHuRVS74ijNSkJqApJ2+LGbz5ErPHXPUST8CaeZMCfg6ayw==
X-Received: by 2002:a1c:9d4b:: with SMTP id g72mr1990416wme.68.1598969154859; 
 Tue, 01 Sep 2020 07:05:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u6sm2415822wrn.95.2020.09.01.07.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:05:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D3B31FF7E;
 Tue,  1 Sep 2020 15:05:52 +0100 (BST)
References: <20200824110057.32089-1-kraxel@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] usb-host: workaround libusb bug
In-reply-to: <20200824110057.32089-1-kraxel@redhat.com>
Date: Tue, 01 Sep 2020 15:05:52 +0100
Message-ID: <878sdt618f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

> libusb_get_device_speed() does not work for
> libusb_wrap_sys_device() devices in v1.0.23.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1871090
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/host-libusb.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index c474551d8456..77f1eaa5fe9e 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -39,6 +39,11 @@
>  #endif
>  #include <libusb.h>
>=20=20
> +#ifdef CONFIG_LINUX
> +#include <sys/ioctl.h>
> +#include <linux/usbdevice_fs.h>
> +#endif
> +
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
> @@ -885,6 +890,7 @@ static void usb_host_ep_update(USBHostDevice *s)
>  static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostf=
d)
>  {
>      USBDevice *udev =3D USB_DEVICE(s);
> +    int libusb_speed;
>      int bus_num =3D 0;
>      int addr =3D 0;
>      int rc;
> @@ -935,7 +941,36 @@ static int usb_host_open(USBHostDevice *s, libusb_de=
vice *dev, int hostfd)
>      usb_ep_init(udev);
>      usb_host_ep_update(s);
>=20=20
> -    udev->speed     =3D speed_map[libusb_get_device_speed(dev)];
> +    libusb_speed =3D libusb_get_device_speed(dev);
> +#ifdef CONFIG_LINUX
> +    if (hostfd && libusb_speed =3D=3D 0) {
> +        /*
> +         * Workaround libusb bug: libusb_get_device_speed() does not
> +         * work for libusb_wrap_sys_device() devices in v1.0.23.
> +         *
> +         * Speeds are defined in linux/usb/ch9.h, file not included
> +         * due to name conflicts.
> +         */
> +        int rc =3D ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);

This (further) breaks a bunch of the Travis jobs - I assume because libusb =
doesn't
always have this symbol:

  Compiling C object libcommon.fa.p/hw_input_vhost-user-input.c.o

  ../hw/usb/host-libusb.c: In function =E2=80=98usb_host_open=E2=80=99:

  ../hw/usb/host-libusb.c:954:32: error: =E2=80=98USBDEVFS_GET_SPEED=E2=80=
=99 undeclared (first use in this function)

  int rc =3D ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);

  ^

  ../hw/usb/host-libusb.c:954:32: note: each undeclared identifier is repor=
ted only once for each function it appears in

  Makefile.ninja:961: recipe for target 'libcommon.fa.p/hw_usb_host-libusb.=
c.o' failed

  make: *** [libcommon.fa.p/hw_usb_host-libusb.c.o] Error 1

  make: *** Waiting for unfinished jobs....

--=20
Alex Benn=C3=A9e

