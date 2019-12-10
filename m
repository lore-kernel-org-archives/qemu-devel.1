Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D31320726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA0iVpCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D31320726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeAh-0000cp-I4
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iee9W-0008FS-4l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iee9U-0003JY-Fx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iee9U-0003Ir-BJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575979084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRdqkqxR9N3zi7OpmubjLSAxZqgiCCmYcpqDSuCy9pc=;
 b=QA0iVpCWKJsnMex2qL9v6z01SfjjYlMt3LkWDtLWwuirgUa0i58R28l0AbRsiAG8MrOZ/m
 jUiM9Vcna+VpdbZBtJYJj9AbNLPgBXwsTM300yoqQdGCof7Th2uoEsLeE16TvNQjx6hP8F
 HtTl1uKOMkZ2VYAx+syq/Lqurv3YI9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-MABDlUAYMpG6XAP49h-LkQ-1; Tue, 10 Dec 2019 06:58:00 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so526585wmk.6
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZWIEnchhpicxEbBUuDnAKg/VnJKbje9a3IMZ+juUxkQ=;
 b=Kx3doKluoeHIfF0DFz9LHuZDWbad2KxgD2P3x4XRwqXibPa0EenGWOY7l6yzevdQKk
 KCiT4zEk0fXJTL4B6HVm15BSLK2oh+3flKa2Qmask4pE1d98RcDvq+x4tQbinUe0/lEc
 Lpi6m1iDd0E3GdaMotmMbEDdJKQwvZLw910Gg+afbQ0NJ+eUHHYrlmEbmxuaY67JSKuC
 HwdmOKS5hJtw0x3IzEHtiP3R/dOtUaMTy+9ES9gSipoCN0S9a75/jofGYkTU+vGhmPQV
 NmyigH4eKl+VnnRHEgk915+vV523mrDRSaLyOxiJdXxFApJxfxexjeiK57HncHQLunRc
 L+6A==
X-Gm-Message-State: APjAAAWPV2y0sk2CTQo7fO0nxpYQK8S21ZNb6optBwzQ7PFKOzMUb+Ji
 LKT/6cQ2WcdDE8eM3P/WGFvoEf7f+vdVJJ/c6Fc1IMbEoa6Ye6WJg6dfUPP+/GwZiYUMXZuAH1Q
 8uFxUmlFnBPBpMqM=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr2871775wrc.69.1575979079526; 
 Tue, 10 Dec 2019 03:57:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTChExOc8ZHr1iAzqHAPWLCZGcsAbwPcaApkTCt6c/QOQYYgRr+e9L1Pgi3VS5Shcy5M6V2A==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr2871751wrc.69.1575979079257; 
 Tue, 10 Dec 2019 03:57:59 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id b63sm2782213wmb.40.2019.12.10.03.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:57:58 -0800 (PST)
Subject: Re: [PATCH v2 05/18] vl: merge -accel processing into
 configure_accelerators
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-6-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a8adff9-7346-df04-f753-38cf333812cb@redhat.com>
Date: Tue, 10 Dec 2019 12:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-6-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: MABDlUAYMpG6XAP49h-LkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> The next step is to move the parsing of "-machine accel=3D..." into vl.c,
> unifying it with the configure_accelerators() function that has just
> been introduced.  This way, we will be able to desugar it into multiple
> "-accel" options, without polluting accel/accel.c.
>=20
> The CONFIG_TCG and CONFIG_KVM symbols are not available in vl.c, but
> we can use accel_find instead to find their value at runtime.  Once we
> know that the binary has one of TCG or KVM, the default accelerator
> can be expressed simply as "tcg:kvm", because TCG never fails to initiali=
ze.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/accel.c          | 69 ++-----------------------------------------=
-------
>   include/sysemu/accel.h |  4 ++-
>   vl.c                   | 64 ++++++++++++++++++++++++++++++++++++++++++-=
---
>   3 files changed, 64 insertions(+), 73 deletions(-)
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index 5fa3171..60c3827 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -28,13 +28,7 @@
>   #include "hw/boards.h"
>   #include "sysemu/arch_init.h"
>   #include "sysemu/sysemu.h"
> -#include "sysemu/kvm.h"
> -#include "sysemu/qtest.h"
> -#include "hw/xen/xen.h"
>   #include "qom/object.h"
> -#include "qemu/error-report.h"
> -#include "qemu/option.h"
> -#include "qapi/error.h"
>  =20
>   static const TypeInfo accel_type =3D {
>       .name =3D TYPE_ACCEL,
> @@ -44,7 +38,7 @@ static const TypeInfo accel_type =3D {
>   };
>  =20
>   /* Lookup AccelClass from opt_name. Returns NULL if not found */
> -static AccelClass *accel_find(const char *opt_name)
> +AccelClass *accel_find(const char *opt_name)
>   {
>       char *class_name =3D g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_na=
me);
>       AccelClass *ac =3D ACCEL_CLASS(object_class_by_name(class_name));
> @@ -52,7 +46,7 @@ static AccelClass *accel_find(const char *opt_name)
>       return ac;
>   }
>  =20
> -static int accel_init_machine(AccelClass *acc, MachineState *ms)
> +int accel_init_machine(AccelClass *acc, MachineState *ms)
>   {
>       ObjectClass *oc =3D OBJECT_CLASS(acc);
>       const char *cname =3D object_class_get_name(oc);
> @@ -71,65 +65,6 @@ static int accel_init_machine(AccelClass *acc, Machine=
State *ms)
>       return ret;
>   }
>  =20
> -void configure_accelerator(MachineState *ms, const char *progname)
> -{
> -    const char *accel;
> -    char **accel_list, **tmp;
> -    int ret;
> -    bool accel_initialised =3D false;
> -    bool init_failed =3D false;
> -    AccelClass *acc =3D NULL;
> -
> -    accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> -    if (accel =3D=3D NULL) {
> -        /* Select the default accelerator */
> -        int pnlen =3D strlen(progname);
> -        if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
> -            /* If the program name ends with "kvm", we prefer KVM */
> -            accel =3D "kvm:tcg";
> -        } else {
> -#if defined(CONFIG_TCG)
> -            accel =3D "tcg";
> -#elif defined(CONFIG_KVM)
> -            accel =3D "kvm";
> -#else
> -            error_report("No accelerator selected and"
> -                         " no default accelerator available");
> -            exit(1);
> -#endif
> -        }
> -    }
> -
> -    accel_list =3D g_strsplit(accel, ":", 0);
> -
> -    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> -        acc =3D accel_find(*tmp);
> -        if (!acc) {
> -            continue;
> -        }
> -        ret =3D accel_init_machine(acc, ms);
> -        if (ret < 0) {
> -            init_failed =3D true;
> -            error_report("failed to initialize %s: %s",
> -                         acc->name, strerror(-ret));
> -        } else {
> -            accel_initialised =3D true;
> -        }
> -    }
> -    g_strfreev(accel_list);
> -
> -    if (!accel_initialised) {
> -        if (!init_failed) {
> -            error_report("-machine accel=3D%s: No accelerator found", ac=
cel);
> -        }
> -        exit(1);
> -    }
> -
> -    if (init_failed) {
> -        error_report("Back to %s accelerator", acc->name);
> -    }
> -}
> -
>   void accel_setup_post(MachineState *ms)
>   {
>       AccelState *accel =3D ms->accelerator;
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 8eb60b8..90b6213 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -66,7 +66,9 @@ typedef struct AccelClass {
>  =20
>   extern unsigned long tcg_tb_size;
>  =20
> -void configure_accelerator(MachineState *ms, const char *progname);
> +AccelClass *accel_find(const char *opt_name);
> +int accel_init_machine(AccelClass *acc, MachineState *ms);
> +
>   /* Called just before os_setup_post (ie just before drop OS privs) */
>   void accel_setup_post(MachineState *ms);
>  =20
> diff --git a/vl.c b/vl.c
> index 1ad6dfb..19c77b4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2839,8 +2839,65 @@ static int do_configure_accelerator(void *opaque, =
QemuOpts *opts, Error **errp)
>       return 0;
>   }
>  =20
> -static void configure_accelerators(void)
> +static void configure_accelerators(const char *progname)
>   {
> +    const char *accel;
> +    char **accel_list, **tmp;
> +    int ret;
> +    bool accel_initialised =3D false;
> +    bool init_failed =3D false;
> +    AccelClass *acc =3D NULL;
> +
> +    qemu_opts_foreach(qemu_find_opts("icount"),
> +                      do_configure_icount, NULL, &error_fatal);
> +
> +    accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> +    if (accel =3D=3D NULL) {
> +        /* Select the default accelerator */
> +        if (!accel_find("tcg") && !accel_find("kvm")) {
> +            error_report("No accelerator selected and"
> +                         " no default accelerator available");
> +            exit(1);
> +        } else {
> +            int pnlen =3D strlen(progname);
> +            if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")=
) {
> +                /* If the program name ends with "kvm", we prefer KVM */
> +                accel =3D "kvm:tcg";
> +            } else {
> +                accel =3D "tcg:kvm";
> +            }
> +        }
> +    }
> +
> +    accel_list =3D g_strsplit(accel, ":", 0);
> +
> +    for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> +        acc =3D accel_find(*tmp);
> +        if (!acc) {
> +            continue;
> +        }
> +        ret =3D accel_init_machine(acc, current_machine);
> +        if (ret < 0) {
> +            init_failed =3D true;
> +            error_report("failed to initialize %s: %s",
> +                         acc->name, strerror(-ret));
> +        } else {
> +            accel_initialised =3D true;
> +        }
> +    }
> +    g_strfreev(accel_list);
> +
> +    if (!accel_initialised) {
> +        if (!init_failed) {
> +            error_report("-machine accel=3D%s: No accelerator found", ac=
cel);
> +        }
> +        exit(1);
> +    }
> +
> +    if (init_failed) {
> +        error_report("Back to %s accelerator", acc->name);
> +    }
> +
>       qemu_opts_foreach(qemu_find_opts("accel"),
>                         do_configure_accelerator, NULL, &error_fatal);
>  =20
> @@ -4190,9 +4247,7 @@ int main(int argc, char **argv, char **envp)
>        * Note: uses machine properties such as kernel-irqchip, must run
>        * after machine_set_property().
>        */
> -    qemu_opts_foreach(qemu_find_opts("icount"),
> -                      do_configure_icount, NULL, &error_fatal);
> -    configure_accelerator(current_machine, argv[0]);
> +    configure_accelerators(argv[0]);
>  =20
>       /*
>        * Beware, QOM objects created before this point miss global and
> @@ -4277,7 +4332,6 @@ int main(int argc, char **argv, char **envp)
>       qemu_spice_init();
>  =20
>       cpu_ticks_init();
> -    configure_accelerators();
>  =20
>       if (default_net) {
>           QemuOptsList *net =3D qemu_find_opts("net");
>=20


