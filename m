Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F1C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1F120663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmih/sfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1F120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8v9-0002Dn-M9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8uM-0001Lc-8D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8uL-0007xY-4F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:53:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8uK-0007vr-W9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laNZlL7Tt9NYI5LoxZQ8lyNrzvzhVmV+Pbohz3i15mY=;
 b=Mmih/sfcdW9+Fqtg9Q53Hsuy/JkouJr7+vJGXE6wreTYau461/Ls1zV7cw6ChOVmjDYV1X
 39VVFsRrex7K2L3A0ll+gI2BVFP4lKfPSGrK2Qpbnn5vYHZ9QEtc4fM1AWsan+lEHe/z7H
 UjN4MuxOL3oOP+EJr8w9UMShVuC4aGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-IdVc5WybPKmEVoTqOpcCnw-1; Tue, 17 Mar 2020 05:53:06 -0400
X-MC-Unique: IdVc5WybPKmEVoTqOpcCnw-1
Received: by mail-wm1-f72.google.com with SMTP id f207so6911598wme.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OcE9RsIGTqtb4S7XTfRvGWs4Vuw7HRNex08Oaq9O0V0=;
 b=dWw9uIeCDRCVb9MvJSbbsxlNLGWEZAYOUWFJsS1IPfjADSqcLUv9SP8SCQG1sHjTgF
 CCyngVdu1Gv5JFlEFWeE95G3fgfnxVWqFY59/wAJrX+E5hlHcFKi8r/nhI083kpXLyQm
 aA+TwcwS6QiJnODuj8i1rtyS78OOIoYlevdW13GyV/7VTtVhtltfhOPKzQJPTWAaHAU1
 pOur+7rDAYW5qmJOVWiez78LpmjTOxUGErATm5wXkz6jfgsN1AO+m9CBh7auuyvpj7MT
 3WHpAUAB9Fi+7YhcwjTACz83ptfpkYRVHNHMXbzYWRRRsRknwvjtk48soCMbmqHH4ybb
 Q/4w==
X-Gm-Message-State: ANhLgQ37MwfMVr7x5Lk7d4SWjRBGkxdx7A4LQPhNB/7NdhgHUl3Wolak
 t1p+S8nRdhK1d6G72GVWfZPdAQU74sgJ6LsWbp3YsM1dlnYSQgFgZPqsZNzKthCfD6fYbH+llpO
 Jja59uVSWNQUGAN4=
X-Received: by 2002:adf:f807:: with SMTP id s7mr5011848wrp.49.1584438785577;
 Tue, 17 Mar 2020 02:53:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttmpvei2C6jE946LeR/RwTzv1Jawzh/HFVpZ4WtaquipivtTYuOo9kEj2duVRmVKG8PSH4LA==
X-Received: by 2002:adf:f807:: with SMTP id s7mr5011821wrp.49.1584438785327;
 Tue, 17 Mar 2020 02:53:05 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id l83sm3252809wmf.43.2020.03.17.02.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:53:04 -0700 (PDT)
Subject: Re: [PATCH v1 13/28] target/i386: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ecb1d64-c447-5c0d-0280-ce9cd6537fa6@redhat.com>
Date: Tue, 17 Mar 2020 10:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-14-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v7
>    - remove stray space
>    - fixup the floatx80 set/get routines
> ---
>   target/i386/gdbstub.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
>=20
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index 572ead641ca..e4d8cb66c00 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -98,26 +98,22 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *=
mem_buf, int n)
>                   return gdb_get_reg64(mem_buf,
>                                        env->regs[gpr_map[n]] & 0xffffffff=
UL);
>               } else {
> -                memset(mem_buf, 0, sizeof(target_ulong));
> -                return sizeof(target_ulong);
> +                return gdb_get_regl(mem_buf, 0);
>               }
>           } else {
>               return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
>           }
>       } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> -#ifdef USE_X86LDOUBLE
> -        /* FIXME: byteswap float values - after fixing fpregs layout. */
> -        memcpy(mem_buf, &env->fpregs[n - IDX_FP_REGS], 10);
> -#else
> -        memset(mem_buf, 0, 10);
> -#endif
> -        return 10;
> +        floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
> +        int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> +        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        return len;
>       } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>           n -=3D IDX_XMM_REGS;
>           if (n < CPU_NB_REGS32 || TARGET_LONG_BITS =3D=3D 64) {
> -            stq_p(mem_buf, env->xmm_regs[n].ZMM_Q(0));
> -            stq_p(mem_buf + 8, env->xmm_regs[n].ZMM_Q(1));
> -            return 16;
> +            return gdb_get_reg128(mem_buf,
> +                                  env->xmm_regs[n].ZMM_Q(0),
> +                                  env->xmm_regs[n].ZMM_Q(1));
>           }
>       } else {
>           switch (n) {
> @@ -290,10 +286,9 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t=
 *mem_buf, int n)
>               return 4;
>           }
>       } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> -#ifdef USE_X86LDOUBLE
> -        /* FIXME: byteswap float values - after fixing fpregs layout. */
> -        memcpy(&env->fpregs[n - IDX_FP_REGS], mem_buf, 10);
> -#endif
> +        floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
> +        fp->low =3D le64_to_cpu(* (uint64_t *) mem_buf);
> +        fp->high =3D le16_to_cpu(* (uint16_t *) (mem_buf + 8));
>           return 10;
>       } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>           n -=3D IDX_XMM_REGS;
>=20

I'd prefer both USE_X86LDOUBLE hunks in a separate patch, anyway:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


