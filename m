Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24EDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75A920843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75A920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVwi-0005wo-QT
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:50:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQVvp-0005Z3-VH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQVvo-0006pg-UO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQVvo-0006o9-NC; Tue, 14 May 2019 07:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ABAA308A963;
	Tue, 14 May 2019 11:49:15 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE135D724;
	Tue, 14 May 2019 11:49:06 +0000 (UTC)
Date: Tue, 14 May 2019 13:49:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <20190514134904.67decb8b.cohuck@redhat.com>
In-Reply-To: <1557499133-24169-4-git-send-email-pmorel@linux.ibm.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
	<1557499133-24169-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 11:49:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] s390: vfio_pci: Use a PCI Group
 structure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pasic@linux.vnet.ibm.com, mst@redhat.com, qemu-s390x@nongnu.org,
	david@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 16:38:51 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We use a S390PCIGroup structure to hold the information
> related to zPCI Function group.
> 
> This allows us to be ready to support multiple groups and to retrieve
> the group information from the host.

What if there is no host to retrieve information from?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-pci-bus.h  | 11 ++++++++++-
>  hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
>  3 files changed, 65 insertions(+), 10 deletions(-)

> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index be28962..8147847 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -284,21 +284,25 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
>          stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
>          stl_p(&resquery->fid, pbdev->fid);
>          stw_p(&resquery->pchid, 0);
> -        stw_p(&resquery->ug, 1);
> +        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
>          stl_p(&resquery->uid, pbdev->uid);
>          stw_p(&resquery->hdr.rsp, CLP_RC_OK);
>          break;
>      }
>      case CLP_QUERY_PCI_FNGRP: {
>          ClpRspQueryPciGrp *resgrp = (ClpRspQueryPciGrp *)resh;
> -        resgrp->fr = 1;
> -        stq_p(&resgrp->dasm, 0);
> -        stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
> -        stw_p(&resgrp->mui, DEFAULT_MUI);
> -        stw_p(&resgrp->i, 128);
> -        stw_p(&resgrp->maxstbl, 128);
> -        resgrp->version = 0;
>  
> +        ClpReqQueryPciGrp *reqgrp = (ClpReqQueryPciGrp *)reqh;
> +        S390PCIGroup *grp;
> +
> +        grp = s390_grp_find(reqgrp->g);
> +        if (!grp) {
> +            /* We do not allow access to unknown groups */
> +            /* The group must have been obtained with a vfio device */

What about non-vfio devices? How does this whole feature work for
emulated devices?

> +            stw_p(&resgrp->hdr.rsp, CLP_RC_QUERYPCIFG_PFGID);
> +            goto out;
> +        }
> +        memcpy(resgrp, &grp->zpci_grp, sizeof(ClpRspQueryPciGrp));
>          stw_p(&resgrp->hdr.rsp, CLP_RC_OK);
>          break;
>      }
> @@ -752,7 +756,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>      }
>      /* Length must be greater than 8, a multiple of 8 */
>      /* and not greater than maxstbl */
> -    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
> +    if ((len <= 8) || (len % 8) || (len > pbdev->pci_grp->zpci_grp.maxstbl)) {
>          goto specification_error;
>      }
>      /* Do not cross a 4K-byte boundary */


