Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008DCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84B32076E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRYw/T0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84B32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rq3-00069s-3D
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1k2rpK-0005j0-4c
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:57:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1k2rpG-0004dz-Rm
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:57:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id r2so31378554wrs.8
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=vvQsoFHR2+DeaNoRp6DMvUWjuYGvhITErRMiUFGaDog=;
 b=dRYw/T0yqo5tl0bDOFShRYSS6Qf3gjZEgMUmriHTzgnKjgLlSGhSdbJ5egLrYzbEpW
 kyJfO+uq4G3gnyQ0qxGkaHHZD0BfRoVzpJ7EamxfRuroAnSCec7bGONhnWOzQ0xGxrtG
 KFt4qpRaYMjrGRLyY+mNMBaD6JZjHiAcpOeCZ3HbBPrnaEfz+lKfxI/bxdJirJW2Mzs2
 NFsKPMrLeT1vF5+ocVSwE2mCzRbLmZSK3iJboY+lEDqGYM/jFVi6CKGTDs0vUxnkWaHT
 pPtVo7tkVeJxSSFk9mTnY5wDIgIkouKaTx/GM7CMggRADoOZ7inEVmtPXlii3Hmplx16
 Vm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=vvQsoFHR2+DeaNoRp6DMvUWjuYGvhITErRMiUFGaDog=;
 b=AtDdsOknu1TSJSKFcP8kJPXWz3NhNmmnxMRzYbbFx8Kz+JpkBsFHA24FzUTEGGR4fl
 mVZTQeOFTwLFELsuehgIf+t1cZy0ncd7DXQEc5SPJQ4d1fp+dzLtqdCmWIwVwg6AE30w
 V8w+JqWzCtwTux/Ucoa3lRo/9bfkeZt5rDUiwtyewjlp4SblMNLPVM0c+NvfcUWn298A
 cJ9mT7c8Dq+HsBeYJdLOtvxwPbuH//quTbktP71ZKhYUlJqhIDohoEBdArqqH2L5E58G
 Znaado9xmMGwzmrEjGwl+/DkiRljE/65cW0D3TGSHSfAnMiJ0pR0n4fd86rrtYeebKbU
 Z/6Q==
X-Gm-Message-State: AOAM530VxR7DxZwLP8w6lWgz8OfYTQ7fiDl+eqxXPe67uD+ng42vMgYW
 DuxN9fL34OWFil0pE8bWbRE=
X-Google-Smtp-Source: ABdhPJz5q55RXy9x8zNWsppP9ibasWEC4DANgO7R8btCtThODKtR27kGUGJdBZeIVcEjiBsemuaUpw==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr19684984wro.71.1596527852677; 
 Tue, 04 Aug 2020 00:57:32 -0700 (PDT)
Received: from CBGR90WXYV0 ([2a00:23c5:5785:9a01:9005:cf07:3ece:ca77])
 by smtp.gmail.com with ESMTPSA id r3sm2114782wro.1.2020.08.04.00.57.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Aug 2020 00:57:32 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200804074930.13104-1-philmd@redhat.com>
 <20200804074930.13104-2-philmd@redhat.com>
In-Reply-To: <20200804074930.13104-2-philmd@redhat.com>
Subject: RE: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Date: Tue, 4 Aug 2020 08:57:31 +0100
Message-ID: <001201d66a34$e82ec070$b88c4150$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQM/xXTZtf+c9Zv1otz4aIX099Jj8gDx5jXApk1PJBA=
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x442.google.com
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Paul Durrant' <pdurrant@amazon.com>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 04 August 2020 08:50
> To: qemu-devel@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>; Anthony Perard =
<anthony.perard@citrix.com>; Paolo
> Bonzini <pbonzini@redhat.com>; Stefano Stabellini =
<sstabellini@kernel.org>; xen-
> devel@lists.xenproject.org; Paul Durrant <paul@xen.org>; Philippe =
Mathieu-Daud=C3=A9 <philmd@redhat.com>;
> Paul Durrant <pdurrant@amazon.com>
> Subject: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior =
on target-agnostic objects
>=20
> CONFIG_XEN is generated by configure and stored in "config-target.h",
> which is (obviously) only include for target-specific objects.
> This is a problem for target-agnostic objects as CONFIG_XEN is never
> defined and xen_enabled() is always inlined as 'false'.
>=20
> Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
> when we don't know to force the call of the non-inlined function,
> returning the xen_allowed boolean.
>=20
> Fixes: da278d58a092 ("accel: Move Xen accelerator code under =
accel/xen/")
> Reported-by: Paul Durrant <pdurrant@amazon.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/sysemu/xen.h   | 18 ++++++++++++++----
>  accel/stubs/xen-stub.c |  2 ++
>  accel/xen/xen-all.c    |  7 +------
>  3 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index 1ca292715e..2c2c429ea8 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -8,9 +8,19 @@
>  #ifndef SYSEMU_XEN_H
>  #define SYSEMU_XEN_H
>=20
> -#ifdef CONFIG_XEN
> +#ifdef NEED_CPU_H
> +# ifdef CONFIG_XEN
> +#  define CONFIG_XEN_IS_POSSIBLE
> +# endif
> +#else
> +# define CONFIG_XEN_IS_POSSIBLE
> +#endif
>=20
> -bool xen_enabled(void);
> +#ifdef CONFIG_XEN_IS_POSSIBLE
> +
> +extern bool xen_allowed;
> +
> +#define xen_enabled()           (xen_allowed)

Can this not move ahead of the #ifdef now (since xen_allowed is present =
in both xen-stub and xen-all)? I think this is what Peter was saying in =
his option '(2)'.

  Paul

>=20
>  #ifndef CONFIG_USER_ONLY
>  void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> @@ -18,7 +28,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t =
size,
>                     struct MemoryRegion *mr, Error **errp);
>  #endif
>=20
> -#else /* !CONFIG_XEN */
> +#else /* !CONFIG_XEN_IS_POSSIBLE */
>=20
>  #define xen_enabled() 0
>  #ifndef CONFIG_USER_ONLY
> @@ -33,6 +43,6 @@ static inline void xen_ram_alloc(ram_addr_t =
ram_addr, ram_addr_t size,
>  }
>  #endif
>=20
> -#endif /* CONFIG_XEN */
> +#endif /* CONFIG_XEN_IS_POSSIBLE */
>=20
>  #endif
> diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
> index dcca4e678a..8ae658acff 100644
> --- a/accel/stubs/xen-stub.c
> +++ b/accel/stubs/xen-stub.c
> @@ -9,6 +9,8 @@
>  #include "hw/xen/xen.h"
>  #include "qapi/qapi-commands-misc.h"
>=20
> +bool xen_allowed;
> +
>  void xenstore_store_pv_console_info(int i, Chardev *chr)
>  {
>  }
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 0c24d4b191..60b971d0a8 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -32,12 +32,7 @@
>      do { } while (0)
>  #endif
>=20
> -static bool xen_allowed;
> -
> -bool xen_enabled(void)
> -{
> -    return xen_allowed;
> -}
> +bool xen_allowed;
>=20
>  xc_interface *xen_xc;
>  xenforeignmemory_handle *xen_fmem;
> --
> 2.21.3



