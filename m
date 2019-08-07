Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775ECC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C77321EF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C77321EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPTJ-00010s-KX
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPSr-0000bw-0I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPSp-0000Xk-Tl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:11:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPSp-0000W9-OO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:11:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so92110969wrf.11
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+jPV2sCSK9wrFFo/ulYP7qlKRrk9o6gS3KKV+Oo6niI=;
 b=ulWOG+qcuv2b+SjpcVUw6V8UzGrW0UiLrTIG2GGCh8xS9rjFCwNxvbjmhpStEBiVxi
 +jmcO7qboLlAKXzJvp8T5+kXulq6AWvRl1517HxtUddzhuscpFc0GsqEtzZRElOhjE63
 yMOVfiGSfpu/nRtuAv2NyxIBaMES5+m/piabvDn6VChA4XlsFxf/8ExIpgv4ZjCaDbxn
 b/20Kkgs9m0UcJoo148PB9oXLKPweKuCWgvEZkJGZDuhemniJCTlK62yDjOe2pHZDGkB
 nvvNhU2/QxHvmW+NvqMvJGWF5K2SOTMzG0VpE94uuegOpOKlPXESEoBrHkwY3qtCq7Vh
 RmvA==
X-Gm-Message-State: APjAAAVI1AXCsS4eL7G6zPz0AKIZVF+itK17QpJ3qEFnbvOd+FLhouNQ
 ai1fYaaPgjyykTgwKhkk6Mt2YNfzQs0=
X-Google-Smtp-Source: APXvYqyzjYfI1mxTbqa2sBA8l0cNplNvUsOXDWwCvToz917mRaSgKC7xGiQ783QMjrRSqOctK+uDDA==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr11810992wrm.91.1565197862464; 
 Wed, 07 Aug 2019 10:11:02 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id g19sm884377wmg.10.2019.08.07.10.11.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:11:01 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-18-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <53292d1d-34b8-e541-5a5b-ec19f3bf24f3@redhat.com>
Date: Wed, 7 Aug 2019 19:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 17/29] Include qom/object.h slightly less
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

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> hw/hw.h used to include headers hardware emulation "usually" needs.
> The previous commits removed all but one of them, to good effect.
> Only qom/object.h is left.  Remove that one, too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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

2560 objects improved by this tiny patch :)

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

