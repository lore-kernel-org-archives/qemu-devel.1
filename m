Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438AAC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CC82073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSRT2aSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CC82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgjH-0003WD-74
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:01:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTgiO-0002iB-RM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTgiN-0003HM-Ee
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:01:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTgiM-0003Gy-Vy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588143661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFAslWw1ZehCc+sX5pQXC2I2OJUcupQ+3LyoaWXKKDA=;
 b=NSRT2aSdvySo+Wx5O1LBrfbnNxQncPG9M3asZxdWAFRo+DVXtqqL9etdejqDTpK4powwMx
 d0uTPb/qpLQgof3nR2oSWiX8kZXhwD+4889+ZrXTypHXVtTG+V30XDtcZLDNKsnvOf9NXR
 nBL7OrEyb16P5FS1Y8Szr44BEwPLG6c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-2ognhsw3MrG8jtkwzcwzGA-1; Wed, 29 Apr 2020 03:01:00 -0400
X-MC-Unique: 2ognhsw3MrG8jtkwzcwzGA-1
Received: by mail-wr1-f70.google.com with SMTP id r17so1242658wrg.19
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFAslWw1ZehCc+sX5pQXC2I2OJUcupQ+3LyoaWXKKDA=;
 b=ROs6vbIfxEn2nBm8fDu7eB9JGkQgz2OyXLcSNxYX1fejd7/wvV9GxPgtrfUmS20W4r
 H74/4G+4xNvvLpxoPFdStaMd+RCgjRE/XYK+u7WwlzPs1ZKUidSYlAzeJ0qhvXD0NQqv
 A5oyvsztMj7poMR6Af0qxoITDU+KeWQGcygs+5xh70CAW9/0M6TiaA+u7NkHaW3w2QmV
 d2x4S+90b7+xaMiXv8QqtzsPxBMuL3sWB5cDYZbOyO0HcBf2HkTyRWKIHREIsHpTbmYp
 j8nZ9XzrisoYQ/lh5x3WzNJwur6ahSQR8fkG89Tj/0vtPDq8ScHfN5VIkoigNUmZcJk1
 3FRw==
X-Gm-Message-State: AGi0PubAPWw/yHgdhatq46UgYc38O1IyRIFC8nOh4oh4cpSH+mFx79Zy
 QIqwRc1MrwBJ97xwN+S9CE0A8alf6an7I90VkodF/i7AGt58a/PNvL3Y40Gxli5lBxYCBGkSEjI
 ZBrYMmFLJZGJwqlw=
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr1418651wml.7.1588143658796;
 Wed, 29 Apr 2020 00:00:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPaAvRkbyvhMrv77HRPE8ta4wh/qduvIDGP2ZRtQjWAQxEllhlKtJc494If8K205PRk4b5wg==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr1418618wml.7.1588143658426;
 Wed, 29 Apr 2020 00:00:58 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id z8sm27255837wrr.40.2020.04.29.00.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 00:00:57 -0700 (PDT)
Subject: Re: [PATCH] s390x/kvm: help valgrind in several places
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
References: <20200428183109.89439-1-borntraeger@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a9751b5-3b0b-2982-0756-3083cea22f31@redhat.com>
Date: Wed, 29 Apr 2020 09:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428183109.89439-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Christian,

On 4/28/20 8:31 PM, Christian Borntraeger wrote:
> We need some little help in the code to reduce the valgrind noise.
> - some designated initializers for the cpu model features and subfunctions

^ This could go as trivial patch while we discuss the rest.

> - mark memory as defined for sida memory reads
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

I couldn't apply this patch, then figured out it targets s390-next.

>   target/s390x/kvm.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 69881a0da0..bcd0ee0d14 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -52,6 +52,10 @@
>   #include "hw/s390x/s390-virtio-hcall.h"
>   #include "hw/s390x/pv.h"
>   
> +#ifdef CONFIG_VALGRIND_H
> +#include <valgrind/memcheck.h>
> +#endif
> +
>   #ifndef DEBUG_KVM
>   #define DEBUG_KVM  0
>   #endif
> @@ -875,6 +879,13 @@ int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
>           error_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
>           abort();
>       }

What about kvm_s390_mem_op()?

> +
> +#ifdef CONFIG_VALGRIND_H
> +    if (!is_write) {
> +        VALGRIND_MAKE_MEM_DEFINED(hostbuf, len);
> +    }
> +#endif

I agree with this macro usage, but think it should be widely accessible 
by the whole codebase (and other targets).

"exec/memory.h" is for MemoryRegion and AddressSpace. Maybe 
"exec/ram_addr.h" is a better place for common helpers.

If Valgrind is only confused under KVM, the "sysemu/kvm.h" is the 
obvious place.

> +
>       return ret;
>   }
>   
> @@ -2165,7 +2176,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>   
>   static int query_cpu_subfunc(S390FeatBitmap features)
>   {
> -    struct kvm_s390_vm_cpu_subfunc prop;
> +    struct kvm_s390_vm_cpu_subfunc prop = {};
>       struct kvm_device_attr attr = {
>           .group = KVM_S390_VM_CPU_MODEL,
>           .attr = KVM_S390_VM_CPU_MACHINE_SUBFUNC,
> @@ -2292,7 +2303,7 @@ static int kvm_to_feat[][2] = {
>   
>   static int query_cpu_feat(S390FeatBitmap features)
>   {
> -    struct kvm_s390_vm_cpu_feat prop;
> +    struct kvm_s390_vm_cpu_feat prop = {};
>       struct kvm_device_attr attr = {
>           .group = KVM_S390_VM_CPU_MODEL,
>           .attr = KVM_S390_VM_CPU_MACHINE_FEAT,
> 


