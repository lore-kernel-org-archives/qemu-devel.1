Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02166C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E720674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtdKypup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34E720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGm9-0002Jv-UO
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEGbc-00064g-7n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEGba-0003fj-Do
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:06:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEGba-0003dw-7O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584468377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfNRKrxqo2jMTYy3+h3lKvv6PqiHbPojnK8xnOxJ7n4=;
 b=OtdKypuprn5RUDtythrjtvtnaV8/1CU6arZjFr7tRQWOt5UcO1x/gCd3DOl9dgQVGrZfCt
 xRwNZVtYCfugaeOPR2o0g3ax93GFvp6b+TaE4aNcxeQn5UFvZ6xZ8Ndi3L6n0zGWfENNRk
 PGPWWx0qjVPlabmhz9wD23bxxPOEI2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-JmTj_pzCN_-uI9mPb9CjXg-1; Tue, 17 Mar 2020 14:06:16 -0400
X-MC-Unique: JmTj_pzCN_-uI9mPb9CjXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAF4918FF683;
 Tue, 17 Mar 2020 18:06:14 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AADC9F5C;
 Tue, 17 Mar 2020 18:06:07 +0000 (UTC)
Date: Tue, 17 Mar 2020 19:06:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 15/15] s390x: Add unpack facility feature to GA1
Message-ID: <20200317190605.36c5c73b.cohuck@redhat.com>
In-Reply-To: <20200311132151.172389-16-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-16-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:51 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The unpack facility is an indication that diagnose 308 subcodes 8-10
> are available to the guest. That means, that the guest can put itself
> into protected mode.
> 
> Once it is in protected mode, the hardware stops any attempt of VM
> introspection by the hypervisor.
> 
> Some features are currently not supported in protected mode:
>      * Passthrough devices

s/Passthrough/vfio/ ?

>      * Migration
>      * Huge page backings
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Btw: please add your s-o-b if you're passing on patches from others.

> ---
>  target/s390x/gen-features.c | 1 +
>  target/s390x/kvm.c          | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 6278845b12b8dee8..8ddeebc54419a3e2 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -562,6 +562,7 @@ static uint16_t full_GEN15_GA1[] = {
>      S390_FEAT_GROUP_MSA_EXT_9,
>      S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
>      S390_FEAT_ETOKEN,
> +    S390_FEAT_UNPACK,
>  };
>  
>  /* Default features (in order of release)
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ff6027036ec2f14a..e11e895a3d9038bb 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2403,6 +2403,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          clear_bit(S390_FEAT_BPB, model->features);
>      }
>  
> +    /* we do have the IPL enhancements */

I'm more confused by that comment than educated :) Not sure what 'IPL
enhancements' means in this context.

> +    if (cap_protected) {
> +        set_bit(S390_FEAT_UNPACK, model->features);
> +    }
> +
>      /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
>      set_bit(S390_FEAT_ZPCI, model->features);
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);


