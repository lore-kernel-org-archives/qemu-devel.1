Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C18C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 04:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE6620888
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 04:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF9bEA0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE6620888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLfLx-00071G-F2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 00:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kLfLI-0006bd-2v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 00:28:20 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kLfLF-0000T8-Lz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 00:28:19 -0400
Received: by mail-io1-xd44.google.com with SMTP id m17so1406867ioo.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wR4H4Y2nHt/Vl5c+Snggk/KwIir8bq5iQK/I5Iw0+ew=;
 b=CF9bEA0YIQ06i6AGcr7YlrPpbikFyVNQCyZzPEKyJLrJq84XCJSCejMq7kgMUXg1GO
 B7Qhv7seQ3o9Sp03gGzADlndAceoPpCoDPTI1UzvKL+vxxbygODj0kXFxF/a9i6Jzun2
 eNdCWQbwLmktSIPEUHhEAYXkF5McTSOqYeBfqMdL7u2vmKs8meSTLTXR7AryDa+UBdM8
 GxQYzslvyX0GrJpfsmVvhMsk50HKcgMARSDiQVQWxaCJObDwg3hgHC0MllCKKxxk6H/f
 ucPgj00fY1JEVWsUa6Pfolu4mBXcjoRCL2cppxGa4b7l3bOVmxPJ/l9tfrfvgzdlMxlz
 oSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wR4H4Y2nHt/Vl5c+Snggk/KwIir8bq5iQK/I5Iw0+ew=;
 b=px7QobB6otnKoV1tOnP/ImJAjsQre69/n7vvowmWKCZSTkLAwMM4f+JhuiVjzBXBmR
 tmlddkohqSJTJWdhKs+6dViEh4yBlLN6g6uNHZVnj62M0WBLS7bAiGXHRfZ/vfAXDCft
 tpkhM/xuUC8DTGjcgiQxlWK5pLX8FwG7laA0XlKSNtMjyfHQb/n1E4Dx+tuaULKq9Dxm
 x/8WMyR2nReTLqzd+b1d/9cuu88bSHjes8ZURDkVUKptNURw0vF3v/l0nnXop0gdN9Pt
 sLx4+gQnvOzpQzRvVpHPUknUf0NZ9His4StRBBueyNFu+OjK5H6Xht+3Cet7BQ0j3ieA
 T7Ew==
X-Gm-Message-State: AOAM530CcMVS5rvQGdyo0GAF0KR3bK3cXmy5hY7RvX+Z7PiDIp2n68p3
 sGZObxFy3I4xyxkUURya5X8PZCp2esV0PChh/do=
X-Google-Smtp-Source: ABdhPJyCFLAS/d68Yl/TnWlXnriSHkC1jS9S66+5rwrADjyHNvSsmSNc5pGuAtKCI14v1RHVOM4Rug0vZieubjmw8C0=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr1921338iog.125.1601008095944; 
 Thu, 24 Sep 2020 21:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
 <4a461bbc-3765-4d3c-7e7b-952dab564af1@amsat.org>
In-Reply-To: <4a461bbc-3765-4d3c-7e7b-952dab564af1@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 25 Sep 2020 12:28:02 +0800
Message-ID: <CAAhV-H5UXE-BWgrF89kQMMsP1s0uzoRq05Jf2SxN5j72_quCPA@mail.gmail.com>
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Thu, Sep 24, 2020 at 11:40 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 9/16/20 11:49 AM, Huacai Chen wrote:
> > Hi, Philippe,
> >
> > On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> Hi Huacai,
> >>
> >> On 9/16/20 4:12 AM, Huacai Chen wrote:
> ...
> >> hw/mips/loongson3_virt.c:373:15: note: each undeclared identifier is
> >> reported only once for each function it appears in
> >> hw/mips/loongson3_virt.c:373:15: error: excess elements in struct
> >> initializer [-Werror]
> >> hw/mips/loongson3_virt.c:373:15: note: (near initialization for 'freq_=
reg')
> >> hw/mips/loongson3_virt.c:374:9: error: unknown field 'addr' specified =
in
> >> initializer
> >>          .addr =3D (uintptr_t)(&freq)
> >>          ^
> >> hw/mips/loongson3_virt.c:374:17: error: excess elements in struct
> >> initializer [-Werror]
> >>          .addr =3D (uintptr_t)(&freq)
> >>                  ^
> >> hw/mips/loongson3_virt.c:374:17: note: (near initialization for 'freq_=
reg')
> >> hw/mips/loongson3_virt.c:372:24: error: storage size of 'freq_reg' isn=
't
> >> known
> >>      struct kvm_one_reg freq_reg =3D {
> >>                         ^
> >> hw/mips/loongson3_virt.c:380:41: error: 'KVM_GET_ONE_REG' undeclared
> >> (first use in this function)
> >>          ret =3D kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg)=
;
> >>                                          ^
> >> hw/mips/loongson3_virt.c:372:24: error: unused variable 'freq_reg'
> >> [-Werror=3Dunused-variable]
> >>      struct kvm_one_reg freq_reg =3D {
> >>                         ^
> >> hw/mips/loongson3_virt.c: In function 'init_loongson_params':
> >> hw/mips/loongson3_virt.c:467:25: error: cast from pointer to integer o=
f
> >> different size [-Werror=3Dpointer-to-int-cast]
> >>      lp->memory_offset =3D (unsigned long long)init_memory_map(p)
> >>                          ^
> > I guess this happens on a 32bit platform where pointer is 32bit, and
> > could you please suggest a best solution for this? Maybe use uintptr_t
> > instead of unsigned long long?
>
> Since the machine doesn't have to know the EFI structures
> layout, I'd change your method to fill EFI structures as i.e.:
>
> /*
>  * @ptr: Pointer to fill
>  * @size: Buffer size available at @ptr
>  * Returns: Structure size filled on success, -1 on error.
>  */
> size_t fill_efi_memory_map_loongson(char *ptr, size_t size);
>
> And move that to hw/mips/loongson_efi.{c,h}.
>
> Then you don't need to worry about host pointer size, you just
> exchange buffer/size, then caller can round up and increment an
> offset.
All boot parameters are located in a small region, so a uint32_t seems
enough for xxx_offset, so uintptr_t is just OK, I think.

>
> BTW the EFI helpers are not endian safe.
>
> You should use the helpers described in docs/devel/loads-stores.rst:
>
> stw_le_p, stl_le_p(), ... (as I don't expect big-endian guests).
This seems like a very big project, but I will do it in the next version.

Huacai
>
> Regards,
>
> Phil.

