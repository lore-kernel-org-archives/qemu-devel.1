Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508BC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F078E2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY7F9sxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F078E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyBC-0006nC-29
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jSy9w-0005zz-St
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jSy9v-0002ZS-Vl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:26:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jSy9u-0002ZE-VP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:26:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so19209885wrb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=2sFt+Wl5nQfbKLhBnpXj+yuRCjH0wwQbgpo5vn/ll8E=;
 b=hY7F9sxspBbbidu6h43ncIlRd48Kx+6NDy194cOob4Y89WwbxUyVsHK8K0fGH1MFos
 wAl294tUW9Q2rsW6wYYdNsEy3qLbpjPQKERMCHmK9rZqagVhW1blmpBP2R5Y0C0V0EqW
 LDAlNkWPJs3DlxU8vQSIvSxoqKGUL8M0xLQeDoIW2LhKeJt+b4g873RDJBVKvHP2wXfd
 SnolXGT6rFFel1uTGVOZQsNEXxkx9xiylj1K2Zlk5HwArGGNKUjGGbHu+drW/su/9b6A
 hl4uUj2FHGpgJKJ7qEydqJrTEOGTyCUyhm//UpCgzpDiqCziX0rIdVxrFh0K+4pUnPXI
 6BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=2sFt+Wl5nQfbKLhBnpXj+yuRCjH0wwQbgpo5vn/ll8E=;
 b=DeqxUsCJJNMtByy2qkhfkPVxmXDZfQyROfRLvg+37nuYjcX83E4HK/mHaso08A3NRd
 NBbj6ekF7H/cJVWMEaV5tMJMz2Rn5cf8AM4gaqI5F89bPoMqU+PADY/rs650YpSkqI0E
 o8H3xLmwEa2L3vpvnbGPUg0PHlrR4kseQ/nLu9ZSB7iY0v2OmoycNOYFILnzpcCHWR1a
 zw8Bl7RrN31Sxpf6RCB65GOzPy9L39b9Ap7eR8HSORAN5GzAgT5hsEfJ43ELxO+Dzz2R
 LDJ0rNLWbUMNp5lORMF2+887BovuUHPTUMWUl/pAFI91JVQoa7CdVFRwe/kbuL+br2n9
 FpVw==
X-Gm-Message-State: AGi0PuZjzujf8647FpxB+cgm3pE93zOguGpKfoggkg3G5klpS3F77e/G
 1xnUMzI2zkUHFyQ4IzxAXHs=
X-Google-Smtp-Source: APiQypK2bKec+4ymIXmjGvWiw4APZjCRf7StyGXywZhrVDw9ZyQWJ8wBUrrtAwZCfZuryHtH8dsfvQ==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr26822982wrc.416.1587972388993; 
 Mon, 27 Apr 2020 00:26:28 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id a125sm14253155wme.3.2020.04.27.00.26.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 00:26:28 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Markus Armbruster'" <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-3-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-3-armbru@redhat.com>
Subject: RE: [PATCH 02/11] xen: Fix and improve handling of device_add
 usb-host errors
Date: Mon, 27 Apr 2020 08:26:26 +0100
Message-ID: <000501d61c65$2a65af30$7f310d90$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQMXmDKzuqWE9I5CndWgcA3L3a4P9AL+km1ypfGklyA=
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Reply-To: paul@xen.org
Cc: 'Anthony Perard' <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Gerd Hoffmann' <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: 24 April 2020 20:20
> To: qemu-devel@nongnu.org
> Cc: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> Durrant <paul@xen.org>; Gerd Hoffmann <kraxel@redhat.com>; xen-devel@lists.xenproject.org
> Subject: [PATCH 02/11] xen: Fix and improve handling of device_add usb-host errors
> 
> usbback_portid_add() leaks the error when qdev_device_add() fails.
> Fix that.  While there, use the error to improve the error message.
> 
> The qemu_opts_from_qdict() similarly leaks on failure.  But any
> failure there is a programming error.  Pass &error_abort.
> 
> Fixes: 816ac92ef769f9ffc534e49a1bb6177bddce7aa2
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/usb/xen-usb.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
> index 961190d0f7..42643c3390 100644
> --- a/hw/usb/xen-usb.c
> +++ b/hw/usb/xen-usb.c
> @@ -30,6 +30,7 @@
>  #include "hw/usb.h"
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "monitor/qdev.h"
> +#include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> 
> @@ -755,13 +756,15 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
>      qdict_put_int(qdict, "port", port);
>      qdict_put_int(qdict, "hostbus", atoi(busid));
>      qdict_put_str(qdict, "hostport", portname);
> -    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
> -    if (local_err) {
> -        goto err;
> -    }
> +    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
> +                                &error_abort);
>      usbif->ports[port - 1].dev = USB_DEVICE(qdev_device_add(opts, &local_err));
>      if (!usbif->ports[port - 1].dev) {
> -        goto err;
> +        qobject_unref(qdict);
> +        xen_pv_printf(&usbif->xendev, 0,
> +                      "device %s could not be opened: %s\n",
> +                      busid, error_get_pretty(local_err));
> +        error_free(local_err);

Previously the goto caused the function to bail out. Should there not be a 'return' here?

>      }
>      qobject_unref(qdict);
>      speed = usbif->ports[port - 1].dev->speed;
> @@ -793,11 +796,6 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
>      usbback_hotplug_enq(usbif, port);
> 
>      TR_BUS(&usbif->xendev, "port %d attached\n", port);
> -    return;
> -
> -err:
> -    qobject_unref(qdict);
> -    xen_pv_printf(&usbif->xendev, 0, "device %s could not be opened\n", busid);
>  }
> 
>  static void usbback_process_port(struct usbback_info *usbif, unsigned port)
> --
> 2.21.1



