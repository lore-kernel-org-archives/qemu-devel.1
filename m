Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4976C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F18424653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iO6k4xLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F18424653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71Jc-000144-PR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j71J0-0000YQ-9u
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j71Iy-0005T4-VU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:21:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j71Iy-0005Qb-Ob
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:21:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so295442wma.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ySK2s59J1sTG2zP2czHCLrR2vg8EAOOqFSMi+9ODHFQ=;
 b=iO6k4xLQSaevQJ8tmuz8EH8pK/Cmb2OxuOu7Utd8M+fg2ReuHD78qyvRrEyLBrDwlo
 /nX1FvX0xw3BaEoHNAe9N3v43tNSuywv7zzt19X9d0RplbMRqohQP4SERVR299qYdgm1
 UeqXQpgRR3KpEdiEDboOaJpagxCpp/wub3aJsRyD3plA/YepmjxOmO6LAjRW/8d+FUBo
 k0MRKOHXfkU36tqRAb3T4VqDmbpGYBcS4StQ5ZyoSenC4lnRiCjV9erERv4I+8mDeuMK
 tXAwZwjKdSsT/rHtpYORwD8zzPZ2YdDhWbwxN/5LqWMXc9S9K1wKDcIwDt8oTIPd6JWr
 9tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ySK2s59J1sTG2zP2czHCLrR2vg8EAOOqFSMi+9ODHFQ=;
 b=fhu89dGiiXGKnVthOG8J1rQY3ioAQBykYGl3BY7XfsLfNsuH7gku1JRtZdrRNIcmL/
 Xlf7zn9ddcG0Qm2eLlgfDZbnqUnbLa40L7JgadWuhoYU7D4HlGzFrOC4/29XBHjkCXzl
 621K7uRqlEHEB4KukeZ5vBxZbRfLneu+wHz/ee4MP4N+L+OpgvqeWh1MQe4S0siGWDf+
 bflXoh0tAOien7Xoqfh4eCDs1IWvyvir3ykwhVDOf9kvyaxg+nEwYqz91XlqsrQ4PI1f
 K5+1tiSRMnIeutoV9Xm1kfyL+ulTuUGbUpJwItzZExBT3uMF9Li3qRAMhlYI0v9hR1S5
 g2tQ==
X-Gm-Message-State: APjAAAW/bwNJEic8rxGPACYXrtqpy8D9DXFy870F0yetxP/Uz336enYJ
 RAFBKTXtWP/2OQEDAorWvVnVdw==
X-Google-Smtp-Source: APXvYqzZc+usPalAZkWNHrdWZp44uMweQeqTd92rqN9C+WyHgdMF7RHZtbITTYwpoOr5nEJNahNGOQ==
X-Received: by 2002:a1c:4908:: with SMTP id w8mr136394wma.57.1582741267513;
 Wed, 26 Feb 2020 10:21:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 25sm4068840wmi.32.2020.02.26.10.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:21:06 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 948D81FF87;
 Wed, 26 Feb 2020 18:21:05 +0000 (GMT)
References: <20200226163539.31960-1-imammedo@redhat.com>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] softmmu/vl.c: fix too slow TCG regression
In-reply-to: <20200226163539.31960-1-imammedo@redhat.com>
Date: Wed, 26 Feb 2020 18:21:05 +0000
Message-ID: <875zftxl9q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 nieklinnenbank@gmail.com, hsp.cat7@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor Mammedov <imammedo@redhat.com> writes:

> Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
> that broke TCG accelerator initialization which accesses global ram_size
> from size_code_gen_buffer() which is equal to 0 at that moment.
>
> Partially revert a1b18df9a4, by returning set_memory_options() to its
> original location and only keep 32-bit host VA check and 'memory-backend'
> size check introduced by fe64d06afc at current place.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>
> PS:
> This should take care of regression and give more time to think about
> how to remove size_code_gen_buffer() dependency on ram_size

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

FWIW I don't think it will take too long to fixup size_code_gen_buffer.
See:

  Subject: [PATCH  v1 0/4] Fix codegen translation cache size=20
  Date: Wed, 26 Feb 2020 18:10:16 +0000
  Message-Id: <20200226181020.19592-1-alex.bennee@linaro.org>


> ---
>  softmmu/vl.c | 49 +++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index a9cce78f45..da7577129c 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2634,29 +2634,6 @@ static void set_memory_options(uint64_t *ram_slots=
, ram_addr_t *maxram_size,
>          exit(EXIT_FAILURE);
>      }
>=20=20
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
>      loc_pop(&loc);
>  }
>=20=20
> @@ -3821,6 +3798,8 @@ void qemu_init(int argc, char **argv, char **envp)
>      machine_class =3D select_machine();
>      object_set_machine_compat_props(machine_class->compat_props);
>=20=20
> +    set_memory_options(&ram_slots, &maxram_size, machine_class);
> +
>      os_daemonize();
>=20=20
>      /*
> @@ -4296,7 +4275,29 @@ void qemu_init(int argc, char **argv, char **envp)
>          current_machine->cpu_type =3D parse_cpu_option(cpu_option);
>      }
>=20=20
> -    set_memory_options(&ram_slots, &maxram_size, machine_class);
> +    if (!xen_enabled()) {
> +        /* On 32-bit hosts, QEMU is limited by virtual address space */
> +        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
> +            error_report("at most 2047 MB RAM can be simulated");
> +            exit(1);
> +        }
> +    }
> +
> +    if (current_machine->ram_memdev_id) {
> +        Object *backend;
> +        ram_addr_t backend_size;
> +
> +        backend =3D object_resolve_path_type(current_machine->ram_memdev=
_id,
> +                                           TYPE_MEMORY_BACKEND, NULL);
> +        backend_size =3D object_property_get_uint(backend, "size",  &err=
or_abort);
> +        if (backend_size !=3D ram_size) {
> +                error_report("Size specified by -m option must match siz=
e of "
> +                             "explicitly specified 'memory-backend' prop=
erty");
> +                exit(EXIT_FAILURE);
> +        }
> +        ram_size =3D backend_size;
> +    }
> +
>      current_machine->ram_size =3D ram_size;
>      current_machine->maxram_size =3D maxram_size;
>      current_machine->ram_slots =3D ram_slots;


--=20
Alex Benn=C3=A9e

