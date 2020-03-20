Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F7C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A360720739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnJnP7Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A360720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFD5j-0004hZ-Oq
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jFD57-0004Ho-No
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jFD56-0006Qy-PJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:32:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jFD56-0006Ph-LH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584693160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJXnp7ZFksmazHO3/JnHiidMV/XdD4OGlVXg5lrj0Ow=;
 b=TnJnP7SvxfPR16JDFFLUyC8mM5X081Is2uE2j/S/oQVDhLUS9YdcTm7ZiFHj1v7sZF8VB/
 ++zYTfPTy0V4o0zJFBL/ENRCApyZkUV82ApK9lFTTsyxfi7dHJwb9luppsMmUbrJUBDCMf
 9V0/YfO9YDskTa8/ciB23AZ9zfcSDXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-T76IkzwEOKuO0_RQ7uNHXQ-1; Fri, 20 Mar 2020 04:32:38 -0400
X-MC-Unique: T76IkzwEOKuO0_RQ7uNHXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11584107ACC4;
 Fri, 20 Mar 2020 08:32:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F10F36269F;
 Fri, 20 Mar 2020 08:32:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC4069DB3; Fri, 20 Mar 2020 09:32:27 +0100 (CET)
Date: Fri, 20 Mar 2020 09:32:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200320083227.6fnqrchjoii6hhli@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
 <20200319134046.uh2qvyshwtj6ubox@sirius.home.kraxel.org>
 <259fbf57-6d1f-e3cd-d455-d2e6bc4e8b38@redhat.com>
MIME-Version: 1.0
In-Reply-To: <259fbf57-6d1f-e3cd-d455-d2e6bc4e8b38@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 06:34:40PM +0100, Paolo Bonzini wrote:
> On 19/03/20 14:40, Gerd Hoffmann wrote:
> >> Also, can you confirm that it builds without CONFIG_I440FX and
> >> CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
> >> '#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.
> > Hmm, is there some way to do this without modifying
> > default-configs/i386-softmmu.mak in the source tree?  So I can have two
> > build trees with different confugurations?  Also to reduce the risk tha=
t
> > I commit default-config changes by mistake?
>=20
> No, there is no way yet.

Hmm, seems we should have that for better regression testing.
master branch doesn't build with pc+q35+isapc turned off:

  LINK    x86_64-softmmu/qemu-system-x86_64
hw/virtio/virtio-iommu.o: In function `virtio_iommu_get_bdf':
/home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:66: undefined reference=
 to `pci_bus_num'
hw/virtio/virtio-iommu.o: In function `iommu_find_iommu_pcibus':
/home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:84: undefined reference=
 to `pci_bus_num'
hw/virtio/virtio-iommu.o: In function `virtio_iommu_device_realize':
/home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:685: undefined referenc=
e to `pci_setup_iommu'
collect2: error: ld returned 1 exit status

[ adding Eric Auger to Cc: ]

cheers,
  Gerd


