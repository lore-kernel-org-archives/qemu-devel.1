Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE504C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B757421726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4ZteFVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B757421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15wg-0005rD-Ne
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i15sv-0003EO-Jt
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i15su-00040p-0G
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:29:29 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i15sq-0003zM-KN; Fri, 23 Aug 2019 05:29:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id b25so6564360oib.4;
 Fri, 23 Aug 2019 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=45/t6Cx/KCdCPIpHkNsMDMO631LAyzQIDPsrlm/uvpg=;
 b=A4ZteFVhl89SNiNvC6QDwvi3V+23+xYfnPtcnj/B8ssBbn6L3vfx/gfyeq7aejN6Pk
 bliGnXnvfoobF6igeOTpgWXxw67f/qkbNetyHnmduO9VqikY+yO59pqzbZcBF/De3u4I
 jOGrTLuCf/OjHuayf4S8a95a6Z7oNZLIrQcgw8H6WoMBH4jVtCXD6+OejOi1fR79Laxy
 sfEMxpHX2JvtKIGIrLPS5RUcDzl0MzI7e0NPc0eb5NAqXND78pVtsSaDDNKpOFFhT+XJ
 x6Z2a4fBdAJ2GaZgslXDzVPR0MJmu7D2KjG1Hytrt2KoCdzzHNE3y6e0yxZvBWGsJxKJ
 i9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=45/t6Cx/KCdCPIpHkNsMDMO631LAyzQIDPsrlm/uvpg=;
 b=YU2OBj34XfeBrdUcoB3D7iVoiwTa24BH9zcB3HgJBVI8kQt7h8FIjRNS/lRS7kJMzG
 84/iUluoGVoPYuKHcilGJ9lOtC3OA+S/hDBfoLCuQdCe70kTWGyhm3cWRFN548gDIuH5
 8uWZmfXLOtUtLfStrF5jBVFPj7cFAGb+8vSHXo7xjCFc8yyWR1h84rpJL4vN+Banik30
 syV9QzXCjMpOqrtvClOZRCVsVLH5PMkpxYnNVuEezN8HbO8NDkL6lovT1geSq4KlxFc5
 jd9JtF7g6OdSDtrWSSIo4Ud6X76BCe98B/DUVzYcCIst1w8Qgw921pApLTZYoZoyeuCc
 I2LA==
X-Gm-Message-State: APjAAAV/OpEeM1iV8XBzGy/O+gLRKMCKsS0S4kzyxpkWGFsSf2YQ/rNT
 bZ8sbgUsPCQc0krQRZ1+O1dQn0aqOXBcgWXlm88=
X-Google-Smtp-Source: APXvYqyiK8c321HSDwhIOMrogF8tsOj8heLRtU0zZpxVR0tKrZlZQ3g0W+9H46jz0XKCzGCATP4L3EzzT2ORAN7gqI8=
X-Received: by 2002:a05:6808:198:: with SMTP id
 w24mr2408941oic.53.1566552563545; 
 Fri, 23 Aug 2019 02:29:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:29:22
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:29:22
 -0700 (PDT)
In-Reply-To: <20190822231231.1306-1-philmd@redhat.com>
References: <20190822231231.1306-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 23 Aug 2019 11:29:22 +0200
Message-ID: <CAL1e-=g1_PCiQLXGQBmKFQHrMj2e7Ag6H9PCm8pysfmRboJUKw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Add RT-RK to the domain-map
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 01.16, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> This company has at least 7 contributors, add a domain-map entry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index fa9d454473..9efe066ec9 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -18,6 +18,7 @@ nokia.com       Nokia
>  oracle.com      Oracle
>  proxmox.com     Proxmox
>  redhat.com      Red Hat
> +rt-rk.com       RT-RK
>  siemens.com     Siemens
>  sifive.com      SiFive
>  suse.de         SUSE
> --

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Excellent! Merci beaucoup!

> 2.20.1
>
>
