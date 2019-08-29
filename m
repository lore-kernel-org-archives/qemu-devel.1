Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324BC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572DB2189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572DB2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3O78-0005zD-D7
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3O6O-0005X5-Uk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3O6N-00081Z-Da
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3O6N-0007zl-09
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:20:51 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7C2E3B738
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 17:20:49 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j10so2430137wrb.16
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRBZ3j2RI5D5bXWoXNrHk/Z2JGviGl2zXOBeibQPK6k=;
 b=ibt1qFrdoKl89ph7BqzMzVSWbtlbG4B9iUsRkqcSTVen1PQpR9JyKbfxRsce6f7tqc
 DiApuGpO3Y7n1OLqHLwcdK1Jup5d7dILvQRQ2ooSLP5+AcejSZP8kRMFxnoA47UelYOE
 NPBKby+1VYZEI0mFXQiCISszyOlokJj2R6bHKRNdHVXLelA7B2ddtu2hN53SycT6moA3
 9psF9mr2a7MWnrpH5w2/2tGFCpigHFcJBqHxaeWRR6upOZewDKTOShxbcQjNa6dACazM
 vpjPzWZP+QippCrAJ8qJ5/fwz5zgA5dxAbJUnnmdri3jRVNChDHAF6WKSpeABi3kFZ/z
 STRA==
X-Gm-Message-State: APjAAAUr3Dr9+PnFfBbZtdoX6xwwkpuFq3pZcxnRjGKhwpt57CAPZPlZ
 CRaxyLyFMypMz/G7Dsxk1ts+Dp6cZ7D1rdiGtpbYok4sQ7fAiUdhBcDnI4YCdyMLEQOILAaIEoS
 bi5N3e7wkQJ0nyEU=
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr10761212wrx.192.1567099248577; 
 Thu, 29 Aug 2019 10:20:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFp7rHqe1shogijOMbrzzR/Jbc3p8of0piDh+S417nsuS/RlAwRFGByVnKcDIpAg9xsA9aTw==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr10761187wrx.192.1567099248347; 
 Thu, 29 Aug 2019 10:20:48 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id q13sm4203952wmq.30.2019.08.29.10.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:20:47 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dc2d396f-d1ac-1c45-0bf8-16acc7421647@redhat.com>
Date: Thu, 29 Aug 2019 19:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/8] exec: Factor out
 cpu_watchpoint_address_matches
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 1:16 AM, Richard Henderson wrote:
> We want to move the check for watchpoints from
> memory_region_section_get_iotlb to tlb_set_page_with_attrs.
> Isolate the loop over watchpoints to an exported function.
>=20
> Rename the existing cpu_watchpoint_address_matches to
> watchpoint_address_matches, since it doesn't actually
> have a cpu argument.
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h |  7 +++++++
>  exec.c                | 45 ++++++++++++++++++++++++++++---------------
>  2 files changed, 36 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 7bd8bed5b2..c7cda65c66 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1096,6 +1096,12 @@ static inline void cpu_check_watchpoint(CPUState=
 *cpu, vaddr addr, vaddr len,
>                                          MemTxAttrs atr, int fl, uintpt=
r_t ra)
>  {
>  }
> +
> +static inline int cpu_watchpoint_address_matches(CPUState *cpu,
> +                                                 vaddr addr, vaddr len=
)
> +{
> +    return 0;
> +}
>  #else
>  int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                            int flags, CPUWatchpoint **watchpoint);
> @@ -1105,6 +1111,7 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, =
CPUWatchpoint *watchpoint);
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra);
> +int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr le=
n);
>  #endif
> =20
>  /**
> diff --git a/exec.c b/exec.c
> index cb6f5763dc..8575ce51ad 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1138,9 +1138,8 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int=
 mask)
>   * partially or completely with the address range covered by the
>   * access).
>   */
> -static inline bool cpu_watchpoint_address_matches(CPUWatchpoint *wp,
> -                                                  vaddr addr,
> -                                                  vaddr len)
> +static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
> +                                              vaddr addr, vaddr len)
>  {
>      /* We know the lengths are non-zero, but a little caution is
>       * required to avoid errors in the case where the range ends
> @@ -1152,6 +1151,20 @@ static inline bool cpu_watchpoint_address_matche=
s(CPUWatchpoint *wp,
> =20
>      return !(addr > wpend || wp->vaddr > addrend);
>  }
> +
> +/* Return flags for watchpoints that match addr + prot.  */
> +int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr le=
n)
> +{
> +    CPUWatchpoint *wp;
> +    int ret =3D 0;
> +
> +    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> +        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
> +            ret |=3D wp->flags;
> +        }
> +    }
> +    return ret;
> +}
>  #endif /* !CONFIG_USER_ONLY */
> =20
>  /* Add a breakpoint.  */
> @@ -1459,7 +1472,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *=
cpu,
>                                         target_ulong *address)
>  {
>      hwaddr iotlb;
> -    CPUWatchpoint *wp;
> +    int flags, match;
> =20
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
> @@ -1477,17 +1490,17 @@ hwaddr memory_region_section_get_iotlb(CPUState=
 *cpu,
>          iotlb +=3D xlat;
>      }
> =20
> -    /* Make accesses to pages with watchpoints go via the
> -       watchpoint trap routines.  */
> -    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> -        if (cpu_watchpoint_address_matches(wp, vaddr, TARGET_PAGE_SIZE=
)) {
> -            /* Avoid trapping reads of pages with a write breakpoint. =
*/
> -            if ((prot & PAGE_WRITE) || (wp->flags & BP_MEM_READ)) {
> -                iotlb =3D PHYS_SECTION_WATCH + paddr;
> -                *address |=3D TLB_MMIO;
> -                break;
> -            }
> -        }
> +    /* Avoid trapping reads of pages with a write breakpoint. */
> +    match =3D (prot & PAGE_READ ? BP_MEM_READ : 0)
> +          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);

Isn't it cheaper to do here:

       if (!match) {
           return iotlb;
       }

or

       if (match) {

> +    flags =3D cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_S=
IZE);
> +    if (flags & match) {
> +        /*
> +         * Make accesses to pages with watchpoints go via the
> +         * watchpoint trap routines.
> +         */
> +        iotlb =3D PHYS_SECTION_WATCH + paddr;
> +        *address |=3D TLB_MMIO;
>      }

}

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>      return iotlb;
> @@ -2806,7 +2819,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr ad=
dr, vaddr len,
> =20
>      addr =3D cc->adjust_watchpoint_address(cpu, addr, len);
>      QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> -        if (cpu_watchpoint_address_matches(wp, addr, len)
> +        if (watchpoint_address_matches(wp, addr, len)
>              && (wp->flags & flags)) {
>              if (flags =3D=3D BP_MEM_READ) {
>                  wp->flags |=3D BP_WATCHPOINT_HIT_READ;
>=20

