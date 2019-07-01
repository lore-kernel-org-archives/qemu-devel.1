Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE94C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB84208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaM9GUSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB84208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhy8U-00081y-To
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38057)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhy5z-0006ZZ-F2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhy5y-0003Tw-2A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:19:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhy5x-0003SF-Ok
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:19:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id v186so10256590oie.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=88izuRn6GLm/EmQGtulJZg1i2yfV9ZeB3PdO+YNXXoU=;
 b=UaM9GUSNRSvLuWgOHYBV3RGaMM1ltC/hXydAor6EgaNxD5KG8SEx2lmQcejuO+zGfi
 qmzh0BDMx9QnJff5b9hLUXBNCA7liO7xvYKClBi52IiCGh3pTJmWWLmrK7mwzfZ8lmWX
 NwDEpBFOnexaECf96dCvA9ECUycHtGm8r/FzQCyxiKpHLcvSA9aaqOhXIVdx7M06NDoK
 z/ul2/6ulK1UZEz6bdzERyWkzthUIq7JHkN+CKmdlvnzrqqmj+ELvJFQdIeq0ct66hnq
 bEykwNL6Ss21fU6lSUYG8c072iHKbzVhn8Q5YwDR6SZRyrtwyIOix2aP5PIEp8yzT+rT
 hItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=88izuRn6GLm/EmQGtulJZg1i2yfV9ZeB3PdO+YNXXoU=;
 b=nQMmHVZvuqNRpqFTlvcIUHF1I5uVYLJHs8wWfZWNlNme0dxN9GGIpC8gUa9pwKr6KD
 xv+pSF6kfQqDpOkcZ16RX6m/JWjRMvwVw/IYU0mUPdG/sTf+U5/XHjEhQuZBI2NP1BWc
 QX43TNO4A3uj+F1w3FV0tP5qp3/McySAg6kc1qxQb2abuOlZGkAsNVJga/VmUxYy1qMx
 LBh2kLUYZIXX9DnuZv1qq2mmdLEnZGuvE+htQHPzT4Ccpukir/ZFpDV9M55WBYyFJsd3
 sOHJhHYT4F/MOfq2D7IWnJkct6dWsYWHovjQLLRhS7C98unj4gGV4tkc2iFdhZSjdw54
 wwgg==
X-Gm-Message-State: APjAAAUkbo2OJug1xlaniG6ZkFnBkXxDK5J3TmMsw3bhE0zxJZ2D1X00
 xDlTdJLWylwWFfd+QPaG1YkNM0nF5qYEjx529NVhMg==
X-Google-Smtp-Source: APXvYqzbYS1BvCZjBSoFBGwSGjTzA8eYsybKPAmnmyGxcieu+hxANClVrQ3+0NJjwHxNaaj3jxAds2AASfCrKJ14JZo=
X-Received: by 2002:aca:6185:: with SMTP id v127mr7352429oib.163.1561994392862; 
 Mon, 01 Jul 2019 08:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190701132516.26392-1-philmd@redhat.com>
 <20190701132516.26392-14-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-14-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 16:19:42 +0100
Message-ID: <CAFEAcA8GtFqxRnWS+Gb2GZresBXuJFzXbnEWTnOkUfcumdje9w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 13/27] target/arm: Move debug routines
 to debug_helper.c
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 14:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> These routines are TCG specific.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/Makefile.objs  |   2 +-
>  target/arm/cpu.c          |  11 +-
>  target/arm/debug_helper.c | 334 ++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c       |  23 ---
>  target/arm/op_helper.c    | 295 ---------------------------------
>  5 files changed, 339 insertions(+), 326 deletions(-)
>  create mode 100644 target/arm/debug_helper.c

> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2566,7 +2566,6 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
>      cc->gdb_write_register =3D arm_cpu_gdb_write_register;
>  #ifndef CONFIG_USER_ONLY
>      cc->do_interrupt =3D arm_cpu_do_interrupt;
> -    cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
>      cc->asidx_from_attrs =3D arm_asidx_from_attrs;
>      cc->vmsd =3D &vmstate_arm_cpu;
>      cc->virtio_is_big_endian =3D arm_cpu_virtio_is_big_endian;
> @@ -2578,19 +2577,17 @@ static void arm_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->gdb_arch_name =3D arm_gdb_arch_name;
>      cc->gdb_get_dynamic_xml =3D arm_gdb_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint =3D true;
> -    cc->debug_excp_handler =3D arm_debug_excp_handler;
> -    cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
> -#if !defined(CONFIG_USER_ONLY)
> -    cc->adjust_watchpoint_address =3D arm_adjust_watchpoint_address;
> -#endif
> -
>      cc->disas_set_info =3D arm_disas_set_info;
>  #ifdef CONFIG_TCG
>      cc->tcg_initialize =3D arm_translate_init;
>      cc->tlb_fill =3D arm_cpu_tlb_fill;
> +    cc->debug_excp_handler =3D arm_debug_excp_handler;
> +    cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
>  #if !defined(CONFIG_USER_ONLY)
>      cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
>      cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
> +    cc->adjust_watchpoint_address =3D arm_adjust_watchpoint_address;
> +    cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
>  #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */

I don't think get_phys_page_attrs_debug is TCG specific -- anything
that wants to do a virt-to-phys translation will use it, including
for instance cpu_memory_rw_debug() or the monitor gva2gpa command.
target/i386/cpu.c doesn't put its cc->get_phys_page_debug assignment
inside a CONFIG_TCG ifdef.

thanks
-- PMM

