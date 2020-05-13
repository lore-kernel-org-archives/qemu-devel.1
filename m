Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B67C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCF1206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROk2Qq4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCF1206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYlSo-0006pn-NZ
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 03:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYlSC-0006IU-Sv
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:05:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYlSC-0006PR-5C
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589353519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kupgTKDTy7NvN8jOLzjEcNwAp9ZzF+dzKc5eeJgmg0=;
 b=ROk2Qq4iOIcUpRy3+Uj7dVeHTY8YyeaaWwzHay9vJDAEr/QiPlrFlMZSzP3rSJbXBUEC8H
 u1eY8o6+YYbr0x0CMtLdsUoVDwILVuLunSRxDYQuIk/+lgdBPDf3bpThJyT3D+zncn4nTV
 u9TWBRaRPkKtuWDVhEuwe5HePscJ8T0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-iiTvemBGNlGfT4RWDhgD9A-1; Wed, 13 May 2020 03:05:15 -0400
X-MC-Unique: iiTvemBGNlGfT4RWDhgD9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B77A835B41;
 Wed, 13 May 2020 07:05:13 +0000 (UTC)
Received: from gondolin (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E83CE60FB9;
 Wed, 13 May 2020 07:05:10 +0000 (UTC)
Date: Wed, 13 May 2020 09:05:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v1 7/8] s390/kvm: header sync for diag318
Message-ID: <20200513090508.79b7fc54.cohuck@redhat.com>
In-Reply-To: <20200508230823.22956-8-walling@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-8-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  8 May 2020 19:08:22 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 0138ccb0d8..b661feafdc 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>  #define KVM_S390_VM_CRYPTO		2
>  #define KVM_S390_VM_CPU_MODEL		3
>  #define KVM_S390_VM_MIGRATION		4
> +#define KVM_S390_VM_MISC		5
>  
>  /* kvm attributes for mem_ctrl */
>  #define KVM_S390_VM_MEM_ENABLE_CMMA	0
> @@ -171,6 +172,10 @@ struct kvm_s390_vm_cpu_subfunc {
>  #define KVM_S390_VM_MIGRATION_START	1
>  #define KVM_S390_VM_MIGRATION_STATUS	2
>  
> +/* kvm attributes for KVM_S390_VM_MISC */
> +#define KVM_S390_VM_MISC_ENABLE_DIAG318		0
> +#define KVM_S390_VM_MISC_DIAG318			1
> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  	/* general purpose regs for s390 */

Hm... remind me what the state of the kernel part is?


