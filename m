Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ECC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7940420989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBviLL1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7940420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCYl-0004eW-KE
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:56:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCUp-0001iK-Ji
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCUo-00043h-GE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:51:59 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCUo-000425-8T; Fri, 10 May 2019 16:51:58 -0400
Received: by mail-lj1-x241.google.com with SMTP id n4so6199091ljg.4;
	Fri, 10 May 2019 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=V4FO/4vDfUYXhv0hUf0VkpD2C+NuA0Nhc2FW6S1ZLPE=;
	b=aBviLL1LffFjlUPTlOrkIPYWamZFF+z40+aaxA5agV21Oab4LKj6j/QP414LyoH6J8
	kEjmQtOfuoFzbUfjXSHEPli4sU/6FA2KIHc47EHeCL4X7bovL23/J30Th7/6fRqhYdVu
	dWnJUoIL0vJXe3qFbftHWuD93+hLNXGHsRjqd8AdRjfoT7AxZeFfftrsa7jLx9IvGNDI
	SazUqTnmrGIu6uMxbh+vethmsCX8uTHVfscpRatqKrBtg6sZ6Yhgqiu8ju8jiyF5PVkE
	WbudynB54437gSjYKL/ZDbH0iu6eELb4fW+b/dH2XwridFZeyln1dyIzSh6//Rvz0S76
	4ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=V4FO/4vDfUYXhv0hUf0VkpD2C+NuA0Nhc2FW6S1ZLPE=;
	b=DPc7vAE0JmeR86K3J2UzhVH1UdZKR0o4lRIRpWZcJfml9rP7psg9Y/x4woPHqqS3IO
	SyMVsKpdLZCHQ/PT7CvbdtCLSowBTswx6FTxAqBmAvOY97aQcNN87EGa5VV5qI6KojCF
	3M1ISZqMcUgoJUAOnu4oyDKGUoPZ9mP8eO7JHAtJPdGreKyPAOJIwx72ZrE4DY7e3OLO
	amaaH0AUgFL+BU2ji0c8/dA02F+KwtH+NnBKLCm4UBnTxIX5z17zdOwxVGfP8S1iKJ/I
	5Fmri5XYQ9xyuDTVi5ZdDN0zZg4Zgm3muocp594BjDpsOBjI5ohThZ1G2pHpG0G4RpEp
	yJDg==
X-Gm-Message-State: APjAAAVUsmrEUSBoT3gxEOXN/VgFfHkuNkWMRE4g2p/QNY8sOW3hyISn
	vgqR3hvR1E4MRlc0HJi/Z2snH20zfWNZd2Z7ZRM=
X-Google-Smtp-Source: APXvYqySDjtZkPawt/zPDDyuVmeBiGqd1O2c2u9DwLr6ghfYiJguDYIMataXJkkMknn0XfzQTCizQvKDoPwTSlKB0k4=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr6832502ljh.197.1557521516851; 
	Fri, 10 May 2019 13:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-17-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-17-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:49:48 -0700
Message-ID: <CAKmqyKN_rKoPCf4Lk+v4Ly0P0gvp0gJYJSqm-ivWdE5+wFXy4w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 16/16] hw/intc/nvic: Use
 object_initialize_child for correct reference counting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"open list:New World" <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 9:48 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> As explained in commit aff39be0ed97:
>
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>
> This patch was generated using the following Coccinelle script:
>
>  @use_sysbus_init_child_obj_missing_parent@
>  expression child_ptr;
>  expression child_type;
>  expression child_size;
>  @@
>  -   object_initialize(child_ptr, child_size, child_type);
>      ...
>  -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  +   sysbus_init_child_obj(OBJECT(PARENT_OBJ), "CHILD_NAME", child_ptr,
>  +                         child_size, child_type);
>
> We let NVIC adopt the SysTick timer.
>
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> This choice also matches when using sysbus_init_child_obj(),
> since its code is:
>
>   void sysbus_init_child_obj(Object *parent,
>                              const char *childname, void *child,
>                              size_t childsize, const char *childtype)
>   {
>       object_initialize_child(parent, childname, child, childsize,
>                               childtype, &error_abort, NULL);
>
>       qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>   }
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/armv7m_nvic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index fff6e694e60..2334fe51426 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -2568,9 +2568,9 @@ static void armv7m_nvic_realize(DeviceState *dev, E=
rror **errp)
>           * as we didn't know then if the CPU had the security extensions=
;
>           * so we have to do it here.
>           */
> -        object_initialize(&s->systick[M_REG_S], sizeof(s->systick[M_REG_=
S]),
> -                          TYPE_SYSTICK);
> -        qdev_set_parent_bus(DEVICE(&s->systick[M_REG_S]), sysbus_get_def=
ault());
> +        sysbus_init_child_obj(OBJECT(dev), "systick-reg-s",
> +                              &s->systick[M_REG_S],
> +                              sizeof(s->systick[M_REG_S]), TYPE_SYSTICK)=
;
>
>          object_property_set_bool(OBJECT(&s->systick[M_REG_S]), true,
>                                   "realized", &err);
> --
> 2.20.1
>
>

