Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE4BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA1D214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHVvGymj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA1D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rVS-0005Ds-T8
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8rUk-0004m3-NT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8rUj-0007w0-8z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:16:54 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8rUj-0007uq-14
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:16:53 -0500
Received: by mail-lj1-x242.google.com with SMTP id e3so880701lja.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WGAVUk2LLxV/xl0K5AduPPkNv1HJe31VrWTebw+PVpo=;
 b=qHVvGymjNKBxNhVLAbba1KqrCgNPJHQ+08ALVlyapY1n2UpNRkZNm2MjI/AR4LHKot
 /fi3v5h/XkeZXY4caX1pFVBWy5qsKXkokjyCPFZ6GyMie02hS2RocGgkMtQQYRHLbG7V
 nbcIDlQnXUkMqT3L4d7/jjS+d4WqXot9n4IWYWJIksW87qCCK7I657pZRzhLz0pdyM1+
 tBbT+G8Q6h3K8IFYPORXAECE5enw4xKOYveL1k7Oos1vgZ67+V7DoLuGLsOfFmNXKchv
 oa+XGBS2/n1vmMrutC6OcudMBajk8VAEVWAKPNxRAcq+8ZCwdYYwfuXXnkyYf2xzXgEF
 aFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WGAVUk2LLxV/xl0K5AduPPkNv1HJe31VrWTebw+PVpo=;
 b=ZV1Q3ETTL6hGTCJvYaOAGiGLvkGOXZzHU/FaZ+uAEKu/1ZyZDgSVhSzZ7xKEPpcBa+
 z5WuGiDaEMx1x2wMlK62APG+JgGKSk3ZXrqmYVN0hU4fBR0JtSX0c0Wy3Gjp/Npv6fr8
 ttVEVYQe1u5Yq2FjGmh66aPAbVWTBEpxyu4OZ7iY8pL++TpPbBFWECzEnws/APL9u3y4
 RoJjPoDNASdZ3pPedmrOoVmf4P9DPp0KpxcMw2UoUKZXK+nlrzqCvOg6y8BWhElLQI2R
 THIhcEeRVDm1r/BHV7tQhQe08vxI3BKf2bvsGEme8vVUmFiHM+KOzre7cQPUOMRPG2bB
 AGsA==
X-Gm-Message-State: ANhLgQ1oLdeJgOVnbf785zrmuIdvnqGa/AAbE9uyBWLoeaG6m1Nnos3y
 bUPyA8uPUOntfYGzFPEtMzjuh4jotLNPwbQjbWXNatUI
X-Google-Smtp-Source: ADFU+vungvHCb0ZteATcBTgF0s9+2041YoVbjRaTglQEHYUz/TexU/nIXAFi0w241FYxyRHNxDo6d5RVFphw818MRJ4=
X-Received: by 2002:a2e:7213:: with SMTP id n19mr373990ljc.148.1583180210918; 
 Mon, 02 Mar 2020 12:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20200302201320.6465-1-jcfaracco@gmail.com>
In-Reply-To: <20200302201320.6465-1-jcfaracco@gmail.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 2 Mar 2020 17:16:39 -0300
Message-ID: <CAENf94KQnG_+cCL1z4Rj0jX7aA3g3=d0KdX4bSwZ3bU4tjq+sA@mail.gmail.com>
Subject: Re: [PATCH v4] i386: Fix GCC warning with snprintf when HAX is enabled
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Em seg., 2 de mar. de 2020 =C3=A0s 17:13, Julio Faracco
<jcfaracco@gmail.com> escreveu:
>
> When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
> snprintf(). Replacing old snprintf() by g_strdup_printf() fixes the
> problem with boundary checks of vm_id and vcpu_id and finally the
> warnings produced by GCC.
>
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
>
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
>
> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
> index a5426a6dac..3bad89f133 100644
> --- a/target/i386/hax-posix.c
> +++ b/target/i386/hax-posix.c
> @@ -108,41 +108,12 @@ int hax_mod_version(struct hax_state *hax, struct h=
ax_module_version *version)
>
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
>
>  static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>  {
> -    char *name;
> -
> -    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
> -        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_=
id);
> -        return NULL;
> -    }

We probably need a V5 to remove definitions from hax-i386.h:
#define MAX_VM_ID 0x40
#define MAX_VCPU_ID 0x40

That's why I asked about IF last patch. ;-)

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
>
>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
> index 5729ad9b48..0ba488c468 100644
> --- a/target/i386/hax-windows.c
> +++ b/target/i386/hax-windows.c
> @@ -185,41 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct h=
ax_module_version *version)
>
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
>
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
>
>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
> --
> 2.24.1
>

