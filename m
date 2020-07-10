Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5066EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B50720720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6wSjuTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtmOF-0005Dv-CX
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 02:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtmNg-0004lw-RO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:19:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtmNe-0006Ok-L2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594361968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJkAYrKYAMC/z64jLWQ2qcx4VCMiQH3Q9Ra/pQNwqHE=;
 b=C6wSjuTZR3GrU9B0RVWeHhRqRs2e9z+bJK4mhh3f+jvp//hpaiMcwdPBXYrGtOTE1+oT7Y
 AcJZ1aQQGsDvO5s/OYcMDrMLcxQOBPoXvOw94Vp5phEnLwLEaSKRNO5nDciSytOp2CRYZQ
 +s3+uXXcMyftmgtRkGGSCyMeXv9ihwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Wv9ZomXYMaWQjTN5j_J3xQ-1; Fri, 10 Jul 2020 02:19:27 -0400
X-MC-Unique: Wv9ZomXYMaWQjTN5j_J3xQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B5AD1080
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:19:26 +0000 (UTC)
Received: from gondolin (ovpn-112-227.ams2.redhat.com [10.36.112.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9180F920C7;
 Fri, 10 Jul 2020 06:19:22 +0000 (UTC)
Date: Fri, 10 Jul 2020 08:19:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] linux-headers: update again to 5.8-rc
Message-ID: <20200710081919.145c30e5.cohuck@redhat.com>
In-Reply-To: <20200709182849.10309-1-pbonzini@redhat.com>
References: <20200709182849.10309-1-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:55:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jul 2020 14:28:49 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> 5.8-rc1 inadvertently broke userspace ABI compatibility.  Merge
> again with latest kvm/master to undo that.

Ouch.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	The patch should get to Linus tomorrow.  Posting here to
> 	ensure it is on people's radar for hard freeze, because
> 	I probably won't be around.

Looks good to me. We will probably be able to fill in the proper
hash/rc-reference after the weekend and get this merged. This looks
entirely appropriate even for freeze.

Acked-by: Cornelia Huck <cohuck@redhat.com>

> 
>  linux-headers/asm-arm/unistd-common.h | 1 +
>  linux-headers/asm-x86/kvm.h           | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
> index 23de64e44c..57cd1f21db 100644
> --- a/linux-headers/asm-arm/unistd-common.h
> +++ b/linux-headers/asm-arm/unistd-common.h
> @@ -392,5 +392,6 @@
>  #define __NR_clone3 (__NR_SYSCALL_BASE + 435)
>  #define __NR_openat2 (__NR_SYSCALL_BASE + 437)
>  #define __NR_pidfd_getfd (__NR_SYSCALL_BASE + 438)
> +#define __NR_faccessat2 (__NR_SYSCALL_BASE + 439)
>  
>  #endif /* _ASM_ARM_UNISTD_COMMON_H */
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 17c5a038f4..0780f97c18 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
>  };
>  
>  struct kvm_vmx_nested_state_hdr {
> -	__u32 flags;
>  	__u64 vmxon_pa;
>  	__u64 vmcs12_pa;
> -	__u64 preemption_timer_deadline;
>  
>  	struct {
>  		__u16 flags;
>  	} smm;
> +
> +	__u32 flags;
> +	__u64 preemption_timer_deadline;
>  };
>  
>  struct kvm_svm_nested_state_data {


