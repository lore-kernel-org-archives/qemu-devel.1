Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D320C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF74E206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/1aoElj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF74E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUwr-0006Fr-66
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUdj-0004D5-Sz; Mon, 06 Jul 2020 13:10:47 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:34930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUdh-0007rx-Em; Mon, 06 Jul 2020 13:10:47 -0400
Received: by mail-io1-xd41.google.com with SMTP id v8so40052002iox.2;
 Mon, 06 Jul 2020 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wZPcNnfJm5MPTasltoq/pBa3iV0LcdhND5nIpKUJi/8=;
 b=k/1aoEljxB0uBEqfqH0Zn4KhFaSEHuRC7puZspsg00ZQnuYbG361wHg3SacgFJDj5D
 tsj3n5BFbxJduCK35tjRhuF2/a9NzvStraAOtyCnDhA1x3ZIDzvxsj0SeVn96GcH66cQ
 +fOPAx/5lIiJ6CUyYV8ORDaUEU0GMk/TmxFz2lsMqQ1ZPLYRTUaOZTHWIAoFD6WwT2w9
 dE0VZxLY1HVMcUMAVCCqzToMHhxxVykCFBb3WPUEtZ8T5PdUIBDhJKXxk1Spjm8NLNHs
 uMj6b4Ox5j2PchTgKufiol5/oFIvZYBrDFwPFhjtdYp+E3sHNnFizOD1mX/9Z5ZYBI8v
 cucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wZPcNnfJm5MPTasltoq/pBa3iV0LcdhND5nIpKUJi/8=;
 b=MskhW81joZ+3jmobz2zIHp+l3yRAanBxR6fKnIPM9VHB9dxf2+8kExoS0L4YSlFL81
 AxN9y0BV9zP7WUkbDu6PAckQdMo8/HP4KEG3ZRbEtZ0a41foBEogpSSfHeVLJv4xgpex
 Ha0pcia8Vrd7nTQVL5jktNSKUxwfJldI1Fnapyho8Rh3DG7vEWNeVcCro1aUClFiaSso
 yqIzyHXV+meM+aT0KsMA9uFLXfISZZRihbkDKx/8DpsGJOhxrahSG4baM4yuXhYYJf0N
 CH8ingrMv2Xx7pRWGqFbKme8oHe8fRKx5ZSEreMu/AtCfoj8mVz4vdkhGBKo+K5wvwjK
 Sksg==
X-Gm-Message-State: AOAM530dQANcaIXBqppbdGqW46KLTXHkenWB4GUrE4uU9hKJfR91b7qR
 wrB78K5UwntIslSZ5gnZDb+K46qNOfiMIe+VpQE=
X-Google-Smtp-Source: ABdhPJx4Y0GqgQR2J49zdJrF6Wimg0enF5qkXxsI0KvUd7/3ziu/gL8IcMOHx3OKEzWPz3QhdGIRQSrp8CAFUbt1qmc=
X-Received: by 2002:a02:6c4c:: with SMTP id w73mr55529406jab.26.1594055443540; 
 Mon, 06 Jul 2020 10:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-14-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-14-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:00:56 -0700
Message-ID: <CAKmqyKOcdG_Wv8yectwwHaxmryB9uBKK+GX1ZGtrq7ZCRcRsAw@mail.gmail.com>
Subject: Re: [PATCH 13/26] hw/usb/desc: Reduce some declarations scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Paul Zimmerman <pauldzim@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 7:59 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> USBDescString is forward-declared. Only bus.c uses the
> usb_device_get_product_desc() and usb_device_get_usb_desc()
> function. Move all that to the "desc.h" header to reduce
> the big "hw/usb.h" header a bit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/desc.h    | 10 ++++++++++
>  include/hw/usb.h | 10 ----------
>  hw/usb/bus.c     |  1 +
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/hw/usb/desc.h b/hw/usb/desc.h
> index 92594fbe29..4bf6966c4b 100644
> --- a/hw/usb/desc.h
> +++ b/hw/usb/desc.h
> @@ -242,4 +242,14 @@ int usb_desc_get_descriptor(USBDevice *dev, USBPacke=
t *p,
>  int usb_desc_handle_control(USBDevice *dev, USBPacket *p,
>          int request, int value, int index, int length, uint8_t *data);
>
> +const char *usb_device_get_product_desc(USBDevice *dev);
> +
> +const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
> +
> +struct USBDescString {
> +    uint8_t index;
> +    char *str;
> +    QLIST_ENTRY(USBDescString) next;
> +};
> +
>  #endif /* QEMU_HW_USB_DESC_H */
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 15b2ef300a..18f1349bdc 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -192,12 +192,6 @@ typedef struct USBDescOther USBDescOther;
>  typedef struct USBDescString USBDescString;
>  typedef struct USBDescMSOS USBDescMSOS;
>
> -struct USBDescString {
> -    uint8_t index;
> -    char *str;
> -    QLIST_ENTRY(USBDescString) next;
> -};
> -
>  #define USB_MAX_ENDPOINTS  15
>  #define USB_MAX_INTERFACES 16
>
> @@ -555,10 +549,6 @@ int usb_device_alloc_streams(USBDevice *dev, USBEndp=
oint **eps, int nr_eps,
>                               int streams);
>  void usb_device_free_streams(USBDevice *dev, USBEndpoint **eps, int nr_e=
ps);
>
> -const char *usb_device_get_product_desc(USBDevice *dev);
> -
> -const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
> -
>  /* quirks.c */
>
>  /* In bulk endpoints are streaming data sources (iow behave like isoc ep=
s) */
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 957559b18d..111c3af7c1 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -9,6 +9,7 @@
>  #include "monitor/monitor.h"
>  #include "trace.h"
>  #include "qemu/cutils.h"
> +#include "desc.h"
>
>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int inden=
t);
>
> --
> 2.21.3
>
>

