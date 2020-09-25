Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CBF207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmpgyupS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CBF207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkI3-00068Z-GO
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLkEN-0003I9-8f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLkEI-00030D-Fh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:41:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601026884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG3mT3mIsHXGo/NZ/lagLrVrCF3W5tB7wbo/eGmR8/8=;
 b=PmpgyupSu35N1SPu+dkogfunpTlIr1cwLyQLjxU46G7c9t8XDtKJOJro4kJyh0P5l+2qoS
 KhnPzN9sHVvnmBt9B4OFXj8tDJ2TpX8K4KTQnFUX1L4hEilIUaaWVFUIMUMBHOJS0vL61+
 lYgMA0e55MZUfqWYgkcsfUAyMtjgAwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-tQR-5GWWO-Cpe9fjmIx9og-1; Fri, 25 Sep 2020 05:41:22 -0400
X-MC-Unique: tQR-5GWWO-Cpe9fjmIx9og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95BA1186DD46;
 Fri, 25 Sep 2020 09:41:20 +0000 (UTC)
Received: from gondolin (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD8755786;
 Fri, 25 Sep 2020 09:41:08 +0000 (UTC)
Date: Fri, 25 Sep 2020 11:41:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH 4/7] s390x/pci: use a PCI Group structure
Message-ID: <20200925114105.439c1c7d.cohuck@redhat.com>
In-Reply-To: <1600529672-10243-5-git-send-email-mjrosato@linux.ibm.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529672-10243-5-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Sep 2020 11:34:29 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> We use a S390PCIGroup structure to hold the information related to a
> zPCI Function group.
> 
> This allows us to be ready to support multiple groups and to retrieve
> the group information from the host.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-pci-bus.h  | 10 ++++++++++
>  hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
>  3 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 92146a2..3015d86 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -737,6 +737,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>      object_unref(OBJECT(iommu));
>  }
>  
> +static S390PCIGroup *s390_grp_create(int ug)

I think you made the identifiers a bit too compact :)
s390_group_create() is not that long, and I have no idea what the 'ug'
(ugh :) parameter is supposed to mean.

> +{
> +    S390PCIGroup *grp;

group?

> +    S390pciState *s = s390_get_phb();
> +
> +    grp = g_new0(S390PCIGroup, 1);
> +    grp->ug = ug;
> +    QTAILQ_INSERT_TAIL(&s->zpci_grps, grp, link);

zpci_groups? I think you get the idea :)

> +    return grp;
> +}

(...)

No objection to the patch in general.


