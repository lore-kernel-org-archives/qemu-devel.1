Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B4C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638BC214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638BC214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvbE-0003YQ-Mb
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhvWw-0000CE-59
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhvWu-0006En-4a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:35:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhvWq-000673-93
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:35:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id c27so5966370wrb.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AZCeRWSMuP4UqySLZZFrYJOMDJVzaBqONi1GOmlAXYg=;
 b=RHVOsR44DUVO+0Ng+rIkfDHjJA7cOjKrPmNHPGiHphWDxB1ytoUjAzveyBNAlbWVKB
 lj3PIfU3g67D5PKlNKF+5herhyKSLQM2Vsko0Q4qn043RtWeohuJFLpQwNRj9c2meZ9w
 3ENyLjSEX7dbjfDWVIySrnP7LRnOPH473mWWKNg4nokambzeWnHc/dYDwOpnDGo7ZsKZ
 HV89NBJKmuD74hJEjwPJUA+NCbN8nQl66TQVobxAtMpzQvJ+NYKX3a0bEhJlCGTPbX9+
 lY6uc0zo45yOuRhlH4Jto7USbJPfL+ga0+k0SfpvsOnShJCR/XQbEN0vIzd9wdTeXXrB
 PYfQ==
X-Gm-Message-State: APjAAAVZsIiUbZdkFi7JEdvS09dSJ0JSnYygRpCqxiODjPOu8kIoQyim
 FKeSqLjlND9BviINVF8Clc4aow==
X-Google-Smtp-Source: APXvYqyc7rvU/W9uyxI88J3z0JHBsnCmXQiBhM+Rl5u4hIUge9CZklZJzdwN4+Ave+/dsaCMMfbbMQ==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr830627wrw.349.1561984526023;
 Mon, 01 Jul 2019 05:35:26 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x3sm10524424wrp.78.2019.07.01.05.35.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 05:35:25 -0700 (PDT)
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190701123108.12493-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <626f9e20-cff3-757d-1043-04df3c1c2b3c@redhat.com>
Date: Mon, 1 Jul 2019 14:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701123108.12493-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 0/6] hw/arm: Use ARM_CPU_TYPE_NAME() and
 object_initialize_child()
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Buh I forgot to Cc Eduardo.

On 7/1/19 2:31 PM, Philippe Mathieu-Daudé wrote:
> First we use ARM_CPU_TYPE_NAME() when we should.
> 
> Then is follow up of
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01492.html
> 
>   This series looks at Eduardo suggestions from [1]
>   and Thomas commit aff39be0ed97 to replace various
>   object_initialize + qdev_set_parent_bus calls by
>   sysbus_init_child_obj().
> 
> Finally, some devices are declared orphean while they have a parent,
> let them be together again.
> 
> [1] https://patchwork.ozlabs.org/patch/943333/#1953608
> 
> Philippe Mathieu-Daudé (6):
>   hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
>   hw/arm: Use object_initialize_child for correct reference counting
>   hw/arm: Use sysbus_init_child_obj for correct reference counting
>   hw/arm/fsl-imx: Add the cpu as child of the SoC object
>   hw/dma/xilinx_axi: Use object_initialize_child for correct ref.
>     counting
>   hw/net/xilinx_axi: Use object_initialize_child for correct ref.
>     counting

