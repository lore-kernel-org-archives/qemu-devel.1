Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E0C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE242068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP4utUoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE242068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieL1d-0007Y0-EP
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieL0s-00070V-Sd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieL0r-0001pt-FF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:31:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieL0r-0001pY-Bd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575905512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjVBwqlgyQmAhp1MlgvV9EBxja5r5Pf7PS6Ut0Lahm0=;
 b=eP4utUoiOIFilbPi8DYhFdfoeqqm1+aVJiuVNJFqmviG1yo7myesv+b6NLRmb9TJkJ2Wuo
 S5T9FA2vtCXsUyormgTpa4YbYpyax0sNTlZ1EP5CrtYEp00NDHG7NOO4Q12OfGuJc/F6yM
 dKw6BLvzS14dippcfF9F0cTVK9B3j7Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-wgFPGqqJNQGrTPW-m4M9mg-1; Mon, 09 Dec 2019 10:31:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so7704195wrr.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TYoxhLRZ+uEKsQes71SA0NeEjeQFb4CX90fxoVZqZ/Y=;
 b=YgPUXGnhPLM0i66kIS7Fi5FFmh3vkhdvg8BB8pGJeZqFkKg0HGz9sd7AflD60lfGw6
 /p22Fo1PDelUXY7iTpjimj1KAc5b8dqson01qBzeYRuwvP36WKtZpVcFgxjgAsH3qJGy
 vnjJDnDOvwYX2uHkfOC+KjL1ruFkmJaIKHICYuYx+jIu0NZ1Z7oaemsPQb0KE7z0fuBO
 d+J5ECj2wNd4OQ1Vq9MyExwbzvsNSD7+YEiqFw6c69Gd2zpFiXW1x3CJxm4xP5AQDH6B
 1/EtdVeJnZ49ylXaNtYhyfcgysKZyqG5hFfu5Y/WU4kpTZwETKOMtJLMidbsa8oDjZda
 Exuw==
X-Gm-Message-State: APjAAAWALb2FDPnaleDF5JRIndrrXVoPa5lmqggOlw+CEC/JqdBbbhT5
 5VajDp5FxqSyPUt8zRFj3psqI6IyXLwkws87ZCowUo0BbK7/KsdTRrBUkgMndfcNHTLOnUQWt8o
 w5Pc1HAzJ3Wrv7y8=
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr26854976wml.31.1575905508090; 
 Mon, 09 Dec 2019 07:31:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJP8mvZvoSu3Xoz4d11a5F8BM1Ab8XdSG9AYNTiIWH2hiRwMTaJZ5LIrlUTinF+wqJH9COZw==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr26854954wml.31.1575905507812; 
 Mon, 09 Dec 2019 07:31:47 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id v3sm27222140wru.32.2019.12.09.07.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:31:47 -0800 (PST)
Subject: Re: [PATCH v2 11/18] qom: add object_new_with_class
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-12-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <66eaa7a6-e238-172b-f502-39c90bb166c4@redhat.com>
Date: Mon, 9 Dec 2019 16:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-12-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: wgFPGqqJNQGrTPW-m4M9mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> Similar to CPU and machine classes, "-accel" class names are mangled,
> so we have to first get a class via accel_find and then instantiate it.
> Provide a new function to instantiate a class without going through
> object_class_get_name, and use it for CPUs and machines already.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/accel.c             |  4 +---
>   include/qom/object.h      | 12 ++++++++++++
>   qom/object.c              |  5 +++++
>   target/i386/cpu.c         |  8 ++++----
>   target/s390x/cpu_models.c |  4 ++--
>   vl.c                      |  3 +--
>   6 files changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index 60c3827..dd38a46 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -48,9 +48,7 @@ AccelClass *accel_find(const char *opt_name)
>  =20
>   int accel_init_machine(AccelClass *acc, MachineState *ms)
>   {
> -    ObjectClass *oc =3D OBJECT_CLASS(acc);
> -    const char *cname =3D object_class_get_name(oc);
> -    AccelState *accel =3D ACCEL(object_new(cname));
> +    AccelState *accel =3D ACCEL(object_new_with_class(OBJECT_CLASS(acc))=
);
>       int ret;
>       ms->accelerator =3D accel;
>       *(acc->allowed) =3D true;
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 230b18f..f9ad692 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -593,6 +593,18 @@ struct InterfaceClass
>                                                __FILE__, __LINE__, __func=
__))
>  =20
>   /**
> + * object_new_with_class:
> + * @klass: The class to instantiate.
> + *
> + * This function will initialize a new object using heap allocated memor=
y.
> + * The returned object has a reference count of 1, and will be freed whe=
n
> + * the last reference is dropped.
> + *
> + * Returns: The newly allocated and instantiated object.
> + */
> +Object *object_new_with_class(ObjectClass *klass);

The function name bugs me... Pick your poison?

   object_new_by_class
   object_new_of_class
   object_new_for_class
   object_new_from_class
   object_new_with_class

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
> +/**
>    * object_new:
>    * @typename: The name of the type of the object to instantiate.
>    *
> diff --git a/qom/object.c b/qom/object.c
> index bfb4413..bc444d3 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -658,6 +658,11 @@ static Object *object_new_with_type(Type type)
>       return obj;
>   }
>  =20
> +Object *object_new_with_class(ObjectClass *klass)
> +{
> +    return object_new_with_type(klass->type);
> +}
> +
>   Object *object_new(const char *typename)
>   {
>       TypeImpl *ti =3D type_get_by_name(typename);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69f518a..a044078 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4640,7 +4640,7 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>           return;
>       }
>  =20
> -    xc =3D X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))))=
;
> +    xc =3D X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>  =20
>       x86_cpu_expand_features(xc, &err);
>       if (err) {
> @@ -4711,7 +4711,7 @@ static GSList *get_sorted_cpu_model_list(void)
>  =20
>   static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
>   {
> -    Object *obj =3D object_new(object_class_get_name(OBJECT_CLASS(xc)));
> +    Object *obj =3D object_new_with_class(OBJECT_CLASS(xc));
>       char *r =3D object_property_get_str(obj, "model-id", &error_abort);
>       object_unref(obj);
>       return r;
> @@ -5092,7 +5092,7 @@ static X86CPU *x86_cpu_from_model(const char *model=
, QDict *props, Error **errp)
>           goto out;
>       }
>  =20
> -    xc =3D X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))))=
;
> +    xc =3D X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>       if (props) {
>           object_apply_props(OBJECT(xc), props, &err);
>           if (err) {
> @@ -5936,7 +5936,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error =
**errp)
>       APICCommonState *apic;
>       ObjectClass *apic_class =3D OBJECT_CLASS(apic_get_class());
>  =20
> -    cpu->apic_state =3D DEVICE(object_new(object_class_get_name(apic_cla=
ss)));
> +    cpu->apic_state =3D DEVICE(object_new_with_class(apic_class));
>  =20
>       object_property_add_child(OBJECT(cpu), "lapic",
>                                 OBJECT(cpu->apic_state), &error_abort);
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7e92fb2..72cf48b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -440,7 +440,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
>       if (cpu_list_data->model) {
>           Object *obj;
>           S390CPU *sc;
> -        obj =3D object_new(object_class_get_name(klass));
> +        obj =3D object_new_with_class(klass);
>           sc =3D S390_CPU(obj);
>           if (sc->model) {
>               info->has_unavailable_features =3D true;
> @@ -501,7 +501,7 @@ static void cpu_model_from_info(S390CPUModel *model, =
const CpuModelInfo *info,
>           error_setg(errp, "The CPU definition '%s' requires KVM", info->=
name);
>           return;
>       }
> -    obj =3D object_new(object_class_get_name(oc));
> +    obj =3D object_new_with_class(oc);
>       cpu =3D S390_CPU(obj);
>  =20
>       if (!cpu->model) {
> diff --git a/vl.c b/vl.c
> index d6c77bc..f18b26b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3989,8 +3989,7 @@ int main(int argc, char **argv, char **envp)
>                         cleanup_add_fd, NULL, &error_fatal);
>   #endif
>  =20
> -    current_machine =3D MACHINE(object_new(object_class_get_name(
> -                          OBJECT_CLASS(machine_class))));
> +    current_machine =3D MACHINE(object_new_with_class(OBJECT_CLASS(machi=
ne_class)));
>       if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
>           exit(0);
>       }
>=20


