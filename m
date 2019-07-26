Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD608C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DB321873
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DB321873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2XL-00089e-UP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2XB-0007lw-Gn
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2X9-0008IV-Eb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:53:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2X9-0008Dz-6V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:53:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so54906146wre.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=470qnsLlieAsrVJjpU7EjOKQeIUhicZWySgaCQxid4I=;
 b=PTKQM6Kia2SUIO+gq8AposZsetWd3F6RiGBY2K+5oCu8arWBQKr6RFhTdAxonLLSTE
 sBa7rDp3g+Dra0oaC6vFVY+hc2u6XqJoVvdI108OBMjoEgtAGixfv1NWigmPU5wgwxUH
 Ykk8VqHdTg/x33JRz4mFYttcqOyDruciJIYrcVQ6CfuBsxm/z8cmD7n7o4wqy6FDwHyO
 0eSUONHQaKmWM1ihnR3/Wfq+MAfl9WTKav69ey3yNEFHCdeGrw7lwPCWXplVwvWRv9ry
 XbOKqqHBrAiXBcADAJVnDHI1YLSXrTSMzop7kEbqq3hTRpcFC77avLiAt5hAJ+RQYHkG
 qAOw==
X-Gm-Message-State: APjAAAU44C/tBZwOAdHcL3M9IhinHqnaQkqwCeyGeTSnzh+9M2OWB2Mi
 IxCb2qJkiW1xMZcKDLHpZAeZcWqy+Yk=
X-Google-Smtp-Source: APXvYqyjc3N9APtS+7e3cRzbJWkWh5GfNwBrQ1q5BZH8Dc7RzIsU4oOOTD/Dv17rCdVvmr9P86HE+A==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr97437989wrt.227.1564156404861; 
 Fri, 26 Jul 2019 08:53:24 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id o7sm25301739wru.58.2019.07.26.08.53.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 08:53:24 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-18-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e1463779-60f9-b613-666e-37198eb60823@redhat.com>
Date: Fri, 26 Jul 2019 17:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 17/28] Include qom/object.h slightly less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> hw/hw.h used to include headers hardware emulation "usually" needs.
> The previous commits removed all but one of them, to good effect.
> Only qom/object.h is left.  Remove that one, too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/display/edid.h | 2 +-
>  include/hw/hw.h           | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
> index 7948bd2c40..ff99dc0a05 100644
> --- a/include/hw/display/edid.h
> +++ b/include/hw/display/edid.h
> @@ -1,7 +1,7 @@
>  #ifndef EDID_H
>  #define EDID_H
>  
> -#include "hw/hw.h"
> +#include "qom/object.h"
>  
>  typedef struct qemu_edid_info {
>      const char *vendor; /* http://www.uefi.org/pnp_id_list */
> diff --git a/include/hw/hw.h b/include/hw/hw.h
> index 8e18358e6a..8079b911fa 100644
> --- a/include/hw/hw.h
> +++ b/include/hw/hw.h
> @@ -6,8 +6,6 @@
>  #error Cannot include hw/hw.h from user emulation
>  #endif
>  
> -#include "qom/object.h"
> -
>  void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
>  #endif
> 

