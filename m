Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBB520722
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4EQKpNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBB520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiiu-0004zD-7S
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iWihj-00040s-0u
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iWihf-0005Yg-5D
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iWihe-0005Xx-IE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574089953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0vRHQmZ4ipoJAsPrfy1abcxKaMEpIXgO6Qm/VpP6LA=;
 b=S4EQKpNiB8wvRp7Ou48WdWiGkmqksZmlwUAvAYk8RHKmqKEYyiaymV4Aig7mfEvRk/ocOD
 SIfVGgX+nojHV5/f+y0douoXBZY5DOUukwXnDLHC0Gbon74PYqwYdLNNxubN3yAROEOscX
 DSdXkL0/Elt4z4gP/pLdzaSQB+0C6j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Hfc8OaOsPlKgOO5D7xJhrg-1; Mon, 18 Nov 2019 10:12:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAA6A1133563
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-76.gru2.redhat.com
 [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81F106055E;
 Mon, 18 Nov 2019 15:12:29 +0000 (UTC)
Subject: Re: [PATCH 03/16] vl: merge -accel processing into
 configure_accelerators
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cbf027cf-26b6-5508-98c8-ace9545f8b04@redhat.com>
Date: Mon, 18 Nov 2019 13:12:28 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Hfc8OaOsPlKgOO5D7xJhrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/13/19 12:38 PM, Paolo Bonzini wrote:
> The next step is to move the parsing of "-machine accel=3D..." into vl.c,
> unifying it with the configure_accelerators() function that has just
> been introduced.  This way, we will be able to desugar it into multiple
> "-accel" options, without polluting accel/accel.c.
>
> The CONFIG_TCG and CONFIG_KVM symbols are not available in vl.c, but
> we can use accel_find instead to find their value at runtime.  Once we
> know that the binary has one of TCG or KVM, the default accelerator
> can be expressed simply as "tcg:kvm", because TCG never fails to initiali=
ze.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/accel.c          | 63 ++-----------------------------------------=
-------
>   include/sysemu/accel.h |  4 +++-
>   vl.c                   | 62 +++++++++++++++++++++++++++++++++++++++++++=
++----
>   3 files changed, 62 insertions(+), 67 deletions(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/accel/accel.c b/accel/accel.c
> index 5fa3171..74eda68 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -44,7 +44,7 @@ static const TypeInfo accel_type =3D {
>   };
>  =20
>   /* Lookup AccelClass from opt_name. Returns NULL if not found */
> -static AccelClass *accel_find(const char *opt_name)
> +AccelClass *accel_find(const char *opt_name)
>   {
>       char *class_name =3D g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_na=
me);
>       AccelClass *ac =3D ACCEL_CLASS(object_class_by_name(class_name));
> @@ -52,7 +52,7 @@ static AccelClass *accel_find(const char *opt_name)
>       return ac;
>   }
>  =20
> -static int accel_init_machine(AccelClass *acc, MachineState *ms)
> +int accel_init_machine(AccelClass *acc, MachineState *ms)
>   {
>       ObjectClass *oc =3D OBJECT_CLASS(acc);
>       const char *cname =3D object_class_get_name(oc);
> @@ -71,65 +71,6 @@ static int accel_init_machine(AccelClass *acc, Machine=
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
> index 5367f23..fc9e70f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2845,8 +2845,62 @@ static int do_configure_accelerator(void *opaque, =
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
>       qemu_opts_foreach(qemu_find_opts("icount"),
>                         do_configure_icount, NULL, &error_fatal);
>  =20
> @@ -4183,7 +4237,8 @@ int main(int argc, char **argv, char **envp)
>        * Note: uses machine properties such as kernel-irqchip, must run
>        * after machine_set_property().
>        */
> -    configure_accelerator(current_machine, argv[0]);
> +    cpu_ticks_init();
> +    configure_accelerators(argv[0]);
>  =20
>       /*
>        * Beware, QOM objects created before this point miss global and
> @@ -4267,9 +4322,6 @@ int main(int argc, char **argv, char **envp)
>       /* spice needs the timers to be initialized by this point */
>       qemu_spice_init();
>  =20
> -    cpu_ticks_init();
> -    configure_accelerators();
> -
>       if (default_net) {
>           QemuOptsList *net =3D qemu_find_opts("net");
>           qemu_opts_set(net, NULL, "type", "nic", &error_abort);


