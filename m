Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C948C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B942082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW/juRHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B942082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihf7i-0001rM-5W
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf6d-0000yv-KI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf6c-0003HW-Bm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:35:35 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihf6b-0003CP-W4; Wed, 18 Dec 2019 14:35:34 -0500
Received: by mail-ot1-x343.google.com with SMTP id i15so3832751oto.7;
 Wed, 18 Dec 2019 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TmnglxQBI0Zh5IiPq1gi/yI35MDQ3krWMoDnxyu1Cho=;
 b=AW/juRHHuM14qB7AnOQ5IH40wCmnXzkDnQ4eb/kyMN2bHBZJSjC2KpaWKdbD6Joty7
 i4xcZLHZV+Jnm1aPK+NQ/9upi1u+O0DWDXg/JuR603I8hd1hobAWS2lib/WCRrjWRqLm
 vVH1ucfNJF+hVkFKKDZylI2YhUBcuIwRlyibhiyabJLX+O8JSBk1Gn30f/kaRS5z+UyH
 Xen05Lxh8wEbso9HhA0ATPePYQI/vVn/0Pke+ISfzRoTA8mo+OO7sI3qM7/nZxU+zI/c
 1OJjB5AWCZiJcVyjtvc/AGDbYUM5H0gJPGqLxaqhbPIE0C7knHQX9SL4dkk8Wp/SKNL7
 oKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TmnglxQBI0Zh5IiPq1gi/yI35MDQ3krWMoDnxyu1Cho=;
 b=s5lW3qNWk6Z5ng06nQnpLo5drWz1XlN/k4JYuCg+I8FVUAJzG7j68zRlh2VigigsGm
 wjgAsub7sziABKudQqGSyuMqQTONYFUiiy9vZ3hw2zC5adaf71f4UFhNPovUI5ExyWyJ
 hWjQFsrGyAWbEEfMqF77XpQW9LNf1FTjuQicqOrhiLSTOuAQqFRbVRcb11i2IAHTsny0
 Wl2/g0P29H7zr7zuwdIbfGQc4dMWJ1LQ7BWQHbmunfeZBxY2YX6Ei/0ARzV2zlvSYjFw
 ut6YYb+qnZi5devFHQUeK2y1D18CbPcN9FbE4QhrMmNzUWu2yxkwCehhjN1YXNnvJjxm
 +3xg==
X-Gm-Message-State: APjAAAU/a5aMXRdMxgTNcS5KgfCGXSEGEh/vfBVP6m6w/FjKG01CYZ3h
 /9bsyAXkqSTYKWYnQv+VN/1JB71spmS7BVQ5K4U=
X-Google-Smtp-Source: APXvYqzU9RqFPFBqMUNeWUBMxxaCsywj0rH0H7X407Jm9H8yAZZgbbr7RjkdP67fZeBbm8XjIe9OrzEV5Uifr9UpthM=
X-Received: by 2002:a05:6830:1741:: with SMTP id
 1mr4536567otz.295.1576697732994; 
 Wed, 18 Dec 2019 11:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-7-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-7-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 20:35:21 +0100
Message-ID: <CAL1e-=jJFgah4Z4SC61dic7ax0dwc9stS2F3PqY+kchfUWOcwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] hw/pci-host/designware: Remove unuseful
 FALLTHROUGH comment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 8:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We don't need to explicit this obvious switch fall through.
> Stay consistent with the rest of the codebase.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/pci-host/designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 71e9b0d9b5..dd245516dd 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -182,7 +182,7 @@ designware_pcie_root_config_read(PCIDevice *d, uint32=
_t address, int len)
>          break;
>
>      case DESIGNWARE_PCIE_ATU_CR1:
> -    case DESIGNWARE_PCIE_ATU_CR2:          /* FALLTHROUGH */
> +    case DESIGNWARE_PCIE_ATU_CR2:
>          val =3D viewport->cr[(address - DESIGNWARE_PCIE_ATU_CR1) /
>                             sizeof(uint32_t)];
>          break;
> --
> 2.21.0
>
>

