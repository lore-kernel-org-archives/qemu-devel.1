Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC6720726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7goDa20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC6720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iee81-0006tC-Ch
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iee76-0006C7-J0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iee75-0002Qr-10
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:55:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iee74-0002QZ-S8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575978934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTE7Ge91wexAlsE0aOV3BmzYq/7swYxNPGUvELga+7c=;
 b=B7goDa20RY/XBzIrtktEZHmSB7pseipGKRTjMoRTPB6WNUcb+n+2sSN69rb7gx5JOjFIkv
 ZmJhAAdZAxQUGdA+QldyA5xe7cLh8Ov1vKVLZwVrYAHr0ILQtp2EgxZgRogzhMgyEXXgyq
 dyAqZ1Krz7KdTJ62wjYgFaha0jaD7RY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-dYZeylQCOvCpcZVzqnWjuA-1; Tue, 10 Dec 2019 06:55:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id l13so905926wmj.8
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7v1kNyNajKlb3HPK4UYuSbeykDp9MQik8U5jAIeAMMQ=;
 b=GqzrUTJrwb/ysEnYWLqjSxMjfvUr96Gpi2dDao4/CVdS5CZBYEuvPhphIbKcAlfz9a
 19HvxzPl6mw05xr0eeirzSVrREUAFRDe99ew923M84d4WGvCcRmVNAZb0PNFgWT/dGfS
 SWzsb8E+fmFHgsyRZFc2e2WQrTVOvWueAIEM1LpsnmA1PuQtwla7Pk+dZzcvm3UDAuXH
 up0OxNcs6Xm1HU61i1P6WcVMsF/kQ0iSoBXBV5RmIYPp8gzD7X36lZc0YFr7DXMPf4RZ
 yntgV/FjZBQtgbecNnEZX4ON1hTKBaEu3/XGfnxOd+hwFv/r2vOKQP/OZHila1HLNg1f
 MeBw==
X-Gm-Message-State: APjAAAWIHx8z/fIaUz7mkP4BvAMEtIUlWUH7oCmnnATWMIpDOflsuZrN
 /FIBY/9c+h7nxuZd0lSgZk1mgB/+aWgzzEMuDLjLrjnfVYaIlyxwnbyRsdf0hqrhF38lVWAscsC
 4irJLfThp6stoJcs=
X-Received: by 2002:a7b:c936:: with SMTP id h22mr4531003wml.115.1575978931505; 
 Tue, 10 Dec 2019 03:55:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwephIBrBd3WaziH3sqsw9J3aeJry31p5NEfmMaoQIOLNEN+TNjXb5fr+jgPkJASlxD9dDNOg==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr4530977wml.115.1575978931230; 
 Tue, 10 Dec 2019 03:55:31 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c2sm2968501wrp.46.2019.12.10.03.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:55:30 -0800 (PST)
Subject: Re: [PATCH v2 03/18] tcg: move qemu_tcg_configure to
 accel/tcg/tcg-all.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2d68a59-acce-afb2-9d80-eb500163aabe@redhat.com>
Date: Tue, 10 Dec 2019 12:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: dYZeylQCOvCpcZVzqnWjuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> Move everything related to mttcg_enabled in accel/tcg/tcg-all.c,
> which will make even more sense when "thread" becomes a QOM property.
>=20
> For now, initializing mttcg_enabled in the instance_init function
> prepares for the next patch, which will only invoke qemu_tcg_configure
> when the command line includes a -accel option.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   accel/tcg/tcg-all.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   cpus.c              | 72 ---------------------------------------------
>   2 files changed, 85 insertions(+), 72 deletions(-)
>=20
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c59d5b0..78a0ab5 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -30,6 +30,11 @@
>   #include "cpu.h"
>   #include "sysemu/cpus.h"
>   #include "qemu/main-loop.h"
> +#include "tcg/tcg.h"
> +#include "include/qapi/error.h"
> +#include "include/qemu/error-report.h"
> +#include "include/hw/boards.h"
> +#include "qemu/option.h"
>  =20
>   unsigned long tcg_tb_size;
>  =20
> @@ -58,6 +63,55 @@ static void tcg_handle_interrupt(CPUState *cpu, int ma=
sk)
>       }
>   }
>  =20
> +/*
> + * We default to false if we know other options have been enabled
> + * which are currently incompatible with MTTCG. Otherwise when each
> + * guest (target) has been updated to support:
> + *   - atomic instructions
> + *   - memory ordering primitives (barriers)
> + * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> + *
> + * Once a guest architecture has been converted to the new primitives
> + * there are two remaining limitations to check.
> + *
> + * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> + * - The host must have a stronger memory order than the guest
> + *
> + * It may be possible in future to support strong guests on weak hosts
> + * but that will require tagging all load/stores in a guest with their
> + * implicit memory order requirements which would likely slow things
> + * down a lot.
> + */
> +
> +static bool check_tcg_memory_orders_compatible(void)
> +{
> +#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> +    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool default_mttcg_enabled(void)
> +{
> +    if (use_icount || TCG_OVERSIZED_GUEST) {
> +        return false;
> +    } else {
> +#ifdef TARGET_SUPPORTS_MTTCG
> +        return check_tcg_memory_orders_compatible();
> +#else
> +        return false;
> +#endif
> +    }
> +}
> +
> +static void tcg_accel_instance_init(Object *obj)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +
> +    mttcg_enabled =3D default_mttcg_enabled();
> +}
> +
>   static int tcg_init(MachineState *ms)
>   {
>       tcg_exec_init(tcg_tb_size * 1024 * 1024);
> @@ -65,6 +119,36 @@ static int tcg_init(MachineState *ms)
>       return 0;
>   }
>  =20
> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> +{
> +    const char *t =3D qemu_opt_get(opts, "thread");
> +    if (!t) {
> +        return;
> +    }
> +    if (strcmp(t, "multi") =3D=3D 0) {
> +        if (TCG_OVERSIZED_GUEST) {
> +            error_setg(errp, "No MTTCG when guest word size > hosts");
> +        } else if (use_icount) {
> +            error_setg(errp, "No MTTCG when icount is enabled");
> +        } else {
> +#ifndef TARGET_SUPPORTS_MTTCG
> +            warn_report("Guest not yet converted to MTTCG - "
> +                        "you may get unexpected results");
> +#endif
> +            if (!check_tcg_memory_orders_compatible()) {
> +                warn_report("Guest expects a stronger memory ordering "
> +                            "than the host provides");
> +                error_printf("This may cause strange/hard to debug error=
s\n");
> +            }
> +            mttcg_enabled =3D true;
> +        }
> +    } else if (strcmp(t, "single") =3D=3D 0) {
> +        mttcg_enabled =3D false;
> +    } else {
> +        error_setg(errp, "Invalid 'thread' setting %s", t);
> +    }
> +}
> +
>   static void tcg_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -78,6 +162,7 @@ static void tcg_accel_class_init(ObjectClass *oc, void=
 *data)
>   static const TypeInfo tcg_accel_type =3D {
>       .name =3D TYPE_TCG_ACCEL,
>       .parent =3D TYPE_ACCEL,
> +    .instance_init =3D tcg_accel_instance_init,
>       .class_init =3D tcg_accel_class_init,
>   };
>  =20
> diff --git a/cpus.c b/cpus.c
> index 63bda15..b472378 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -166,78 +166,6 @@ typedef struct TimersState {
>   static TimersState timers_state;
>   bool mttcg_enabled;
>  =20
> -/*
> - * We default to false if we know other options have been enabled
> - * which are currently incompatible with MTTCG. Otherwise when each
> - * guest (target) has been updated to support:
> - *   - atomic instructions
> - *   - memory ordering primitives (barriers)
> - * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> - *
> - * Once a guest architecture has been converted to the new primitives
> - * there are two remaining limitations to check.
> - *
> - * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> - * - The host must have a stronger memory order than the guest
> - *
> - * It may be possible in future to support strong guests on weak hosts
> - * but that will require tagging all load/stores in a guest with their
> - * implicit memory order requirements which would likely slow things
> - * down a lot.
> - */
> -
> -static bool check_tcg_memory_orders_compatible(void)
> -{
> -#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> -    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> -#else
> -    return false;
> -#endif
> -}
> -
> -static bool default_mttcg_enabled(void)
> -{
> -    if (use_icount || TCG_OVERSIZED_GUEST) {
> -        return false;
> -    } else {
> -#ifdef TARGET_SUPPORTS_MTTCG
> -        return check_tcg_memory_orders_compatible();
> -#else
> -        return false;
> -#endif
> -    }
> -}
> -
> -void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> -{
> -    const char *t =3D qemu_opt_get(opts, "thread");
> -    if (t) {
> -        if (strcmp(t, "multi") =3D=3D 0) {
> -            if (TCG_OVERSIZED_GUEST) {
> -                error_setg(errp, "No MTTCG when guest word size > hosts"=
);
> -            } else if (use_icount) {
> -                error_setg(errp, "No MTTCG when icount is enabled");
> -            } else {
> -#ifndef TARGET_SUPPORTS_MTTCG
> -                warn_report("Guest not yet converted to MTTCG - "
> -                            "you may get unexpected results");
> -#endif
> -                if (!check_tcg_memory_orders_compatible()) {
> -                    warn_report("Guest expects a stronger memory orderin=
g "
> -                                "than the host provides");
> -                    error_printf("This may cause strange/hard to debug e=
rrors\n");
> -                }
> -                mttcg_enabled =3D true;
> -            }
> -        } else if (strcmp(t, "single") =3D=3D 0) {
> -            mttcg_enabled =3D false;
> -        } else {
> -            error_setg(errp, "Invalid 'thread' setting %s", t);
> -        }
> -    } else {
> -        mttcg_enabled =3D default_mttcg_enabled();
> -    }
> -}
>  =20
>   /* The current number of executed instructions is based on what we
>    * originally budgeted minus the current state of the decrementing
>=20


