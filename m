Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D551C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486A12072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcAz0pZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486A12072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOKk-00088Q-Dl
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiOJe-0007Hl-3d
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiOJc-0000g3-GX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiOJc-0000bd-8T
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:00 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so10540785wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qbdqigT1d1Z4KSxjhHI1xXbeIqUWoxO0Gv6+zmbvBJc=;
 b=xcAz0pZi0V18+RMm96ls1GZ5g+f+GsvaNbTXVldEW4iDi73QZnBhDf0FV1Utzd3nqW
 99O2P/IiczdWc6VxmcaCwa2qE+iefP7achhI5TyhL7tox0Xrl1TaR9jKkCoOrVaixIgk
 k3CpF8pPPutD0pPODxA+a4aHrdnTcXFh8MQ97/QXhEj+c8Rn578qM4YJAYAkYDcfbZS/
 i5vhESGwgkMerlW+Qk5P4w9e47mc157yAfeGrUlX7YhKWTQlZHz4vR/uNLqusm+OtNG0
 9D6sUMDk73TGucJ5TPBJXsHaXtKwjmgr9PEezAQuOYodZeST8NAX5xlC1S4GAgLVuZCs
 CAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qbdqigT1d1Z4KSxjhHI1xXbeIqUWoxO0Gv6+zmbvBJc=;
 b=Y0RCTn6/7GNZArEp297Af92HspmwKxTiDo3JsvJAA+sakSB4kJ6uF65+MhT6v7O1AH
 O9Z2XW3GHPPSIuSU1kN4JGY6lQ8t4zr4oJ/SrVK1k2ntpTTgBkkp4fqEpip0i/+eOaQD
 jbtF1zGF+hyUFfKyynWkOeC/A7dtjvfnErgKM1KUUCuVXcbrSUGrF8Wpgf6q2OA+2Bp6
 2jfEfxsSmnulsw/7g+drt7HJBsv6YGwy0PdvEpCqMfv8ao5XzbO1DU0dS8Jn/g8E8l9A
 v9Fjsk1Uy8ZfycYT+JsPh8fp20BVKGsOaXFB/lQOFxSxpJyjIkiBIc9J2RzsOBYuS0hW
 Udig==
X-Gm-Message-State: APjAAAVONDsRMqyyTCk93pVrFXbOLX+3SHRsF9yPZu0On/XKj4DHW2tK
 ri3yi8z1Cb7yAe0bwcUUgmu97A==
X-Google-Smtp-Source: APXvYqxBXi72y8SjopyyRKEXiDQMyNz//rjweWWLzhZk9pFDDJyxHf0fkIrl2iuCB9NRy1DXYvKx4w==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr16553263wrm.278.1576871518840; 
 Fri, 20 Dec 2019 11:51:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x16sm11018528wmk.35.2019.12.20.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:51:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E072E1FF87;
 Fri, 20 Dec 2019 19:51:56 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-27-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 26/28] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
In-reply-to: <20191216221158.29572-27-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:51:56 +0000
Message-ID: <875ziabwrn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are only two uses.  Within dcbz_common, the local variable
> mmu_idx already contains the epid computation, and we can avoid
> repeating it for the store.  Within helper_icbiep, the usage is
> trivially expanded using PPC_TLB_EPID_LOAD.
>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu.h        |  2 --
>  target/ppc/mem_helper.c | 11 ++---------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e3e82327b7..3bd983adaa 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -951,8 +951,6 @@ struct ppc_radix_page_info {
>   * + real/paged mode combinations. The other two modes are for
>   * external PID load/store.
>   */
> -#define MMU_MODE8_SUFFIX _epl
> -#define MMU_MODE9_SUFFIX _eps
>  #define PPC_TLB_EPID_LOAD 8
>  #define PPC_TLB_EPID_STORE 9
>=20=20
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 1351b53f28..56855f2381 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulo=
ng addr,
>      } else {
>          /* Slow path */
>          for (i =3D 0; i < dcbz_size; i +=3D 8) {
> -            if (epid) {
> -#if !defined(CONFIG_USER_ONLY)
> -                /* Does not make sense on USER_ONLY config */
> -                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
> -#endif
> -            } else {
> -                cpu_stq_data_ra(env, addr + i, 0, retaddr);
> -            }
> +            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);

I assume the possibility of a user-mode with epid is elided in the
translation phase by avoiding gen_dcbzep although I can't quite see
where they get called from. Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>          }
>      }
>  }
> @@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong add=
r)
>  #if !defined(CONFIG_USER_ONLY)
>      /* See comments above */
>      addr &=3D ~(env->dcache_line_size - 1);
> -    cpu_ldl_epl_ra(env, addr, GETPC());
> +    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
>  #endif
>  }


--=20
Alex Benn=C3=A9e

