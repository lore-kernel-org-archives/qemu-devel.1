Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B777C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51E420673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51E420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKdl-0003dr-TU
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCKd2-0003FC-Ix
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCKd0-0002It-Ah
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCKd0-0002IY-3E
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:27:30 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9D92883D7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:27:28 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so4608526wre.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Ua4U/U+FHij3vOY2LNNDQg4FMRZt4szrIMF4aMMhUA=;
 b=QWhl9JahwNcOgiwyFGvKimAcNsuUJ3ZvcCUzbhXkVWlOBq6EgJKgkdeu87/9Izf40t
 wOrliZwfq/fQVjJRIMlteSaZ/LX3AWxP4ronEku6Ct+o5p1bRr3r1Nr4AYBATYsMk+Mv
 wkdqAYXe+ioEvO8RVyBV9/WnpGNkXld7Hwhlh/aEE+Zu7nLnI+zZPIEagq99RE/Oxn7o
 jMhpznVwUnqXBCIXtdA/GyqSJWf0i9+mARQuLgR7XHJKTGk7KmDuSEV2HdnzUCiNtmjC
 H4I4BZqCTap0k/p1yLyWbMrm+NV+RuejnAdEuPD7emcXhdcgSkv/uIWbXmJnh2My9C/a
 6xQg==
X-Gm-Message-State: APjAAAU4QVcQKcwBqIG1nb6NL2Bdhx7+JJvoCbSLXxnR5BjxogsLcYa9
 xK3C1jaarlIVLeIeAxoaMQVnclToTu7xiJ8r3gYGer1BKh3Cj+pbenFlvRywdAimnRRtooNgKmD
 cAyXFvAAzogr1sjo=
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr13744581wmd.100.1569230847023; 
 Mon, 23 Sep 2019 02:27:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrJ1Lr6tRtZhMlLeEjHkrKqsvpErDPDVk6QtX9XGrN1RRQOomS+D0RwvbIjPBXoNoMObIoqQ==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr13744517wmd.100.1569230845849; 
 Mon, 23 Sep 2019 02:27:25 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s12sm16634850wra.82.2019.09.23.02.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:27:25 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47985091-499d-fff4-aba4-97be997a38a6@redhat.com>
Date: Mon, 23 Sep 2019 11:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-10-richard.henderson@linaro.org>
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
> Add a function parameter to perform the actual load/store to ram.
> With optimization, this results in identical code.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 159 +++++++++++++++++++++++----------------------
>  1 file changed, 83 insertions(+), 76 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2222b87764..b4a63d3928 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1280,11 +1280,38 @@ static void *atomic_mmu_lookup(CPUArchState *en=
v, target_ulong addr,
> =20
>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>                                  TCGMemOpIdx oi, uintptr_t retaddr);
> +typedef uint64_t LoadHelper(const void *);
> +
> +/* Wrap the unaligned load helpers to that they have a common signatur=
e.  */
> +static inline uint64_t wrap_ldub(const void *haddr)
> +{
> +    return ldub_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_be(const void *haddr)
> +{
> +    return lduw_be_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_le(const void *haddr)
> +{
> +    return lduw_le_p(haddr);
> +}
> +
> +static inline uint64_t wrap_ldul_be(const void *haddr)
> +{
> +    return (uint32_t)ldl_be_p(haddr);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
> +static inline uint64_t wrap_ldul_le(const void *haddr)
> +{
> +    return (uint32_t)ldl_le_p(haddr);
> +}
> =20
>  static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
> -            FullLoadHelper *full_load)
> +            FullLoadHelper *full_load, LoadHelper *direct)
>  {
>      uintptr_t mmu_idx =3D get_mmuidx(oi);
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> @@ -1373,33 +1400,7 @@ load_helper(CPUArchState *env, target_ulong addr=
, TCGMemOpIdx oi,
> =20
>   do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        res =3D ldub_p(haddr);
> -        break;
> -    case MO_BEUW:
> -        res =3D lduw_be_p(haddr);
> -        break;
> -    case MO_LEUW:
> -        res =3D lduw_le_p(haddr);
> -        break;
> -    case MO_BEUL:
> -        res =3D (uint32_t)ldl_be_p(haddr);
> -        break;
> -    case MO_LEUL:
> -        res =3D (uint32_t)ldl_le_p(haddr);
> -        break;
> -    case MO_BEQ:
> -        res =3D ldq_be_p(haddr);
> -        break;
> -    case MO_LEQ:
> -        res =3D ldq_le_p(haddr);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    return res;
> +    return direct(haddr);
>  }
> =20
>  /*
> @@ -1415,7 +1416,8 @@ load_helper(CPUArchState *env, target_ulong addr,=
 TCGMemOpIdx oi,
>  static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
>                                TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub=
_mmu);
> +    return load_helper(env, addr, oi, retaddr, MO_UB, false,
> +                       full_ldub_mmu, wrap_ldub);
>  }
> =20
>  tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong a=
ddr,
> @@ -1428,7 +1430,7 @@ static uint64_t full_le_lduw_mmu(CPUArchState *en=
v, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
> -                       full_le_lduw_mmu);
> +                       full_le_lduw_mmu, wrap_lduw_le);
>  }
> =20
>  tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong ad=
dr,
> @@ -1441,7 +1443,7 @@ static uint64_t full_be_lduw_mmu(CPUArchState *en=
v, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
> -                       full_be_lduw_mmu);
> +                       full_be_lduw_mmu, wrap_lduw_be);
>  }
> =20
>  tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong ad=
dr,
> @@ -1454,7 +1456,7 @@ static uint64_t full_le_ldul_mmu(CPUArchState *en=
v, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
> -                       full_le_ldul_mmu);
> +                       full_le_ldul_mmu, wrap_ldul_le);
>  }
> =20
>  tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong ad=
dr,
> @@ -1467,7 +1469,7 @@ static uint64_t full_be_ldul_mmu(CPUArchState *en=
v, target_ulong addr,
>                                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
> -                       full_be_ldul_mmu);
> +                       full_be_ldul_mmu, wrap_ldul_be);
>  }
> =20
>  tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong ad=
dr,
> @@ -1480,14 +1482,14 @@ uint64_t helper_le_ldq_mmu(CPUArchState *env, t=
arget_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
> -                       helper_le_ldq_mmu);
> +                       helper_le_ldq_mmu, ldq_le_p);
>  }
> =20
>  uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
> -                       helper_be_ldq_mmu);
> +                       helper_be_ldq_mmu, ldq_be_p);
>  }
> =20
>  /*
> @@ -1530,9 +1532,38 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState=
 *env, target_ulong addr,
>   * Store Helpers
>   */
> =20
> +typedef void StoreHelper(void *, uint64_t);
> +
> +/* Wrap the unaligned store helpers to that they have a common signatu=
re.  */
> +static inline void wrap_stb(void *haddr, uint64_t val)
> +{
> +    stb_p(haddr, val);
> +}
> +
> +static inline void wrap_stw_be(void *haddr, uint64_t val)
> +{
> +    stw_be_p(haddr, val);
> +}
> +
> +static inline void wrap_stw_le(void *haddr, uint64_t val)
> +{
> +    stw_le_p(haddr, val);
> +}
> +
> +static inline void wrap_stl_be(void *haddr, uint64_t val)
> +{
> +    stl_be_p(haddr, val);
> +}
> +
> +static inline void wrap_stl_le(void *haddr, uint64_t val)
> +{
> +    stl_le_p(haddr, val);
> +}
> +
>  static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> -             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> +             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op,
> +             StoreHelper *direct)
>  {
>      uintptr_t mmu_idx =3D get_mmuidx(oi);
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> @@ -1657,74 +1688,49 @@ store_helper(CPUArchState *env, target_ulong ad=
dr, uint64_t val,
> =20
>   do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        stb_p(haddr, val);
> -        break;
> -    case MO_BEUW:
> -        stw_be_p(haddr, val);
> -        break;
> -    case MO_LEUW:
> -        stw_le_p(haddr, val);
> -        break;
> -    case MO_BEUL:
> -        stl_be_p(haddr, val);
> -        break;
> -    case MO_LEUL:
> -        stl_le_p(haddr, val);
> -        break;
> -    case MO_BEQ:
> -        stq_be_p(haddr, val);
> -        break;
> -    case MO_LEQ:
> -        stq_le_p(haddr, val);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -        break;
> -    }
> +    direct(haddr, val);
>  }
> =20
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t =
val,
>                          TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_UB);
> +    store_helper(env, addr, val, oi, retaddr, MO_UB, wrap_stb);
>  }
> =20
>  void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUW, wrap_stw_le);
>  }
> =20
>  void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUW, wrap_stw_be);
>  }
> =20
>  void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEUL, wrap_stl_le);
>  }
> =20
>  void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEUL, wrap_stl_be);
>  }
> =20
>  void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_LEQ);
> +    store_helper(env, addr, val, oi, retaddr, MO_LEQ, stq_le_p);
>  }
> =20
>  void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t =
val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, MO_BEQ);
> +    store_helper(env, addr, val, oi, retaddr, MO_BEQ, stq_be_p);
>  }
> =20
>  /* First set of helpers allows passing in of OI and RETADDR.  This mak=
es
> @@ -1789,7 +1795,8 @@ void helper_be_stq_mmu(CPUArchState *env, target_=
ulong addr, uint64_t val,
>  static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
>                                 TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_c=
mmu);
> +    return load_helper(env, addr, oi, retaddr, MO_8, true,
> +                       full_ldub_cmmu, wrap_ldub);
>  }
> =20
>  uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1802,7 +1809,7 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *e=
nv, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
> -                       full_le_lduw_cmmu);
> +                       full_le_lduw_cmmu, wrap_lduw_le);
>  }
> =20
>  uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1815,7 +1822,7 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *e=
nv, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
> -                       full_be_lduw_cmmu);
> +                       full_be_lduw_cmmu, wrap_lduw_be);
>  }
> =20
>  uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1828,7 +1835,7 @@ static uint64_t full_le_ldul_cmmu(CPUArchState *e=
nv, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
> -                       full_le_ldul_cmmu);
> +                       full_le_ldul_cmmu, wrap_ldul_le);
>  }
> =20
>  uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1841,7 +1848,7 @@ static uint64_t full_be_ldul_cmmu(CPUArchState *e=
nv, target_ulong addr,
>                                    TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
> -                       full_be_ldul_cmmu);
> +                       full_be_ldul_cmmu, wrap_ldul_be);
>  }
> =20
>  uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
> @@ -1854,12 +1861,12 @@ uint64_t helper_le_ldq_cmmu(CPUArchState *env, =
target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
> -                       helper_le_ldq_cmmu);
> +                       helper_le_ldq_cmmu, ldq_le_p);
>  }
> =20
>  uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
>                              TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
> -                       helper_be_ldq_cmmu);
> +                       helper_be_ldq_cmmu, ldq_be_p);
>  }
>=20

