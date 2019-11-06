Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED5C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831E5217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpVZAEuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831E5217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPXp-0005LW-Kx
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iSPWs-0004LI-80
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iSPWr-0006y8-54
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:55:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iSPWr-0006wL-1O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573062936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/sQyRgFw+9/RcW7NfVajRFE3P8eOjZF/FPFFSHK0fE=;
 b=MpVZAEuQsiY/getVPNGCHxMtW/yTEtJKQkYoihm3x7zKF8XqmQoxsZdY3FSlCKPi+QnInT
 aB1ZuuB2fSBeNjZHyToqxor0yxAEOLa4D1qtDX1s0BpcY/3AxQhvKe8yVNpghJBv6/7HEI
 SMC9H66uequTqZaE/ust4bLqQgD05uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-4s9pU-fJMAS0NcmNh66v8g-1; Wed, 06 Nov 2019 12:55:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4860E1005500;
 Wed,  6 Nov 2019 17:55:31 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5DF85C240;
 Wed,  6 Nov 2019 17:55:26 +0000 (UTC)
Date: Wed, 6 Nov 2019 18:55:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [RFC v2 11/14] linux-headers/kvm.h: add capability to forward
 hypercall
Message-ID: <20191106185524.0fe51c50.cohuck@redhat.com>
In-Reply-To: <20191105091056.9541-12-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-12-guoheyi@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4s9pU-fJMAS0NcmNh66v8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 17:10:53 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> To keep backward compatibility, we add new KVM capability
> "KVM_CAP_FORWARD_HYPERCALL" to probe whether KVM supports forwarding
> hypercall to userspace.
>=20
> The capability should be enabled explicitly, for we don't want user
> space application to deal with unexpected hypercall exits. After
> enabling this cap, all HVC calls unhandled by kvm will be forwarded to
> user space.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> ---
>  linux-headers/linux/kvm.h |  1 +
>  target/arm/sdei.c         | 16 ++++++++++++++++
>  target/arm/sdei.h         |  2 ++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 3d9b18f7f8..36c9b3859f 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PMU_EVENT_FILTER 173
>  #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
>  #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
> +#define KVM_CAP_FORWARD_HYPERCALL 176
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING

Is this cap upstream already? I would have thought your header sync
would have brought it in, then. (Saying this, that header sync looks
awfully small.)

If it is not upstream yet, please split off this hunk into a separate
patch -- it's a bit annoying, but makes life easier for merging.


