Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EFC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA02221019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA02221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKfI-0002Sl-P1
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:23:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKbQ-0007ka-D7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKbP-00057Q-9O
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKbP-00056x-2Y
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so2756107wmi.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yO6TnPkSgEUNCXlGeLEiC8rT8lvNtt+ewRL54avYGws=;
	b=aDomYL0FBDKRr4hXFwaXFgcs+xItOhlxVcif8XjJ7wPiVExGBAjnQrB3J+EP2yaRRQ
	gg/pGDs3iUKTiZzyyQ6QTaNF2ZqxxIes/3EcaTQyX7GqTV9ez5eemFl5NROqbLsKv46c
	UncDiK+n/BVKvXADnQ1SXgz46SKOfQL2fbPTS/VGbCRjP+EkgnYi9g97Q2lL2flcAzDf
	jWTjOsYLoIPg9nx74nXsV7MZ9HB1LKOpj6JW+ahq+d3TPChBo0OdX3TN4d+BRYwSWrjn
	ustspDfU8dAyMS74HGV9K0UZPrtHoR7+J+4lUvlTb1jYd3d8OQV9R3swEMoIHtTBBPWK
	MISQ==
X-Gm-Message-State: APjAAAXJlhCkWScBJ78O/GBroIJ8K12WHdvaCYZwyYwAtzsJbBtxa1Q6
	mXi89A5bsKg9qivZ14yiXJnhpQ==
X-Google-Smtp-Source: APXvYqx0agrjB8EcD8bYpBtvNzTPaPyQsd+XMPQeZ0KkJFKETRNhtuSySujfwWI/sJj+1BeVcrIIbw==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr2564517wmj.52.1557314350096; 
	Wed, 08 May 2019 04:19:10 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id z10sm9391426wrs.8.2019.05.08.04.19.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:19:09 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-15-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50c6c3b2-33a1-f051-2b55-e102878d8e7d@redhat.com>
Date: Wed, 8 May 2019 13:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 14/16] hw/microblaze/zynqmp: Use
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
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
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
> (with a bit of manual fix-up for overly long lines):
> 
>  @use_object_initialize_child@
>  expression parent_obj;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_size,
>  +                           child_type, &error_abort, NULL);
>      ... when != parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr), NULL);
>      ...
> ?-   object_unref(OBJECT(child_ptr));
>  |
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_size,
>  +                            child_type, errp, NULL);
>      ... when != parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr), errp);
>      ...
> ?-   object_unref(OBJECT(child_ptr));
>  )
> 
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 0948b1fd5f2..df6c0048aa6 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -176,9 +176,9 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>                                  pmu_ram);
>  
>      /* Create the PMU device */
> -    object_initialize(pmu, sizeof(XlnxZynqMPPMUSoCState), TYPE_XLNX_ZYNQMP_PMU_SOC);
> -    object_property_add_child(OBJECT(machine), "pmu", OBJECT(pmu),
> -                              &error_abort);
> +    object_initialize_child(OBJECT(machine), "pmu", pmu,
> +                            sizeof(XlnxZynqMPPMUSoCState),
> +                            TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort, NULL);
>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
>  
>      /* Load the kernel */
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

