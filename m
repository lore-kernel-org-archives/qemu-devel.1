Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA12C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800A1207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800A1207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHG5-0002vo-LD
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBHEi-0001KB-Sq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBHEh-0003me-S4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBHEh-0003kN-J6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:38:03 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C31F28763B
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 11:38:02 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 190so1086508wme.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 04:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HClEQQM/+wu3VYxV8XNM6ajBeIilWBufjjePZzj0s6M=;
 b=iwP/jlpcHJYCnUAr58OBafst9gNGDFCeQZkN76uT2bvaGg2LT8eYtZyqS7bX7J3dSb
 9tFIfUABH5eQg0NtDFOF0tiWLRszENsJR6llO1yZBNgC75I+Gu22dx4ilRjJT4iZRt0F
 GZc5UR+Vr+hzC32z91YLugQIYQjE69otX8dFTf4+pj3TiXIjbT+5n+xSnCz4hzIEnh2c
 yTbGHBBxrX0p/VtfocEub763G7sqe5HTNeDWJYyUFB8nKjtpS0q1xywhcz8rKtnJgENO
 P1GeRBOJaofd/RtCGYUIlBI3z70IPtj1e+9SZmwH+DwfUTA1+xpvgbPC3g8mDCI9Wiby
 eTsw==
X-Gm-Message-State: APjAAAUOVu1jvXoxxnY4I8pDHCd0n3E6ij5VLFfk0BXEclP8RYjP75vE
 sEaXPOYwnG4l4AyCcWhlMYCiA92D/7WBuri14ulIvjaFyK2CuYo6rWIpWwlqutTqKQPuQK45pJi
 ku3RMgCfx+I5iqvA=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr11084605wrv.10.1568979481480; 
 Fri, 20 Sep 2019 04:38:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSDoMdMUfo56nH1hAN9PUpb7TKYP1KKTdnvhg942zpoWYaCDqQf1h4HRxtUn1Vxk2dQDzqoA==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr11084593wrv.10.1568979481220; 
 Fri, 20 Sep 2019 04:38:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id x5sm2132209wrt.75.2019.09.20.04.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 04:38:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] target/i386: Fix broken build with WHPX enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Justin Terry <juterry@microsoft.com>
References: <20190920113329.16787-1-philmd@redhat.com>
 <20190920113329.16787-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7fef04aa-668c-64d1-2855-7b936f8600ee@redhat.com>
Date: Fri, 20 Sep 2019 13:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920113329.16787-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/19 13:33, Philippe Mathieu-Daud=C3=A9 wrote:
> The WHPX build is broken since commit 12e9493df92 which removed the
> "hw/boards.h" where MachineState is declared:
>=20
>   $ ./configure \
>      --enable-hax --enable-whpx
>=20
>   $ make x86_64-softmmu/all
>   [...]
>     CC      x86_64-softmmu/target/i386/whpx-all.o
>   target/i386/whpx-all.c: In function 'whpx_accel_init':
>   target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
>   incomplete type 'MachineState' {aka 'struct MachineState'}
>        whpx->mem_quota =3D ms->ram_size;
>                            ^~
>   make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
>     CC      x86_64-softmmu/trace/generated-helpers.o
>   make[1]: Target 'all' not remade because of errors.
>   make: *** [Makefile:471: x86_64-softmmu/all] Error 2
>=20
> Restore this header, partially reverting commit 12e9493df92.
>=20
> Fixes: 12e9493df92
> Reported-by: Ilias Maratos <i.maratos@gmail.com>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/i386/whpx-all.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 0c15241ae4..def0c28480 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/runstate.h"
>  #include "qemu/main-loop.h"
> +#include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
>=20

Queued, thanks.

Paolo

