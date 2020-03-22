Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064DC54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05B20722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6wauYrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A05B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFy4F-0007nm-Cy
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFy3B-0006y4-Km
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFy3A-0003Ox-Mf
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFy3A-0003Ol-HJ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584873708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGzYncWghs0d56GocY3DwnH/xBee7weSzI4cQioN7yY=;
 b=B6wauYrqGj49PtKo2hdKwlhmpXLLMhmGaD5vgcxlgnRjIpa7jtBPSPRfp5Kq3Gwtu2xwN6
 C8YIYZNWcpwISRPZtQHOLub4O5C9J6aZt0hugZ+CwvdzFchqY0y7PjNOIu7ImoFelu/P00
 zE6AwTvG3c2Hhnonz0qYnilFUDRtFOY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-hQaqG0lLN6G-lDuvoSD0Hg-1; Sun, 22 Mar 2020 06:41:46 -0400
X-MC-Unique: hQaqG0lLN6G-lDuvoSD0Hg-1
Received: by mail-ed1-f71.google.com with SMTP id dn10so9007109edb.6
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ywl8jtrLVhcEnkAvPkhDLf44lNukmYeqGoLg+yXiaM0=;
 b=sOybWJosGll8a3Qpw+AQ0XF/cGeW/d2xsUHjyuVmhiCP1jXnOY7xwNsQvQJVc4hqAp
 BntHS293XiUJLM5OjOPRxNpczjz4fLZ5Qy6DE2+RBGQrxIBgt+83WTkkvlaP+ZWU1oFA
 DpHrXOCWCDBGFEoub62D4bR2TwRDca5UWaZilEP7Kj9cTLlw5wMsgkiBSSEppaSVAhp3
 eUS80JM7HpZnbFBxEmlmHgU8EIVUcPrAG+YlUNMABqAAIx096c4DOcpDNB53eu3aKYCn
 HJpwOT9QoLUGDKNobru1S48tNR/uZfrdbPnItzZdqKa/KowRSbTMxcy+TVucTi5PlDJt
 ZG6A==
X-Gm-Message-State: ANhLgQ01Z76dSv0zd8Hz8FxfOzJcGKkHV25QA9LCyjRrOwAFGjiLqrjw
 PRvSB7YmKoj/PgdRMlGQ7pET33bOA4MGezzmHZ3/UObHH8iYE4Fh2/MHeXtKDP2YVbeZ+oDihKo
 hLNOWIxlsgYt5lRY=
X-Received: by 2002:a17:906:951:: with SMTP id
 j17mr5761722ejd.33.1584873705182; 
 Sun, 22 Mar 2020 03:41:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUxrgrEjRDuC1C7o9pqe5vVhVcG16meMcfODbrJqHyoKsIuugCecLdaH97GDsiWLQ2Vp93Eg==
X-Received: by 2002:a17:906:951:: with SMTP id
 j17mr5761711ejd.33.1584873704929; 
 Sun, 22 Mar 2020 03:41:44 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m18sm254493eda.14.2020.03.22.03.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2020 03:41:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] linux-user/flatload.c: Use "" for include of QEMU
 header target_flat.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <14469280-0c3a-ab6f-b5a4-5e707c0da22f@redhat.com>
Date: Sun, 22 Mar 2020 11:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-5-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 8:33 PM, Peter Maydell wrote:
> The target_flat.h file is a QEMU header, so we should include it using
> quotes, not angle brackets.
>=20
> Coverity otherwise is unable to find the header:
>=20
> "../linux-user/flatload.c", line 40: error #1712: cannot open source file
>            "target_flat.h"
>    #include <target_flat.h>
>                            ^
>=20
> because the relevant directory is only on the -iquote path, not the -I pa=
th.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know why Coverity in particular has trouble here but
> real compilers don't. Still, the "" is the right thing.
> ---
>   linux-user/flatload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 0122ab3afe6..66901f39cc5 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -37,7 +37,7 @@
>  =20
>   #include "qemu.h"
>   #include "flat.h"
> -#include <target_flat.h>
> +#include "target_flat.h"
>  =20
>   //#define DEBUG
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


