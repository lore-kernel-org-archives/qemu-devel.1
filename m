Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCEC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7300420728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRInYtXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isREV-00038c-IM
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRDh-0002az-0R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRDf-0000fA-Tk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:59:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1isRDd-0000bA-HZ; Fri, 17 Jan 2020 07:59:21 -0500
Received: by mail-wr1-x444.google.com with SMTP id j42so22587599wrj.12;
 Fri, 17 Jan 2020 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bo2XaogUdfhbNeHsGKTAYLqj0dqky/6E6mwFYSkEF5A=;
 b=CRInYtXRFD0EJXaJZ8fMoIuWx10ZYROwLB6AScxVSAgU2eYyxOHPgUsHvsg6+qv0BL
 GvGnodNHnYvyGOIeWsLPMn82LgWHENOe94ZlpYSl6U5tTq9puELS3dVNkZymeq+TM4CO
 DMxkthkFzDNWaPdQ+jQDbhvw+Ww/u6BYW1AEdVaD8mbx0TXU5s7KIKfHBsDSkEglD0yY
 Fl2kx4ZRMreNDCL4krjax18zYMh3aAiX34Qz/ssUy3z0s9K2HIRKtyj+DjvZph9MXwvC
 /vDwDdn1aC0UveE30i+fMb52UOuYUOFWUObgavc6l61NmvE3PrjBNJYgKZxltgjA4axV
 V8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bo2XaogUdfhbNeHsGKTAYLqj0dqky/6E6mwFYSkEF5A=;
 b=AMLuoImShxuoOlhDPv+bAvzoOx5vuDc+F6xEjjr8OQDzkWSFWhjGwlWVzTVRuLpEzY
 p6xNTA7o0bDLtlkhmuMmh5x0sD8Twk3/ZIeQ7ju00xIx0jF1GWmrKXomfVT5RXcCWWHY
 zmn9dAoHKhI4NhKJFNhZRwVbEXe8+WdT9/1jgrHaurX9xVISi/pWwLFnsPEWBrWuBPC7
 zBHTeGE0LaQB1Gjb60tp3uniDO56GkC8udbmwRgAPEdjAyOHJbn5vx7BOm0VbB6RPRth
 d6FzF322xog0DioE1oN0/b4D4IW1Psm6xqhU25E70nomSOnedW/GkzQvilwaQR3XAyGP
 f2eg==
X-Gm-Message-State: APjAAAUpzzcHdTOFoIVrhi9oVuvGv3+ivTfE19W1zsr6RuvcRQBKlDCb
 iB9c/LrY+s58CLuzxYjdy3ynjf0oTu/gKCatTQ4=
X-Google-Smtp-Source: APXvYqz0siPLHKaWbUgLxJ2FxSQpPe/kpKU3LUjhuDZCPO/ns2CcGGustXTXWm4qbH3kjAU2AdFDGt6WBxOm5/3VXUs=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr2861401wrr.32.1579265959912;
 Fri, 17 Jan 2020 04:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-3-stefanb@linux.ibm.com>
In-Reply-To: <20200108161012.1821385-3-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jan 2020 16:59:07 +0400
Message-ID: <CAJ+F1C+-SRBEz4JFoRg-cexa7PeN0W5dPGX07knBApyMmnwCYQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] spapr: Implement get_dt_compatible() callback
To: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 8:11 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> For devices that cannot be statically initialized, implement a
> get_dt_compatible() callback that allows us to ask the device for
> the 'compatible' value.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/ppc/spapr_vio.c         | 11 +++++++++--
>  include/hw/ppc/spapr_vio.h |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 554de9930d..4b24b81797 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -87,6 +87,7 @@ static int vio_make_devnode(SpaprVioDevice *dev,
>      SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
>      int vdevice_off, node_off, ret;
>      char *dt_name;
> +    const char *dt_compatible;
>
>      vdevice_off =3D fdt_path_offset(fdt, "/vdevice");
>      if (vdevice_off < 0) {
> @@ -113,9 +114,15 @@ static int vio_make_devnode(SpaprVioDevice *dev,
>          }
>      }
>
> -    if (pc->dt_compatible) {
> +    if (pc->get_dt_compatible) {
> +        dt_compatible =3D pc->get_dt_compatible(dev);
> +    } else {
> +        dt_compatible =3D pc->dt_compatible;
> +    }
> +
> +    if (dt_compatible) {
>          ret =3D fdt_setprop_string(fdt, node_off, "compatible",
> -                                 pc->dt_compatible);
> +                                 dt_compatible);
>          if (ret < 0) {
>              return ret;
>          }
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 72762ed16b..67f58b7f98 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -58,6 +58,7 @@ typedef struct SpaprVioDeviceClass {
>      void (*realize)(SpaprVioDevice *dev, Error **errp);
>      void (*reset)(SpaprVioDevice *dev);
>      int (*devnode)(SpaprVioDevice *dev, void *fdt, int node_off);
> +    const char *(*get_dt_compatible)(SpaprVioDevice *dev);
>  } SpaprVioDeviceClass;
>
>  struct SpaprVioDevice {
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

