Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E79207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E79207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJmn-0004Ng-1X
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBJjI-0000f0-DX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBJjG-00072N-Qr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:17:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBJjE-000713-OQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:17:46 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14EB881F0D
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:17:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b6so2363010wrx.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M+Olj4paE8U3OqyeMc7yScWhXmf0T+EZnBZnBnpFgqo=;
 b=iz//mJWzMuU3X0nDXI/2WlQOfxxsxiN1lz7UqLfV6nAKPHWDNlElqpOGhw0ggWHjL9
 HjAtFGWxO3H48h3uIOCOYOsYousGU6wwkeolqj0xdY2nYjBK+whmpV4uZHxEZufdvFSx
 Y+/ZTXB9BpFHUsOujJyuzq6RSp+Y+kFZkTPUXcf1S49jlbRtd20CiHKooQ09piWYwhuh
 lvm+f6JiX4GvxGpWInSYPX1j3btuk2xKQuOD68+7APJOsuImsjFNAVfI+ZJ1oPnc8Ngu
 WrNR2HN8up4LhBkHNbsWROtdpFTSfsCRJ0P5nhMdxXhs1a0i9zXXBOjDkCHHASqdi72v
 +VRg==
X-Gm-Message-State: APjAAAUy58FxzOHp+daslMWTSiZOuU1uRTtH4Nj7+bFfvO0RyPGi1TB6
 74+i/hYRKnYO7eNbNYIRE60HFFO6ej2MpXGpRHjqSmrRFLHvIrr746TlYnLj0OhpOFW49LQtxkC
 PijmunXjret4wHJk=
X-Received: by 2002:a05:6000:82:: with SMTP id
 m2mr12764690wrx.241.1568989060688; 
 Fri, 20 Sep 2019 07:17:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWeR7ZKQeheuuhKleYPJIkoRA2qaKnJ+Wrp2t6wXfV+Vw/aGqTuzbUgzQA0u+yScuZ+h4E6A==
X-Received: by 2002:a05:6000:82:: with SMTP id
 m2mr12764666wrx.241.1568989060385; 
 Fri, 20 Sep 2019 07:17:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id o22sm3094863wra.96.2019.09.20.07.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 07:17:39 -0700 (PDT)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190920141248.12887-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <deb6f913-7d80-dacc-4fa4-07c848343e0c@redhat.com>
Date: Fri, 20 Sep 2019 16:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920141248.12887-1-philmd@redhat.com>
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/19 16:12, Philippe Mathieu-Daud=C3=A9 wrote:
> Now that the unassigned_access CPU hooks have been removed,
> the unassigned_mem_read/write functions are only used for
> debugging purpose.
> Simplify by converting them to in-place trace events.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html
>=20
> I first wrote:
>=20
>   These functions are declared using the CPUReadMemoryFunc/
>   CPUWriteMemoryFunc prototypes. Since it is confusing to
>   have such prototype only use for debugging, convert them
>   to in-place trace events.
>=20
> But it doesn't provide helpful information and is rather confusing.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I think it's simplest if all series (RISC-V, remove unassigned_access,
this one) go through the RISC-V tree.

Paolo

> ---
>  memory.c     | 24 +++---------------------
>  trace-events |  2 ++
>  2 files changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index 93a05395cf..07e80a637a 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -35,8 +35,6 @@
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
> =20
> -//#define DEBUG_UNASSIGNED
> -
>  static unsigned memory_region_transaction_depth;
>  static bool memory_region_update_pending;
>  static bool ioeventfd_update_pending;
> @@ -1272,23 +1270,6 @@ static void iommu_memory_region_initfn(Object *o=
bj)
>      mr->is_iommu =3D true;
>  }
> =20
> -static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
> -                                    unsigned size)
> -{
> -#ifdef DEBUG_UNASSIGNED
> -    printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
> -#endif
> -    return 0;
> -}
> -
> -static void unassigned_mem_write(void *opaque, hwaddr addr,
> -                                 uint64_t val, unsigned size)
> -{
> -#ifdef DEBUG_UNASSIGNED
> -    printf("Unassigned mem write " TARGET_FMT_plx " =3D 0x%"PRIx64"\n"=
, addr, val);
> -#endif
> -}
> -
>  static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
>                                     unsigned size, bool is_write,
>                                     MemTxAttrs attrs)
> @@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(MemoryReg=
ion *mr,
>      MemTxResult r;
> =20
>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
> -        *pval =3D unassigned_mem_read(mr, addr, size);
> +        trace_memory_region_invalid_read(size, addr);
> +        *pval =3D 0; /* FIXME now this value shouldn't be accessed in =
guest */
>          return MEMTX_DECODE_ERROR;
>      }
> =20
> @@ -1481,7 +1463,7 @@ MemTxResult memory_region_dispatch_write(MemoryRe=
gion *mr,
>      unsigned size =3D memop_size(op);
> =20
>      if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
> -        unassigned_mem_write(mr, addr, data, size);
> +        trace_memory_region_invalid_write(size, addr, size << 1, data)=
;
>          return MEMTX_DECODE_ERROR;
>      }
> =20
> diff --git a/trace-events b/trace-events
> index 823a4ae64e..83dbeb4b46 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, u=
int64_t value, unsigned siz
>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, u=
nsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, =
uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"P=
RIx64" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr,=
 uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"=
PRIx64" size %u"
> +memory_region_invalid_read(unsigned size, uint64_t addr) "invalid read=
 size %u addr 0x%"PRIx64
> +memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_widt=
h, uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*"PR=
Ix64
>  flatview_new(void *view, void *root) "%p (root %p)"
>  flatview_destroy(void *view, void *root) "%p (root %p)"
>  flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
>=20


