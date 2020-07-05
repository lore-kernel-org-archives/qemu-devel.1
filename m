Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A858C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483D620720
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YDqgHOls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483D620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9D8-0002zo-DS
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>) id 1js99O-00027c-89
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:14:02 -0400
Received: from mout.web.de ([212.227.15.4]:51367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>) id 1js99L-0002Uk-PZ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593972833;
 bh=i5ZF77LVkPyx2p971BzRknEGkCUrnCoKdbrEJ8v2r8I=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=YDqgHOlspWGqXa775TtexF8WV1V7aX+YLAcjQvLEabGkvIoGnVuo74cV4JeS7jgfN
 qiz9c9qmcgk4j8w6uv6tCbd9QM+Z/f7t0e825ey6kXY9/zp3tlSlmN2NsXyovWqCJq
 QjcwRJH81vQSUzN//6mp8kPWt61SgcnKU7SKT7+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.196] ([92.210.73.173]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKaHP-1jsylK1BzT-001wr8; Sun, 05
 Jul 2020 20:13:53 +0200
Subject: Re: [PATCH v2] apic: Report current_count via 'info lapic'
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
References: <e00e2896-ca5b-a929-de7a-8e5762f0c1c2@siemens.com>
Message-ID: <ca8656e4-5f1d-7b41-7020-482fb2e2fe4e@web.de>
Date: Sun, 5 Jul 2020 20:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e00e2896-ca5b-a929-de7a-8e5762f0c1c2@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gqs/2Rqc6l1yr/YqfEqmbc8tDa7F5X5ToTV3I5G7cJTxwM9CG2S
 QVRW8tG4ZkeKaKc5hs3n+Rn6t0nonhbx5QGNRlIglEpQ9KQ/rUG4zD1fDCDGtmGuiuMSFMF
 AIGoeUvp6l6ot8PbUCETTMG8KA2og4+Vy+myNUkZwCe3c+BnWAJ7ywfchjxq1e17oonQKJk
 1/oBZr9faCzgeVf8Z3GwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ghA0quksZVQ=:+JLEJaOmvKJ/kFQy6l60UJ
 SqcL/AnDpw3gqviO7E2+IH0m0DRux23QGRrcECZ65h/fqQ2xdbcpRi4KJRj+C8UAQFsJ5ffCY
 t8hnTmYadOeQ4Ply+FXmaTCz5QZbXq7N1HlqOTB1w/O4HmRwOxfqygLtHRpq/4E5Be7VGTZXo
 3E3NTIzqrBheGmUGHBP8KM0c4cmElLouq599dfwbmFcbrUnODUIiMf7RXQIcoPVcAgvSmyNa4
 PBwcdI1I7I92iTSyqaBqrS29F71EOJqSA+388CE4qhHviMCVZPh1ms2B897j8VZKsVSPR47Z9
 iEtmA3LedG0noFGLo75Jeh0m/6pLWhh1ugFltFIA0oKZSqoGbivXIFgdqqbzY4jE3ZYSeGsln
 4SRD3K9luFqEQLHu4dqMcBxv5xYmOO9eJeBUibOo6Dvl2vEONJyy7PVEP7+9C7C9TG2htN5xQ
 zDqhZWLssXMF+48PhDZgzNGHeV0ShKS0mbrV8nnY49G21QCCxHJmvSHKTds/fr/6r7g4d2UtA
 2SF159+UT01QdZBeyi8vwi/fqEV2IqnbdjvOGKaa5Mv2A9JKaCDcd1DiMZRcyRtQvGqNBiHo8
 SNi2d3XFPBU0krI7zvHLQafbhcoujy3P9QX/ExJfE3yo7m+8Vyitjtwv+CEgGaVGMso9CHJIE
 bLabUhAq2PMQh+NM/sHomiw3bWKBIUbM1jVuJxK8bNgshnz6Hsgi5SixpoQx31eJrqNXKdUOg
 KEzcxyEPZuq66Tf3pXxPutoEcRGU/22s4YvuX2PPtP04S6Ig/cmdc+20kkgW+DxJT4ZdHa/57
 Sqce39zuPnYGcL+PRoRVohSynyuOCDx9anjWSUf5iEXvCkKzqj63R0fYVxLVe6Ca4gOQUNB8I
 tv51BNrlRh84Cu/vhbmmceEddE7bd6otSyft4VID3cfJnGHiTh2T2iI8dtYuDZ+u77r/eysME
 2RvcUzM93E3ozC2CiGxmsWZVGFVfESfrbxXSKUeIaBbjlaV7AGhqywtb9gA9w/m1Knq7upv9X
 gbDLg23TpIzAwF+DoYyEcB6yTKcwE25HpcclsfPX1JgtQ69p7DpP0mFtwyJoaJ+Png2QR4mq0
 ZHCOggDl+EytW/ezDxWYdTktW4G6LvjvlZByZcOZcR9SIoHsKxtV1/uanlVME9VjWIyI27U7Z
 ChsrrO4Kx1mCFVeE6e9RUwUNcqvo+DzhbVVDBIKt4M18bJgCugr7GzP8QM2+16jrYVqHUWB8D
 omYeAWsOoY+PONVF1fEh2RRYCfY39OxWtnHPPjA==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 14:13:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.02.20 07:43, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This is helpful when debugging stuck guest timers.
>
> As we need apic_get_current_count for that, and it is really not
> emulation specific, move it to apic_common.c and export it. Fix its
> style at this chance as well.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>
> Changes in v2:
>   - fix style of apic_get_current_count
>
>   hw/intc/apic.c                  | 18 ------------------
>   hw/intc/apic_common.c           | 19 +++++++++++++++++++
>   include/hw/i386/apic_internal.h |  1 +
>   target/i386/helper.c            |  5 +++--
>   4 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index bd40467965..f2207d0ace 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -615,24 +615,6 @@ int apic_accept_pic_intr(DeviceState *dev)
>       return 0;
>   }
>
> -static uint32_t apic_get_current_count(APICCommonState *s)
> -{
> -    int64_t d;
> -    uint32_t val;
> -    d =3D (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_loa=
d_time) >>
> -        s->count_shift;
> -    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> -        /* periodic */
> -        val =3D s->initial_count - (d % ((uint64_t)s->initial_count + 1=
));
> -    } else {
> -        if (d >=3D s->initial_count)
> -            val =3D 0;
> -        else
> -            val =3D s->initial_count - d;
> -    }
> -    return val;
> -}
> -
>   static void apic_timer_update(APICCommonState *s, int64_t current_time=
)
>   {
>       if (apic_next_timer(s, current_time)) {
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 9ec0f2deb2..fb432e83f2 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -189,6 +189,25 @@ bool apic_next_timer(APICCommonState *s, int64_t cu=
rrent_time)
>       return true;
>   }
>
> +uint32_t apic_get_current_count(APICCommonState *s)
> +{
> +    int64_t d;
> +    uint32_t val;
> +    d =3D (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_loa=
d_time) >>
> +        s->count_shift;
> +    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> +        /* periodic */
> +        val =3D s->initial_count - (d % ((uint64_t)s->initial_count + 1=
));
> +    } else {
> +        if (d >=3D s->initial_count) {
> +            val =3D 0;
> +        } else {
> +            val =3D s->initial_count - d;
> +        }
> +    }
> +    return val;
> +}
> +
>   void apic_init_reset(DeviceState *dev)
>   {
>       APICCommonState *s;
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inte=
rnal.h
> index b04bdd947f..2597000e03 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -211,6 +211,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUSt=
ate *cpu, target_ulong ip,
>                                TPRAccess access);
>
>   int apic_get_ppr(APICCommonState *s);
> +uint32_t apic_get_current_count(APICCommonState *s);
>
>   static inline void apic_set_bit(uint32_t *tab, int index)
>   {
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c3a6e4fabe..e3c3726c29 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -370,10 +370,11 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, i=
nt flags)
>       dump_apic_lvt("LVTTHMR", lvt[APIC_LVT_THERMAL], false);
>       dump_apic_lvt("LVTT", lvt[APIC_LVT_TIMER], true);
>
> -    qemu_printf("Timer\t DCR=3D0x%x (divide by %u) initial_count =3D %u=
\n",
> +    qemu_printf("Timer\t DCR=3D0x%x (divide by %u) initial_count =3D %u=
"
> +                " current_count =3D %u\n",
>                   s->divide_conf & APIC_DCR_MASK,
>                   divider_conf(s->divide_conf),
> -                s->initial_count);
> +                s->initial_count, apic_get_current_count(s));
>
>       qemu_printf("SPIV\t 0x%08x APIC %s, focus=3D%s, spurious vec %u\n"=
,
>                   s->spurious_vec,
>

Ping.

Jan

