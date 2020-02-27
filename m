Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69DC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3BB2469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4fgyqD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3BB2469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MAg-0003WO-Ph
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7M8P-0000dH-IP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7M8N-0005EP-M7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:35:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7M8N-0005E6-6i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrrgzLI9dFk0vFO5y4lknIwdwegO/AibxlJNnXR7Qm0=;
 b=B4fgyqD4pPtJ0d6IRVQNGXK6l5IlUCeNjjmV2ZU0rBJWazyGDy9Z4WIGYCPdUdBTei1n58
 3sT/3iq/WcEWqFGaGstg+4TqBpr9sJ8jR12jqFU8IWICBM5IruXHUbtLuYKEdgRDjrfCNL
 0a118plxe2nb8ozn7rzAVVix+cAIi0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-qPMCZxk4OlmU-v4JLEhUAw-1; Thu, 27 Feb 2020 11:35:32 -0500
X-MC-Unique: qPMCZxk4OlmU-v4JLEhUAw-1
Received: by mail-wr1-f72.google.com with SMTP id p11so70422wrn.10
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 08:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XhzIT/gV6b2z75HaYsyeGAu19awhsRqLt/n4X+OhWH8=;
 b=XIHV7fB0nDbzdG8XhmAvURyjGL0BWSsTLc5BKXD3IcEejOzbsZ8wmf3w/8VveoeA1p
 p5c2/gCPkQn5rdVon1mgKdencl44OZa3tzq2mm9Xc8QlooIznBYDY7T0Zsp8Di7j7qeJ
 ge0dytNu4m37p48pzRNLRq2iN3zWbbNAv63cSbJ9wCw/z1qTElJEtps/z0RheUCxlakE
 c7JmBQXzd7Ai3REfWKG+YsGECNkZi8bJzSPCpIwygrmO/PqhDALq0ZzRiZIKMv1OHYxf
 Hc6K1catjIhvoR1OtusQNVlHCPUXN2av5UxFbzmixP/yi0Has4y+2XatUl/1JSsqp2fR
 m6QA==
X-Gm-Message-State: APjAAAXBOXOD6pLoQ4fd60U3B7/JyHZBdfRTgTLEJIHw9Hqro4A59emz
 4mtT0momEWgOEDanXozq2Yk2oNdeXKS7iyLixrfAQfX5jKGLTuvYvVIHtIALSfF8l17kjX+RBlw
 gN1xofICM9YyRZAA=
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr342789wmd.11.1582821331367; 
 Thu, 27 Feb 2020 08:35:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6QnaCbcV2IlfP9um9Kf5XIs2tyqW2jOHCypVW5JH7ov9aYHNzCDzwThcz8wkOn/p4+c68+Q==
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr342760wmd.11.1582821331081; 
 Thu, 27 Feb 2020 08:35:31 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f127sm8214767wma.4.2020.02.27.08.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 08:35:30 -0800 (PST)
Subject: Re: [PATCH v2] softmmu/vl.c: fix too slow TCG regression
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200227161454.32368-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ad9e0a0-2e1e-d931-6210-08fd2154f330@redhat.com>
Date: Thu, 27 Feb 2020 17:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227161454.32368-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, nieklinnenbank@gmail.com,
 hsp.cat7@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can we improve the patch subject? "vl: Fix slower TCG on softmmu" or better=
?

On 2/27/20 5:14 PM, Igor Mammedov wrote:
> Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
> that broke TCG accelerator initialization which accesses global ram_size
> from size_code_gen_buffer() which is equal to 0 at that moment.
>=20
> Partially revert a1b18df9a4, by returning set_memory_options() to its
> original location and only keep 32-bit host VA check and 'memory-backend'
> size check introduced by fe64d06afc at current place.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
> v2:
>    * check if user used -m SZ before comparing ram_size with backend's si=
ze.
>      Fixes case where qemu exits with error when backend's size doesn't m=
atch
>      dafault ram_size (i.e. user haven't used -m option  at all)
>      (Peter Maydell <peter.maydell@linaro.org>)
>    * keep order addr space size check for 32-bit host after
>      backend size check. So it would be affected by backend's size as wel=
l.
> ---
>   softmmu/vl.c | 54 ++++++++++++++++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 25 deletions(-)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index a9cce78f45..16ff5a16a3 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2558,7 +2558,7 @@ static bool object_create_delayed(const char *type,=
 QemuOpts *opts)
>   }
>  =20
>  =20
> -static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_s=
ize,
> +static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_s=
ize,
>                                  MachineClass *mc)
>   {
>       uint64_t sz;
> @@ -2634,30 +2634,8 @@ static void set_memory_options(uint64_t *ram_slots=
, ram_addr_t *maxram_size,
>           exit(EXIT_FAILURE);
>       }
>  =20
> -    if (current_machine->ram_memdev_id) {
> -        Object *backend;
> -        ram_addr_t backend_size;
> -
> -        backend =3D object_resolve_path_type(current_machine->ram_memdev=
_id,
> -                                           TYPE_MEMORY_BACKEND, NULL);
> -        backend_size =3D object_property_get_uint(backend, "size",  &err=
or_abort);
> -        if (mem_str && backend_size !=3D ram_size) {
> -                error_report("Size specified by -m option must match siz=
e of "
> -                             "explicitly specified 'memory-backend' prop=
erty");
> -                exit(EXIT_FAILURE);
> -        }
> -        ram_size =3D backend_size;
> -    }
> -
> -    if (!xen_enabled()) {
> -        /* On 32-bit hosts, QEMU is limited by virtual address space */
> -        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> -            error_report("at most 2047 MB RAM can be simulated");
> -            exit(1);
> -        }
> -    }
> -
>       loc_pop(&loc);
> +    return !!mem_str;
>   }
>  =20
>   static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
> @@ -2861,6 +2839,7 @@ void qemu_init(int argc, char **argv, char **envp)
>       bool list_data_dirs =3D false;
>       char *dir, **dirs;
>       const char *mem_path =3D NULL;
> +    bool have_custom_ram_size;
>       BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_qu=
eue);
>       QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list)=
;
>       int mem_prealloc =3D 0; /* force preallocation of physical target m=
emory */
> @@ -3821,6 +3800,9 @@ void qemu_init(int argc, char **argv, char **envp)
>       machine_class =3D select_machine();
>       object_set_machine_compat_props(machine_class->compat_props);
>  =20
> +    have_custom_ram_size =3D set_memory_options(&ram_slots, &maxram_size=
,
> +                                              machine_class);
> +
>       os_daemonize();
>  =20
>       /*
> @@ -4296,7 +4278,29 @@ void qemu_init(int argc, char **argv, char **envp)
>           current_machine->cpu_type =3D parse_cpu_option(cpu_option);
>       }
>  =20
> -    set_memory_options(&ram_slots, &maxram_size, machine_class);
> +    if (current_machine->ram_memdev_id) {
> +        Object *backend;
> +        ram_addr_t backend_size;
> +
> +        backend =3D object_resolve_path_type(current_machine->ram_memdev=
_id,
> +                                           TYPE_MEMORY_BACKEND, NULL);
> +        backend_size =3D object_property_get_uint(backend, "size",  &err=
or_abort);
> +        if (have_custom_ram_size && backend_size !=3D ram_size) {
> +                error_report("Size specified by -m option must match siz=
e of "
> +                             "explicitly specified 'memory-backend' prop=
erty");
> +                exit(EXIT_FAILURE);
> +        }
> +        ram_size =3D backend_size;
> +    }
> +
> +    if (!xen_enabled()) {
> +        /* On 32-bit hosts, QEMU is limited by virtual address space */
> +        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> +            error_report("at most 2047 MB RAM can be simulated");
> +            exit(1);
> +        }
> +    }
> +
>       current_machine->ram_size =3D ram_size;
>       current_machine->maxram_size =3D maxram_size;
>       current_machine->ram_slots =3D ram_slots;
>=20


