Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E54C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7321820C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0YGFs+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7321820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKt8-0000yS-AX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGKsS-000081-FC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGKsP-0002xq-Iq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599737788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49H7U6LJbGnt6e693nebQ7+aRxoWnzJ6KmFbIoT1CKw=;
 b=X0YGFs+ZBENS8u1yH48p2jNu3/Cl0eXM1kZ6EF3PcmTM1G1ct0YogzwMB+QMYJM8KNaQA1
 RF2+oUFLwH6Ihj4omRJuY1k9nNCCdky9rgdtBoBcRIzI4+iDIE16gxYBmEioeM2ObYv5uo
 wCa2beR3rPALo8o6gfGWrGNoe7bQFbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-h5xfY9iHNuKG2eaqfXuq4w-1; Thu, 10 Sep 2020 07:36:27 -0400
X-MC-Unique: h5xfY9iHNuKG2eaqfXuq4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E0DE801AEA;
 Thu, 10 Sep 2020 11:36:25 +0000 (UTC)
Received: from gondolin (ovpn-112-89.ams2.redhat.com [10.36.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C61827E8EC;
 Thu, 10 Sep 2020 11:36:11 +0000 (UTC)
Date: Thu, 10 Sep 2020 13:36:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200910133609.4ac88c25.cohuck@redhat.com>
In-Reply-To: <20200907172253.0a51f5f7.pasic@linux.ibm.com>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <20200907172253.0a51f5f7.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 ehabkost@redhat.com, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Sep 2020 17:22:53 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 24 Jul 2020 12:57:44 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > At least some s390 cpu models support "Protected Virtualization" (PV),
> > a mechanism to protect guests from eavesdropping by a compromised
> > hypervisor.
> > 
> > This is similar in function to other mechanisms like AMD's SEV and
> > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > machine option.  s390 is a slightly special case, because we already
> > supported PV, simply by using a CPU model with the required feature
> > (S390_FEAT_UNPACK).
> > 
> > To integrate this with the option used by other platforms, we
> > implement the following compromise:
> > 
> >  - When the host-trust-limitation option is set, s390 will recognize
> >    it, verify that the CPU can support PV (failing if not) and set
> >    virtio default options necessary for encrypted or protected guests,
> >    as on other platforms.  i.e. if host-trust-limitation is set, we
> >    will either create a guest capable of entering PV mode, or fail
> >    outright  
> 
> Shouldn't we also fail outright if the virtio features are not PV
> compatible (invalid configuration)?
> 
> I would like to see something like follows as a part of this series.
> ----------------------------8<--------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Mon, 7 Sep 2020 15:00:17 +0200
> Subject: [PATCH] virtio: handle host trust limitation
> 
> If host_trust_limitation_enabled() returns true, then emulated virtio
> devices must offer VIRTIO_F_ACCESS_PLATFORM, because the device is not
> capable of accessing all of the guest memory. Otherwise we are in
> violation of the virtio specification.
> 
> Let's fail realize if we detect that VIRTIO_F_ACCESS_PLATFORM feature is
> obligatory but missing.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/virtio/virtio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5bd2a2f621..19b4b0a37a 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -27,6 +27,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/runstate.h"
> +#include "exec/host-trust-limitation.h"
>  
>  /*
>   * The alignment to use between consumer and producer parts of vring.
> @@ -3618,6 +3619,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>      /* Devices should either use vmsd or the load/save methods */
>      assert(!vdc->vmsd || !vdc->load);
>  
> +    if (host_trust_limitation_enabled(MACHINE(qdev_get_machine()))
> +        && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> +        error_setg(&err, "devices without VIRTIO_F_ACCESS_PLATFORM are not compatible with host trust imitation");
> +        error_propagate(errp, err);
> +        return;

How can we get here? I assume only if the user explicitly turned the
feature off while turning HTL on, as otherwise patch 9 should have
taken care of it?

> +    }
>      if (vdc->realize != NULL) {
>          vdc->realize(dev, &err);
>          if (err != NULL) {


