Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1EC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 06:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10D121738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 06:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10D121738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqAwD-0003QH-2u
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 02:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hqAw3-00031u-CQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hqAw2-0000qe-Fh
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hqAw2-0000pv-9T
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:39:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6F84335FD;
 Wed, 24 Jul 2019 06:39:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8868D60BF3;
 Wed, 24 Jul 2019 06:39:32 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id C48451800202;
 Wed, 24 Jul 2019 06:39:31 +0000 (UTC)
Date: Wed, 24 Jul 2019 02:39:31 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <1163453389.4034945.1563950371742.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190723160859.27250-1-imammedo@redhat.com>
References: <20190723160859.27250-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.75, 10.4.195.2]
Thread-Topic: pc-dimm: fix crash when invalid slot number is used
Thread-Index: MhaalF53fVNFbdubr+F+iHK2cB2elQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 24 Jul 2019 06:39:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pc-dimm: fix crash when invalid slot
 number is used
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> QEMU will crash with:
>   Segmentation fault (core dumped)
> when negative slot number is used, ex:
>   qemu-system-x86_64 -m 1G,maxmem=20G,slots=256 \
>       -object memory-backend-ram,id=mem1,size=1G \
>       -device pc-dimm,id=dimm1,memdev=mem1,slot=-2
> 
> fix it by checking that slot number is within valid range.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/mem/pc-dimm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index b1239fd0d3..29c785799c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -38,6 +38,13 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState
> *machine,
>  
>      slot = object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
>                                     &error_abort);
> +    if ((slot < 0 || slot >= machine->ram_slots) &&
> +         slot != PC_DIMM_UNASSIGNED_SLOT) {
> +        error_setg(&local_err, "invalid slot number, valid range is [0-%"
> +                   PRIu64 "]", machine->ram_slots - 1);
> +        goto out;
> +    }
> +
>      slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL :
>      &slot,
>                                   machine->ram_slots, &local_err);
>      if (local_err) {
> --

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 2.18.1
> 
> 
> 

