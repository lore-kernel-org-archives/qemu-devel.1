Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A6EC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C568120449
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C568120449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKjU-0006QU-4f
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:27:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKd3-0000ka-NN
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKd2-00079T-Hl
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:20:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKd2-000797-Af
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:20:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so26707477wrb.9
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oiEVdit+cpH2GuKWB0ff/Ty4GRLoY1rtT38uhw2uAB4=;
	b=isLwruZZp/BJ2EQ7C+TQCYgRzLqiBYS11b8JxQ1tNnh8dvMBL82MATpxZww08D8IA/
	z+pNiMGCJaxj66iabud+fzn8yT0/Lh7tUfAKSuiW4i/D+dz8wiqNLi1tRRFKf3A0edSv
	7Gk1TG7ogELE1DlYYO2CF2CS5omIG8ugCL2qKMTuoGS21OA9v5gBHUONHpuzdXZysECB
	7RFoKvAqLIBROBWsvgGYKQS7PxSqUC2rchzTeoWMOWUeicmeJiuy5CrAZoVCCSLsec62
	hzwtOogD0ZcH0TfKVP0NJO07a745faHc6sHlH14fwVauJC9yloQl3OM8IgmDg5KGajoo
	/kAQ==
X-Gm-Message-State: APjAAAWsH0zF7OkhbwJHaSdq3tTUXyAjVLCqBvqplQsb9CODklqCa3uK
	+EjzTr7tabcPz+ChfiL+TR1/pA==
X-Google-Smtp-Source: APXvYqxdLSJ+Ba+yVaPNf/e2/oibo+0Hr1fqtrwvjW3o1yWJUH0/8ud0BPhODBvxyLqZG3LPGIed/A==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr26000670wrp.96.1557314451276; 
	Wed, 08 May 2019 04:20:51 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	h16sm33014229wrb.31.2019.05.08.04.20.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:20:50 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-17-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b08740c8-96fc-e336-78cd-66d595d6be98@redhat.com>
Date: Wed, 8 May 2019 13:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-17-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/intc/armv7m_nvic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index fff6e694e60..2334fe51426 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -2568,9 +2568,9 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>           * as we didn't know then if the CPU had the security extensions;
>           * so we have to do it here.
>           */
> -        object_initialize(&s->systick[M_REG_S], sizeof(s->systick[M_REG_S]),
> -                          TYPE_SYSTICK);
> -        qdev_set_parent_bus(DEVICE(&s->systick[M_REG_S]), sysbus_get_default());
> +        sysbus_init_child_obj(OBJECT(dev), "systick-reg-s",
> +                              &s->systick[M_REG_S],
> +                              sizeof(s->systick[M_REG_S]), TYPE_SYSTICK);
>  
>          object_property_set_bool(OBJECT(&s->systick[M_REG_S]), true,
>                                   "realized", &err);
> 

Nice, the M_REG_NS is already using sysbus_init_child_obj. :)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

