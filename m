Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF3CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9052084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9052084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxYo-0003fz-4p
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMxKv-0003iG-Qp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMxKu-0001jj-0g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMxKt-0001j7-QN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:48:43 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB1B4C057EC6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 16:48:42 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s19so6163455wmj.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8XdubcR4QC1xaNPRCKO6AEMrLBJsl5gYaPZXzSLnoJg=;
 b=RPEuXmGxVGZeVtZ9ODelcsArpXmhy12lwf28YOPruDqmoALgnJBMOcwYweCbIEz7nE
 PrkdXJ6duhLTKjZhTKbtnauHteE123pJpsUMNh0pkuyKsaM4SSVkcpX6DZT6FGjtSvkR
 4HWGmbaVXu6z0uAeglRPPTYBtWmATWG9OnRV6Q4vCpvocWv/lAYM70gdwwccpbx3+ker
 8P+S1hMMA1yk35unHDpQi2ft8XJHshfXh1W+q/MrtVnrgOPhsrOmfqqKKwK1f5Jcw4kP
 QKbnedZGO70AUkTu5PWisvnJP9ejJHP+YBhRqlHhU8ZctjI6PadJApVh5jyzKjv6mavL
 qd2A==
X-Gm-Message-State: APjAAAXtO0PRvO7fKGbcGVb1nA0mhxIwtCItgz+S4TYs24x3PqI1ZjkB
 umWawZy7p314qrf1JuoMkXbVzUr1mVImWNHUp9nmNBwI2c871VmePjOaVKv6naZB7X98AJM97bh
 +RVEtuljWHi5k2qU=
X-Received: by 2002:a5d:4705:: with SMTP id y5mr4336159wrq.364.1571762921082; 
 Tue, 22 Oct 2019 09:48:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJZ7+DrPOejRZ6d7/5QHnBaQEvdO9rYkFjrrlAbxoEa7uiCaLWAnaOrAyiePfyedD3hLqt+g==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr4336134wrq.364.1571762920758; 
 Tue, 22 Oct 2019 09:48:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id v16sm18290823wrt.12.2019.10.22.09.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 09:48:39 -0700 (PDT)
Subject: Re: [PATCH] hw/timer/mc146818rtc: Only include qapi-commands-misc on
 I386
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20191017162614.21327-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <20ba703a-b25f-078b-69fa-dcc5a7072ccf@redhat.com>
Date: Tue, 22 Oct 2019 18:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017162614.21327-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/19 18:26, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit a6c7040fb09 restricted the rtc-reset-reinjection command
> to the I386 target.
> Restrict the "qapi/qapi-commands-misc-target.h" header to it too.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/timer/mc146818rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..c1eb0a7376 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -37,12 +37,12 @@
>  #include "hw/timer/mc146818rtc.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc-target.h"
>  #include "qapi/qapi-events-misc-target.h"
>  #include "qapi/visitor.h"
>  #include "exec/address-spaces.h"
> =20
>  #ifdef TARGET_I386
> +#include "qapi/qapi-commands-misc-target.h"
>  #include "hw/i386/apic.h"
>  #endif
> =20
>=20

Queued, thanks.

Paolo

