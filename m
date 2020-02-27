Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ACC35677
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CE22469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WinOLGGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CE22469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MBE-0004ME-1J
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7MAX-0003Wd-3o
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7MAV-0006VF-RM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:37:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7MAV-0006Ua-MQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyJMn5oZia6/M8bjb30iPTUaX5U1llRQf18chBqu7bU=;
 b=WinOLGGu6/u/lbkMmgzGF3SoFcUlBhIU/XMGz6KAn4XcAyruWvVB/vNRRPFLO70p97Q6IT
 Xu+LVPq0cCj7KjbUZM6Zjoju2cNFnUm9goYGwxYMbmu44qeP60pwCrgKfJ5gHPM1ITHGPg
 MgUYOyUs243zETE7nStNPqhr1KAnims=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-QXduuFqLPwWfnDY-e-wF-w-1; Thu, 27 Feb 2020 11:37:43 -0500
X-MC-Unique: QXduuFqLPwWfnDY-e-wF-w-1
Received: by mail-wm1-f71.google.com with SMTP id p26so897676wmg.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 08:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=na9nDnRWWBnqaB4FfsgrHzNMYSXD448+hkajvcnzbFs=;
 b=QQsbI0o7sm2vGj43UIhXaZGxf34POcK7SUGIvPr++QTuy8y4yhP3W7we9mA+0WIkVi
 7ctOZTdQLC3XCr7nXev3EsF21stkyp06Tzwr9Gr8uDo7GTk9gYQop00S4NHESLEfY6QT
 Q70i/V7Pf9zx0itc3MWLKhI1sazWFzx+Wa71haR9xHecMa/sCUSbUKgYIKWio8L7JBd3
 BZ7doVfv/vNaMUI3QrQJaPQ3gp+HzoWDiPwJRvyqJ2E3/MvTnMEi3Jga2tkgwjVo9exa
 jSnb7XFYojjYmsstnnKTvvUWiUWwA5S9ab+J7k++ZJmw/YCAWBPVrlVOnWYMg8sAx9sk
 h+GA==
X-Gm-Message-State: APjAAAVQQnfU92k8vNl7cwu3NeTwvHFpi5FkP1hwvVY7p4btGa6KiuA4
 u2P5x1fYCDljjAkIlherQBmqWypsVxCfKljaKXEXIOQmT09Dv6AVLYHFjHNXmNSZlnHbsHfaMJC
 3JXB1/0DeZZHpBAk=
X-Received: by 2002:a1c:df45:: with SMTP id w66mr303262wmg.171.1582821460163; 
 Thu, 27 Feb 2020 08:37:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKEeIhl61IQNJ8n3DV8N6aPNjo20pvDYr76nCe69B8zIahxPfg6p9Kg2Vyzbje9coXOhpPuQ==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr303246wmg.171.1582821459890; 
 Thu, 27 Feb 2020 08:37:39 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i10sm1461629wrn.53.2020.02.27.08.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 08:37:39 -0800 (PST)
Subject: Re: [PATCH v2] softmmu/vl.c: fix too slow TCG regression
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200227161454.32368-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <adfc6ae6-ad35-b1fd-236a-e89d9093e389@redhat.com>
Date: Thu, 27 Feb 2020 17:37:38 +0100
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, nieklinnenbank@gmail.com,
 hsp.cat7@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


