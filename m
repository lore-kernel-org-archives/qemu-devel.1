Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E74C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B0A206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiLolQWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B0A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPZr-00031G-RY
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKPZ1-0002DX-Lh
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKPYz-0004OV-MP
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:53:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKPYz-0004Nu-Fj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585932780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3NugmdaZPLvfahTX1fNLae6Me4NOTXg6W2A5gp3jnk=;
 b=UiLolQWk9eye41FZtqLaj9XGixPaS4lOc+S51wotUnzafl7viWHNuqWbRae9go9Dxh97Lt
 VOXxc409t6aFp+mePJBwzZiJXhqOieRaIo5scwIjns1jfM47XKNQoj3nJLbBZ+w9SGX1Gt
 BNfuI+w1fbAhrjin5NgHcc1+Qg3kyUY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-QXQKAnTGNIey6169tE7ztg-1; Fri, 03 Apr 2020 12:52:57 -0400
X-MC-Unique: QXQKAnTGNIey6169tE7ztg-1
Received: by mail-ed1-f71.google.com with SMTP id q29so6002374edc.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W3NugmdaZPLvfahTX1fNLae6Me4NOTXg6W2A5gp3jnk=;
 b=Un45oVxdAkWhsdnC65RvGFvbtrGL7fHh8Y9/cWsxi96sP9V1CRrX1UzWGPWAycn2EO
 AxIEgIiOY8H+v0ko5eXAxFyOopkVnH8EukGs5udk3XdqSu+Z08nshUCe9JDirs0RymuI
 cQESA1RCl/+h3oYkSNVcF4NW4Q2Q+uw8JhN89z2fOg/y/yV6gyKy2y8DayabqIpTiWzU
 ajULfK4GcHSUeby/MO2/I+/NwJuKcXVgSXO7QrsdS+9wXRm+mYq4tFMR+kUW5vLxwtgD
 TUE7EG8OCnKV+QUpeM+IPo2qLXKJ4wesm7tNq2WlNgFzvyLFXvSjWyRkZLqVuMlU9rV9
 jBFw==
X-Gm-Message-State: AGi0PuYlBhdjFXdQUhziYUCDAmOG/eg4oHLipQQY9kAvaqZJZORVtxtT
 IAL8zmwY9DvBi4RI+a/mCVnM0Jl6Od3tKqFdzC65HTKjwmtI77l9pGYhaB+pVFh9lX/YZQrwQC1
 34J9b9RMoexWFU6c=
X-Received: by 2002:a17:906:3788:: with SMTP id
 n8mr9544632ejc.306.1585932775975; 
 Fri, 03 Apr 2020 09:52:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlRU81FdHUuxf2b58UzIkqkC8Y6IhBfwqBYlp9dk33UZ5sqCiLvfCH/TNzujOImi7x5Iauuw==
X-Received: by 2002:a17:906:3788:: with SMTP id
 n8mr9544592ejc.306.1585932775552; 
 Fri, 03 Apr 2020 09:52:55 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s29sm1494932edc.25.2020.04.03.09.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 09:52:54 -0700 (PDT)
Subject: Re: [PATCH v2] nvdimm-utils: clean up headers and add license comment
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200403144149.14068-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8145b0f-4a06-2997-8516-0f06ece28379@redhat.com>
Date: Fri, 3 Apr 2020 18:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403144149.14068-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, sbhat@linux.ibm.com,
 aik@ozlabs.ru, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 4/3/20 4:41 PM, Igor Mammedov wrote:
> Fixes: 3f350f6bb36233be50fc2bc18dc78b6a948a5dbe
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>    - add license blob to header as well
>    - trim comment a litle bit to remove unrelated NFIT/PMEM sentences
> ---
>   include/qemu/nvdimm-utils.h | 23 +++++++++++++++++++++--
>   util/nvdimm-utils.c         | 23 +++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> index 4b8b198ba7..2d8cde085c 100644
> --- a/include/qemu/nvdimm-utils.h
> +++ b/include/qemu/nvdimm-utils.h
> @@ -1,7 +1,26 @@
>   #ifndef NVDIMM_UTILS_H
>   #define NVDIMM_UTILS_H

I think most of the files in the tree use the pattern "license comment 
before the ifdef guard", but I won't write a script to prove me 
right/wrong :)

> -
> -#include "qemu/osdep.h"
> +/*
> + * NVDIMM utilities
> + *
> + * Copyright(C) 2015 Intel Corporation.
> + *
> + * Author:
> + *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */

So here goes the ifdef:

     #ifndef NVDIMM_UTILS_H
     #define NVDIMM_UTILS_H

>   
>   GSList *nvdimm_get_device_list(void);
>   #endif
> diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> index 5cc768ca47..3d570c3c3e 100644
> --- a/util/nvdimm-utils.c
> +++ b/util/nvdimm-utils.c
> @@ -1,3 +1,26 @@
> +/*
> + * NVDIMM utilities
> + *
> + * Copyright(C) 2015 Intel Corporation.
> + *
> + * Author:
> + *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
>   #include "qemu/nvdimm-utils.h"
>   #include "hw/mem/nvdimm.h"
>   
> 


