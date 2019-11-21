Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8EC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEE220898
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvLf20CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEE220898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmU5-0002u1-08
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXmSz-0002Q1-4B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXmSx-0005XF-4r
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:25:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXmSx-0005W6-1D
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574342746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezJnzsFb2W0EyXEmDHJw+EoC1EaakzUfT7UT4k0791A=;
 b=TvLf20CLKP3oYmqA04KJr92qdFqbE5wGWH57Gq1+QFgx1gfTH7UQzeTo3zKAYuQufegId/
 kz8OkiFQldQDSvZoFSZ2wOM+8X7uxqsuMx7XSIT/ZDijRi5MZmK19aI91iB5cw404RjKas
 EPqGFH6TQ6/CmKYrN2ZhPqdjYuznCVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-e9fVOgQjNJOkEqfcwEaFzg-1; Thu, 21 Nov 2019 08:25:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE3AB18B635B;
 Thu, 21 Nov 2019 13:25:40 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E73D60C23;
 Thu, 21 Nov 2019 13:25:36 +0000 (UTC)
Date: Thu, 21 Nov 2019 14:25:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 05/15] s390x: protvirt: Sync PV state
Message-ID: <20191121142534.0ac78840.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-6-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: e9fVOgQjNJOkEqfcwEaFzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:24 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We do not always have the SIE intercept code handy at each place where
> we do emulation. Unfortunately emulation for secure guests often
> differ slightly from normal emulation and we need to make decisions
> based on the protected state of the VCPU.
>=20
> Let's sync the protected state and make it available.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 1 +
>  target/s390x/cpu.h           | 1 +
>  target/s390x/kvm.c           | 4 ++++
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 41976d33f0..7c46cf6078 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -231,6 +231,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_GSCB   (1UL << 9)
>  #define KVM_SYNC_BPBC   (1UL << 10)
>  #define KVM_SYNC_ETOKEN (1UL << 11)
> +#define KVM_SYNC_PV=09(1UL << 12)

That should go into the previous patch (will be picked up by header
sync).

>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 17460ed7b3..a787221772 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -116,6 +116,7 @@ struct CPUS390XState {
> =20
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> +    bool pv; /* protected virtualization */
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c24c869e77..418154ccfe 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -676,6 +676,10 @@ int kvm_arch_get_registers(CPUState *cs)
>          env->etoken_extension =3D cs->kvm_run->s.regs.etoken_extension;
>      }
> =20
> +    if (can_sync_regs(cs, KVM_SYNC_PV)) {
> +        env->pv =3D !!cs->kvm_run->s.regs.pv;
> +    }
> +
>      /* pfault parameters */
>      if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
>          env->pfault_token =3D cs->kvm_run->s.regs.pft;

As you add a new field to the cpu state... you probably can't migrate
protected guests, so you don't need a new vmstate subsection?


