Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C3C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C63214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSigYRak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C63214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94mU-0006Ex-Ir
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j94aq-0002YG-Sk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j94ap-0000V4-K3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:16:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j94ap-0000Uy-GY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCNTmIqzCz8GEs4yUEV2AFU79BSVBkInDEin/vM7XUA=;
 b=aSigYRakkHGHyHPp1yrnuViKWLXkbLzzo5Mv1M1L94BoWEUVF7sGhfyhm2aMrPIaaeAjmw
 53tToRyzpf9iuOwkkgIFsqzjW8OltjMZZVACkGi6nj/C4AN5irKr8oH0LnAB3SYhVIzgwa
 ltJVBOcCeEboOfPb5q2ND75Z0Lx3b9I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-8HA9xplDNRuMuFwgJcm00w-1; Tue, 03 Mar 2020 05:16:00 -0500
X-MC-Unique: 8HA9xplDNRuMuFwgJcm00w-1
Received: by mail-wr1-f70.google.com with SMTP id f10so1014122wrv.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aBenczBTiCbsLPHyrEIt+tC3sP67vYZQWWmU9hIoOUg=;
 b=T63pMq0y6kqljfKGrY2m0adgEHmaOdRyaOrfDUPwfcMft1BeKfUdoYM9yzX5k6X8AZ
 4Uqh4rGsXj5fCfafczR5S4iFmVKFLlIHCj53duy70IW3PUvtKxgU8ZCa1QtADr0NCqIH
 8xPKQnDL89n6uA/dEjVEmnGKDDNuW9WbBYeWRQZ0tB6XUAhJG93noUwt5qCsbVXxinQB
 bRqXQJoOv9U8kugECbDf14qs39LjW+A2rBxW6wMFX9/BNu5DBYHTM2idbOVy0N9HBJ6Z
 cCWpqSD2aoA/u0n/tUArHToMyPHUlgG079xtYwLL34DwfbE5WMM5/SAt8DSkNryJCs0D
 gANQ==
X-Gm-Message-State: ANhLgQ2w1RLI8ZgLOQVrZShJ9nHLbl7Kth1jRlwwQnIEEfiwHc1zi/5W
 rXnaqtIgq/JVrNR/Xh2PhnOsHfljFIsUL3FgGBpLaq6Ka83D9hdRWZOXF874+nMPYA1XRw9aRzB
 ulRFjYSzuflK8lYM=
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr4635094wrw.194.1583230559427; 
 Tue, 03 Mar 2020 02:15:59 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsr/BwzV/sSMlAbc3emlT8s7sdq089+YdA+wX01AWl1Twoyp+6TfM3R9Ec0zfICeKbU3jvdrw==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr4635074wrw.194.1583230559072; 
 Tue, 03 Mar 2020 02:15:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id z16sm32090152wrp.33.2020.03.03.02.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 02:15:58 -0800 (PST)
Subject: Re: [PATCH v4] i386: Fix GCC warning with snprintf when HAX is enabled
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200302201320.6465-1-jcfaracco@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <029f2134-ba84-baf1-3234-6239a57795bd@redhat.com>
Date: Tue, 3 Mar 2020 11:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302201320.6465-1-jcfaracco@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/03/20 21:13, Julio Faracco wrote:
> When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
> snprintf(). Replacing old snprintf() by g_strdup_printf() fixes the
> problem with boundary checks of vm_id and vcpu_id and finally the
> warnings produced by GCC.
>=20
> For more details, one example of warning:
>   CC      i386-softmmu/target/i386/hax-posix.o
> qemu/target/i386/hax-posix.c: In function =E2=80=98hax_host_open_vm=E2=80=
=99:
> qemu/target/i386/hax-posix.c:124:56: error: =E2=80=98%02d=E2=80=99 direct=
ive output may be
> truncated writing between 2 and 11 bytes into a region of size 3
> [-Werror=3Dformat-truncation=3D]
>   124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_=
id);
>       |                                                        ^~~~
> qemu/target/i386/hax-posix.c:124:41: note: directive argument in the rang=
e
> [-2147483648, 64]
>   124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_=
id);
>       |                                         ^~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/stdio.h:867,
>                  from qemu/include/qemu/osdep.h:99,
>                  from qemu/target/i386/hax-posix.c:14:
> /usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output
> between 17 and 26 bytes into a destination of size 17
>    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL =
- 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>    68 |        __bos (__s), __fmt, __va_arg_pack ());
>       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
> v1-v2: Add assert() as Richard Henderson suggested.
> v2-v3: Fix code syntax alignment with vm_id and snprintf() function.
> v3-v4: Replacing snprintf() by g_strdup_printf() from linux and windows.
> ---
> ---
>  target/i386/hax-posix.c   | 33 ++-------------------------------
>  target/i386/hax-windows.c | 33 ++-------------------------------
>  2 files changed, 4 insertions(+), 62 deletions(-)
>=20
> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
> index a5426a6dac..3bad89f133 100644
> --- a/target/i386/hax-posix.c
> +++ b/target/i386/hax-posix.c
> @@ -108,41 +108,12 @@ int hax_mod_version(struct hax_state *hax, struct h=
ax_module_version *version)
> =20
>  static char *hax_vm_devfs_string(int vm_id)
>  {
> -    char *name;
> -
> -    if (vm_id > MAX_VM_ID) {
> -        fprintf(stderr, "Too big VM id\n");
> -        return NULL;
> -    }
> -
> -#define HAX_VM_DEVFS "/dev/hax_vm/vmxx"
> -    name =3D g_strdup(HAX_VM_DEVFS);
> -    if (!name) {
> -        return NULL;
> -    }
> -
> -    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> -    return name;
> +    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
>  }
> =20
>  static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>  {
> -    char *name;
> -
> -    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
> -        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_=
id);
> -        return NULL;
> -    }
> -
> -#define HAX_VCPU_DEVFS "/dev/hax_vmxx/vcpuxx"
> -    name =3D g_strdup(HAX_VCPU_DEVFS);
> -    if (!name) {
> -        return NULL;
> -    }
> -
> -    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> -             vm_id, vcpu_id);
> -    return name;
> +    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
>  }
> =20
>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
> index 5729ad9b48..0ba488c468 100644
> --- a/target/i386/hax-windows.c
> +++ b/target/i386/hax-windows.c
> @@ -185,41 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct h=
ax_module_version *version)
> =20
>  static char *hax_vm_devfs_string(int vm_id)
>  {
> -    char *name;
> -
> -    if (vm_id > MAX_VM_ID) {
> -        fprintf(stderr, "Too big VM id\n");
> -        return NULL;
> -    }
> -
> -#define HAX_VM_DEVFS "\\\\.\\hax_vmxx"
> -    name =3D g_strdup(HAX_VM_DEVFS);
> -    if (!name) {
> -        return NULL;
> -    }
> -
> -    snprintf(name, sizeof HAX_VM_DEVFS, "\\\\.\\hax_vm%02d", vm_id);
> -    return name;
> +    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
>  }
> =20
>  static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>  {
> -    char *name;
> -
> -    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
> -        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_=
id);
> -        return NULL;
> -    }
> -
> -#define HAX_VCPU_DEVFS "\\\\.\\hax_vmxx_vcpuxx"
> -    name =3D g_strdup(HAX_VCPU_DEVFS);
> -    if (!name) {
> -        return NULL;
> -    }
> -
> -    snprintf(name, sizeof HAX_VCPU_DEVFS, "\\\\.\\hax_vm%02d_vcpu%02d",
> -             vm_id, vcpu_id);
> -    return name;
> +    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
>  }
> =20
>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
>=20

Queued, thanks.

Paolo


