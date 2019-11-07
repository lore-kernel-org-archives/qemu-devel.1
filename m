Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C1C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6623C2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu4MxBqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6623C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSggD-0005mR-Gl
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iSgeJ-0004Pm-KA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iSgeH-00083j-Tw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:12:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iSgeH-0007xK-HK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573128744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=It6V3UM/dbrCXbVlN6LCxs/ovMmz5vJ2AooEt0KlmFw=;
 b=Mu4MxBqePUiJwsI21ZdP6VPSR6aXbvIEKwcOwa9tVyuXYRFh5zgP2aZ3dVJUfwhl6rLE16
 sHia+wZvfxujwjH/NxfXbz6sTqN8ttfS7VL68T/Snw7FYdUuibp6untNIDMBDR7Mrj/tX1
 rcesQQ+YGIZluOMoEm1+YmOa0UAsBdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-IIwgu445NTusestkhKdMeg-1; Thu, 07 Nov 2019 07:12:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FBE107ACC3;
 Thu,  7 Nov 2019 12:12:19 +0000 (UTC)
Received: from gondolin (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A32A75D6D8;
 Thu,  7 Nov 2019 12:12:13 +0000 (UTC)
Date: Thu, 7 Nov 2019 13:12:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [RFC v2 11/14] linux-headers/kvm.h: add capability to forward
 hypercall
Message-ID: <20191107131210.26acf011.cohuck@redhat.com>
In-Reply-To: <da720295-2a84-e38b-9828-5287daefcfa2@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-12-guoheyi@huawei.com>
 <20191106185524.0fe51c50.cohuck@redhat.com>
 <4dbcbd18-0e6c-f985-c36d-96df65331d11@huawei.com>
 <20191107035624-mutt-send-email-mst@kernel.org>
 <da720295-2a84-e38b-9828-5287daefcfa2@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IIwgu445NTusestkhKdMeg-1
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 19:57:22 +0800
Guoheyi <guoheyi@huawei.com> wrote:

> On 2019/11/7 16:57, Michael S. Tsirkin wrote:
> > On Thu, Nov 07, 2019 at 09:44:36AM +0800, Guoheyi wrote: =20
> >>
> >> On 2019/11/7 1:55, Cornelia Huck wrote: =20
> >>> On Tue, 5 Nov 2019 17:10:53 +0800
> >>> Heyi Guo <guoheyi@huawei.com> wrote:
> >>> =20
> >>>> To keep backward compatibility, we add new KVM capability
> >>>> "KVM_CAP_FORWARD_HYPERCALL" to probe whether KVM supports forwarding
> >>>> hypercall to userspace.
> >>>>
> >>>> The capability should be enabled explicitly, for we don't want user
> >>>> space application to deal with unexpected hypercall exits. After
> >>>> enabling this cap, all HVC calls unhandled by kvm will be forwarded =
to
> >>>> user space.
> >>>>
> >>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >>>> Cc: Peter Maydell <peter.maydell@linaro.org>
> >>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>>> Cc: Cornelia Huck <cohuck@redhat.com>
> >>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>>> Cc: Dave Martin <Dave.Martin@arm.com>
> >>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: James Morse <james.morse@arm.com>
> >>>> ---
> >>>>    linux-headers/linux/kvm.h |  1 +
> >>>>    target/arm/sdei.c         | 16 ++++++++++++++++
> >>>>    target/arm/sdei.h         |  2 ++
> >>>>    3 files changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> >>>> index 3d9b18f7f8..36c9b3859f 100644
> >>>> --- a/linux-headers/linux/kvm.h
> >>>> +++ b/linux-headers/linux/kvm.h
> >>>> @@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
> >>>>    #define KVM_CAP_PMU_EVENT_FILTER 173
> >>>>    #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
> >>>>    #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
> >>>> +#define KVM_CAP_FORWARD_HYPERCALL 176
> >>>>    #ifdef KVM_CAP_IRQ_ROUTING =20
> >>> Is this cap upstream already? I would have thought your header sync
> >>> would have brought it in, then. (Saying this, that header sync looks
> >>> awfully small.)
> >>>
> >>> If it is not upstream yet, please split off this hunk into a separate
> >>> patch -- it's a bit annoying, but makes life easier for merging. =20
> >> No, it is not upstream yet. The whole framework and interfaces between=
 KVM
> >> and qemu are still under discussion. I'll keep in mind of this when mo=
ving
> >> forward to next steps...
> >>
> >> Thanks,
> >> HG =20
> > It's best to add it in some other place meanwhile. =20
> Do you mean to split this patch from the whole patch set and send it=20
> separately? Sorry I'm not clear about maintainers' work and may bring=20
> you some trouble...

My preferred approach:

- add a commit entitled "placeholder for headers update" that contains
  the not-yet-upstream changes in the header files you need
- base the rest of your work on that
...
<review happens, series looks good>
...
- if kernel changes are upstream: replace the placeholder patch with a
  real update (may include separate patches, if you need an additional
  header); maintainer merges
- if kernel changes are not yet upstream: maintainer merges with
  placeholder to a feature branch, replaces with real update and merges
  once kernel patches hit upstream
(not every maintainer does the second approach; they may ask you
instead to resend with a proper headers update once the kernel changes
are upstream)


