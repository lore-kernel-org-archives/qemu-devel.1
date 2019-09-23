Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3716C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E6620640
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E6620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKWt-0000I3-TN
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCKUJ-0006wm-FO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCKUH-0006wW-Uw
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCKUH-0006u4-KM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:18:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 959CD883C2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:18:28 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s19so2284634wmj.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tBv/yNGIt3CmwdQ7oDAcOnZz2UqZBCb12AOfE+Bf88o=;
 b=U9PN23heo2oCBkjPyTX8pNICqvkoyjP//wgtvrHMpCBVUntwrNSi87/8jitc6GxK1r
 QgzuGY2brikP2LgZWKELuprYVfHXb5duRpuihvj1DPHIMaD8NZ99IhgFZZ7NWk+mM10+
 eS/9Wzuo6zI7aXM168VnXV6Vxcj9w9Dh3ZiWclLjnDzB6GN8Ilx3er8fm9H3EGYsBA6Z
 xdAUPe+t5+rAgGxcQTIx7WhEXPN9DpO72Ii4ccGrYVmoy8IwlHuosY6cwVRlD3gmt65s
 DKQubE05oi3oAh2qDpeM4Cvw6/TG9KDdR2AYSYhg8Mz3NU76TB5K3osV/3ReKIv6MlXA
 rZQw==
X-Gm-Message-State: APjAAAXqbN9Lg+jTwuMtenZVWxx+A3zhRv6OSbVBvJlzdjSNN5+/kiDP
 dQkm98LPZUawyAp/zne4uftkiOIcBYXdOoSclE/IVM79vHkEfwFs1WkineQE9T6WfQg5FG7uwUR
 nY3UM8SU2TbhbBDg=
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr11714161wmg.24.1569230307403; 
 Mon, 23 Sep 2019 02:18:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJpUDapZ1PhZphsks8WSe8vA0Xo82w4fhpjZ/ugiqPJbSVjzgl6d/qhALBPiIKzhvKQdC4Gg==
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr11714147wmg.24.1569230307219; 
 Mon, 23 Sep 2019 02:18:27 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n7sm11134339wrt.59.2019.09.23.02.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:18:26 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <203e5f5d-a914-e032-2001-e1aba4e48e4c@redhat.com>
Date: Mon, 23 Sep 2019 11:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/19 5:54 AM, Richard Henderson wrote:
> This forced inlining can result in missing symbols,
> which makes a debugging build harder to follow.
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/compiler.h | 11 +++++++++++
>  accel/tcg/cputlb.c      |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 09fc44cca4..d6d400c523 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -170,6 +170,17 @@
>  # define QEMU_NONSTRING
>  #endif
> =20
> +/*
> + * Forced inlining may be desired to encourage constant propagation
> + * of function parameters.  However, it can also make debugging harder=
,
> + * so disable it for a non-optimizing build.
> + */
> +#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
> +#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
> +#else
> +#define QEMU_ALWAYS_INLINE
> +#endif
> +
>  /* Implement C11 _Generic via GCC builtins.  Example:
>   *
>   *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index abae79650c..2222b87764 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env,=
 target_ulong addr,
>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>                                  TCGMemOpIdx oi, uintptr_t retaddr);
> =20
> -static inline uint64_t __attribute__((always_inline))
> +static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
>              FullLoadHelper *full_load)
> @@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState =
*env, target_ulong addr,
>   * Store Helpers
>   */
> =20
> -static inline void __attribute__((always_inline))
> +static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>               TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
>  {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

