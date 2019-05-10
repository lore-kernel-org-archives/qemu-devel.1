Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A4C20881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc5oWC7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A4C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCVL-0001py-4W
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:52:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCTb-0008TF-R7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCTa-0002NJ-OJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:50:43 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCTa-0002L6-Fw; Fri, 10 May 2019 16:50:42 -0400
Received: by mail-lf1-x141.google.com with SMTP id v18so5088894lfi.1;
	Fri, 10 May 2019 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=YFs8tYIB4fQU4YmAVX+dhWe0qPrL6tFDfZQQKGjfLRQ=;
	b=Kc5oWC7zin00jQBVMwoE4WVSpxpoM8yMCe2FONFZExwoxUwrry8CP6XytnCCq/l6Q0
	ethpVRvd3R4AkzmD5GJOdlYI06LLAvvvB2+Vctab2ihDuRipsk9dErNFTmTX/o982HD9
	/3F8FGknDTi/GrJhz8zLu0BO/kZVCLwKwmKnGLw+BExFfSVYb1ydyZdlZfCzu0kHarQw
	xHGqKyz4xZrZDsqbxhIrkW9pqgj+LiJ4JcM4bePkoDrSIA3qWA8OWOmdmsp8IasecRDL
	1mJsRImTkavf4MeW9RhONitWKmAjr9Vl/CZQotApAhacMlRpXRRcdln95CztWdfSdfas
	r5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=YFs8tYIB4fQU4YmAVX+dhWe0qPrL6tFDfZQQKGjfLRQ=;
	b=H+ZIaGyqni31vgptZaPb6/P0Re1eLi27p+rLkvnYTNrGZHEe/9uXXVOjVEN1hmTYN3
	QQVpIS78xiycWPs6pVAoc3r32hIoE7JY2WmBMfw85IjmJOWCwiUAKLH0e5wCYBkXpKSX
	+somtoTr/cqYaJ1kpKiMfsyYzd+ne06kRr10dbXsjaMLJ6ee2qWl7NIAdw3P6UVktIhf
	NRqfOgJE+eD4jwKeLfQkcrOhrKZhtIXZvfkEdFlqxkY7k9CLfGkjZXXDu4Qko5khr4Vd
	YzBK01xVCizNwJKRJfe3OuZRU6RTgMyK42Jm13toUq3Ka6YbmvZ3iaa+1IPgjkjk0fwA
	l9GA==
X-Gm-Message-State: APjAAAWG/f1ZCThAbV5zpuYNZlQc6gIbJOpFJYvtvX9SHVGNcAD0s/8i
	OKcgQ0HF0/O2M4gJekW0HvIFnLR3fsjFk6Kqoa8=
X-Google-Smtp-Source: APXvYqwii9Zd8ZMgXRlpjwort/gCfaxk5MgxPQVofhd6cEdz33UteWn09dUDLe2VDn3UtpQT3TyUh2wN2C1VCvvrH6Y=
X-Received: by 2002:a19:189:: with SMTP id 131mr6941969lfb.74.1557521440933;
	Fri, 10 May 2019 13:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-14-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-14-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:48:32 -0700
Message-ID: <CAKmqyKPbx5YhWfpSBS=nWp+cPAPPGbz+-Rjm=Wcn_RrNhjjfJQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2 13/16] hw/microblaze/zynqmp: Use
 object_initialize_child for correct ref. counting
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

On Tue, May 7, 2019 at 9:46 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
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
> This patch was generated using the following Coccinelle script
> (then manually modified to use numbered IPI name)
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
> We let the SoC adopt the IPI children.
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
>  hw/microblaze/xlnx-zynqmp-pmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
> index 20e973edf5f..0948b1fd5f2 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -71,9 +71,10 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>
>      /* Create the IPI device */
>      for (int i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_initialize(&s->ipi[i], sizeof(XlnxZynqMPIPI),
> -                          TYPE_XLNX_ZYNQMP_IPI);
> -        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
> +        char *name =3D g_strdup_printf("ipi%d", i);
> +        sysbus_init_child_obj(obj, name, &s->ipi[i],
> +                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IP=
I);
> +        g_free(name);
>      }
>  }
>
> --
> 2.20.1
>
>

