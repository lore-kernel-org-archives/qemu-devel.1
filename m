Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634CC35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711D4222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8QdtPtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711D4222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54x6-0001Na-LH
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j54vv-0008P7-CA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j54vu-0001Q3-6e
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:49:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j54vu-0001Od-1l
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582278557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izhuloIbjeBJt15cistugJTnZiA/YtlXu6SOpYMF2FU=;
 b=I8QdtPtXJUawA1ecb+mGAddmPgFw0+enZZTAKNgcU2oLYn4vQ4B1h0e2jU0woLIfbTAnzd
 R4rv+5MIcyWd1wr86Q2hwN3JuwBvSnEFY0SnBLMpiWejad/DeAsn9xThmH2i98t2BPiF3m
 89a2+yvbg8SDOuJ9dAOGm6j73snO0Xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-jrPwCEx6PEmYzhbI8nV8sQ-1; Fri, 21 Feb 2020 04:49:15 -0500
X-MC-Unique: jrPwCEx6PEmYzhbI8nV8sQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66BAF92AA0;
 Fri, 21 Feb 2020 09:49:14 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A17C60BE0;
 Fri, 21 Feb 2020 09:49:10 +0000 (UTC)
Date: Fri, 21 Feb 2020 10:49:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 02/16] s390x: protvirt: Add diag308 subcodes 8 - 10
Message-ID: <20200221104908.7c54fd64.cohuck@redhat.com>
In-Reply-To: <20200220125638.7241-3-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
 <20200220125638.7241-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 07:56:24 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
> 
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
> 
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
> 
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h      | 31 +++++++++++++++++++++++++++++
>  target/s390x/diag.c | 27 ++++++++++++++++++++++---
>  3 files changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7773499d7f..e92d989813 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -538,15 +538,56 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>  }
>  
> +int s390_ipl_pv_check_components(IplParameterBlock *iplb)
> +{
> +    int i;
> +    IPLBlockPV *ipib_pv = &iplb->pv;
> +
> +    if (ipib_pv->num_comp == 0) {
> +        return -EINVAL;
> +    }
> +
> +    for (i = 0; i < ipib_pv->num_comp; i++) {
> +
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return -EINVAL;
> +        }
> +
> +        /* Tweak prefix is monotonously increasing with each component */
> +        if (i < ipib_pv->num_comp - 1 &&
> +            ipib_pv->components[i].tweak_pref >
> +            ipib_pv->components[i + 1].tweak_pref) {
> +            return -EINVAL;
> +        }
> +    }
> +    return 1;

Any reason why you return 1 here? 0 vs negative error is the more usual
pattern.

> +}
> +

(...)

> @@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
>  
> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
> +            !(iplb_valid_pv(iplb) && s390_ipl_pv_check_components(iplb) >= 0)) {

!s390_ipl_pv_check_components() would also read nicer IMHO :)

>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }

Otherwise, looks good to me.


